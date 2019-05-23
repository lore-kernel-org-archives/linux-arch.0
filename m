Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:51354 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbfEWBGx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 21:06:53 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 22 May 2019 19:39:13 -0500
Message-ID: <20190523003916.20726-24-ebiederm@xmission.com>
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [REVIEW][PATCH 23/26] signal: Move the computation of force into send_signal and correct it.
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Message-ID: <20190523003913.ev5-PXz0YiSmOqZoP3-vAE-S7G-UOnn80jyKn_L5h9Y@z>

Forcing a signal or not allowing a pid namespace init to ignore
SIGKILL or SIGSTOP is more cleanly computed in send_signal.

There are two cases where we don't allow a pid namespace init
to ignore SIGKILL or SIGSTOP.  If the sending process is
from an ancestor pid namespace and as such is effectively
the god to the target process, and if the it is the kernel
that is sending the signal, not another application.

It is known that a process is from an ancestor pid namespace if
it can see it's target but it's target does not have a pid for
the sender in it's pid namespace.

It is know that a signal is sent from the kernel if si_code is set to
SI_KERNEL or info is SEND_SIG_PRIV (which ultimately generates
a signal with si_code == SI_KERNEL).

The only signals that matter are SIGKILL and SIGSTOP neither of
which can really be caught, and both of which always have a siginfo
layout that includes si_uid and si_pid.  Therefore we never need
to worry about forcing a signal when si_pid and si_uid are absent.

So handle the two special cases of info and the case when si_pid and
si_uid are present.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index b2f0cf3a68aa..0da35880261e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1057,7 +1057,7 @@ static inline bool legacy_queue(struct sigpending *signals, int sig)
 }
 
 static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struct *t,
-			enum pid_type type, int from_ancestor_ns)
+			enum pid_type type, bool force)
 {
 	struct sigpending *pending;
 	struct sigqueue *q;
@@ -1067,8 +1067,7 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 	assert_spin_locked(&t->sighand->siglock);
 
 	result = TRACE_SIGNAL_IGNORED;
-	if (!prepare_signal(sig, t,
-			from_ancestor_ns || (info == SEND_SIG_PRIV)))
+	if (!prepare_signal(sig, t, force))
 		goto ret;
 
 	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
@@ -1198,13 +1197,17 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
 static int send_signal(int sig, struct kernel_siginfo *info, struct task_struct *t,
 			enum pid_type type)
 {
-	int from_ancestor_ns = 0;
-
-#ifdef CONFIG_PID_NS
-	from_ancestor_ns = si_fromuser(info) &&
-			   !task_pid_nr_ns(current, task_active_pid_ns(t));
-#endif
-	if (!is_si_special(info) && has_si_pid_and_uid(info)) {
+	/* Should SIGKILL or SIGSTOP be received by a pid namespace init? */
+	bool force = false;
+
+	if (info == SEND_SIG_NOINFO) {
+		/* Force if sent from an ancestor pid namespace */
+		force = !task_pid_nr_ns(current, task_active_pid_ns(t));
+	} else if (info == SEND_SIG_PRIV) {
+		/* Don't ignore kernel generated signals */
+		force = true;
+	} else if (has_si_pid_and_uid(info)) {
+		/* SIGKILL and SIGSTOP is special or has ids */
 		struct user_namespace *t_user_ns;
 
 		rcu_read_lock();
@@ -1215,10 +1218,16 @@ static int send_signal(int sig, struct kernel_siginfo *info, struct task_struct
 		}
 		rcu_read_unlock();
 
-		if (!task_pid_nr_ns(current, task_active_pid_ns(t)))
+		/* A kernel generated signal? */
+		force = (info->si_code == SI_KERNEL);
+
+		/* From an ancestor pid namespace? */
+		if (!task_pid_nr_ns(current, task_active_pid_ns(t))) {
 			info->si_pid = 0;
+			force = true;
+		}
 	}
-	return __send_signal(sig, info, t, type, from_ancestor_ns);
+	return __send_signal(sig, info, t, type, force);
 }
 
 static void print_fatal_signal(int signr)
@@ -1509,7 +1518,7 @@ int kill_pid_usb_asyncio(int sig, int errno, sigval_t addr,
 
 	if (sig) {
 		if (lock_task_sighand(p, &flags)) {
-			ret = __send_signal(sig, &info, p, PIDTYPE_TGID, 0);
+			ret = __send_signal(sig, &info, p, PIDTYPE_TGID, false);
 			unlock_task_sighand(p, &flags);
 		} else
 			ret = -ESRCH;
-- 
2.21.0
