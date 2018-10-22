From: Enke Chen <enkechen@cisco.com>
Subject: [PATCH v2] kernel/signal: Signal-based pre-coredump notification
Date: Mon, 22 Oct 2018 14:09:09 -0700
Message-ID: <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@s>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Victor Kamensky (kamensky)" <kamensky@cisco.com>, xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>, Enke Chen <enkechen@cisco.com>
List-Id: linux-arch.vger.kernel.org

For simplicity and consistency, this patch provides an implementation
for signal-based fault notification prior to the coredump of a child
process. A new prctl command, PR_SET_PREDUMP_SIG, is defined that can
be used by an application to express its interest and to specify the
signal (SIGCHLD or SIGUSR1 or SIGUSR2) for such a notification. A new
signal code (si_code), CLD_PREDUMP, is also defined for SIGCHLD.

Changes to prctl(2):

   PR_SET_PREDUMP_SIG (since Linux 4.20.x)
          Set the child pre-coredump signal of the calling process to
          arg2 (either SIGUSR1, or SIUSR2, or SIGCHLD, or 0 to clear).
          This is the signal that the calling process will get prior to
          the coredump of a child process. This value is cleared across
          execve(2), or for the child of a fork(2).

          When SIGCHLD is specified, the signal code will be set to
          CLD_PREDUMP in such an SIGCHLD signal.

   PR_GET_PREDUMP_SIG (since Linux 4.20.x)
          Return the current value of the child pre-coredump signal,
          in the location pointed to by (int *) arg2.

Background:

As the coredump of a process may take time, in certain time-sensitive
applications it is necessary for a parent process (e.g., a process
manager) to be notified of a child's imminent death before the coredump
so that the parent process can act sooner, such as re-spawning an
application process, or initiating a control-plane fail-over.

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
v1 -> v2:

o remove the setting/gettting on others in prctl().
o move the notification from get_signal() to do_coredump().
o notify the "parent" instead of "real_parent".
o move the "predump_signal" from "task_struct" to "signal_struct".
o clear the signal setting across execve(2) as well.
o add validation for unused prctl() parameters.
o add selftests for the new prctl() API.

 arch/x86/kernel/signal_compat.c                  |   2 +-
 fs/coredump.c                                    |  10 ++
 fs/exec.c                                        |   3 +
 include/linux/sched/signal.h                     |   4 +
 include/linux/signal.h                           |   5 +
 include/uapi/asm-generic/siginfo.h               |   3 +-
 include/uapi/linux/prctl.h                       |   4 +
 kernel/fork.c                                    |   3 +
 kernel/signal.c                                  |  39 ++++++
 kernel/sys.c                                     |  15 ++
 tools/testing/selftests/prctl/Makefile           |   2 +-
 tools/testing/selftests/prctl/predump-sig-test.c | 171 +++++++++++++++++++++++
 12 files changed, 258 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/prctl/predump-sig-test.c

diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index 9ccbf05..a3deba8 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -30,7 +30,7 @@ static inline void signal_compat_build_tests(void)
 	BUILD_BUG_ON(NSIGSEGV != 7);
 	BUILD_BUG_ON(NSIGBUS  != 5);
 	BUILD_BUG_ON(NSIGTRAP != 5);
-	BUILD_BUG_ON(NSIGCHLD != 6);
+	BUILD_BUG_ON(NSIGCHLD != 7);
 	BUILD_BUG_ON(NSIGSYS  != 1);
 
 	/* This is part of the ABI and can never change in size: */
diff --git a/fs/coredump.c b/fs/coredump.c
index e42e17e..f11e31f 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -546,6 +546,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	struct cred *cred;
 	int retval = 0;
 	int ispipe;
+	bool notify;
 	struct files_struct *displaced;
 	/* require nonrelative corefile path and be extra careful */
 	bool need_suid_safe = false;
@@ -590,6 +591,15 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	if (retval < 0)
 		goto fail_creds;
 
+	/*
+	 * Send the pre-coredump signal to the parent if requested.
+	 */
+	read_lock(&tasklist_lock);
+	notify = do_notify_parent_predump(current);
+	read_unlock(&tasklist_lock);
+	if (notify)
+		cond_resched();
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
index 13789d1..047829d 100644
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
@@ -332,6 +335,7 @@ extern int kill_pid_info_as_cred(int, struct kernel_siginfo *, struct pid *,
 extern int kill_pgrp(struct pid *pid, int sig, int priv);
 extern int kill_pid(struct pid *pid, int sig, int priv);
 extern __must_check bool do_notify_parent(struct task_struct *, int);
+extern bool do_notify_parent_predump(struct task_struct *p);
 extern void __wake_up_parent(struct task_struct *p, struct task_struct *parent);
 extern void force_sig(int, struct task_struct *);
 extern int send_sig(int, struct task_struct *, int);
diff --git a/include/linux/signal.h b/include/linux/signal.h
index f428e86..6e1b2c9 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -262,6 +262,11 @@ static inline int valid_signal(unsigned long sig)
 	return sig <= _NSIG ? 1 : 0;
 }
 
