From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 01/11] signal: Simplify and fix kdb_send_sig
Date: Thu, 11 Jan 2018 18:59:30 -0600
Message-ID: <20180112005940.23279-1-ebiederm@xmission.com>
References: <87373b6ghs.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87373b6ghs.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

- Rename from kdb_send_sig_info to kdb_send_sig
  As there is no meaningful siginfo sent

- Use SEND_SIG_PRIV instead of generating a siginfo for a kdb
  signal.  The generated siginfo had a bogus rationale and was
  not correct in the face of pid namespaces.  SEND_SIG_PRIV
  is simpler and actually correct.

- As the code grabs siglock just send the signal with siglock
  held instead of dropping siglock and attempting to grab it again.

- Move the sig_valid test into kdb_kill where it can generate
  a good error message.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 kernel/debug/kdb/kdb_main.c    | 10 ++--------
 kernel/debug/kdb/kdb_private.h |  2 +-
 kernel/signal.c                | 14 +++++++-------
 3 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index c8146d53ca67..dbb0781a0533 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2441,7 +2441,6 @@ static int kdb_kill(int argc, const char **argv)
 	long sig, pid;
 	char *endp;
 	struct task_struct *p;
-	struct siginfo info;
 
 	if (argc != 2)
 		return KDB_ARGCOUNT;
@@ -2449,7 +2448,7 @@ static int kdb_kill(int argc, const char **argv)
 	sig = simple_strtol(argv[1], &endp, 0);
 	if (*endp)
 		return KDB_BADINT;
-	if (sig >= 0) {
+	if ((sig >= 0) || !valid_signal(-sig)) {
 		kdb_printf("Invalid signal parameter.<-signal>\n");
 		return 0;
 	}
@@ -2470,12 +2469,7 @@ static int kdb_kill(int argc, const char **argv)
 		return 0;
 	}
 	p = p->group_leader;
-	info.si_signo = sig;
-	info.si_errno = 0;
-	info.si_code = SI_USER;
-	info.si_pid = pid;  /* same capabilities as process being signalled */
-	info.si_uid = 0;    /* kdb has root authority */
-	kdb_send_sig_info(p, &info);
+	kdb_send_sig(p, sig);
 	return 0;
 }
 
diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index fc224fbcf954..1e5a502ba4a7 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -208,7 +208,7 @@ extern unsigned long kdb_task_state(const struct task_struct *p,
 extern void kdb_ps_suppressed(void);
 extern void kdb_ps1(const struct task_struct *p);
 extern void kdb_print_nameval(const char *name, unsigned long val);
-extern void kdb_send_sig_info(struct task_struct *p, struct siginfo *info);
+extern void kdb_send_sig(struct task_struct *p, int sig);
 extern void kdb_meminfo_proc_show(void);
 extern char *kdb_getstr(char *, size_t, const char *);
 extern void kdb_gdb_state_pass(char *buf);
diff --git a/kernel/signal.c b/kernel/signal.c
index 9558664bd9ec..c894162ec96c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3684,26 +3684,25 @@ void __init signals_init(void)
 #ifdef CONFIG_KGDB_KDB
 #include <linux/kdb.h>
 /*
- * kdb_send_sig_info - Allows kdb to send signals without exposing
+ * kdb_send_sig - Allows kdb to send signals without exposing
  * signal internals.  This function checks if the required locks are
  * available before calling the main signal code, to avoid kdb
  * deadlocks.
  */
-void
-kdb_send_sig_info(struct task_struct *t, struct siginfo *info)
+void kdb_send_sig(struct task_struct *t, int sig)
 {
 	static struct task_struct *kdb_prev_t;
-	int sig, new_t;
+	int new_t, ret;
 	if (!spin_trylock(&t->sighand->siglock)) {
 		kdb_printf("Can't do kill command now.\n"
 			   "The sigmask lock is held somewhere else in "
 			   "kernel, try again later\n");
 		return;
 	}
-	spin_unlock(&t->sighand->siglock);
 	new_t = kdb_prev_t != t;
 	kdb_prev_t = t;
 	if (t->state != TASK_RUNNING && new_t) {
+		spin_unlock(&t->sighand->siglock);
 		kdb_printf("Process is not RUNNING, sending a signal from "
 			   "kdb risks deadlock\n"
 			   "on the run queue locks. "
@@ -3712,8 +3711,9 @@ kdb_send_sig_info(struct task_struct *t, struct siginfo *info)
 			   "the deadlock.\n");
 		return;
 	}
-	sig = info->si_signo;
-	if (send_sig_info(sig, info, t))
+	ret = send_signal(sig, SEND_SIG_PRIV, t, false);
+	spin_unlock(&t->sighand->siglock);
+	if (ret)
 		kdb_printf("Fail to deliver Signal %d to process %d.\n",
 			   sig, t->pid);
 	else
-- 
2.14.1
