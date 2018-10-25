From: Enke Chen <enkechen@cisco.com>
Subject: [PATCH v4] kernel/signal: Signal-based pre-coredump notification
Date: Thu, 25 Oct 2018 15:56:10 -0700
Message-ID: <84460a77-a111-404e-4bad-88104a6e246e@cisco.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
 <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@s>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Victor Kamensky (kamensky)" <kamensky@cisco.com>, xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>, Enke Chen <enkechen@cisco.com>
List-Id: linux-arch.vger.kernel.org

For simplicity and consistency, this patch provides an implementation
for signal-based fault notification prior to the coredump of a child
process. A new prctl command, PR_SET_PREDUMP_SIG, is defined that can
be used by an application to express its interest and to specify the
signal for such a notification.

Changes to prctl(2):

   PR_SET_PREDUMP_SIG (since Linux 4.20.x)
          Set the child pre-coredump signal of the calling process to
          arg2 (either a signal value in the range 1..maxsig, or 0 to
          clear). This is the signal that the calling process will get
          prior to the coredump of a child process. This value is
          cleared across execve(2), or for the child of a fork(2).

   PR_GET_PREDUMP_SIG (since Linux 4.20.x)
          Return the current value of the child pre-coredump signal,
          in the location pointed to by (int *) arg2.

Background:

As the coredump of a process may take time, in certain time-sensitive
applications it is necessary for a parent process (e.g., a process
manager) to be notified of a child's imminent death before the coredump
so that the parent process can act sooner, such as re-spawning an
application process, or initiating a control-plane fail-over.

One application is BFD. The early fault notification is a critical
component for maintaining BFD sessions (with a timeout value of
50 msec or 100 msec) across a control-plane failure.

Currently there are two ways for a parent process to be notified of a
child process's state change. One is to use the POSIX signal, and
another is to use the kernel connector module. The specific events and
actions are summarized as follows:

Process Event    POSIX Signal                Connector-based
----------------------------------------------------------------------
ptrace_attach()  do_notify_parent_cldstop()  proc_ptrace_connector()
                 SIGCHLD / CLD_STOPPED

ptrace_detach()  do_notify_parent_cldstop()  proc_ptrace_connector()
                 SIGCHLD / CLD_CONTINUED

pre_coredump/    N/A                         proc_coredump_connector()
get_signal()

post_coredump/   do_notify_parent()          proc_exit_connector()
do_exit()        SIGCHLD / exit_signal
----------------------------------------------------------------------

As shown in the table, the signal-based pre-coredump notification is not
currently available. In some cases using a connector-based notification
can be quite complicated (e.g., when a process manager is written in shell
scripts and thus is subject to certain inherent limitations), and a
signal-based notification would be simpler and better suited.

Signed-off-by: Enke Chen <enkechen@cisco.com>
---
v3 -> v4:

Addressed review comments from Oleg Nesterov, and Eric W. Biederman,
including:
o remove the definition CLD_PREDUMP.
o code simplification.
o split out the selftest code.

 fs/coredump.c                | 23 +++++++++++++++++++++++
 fs/exec.c                    |  3 +++
 include/linux/sched/signal.h |  3 +++
 include/uapi/linux/prctl.h   |  4 ++++
 kernel/sys.c                 | 13 +++++++++++++
 5 files changed, 46 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index e42e17e..22c40dc 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -536,6 +536,24 @@ static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
 	return err;
 }
 
+/*
+ * While do_notify_parent() notifies the parent of a child's death post
+ * its coredump, this function lets the parent (if so desired) know about
+ * the imminent death of a child just prior to its coredump.
+ */
+static void do_notify_parent_predump(void)
+{
+	struct task_struct *parent;
+	int sig;
+
+	read_lock(&tasklist_lock);
+	parent = current->parent;
+	sig = parent->signal->predump_signal;
+	if (sig != 0)
+		do_send_sig_info(sig, SEND_SIG_NOINFO, parent, PIDTYPE_TGID);
+	read_unlock(&tasklist_lock);
+}
+
 void do_coredump(const kernel_siginfo_t *siginfo)
 {
 	struct core_state core_state;
@@ -590,6 +608,11 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	if (retval < 0)
 		goto fail_creds;
 
+	/*
+	 * Send the pre-coredump signal to the parent if requested.
+	 */
+	do_notify_parent_predump();
+
 	old_cred = override_creds(cred);
 
 	ispipe = format_corename(&cn, &cprm);
diff --git a/fs/exec.c b/fs/exec.c
index fc281b7..7714da7 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1181,6 +1181,9 @@ static int de_thread(struct task_struct *tsk)
 	/* we have changed execution domain */
 	tsk->exit_signal = SIGCHLD;
 
+	/* Clear the pre-coredump signal before loading a new binary */
+	sig->predump_signal = 0;
+
 #ifdef CONFIG_POSIX_TIMERS
 	exit_itimers(sig);
 	flush_itimer_signals();
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 13789d1..728ef68 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -112,6 +112,9 @@ struct signal_struct {
 	int			group_stop_count;
 	unsigned int		flags; /* see SIGNAL_* flags below */
 
+	/* The signal sent prior to a child's coredump */
+	int			predump_signal;
+
 	/*
 	 * PR_SET_CHILD_SUBREAPER marks a process, like a service
 	 * manager, to re-parent orphan (double-forking) child processes
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index c0d7ea0..79f0a8a 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -219,4 +219,8 @@ struct prctl_mm_map {
 # define PR_SPEC_DISABLE		(1UL << 2)
 # define PR_SPEC_FORCE_DISABLE		(1UL << 3)
 
+/* Whether to receive signal prior to child's coredump */
+#define PR_SET_PREDUMP_SIG	54
+#define PR_GET_PREDUMP_SIG	55
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 123bd73..39aa3b8 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2476,6 +2476,19 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
 			return -EINVAL;
 		error = arch_prctl_spec_ctrl_set(me, arg2, arg3);
 		break;
+	case PR_SET_PREDUMP_SIG:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		if (!valid_signal((int)arg2))
+			return -EINVAL;
+		me->signal->predump_signal = (int)arg2;
+		break;
+	case PR_GET_PREDUMP_SIG:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = put_user(me->signal->predump_signal,
+				 (int __user *)arg2);
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
1.8.3.1