+static inline int valid_predump_signal(int sig)
+{
+	return (sig == SIGCHLD) || (sig == SIGUSR1) || (sig == SIGUSR2);
+}
+
 struct timespec;
 struct pt_regs;
 enum pid_type;
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index cb3d6c2..1a47cef 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -267,7 +267,8 @@ struct {				\
 #define CLD_TRAPPED	4	/* traced child has trapped */
 #define CLD_STOPPED	5	/* child has stopped */
 #define CLD_CONTINUED	6	/* stopped child has continued */
-#define NSIGCHLD	6
+#define CLD_PREDUMP	7	/* child is about to dump core */
+#define NSIGCHLD	7
 
 /*
  * SIGPOLL (or any other signal without signal specific si_codes) si_codes
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
diff --git a/kernel/fork.c b/kernel/fork.c
index 07cddff..a9c9988 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1553,6 +1553,9 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
 	tty_audit_fork(sig);
 	sched_autogroup_fork(sig);
 
+	/* Clear the pre-coredump signal for the child of fork(2) */
+	sig->predump_signal = 0;
+
 	sig->oom_score_adj = current->signal->oom_score_adj;
 	sig->oom_score_adj_min = current->signal->oom_score_adj_min;
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 9a32bc2..e4c154b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1855,6 +1855,45 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 	return autoreap;
 }
 
+/*
+ * While do_notify_parent() notifies the parent of a child's death post
+ * its coredump, this function lets the parent (if so desired) know about
+ * the imminent death of a child just prior to its coredump.
+ *
+ * The caller must hold at least the read lock on tasklist_lock.
+ */
+bool do_notify_parent_predump(struct task_struct *tsk)
+{
+	struct sighand_struct *sighand;
+	struct kernel_siginfo info;
+	struct task_struct *parent;
+	unsigned long flags;
+	pid_t pid;
+	int sig;
+
+	parent = tsk->parent;
+	sighand = parent->sighand;
+	pid = task_tgid_vnr(tsk);
+
+	spin_lock_irqsave(&sighand->siglock, flags);
+	sig = parent->signal->predump_signal;
+	if (!valid_predump_signal(sig)) {
+		spin_unlock_irqrestore(&sighand->siglock, flags);
+		return false;
+	}
+
+	clear_siginfo(&info);
+	info.si_pid = pid;
+	info.si_signo = sig;
+	if (sig == SIGCHLD)
+		info.si_code = CLD_PREDUMP;
+
+	__group_send_sig_info(sig, &info, parent);
+	__wake_up_parent(tsk, parent);
+	spin_unlock_irqrestore(&sighand->siglock, flags);
+	return true;
+}
+
 /**
  * do_notify_parent_cldstop - notify parent of stopped/continued state change
  * @tsk: task reporting the state change
diff --git a/kernel/sys.c b/kernel/sys.c
index 123bd73..8ed9a63 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2476,6 +2476,21 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
 			return -EINVAL;
 		error = arch_prctl_spec_ctrl_set(me, arg2, arg3);
 		break;
+	case PR_SET_PREDUMP_SIG:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+
+		/* 0 is valid for disabling the feature */
+		if (arg2 && !valid_predump_signal((int)arg2))
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
diff --git a/tools/testing/selftests/prctl/Makefile b/tools/testing/selftests/prctl/Makefile
index c7923b2..f8d60d5 100644
--- a/tools/testing/selftests/prctl/Makefile
+++ b/tools/testing/selftests/prctl/Makefile
@@ -5,7 +5,7 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 ifeq ($(ARCH),x86)
 TEST_PROGS := disable-tsc-ctxt-sw-stress-test disable-tsc-on-off-stress-test \
-		disable-tsc-test
+		disable-tsc-test predump-sig-test
 all: $(TEST_PROGS)
 
 include ../lib.mk
