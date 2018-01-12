From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 11/11] signal: Ensure generic siginfos the kernel sends have all bits initialized
Date: Thu, 11 Jan 2018 18:59:40 -0600
Message-ID: <20180112005940.23279-11-ebiederm@xmission.com>
References: <87373b6ghs.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87373b6ghs.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Call clear_siginfo to ensure stack allocated siginfos are fully
initialized before being passed to the signal sending functions.

This ensures that if there is the kind of confusion documented by
TRAP_FIXME, FPE_FIXME, or BUS_FIXME the kernel won't send unitialized
data to userspace when the kernel generates a signal with SI_USER but
the copy to userspace assumes it is a different kind of signal, and
different fields are initialized.

This also prepares the way for turning copy_siginfo_to_user
into a copy_to_user, by removing the need in many cases to perform
a field by field copy simply to skip the uninitialized fields.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/fcntl.c      | 1 +
 ipc/mqueue.c    | 1 +
 kernel/signal.c | 9 ++++++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 0522e283a4f4..c17369659f4a 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -737,6 +737,7 @@ static void send_sigio_to_task(struct task_struct *p,
 			   delivered even if we can't queue.  Failure to
 			   queue in this case _should_ be reported; we fall
 			   back to SIGIO in that case. --sct */
+			clear_siginfo(&si);
 			si.si_signo = signum;
 			si.si_errno = 0;
 		        si.si_code  = reason;
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 9649ecd8a73a..17bc8b874d92 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -639,6 +639,7 @@ static void __do_notify(struct mqueue_inode_info *info)
 		case SIGEV_SIGNAL:
 			/* sends signal */
 
+			clear_siginfo(&sig_i);
 			sig_i.si_signo = info->notify.sigev_signo;
 			sig_i.si_errno = 0;
 			sig_i.si_code = SI_MESGQ;
diff --git a/kernel/signal.c b/kernel/signal.c
index fd182a845490..241d54958bbb 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -549,6 +549,7 @@ static void collect_signal(int sig, struct sigpending *list, siginfo_t *info,
 		 * a fast-pathed signal or we must have been
 		 * out of queue space.  So zero out the info.
 		 */
+		clear_siginfo(info);
 		info->si_signo = sig;
 		info->si_errno = 0;
 		info->si_code = SI_USER;
@@ -1043,6 +1044,7 @@ static int __send_signal(int sig, struct siginfo *info, struct task_struct *t,
 		list_add_tail(&q->list, &pending->list);
 		switch ((unsigned long) info) {
 		case (unsigned long) SEND_SIG_NOINFO:
+			clear_siginfo(&q->info);
 			q->info.si_signo = sig;
 			q->info.si_errno = 0;
 			q->info.si_code = SI_USER;
@@ -1051,6 +1053,7 @@ static int __send_signal(int sig, struct siginfo *info, struct task_struct *t,
 			q->info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
 			break;
 		case (unsigned long) SEND_SIG_PRIV:
+			clear_siginfo(&q->info);
 			q->info.si_signo = sig;
 			q->info.si_errno = 0;
 			q->info.si_code = SI_KERNEL;
@@ -1623,6 +1626,7 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 			sig = SIGCHLD;
 	}
 
+	clear_siginfo(&info);
 	info.si_signo = sig;
 	info.si_errno = 0;
 	/*
@@ -1717,6 +1721,7 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
 		parent = tsk->real_parent;
 	}
 
+	clear_siginfo(&info);
 	info.si_signo = SIGCHLD;
 	info.si_errno = 0;
 	/*
@@ -1929,7 +1934,7 @@ static void ptrace_do_notify(int signr, int exit_code, int why)
 {
 	siginfo_t info;
 
-	memset(&info, 0, sizeof info);
+	clear_siginfo(&info);
 	info.si_signo = signr;
 	info.si_code = exit_code;
 	info.si_pid = task_pid_vnr(current);
@@ -2136,6 +2141,7 @@ static int ptrace_signal(int signr, siginfo_t *info)
 	 * have updated *info via PTRACE_SETSIGINFO.
 	 */
 	if (signr != info->si_signo) {
+		clear_siginfo(info);
 		info->si_signo = signr;
 		info->si_errno = 0;
 		info->si_code = SI_USER;
@@ -2941,6 +2947,7 @@ SYSCALL_DEFINE2(kill, pid_t, pid, int, sig)
 {
 	struct siginfo info;
 
+	clear_siginfo(&info);
 	info.si_signo = sig;
 	info.si_errno = 0;
 	info.si_code = SI_USER;
-- 
2.14.1