diff --git a/tools/testing/selftests/prctl/predump-sig-test.c b/tools/testing/selftests/prctl/predump-sig-test.c
new file mode 100644
index 0000000..57042f7
--- /dev/null
+++ b/tools/testing/selftests/prctl/predump-sig-test.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018, Enke Chen, Cisco Systems, Inc.
+ *
+ * Tests for prctl(PR_SET_PREDUMP_SIG, ...) / prctl(PR_GET_PREDUMP_SIG, ...)
+ *
+ * When set with prctl(), the specified signal is sent to the parent process
+ * prior to the coredump of a child process.
+ *
+ * Usage: ./predump-sig-test {SIGUSR1 | SIGUSR2 | SIGCHLD}
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/prctl.h>
+#include <signal.h>
+#include <sys/signalfd.h>
+#include <errno.h>
+
+#ifndef PR_SET_PREDUMP_SIG
+#define PR_SET_PREDUMP_SIG	54
+#define PR_GET_PREDUMP_SIG	55
+#endif
+
+#ifndef CLD_PREDUMP
+#define CLD_PREDUMP	7	/* child is about to dump core */
+#endif
+
+#define handle_error(msg) \
+	do { perror(msg); exit(EXIT_FAILURE); } while (0)
+
+static int test_prctl(int sig)
+{
+	int sig2, rc;
+
+	rc = prctl(PR_SET_PREDUMP_SIG, sig, 0, 0, 0);
+	if (rc < 0)
+		handle_error("prctl: setting");
+
+	rc = prctl(PR_GET_PREDUMP_SIG, &sig2, 0, 0, 0);
+	if (rc < 0)
+		handle_error("prctl: getting");
+
+	if (sig2 != sig) {
+		printf("prctl: sig %d, post %d\n", sig, sig2);
+		return -1;
+	}
+	return 0;
+}
+
+static int sigfd;
+static int predump_signal;
+
+static int init_signalfd(void)
+{
+	sigset_t mask;
+	int sfd;
+
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGCHLD);
+	if (predump_signal && (predump_signal != SIGCHLD))
+		sigaddset(&mask, predump_signal);
+
+	/*
+	 * Block signals so that they aren't handled according to their
+	 * default dispositions.
+	 */
+	if (sigprocmask(SIG_BLOCK, &mask, NULL) == -1)
+		handle_error("sigprocmask");
+
+	sfd = signalfd(-1, &mask, SFD_CLOEXEC);
+	if (sfd == -1)
+		handle_error("signalfd");
+
+	return sfd;
+}
+
+static void parent_func(pid_t child_pid)
+{
+	struct signalfd_siginfo si;
+	int count = 0;
+	ssize_t s;
+
+	for (;;) {
+		s = read(sigfd, &si, sizeof(struct signalfd_siginfo));
+		if (s != sizeof(struct signalfd_siginfo))
+			handle_error("read");
+
+		count++;
+		printf("\nReceived signal: ssi_pid %ld, ssi_signo %d\n",
+		       si.ssi_pid, si.ssi_signo);
+		printf("siginfo: ssi_errno %d, ssi_code %d, ssi_status %d\n",
+		       si.ssi_errno, si.ssi_code, si.ssi_status);
+
+		if (si.ssi_signo == SIGCHLD) {
+			if (si.ssi_code == CLD_PREDUMP)
+				printf("predump signal\n");
+			else
+				break;
+		} else if (si.ssi_signo == predump_signal)
+			printf("predump signal\n");
+	}
+
+	printf("Test result: %s\n", (count == 2) ? "PASS" : "FAIL");
+	fflush(stdout);
+}
+
+static void child_func(void)
+{
+	int rc, sig;
+
+	printf("\nChild pid: %ld\n", (long)getpid());
+
+	/* Test: Child should not inherit the predump_signal */
+	rc = prctl(PR_GET_PREDUMP_SIG, &sig, 0, 0, 0);
+	if (rc < 0)
+		handle_error("prctl: child");
+
+	printf("child: predump_signal %d\n", sig);
+
+	/* Force coredump here */
+	printf("child: calling abort()\n");
+	fflush(stdout);
+	abort();
+}
+
+int main(int argc, char *argv[])
+{
+	pid_t child_pid;
+	int rc;
+
+	if (argc != 2) {
+		printf("invalid number of arguments\n");
+		exit(EXIT_FAILURE);
+	}
+
+	if (strcmp(argv[1], "SIGUSR1") == 0)
+		predump_signal = SIGUSR1;
+	else if (strcmp(argv[1], "SIGUSR2") == 0)
+		predump_signal = SIGUSR2;
+	else if (strcmp(argv[1], "SIGCHLD") == 0)
+		predump_signal = SIGCHLD;
+	else {
+		printf("invalid argument for signal\n");
+		fflush(stdout);
+		exit(EXIT_FAILURE);
+	}
+
+	/* Test: prctl() setting */
+	rc = test_prctl(0);
+	printf("prctl: sig %d %s\n", 0, (rc == 0) ? "PASS" : "FAIL");
+	rc = test_prctl(predump_signal);
+	printf("prctl: sig %d %s\n",
+	       predump_signal, (rc == 0) ? "PASS" : "FAIL");
+
+	/* Init signalfd */
+	sigfd = init_signalfd();
+
+	child_pid = fork();
+	if (child_pid == -1)
+		handle_error("fork");
+
+	if (child_pid == 0) {       /* Code executed by child */
+		child_func();
+	} else {                    /* Code executed by parent */
+		parent_func(child_pid);
+		exit(EXIT_SUCCESS);
+	}
+}
-- 
1.8.3.1
