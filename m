Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:51358 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbfEWBGy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 21:06:54 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 22 May 2019 19:39:15 -0500
Message-ID: <20190523003916.20726-26-ebiederm@xmission.com>
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [REVIEW][PATCH 25/26] signal: Factor force_sig_info_to_task out of force_sig_info
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Message-ID: <20190523003915.tcueaKcW1RwxthhkH7_m7aRdnAmrg3VEeQyc4Y2TRHM@z>

All callers of force_sig_info pass info.si_signo in for the signal
by definition as well as in practice.

Further all callers of force_sig_info except force_sig_fault_to_task
pass current as the target task to force_sig_info.

Factor out a static force_sig_info_to_task that
force_sig_fault_to_task can call.

This prepares the way for force_sig_info to have it's task and signal
parameters removed.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index d5f9ed5da9c5..0984158cd41a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1294,12 +1294,13 @@ int do_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p
  * We don't want to have recursive SIGSEGV's etc, for example,
  * that is why we also clear SIGNAL_UNKILLABLE.
  */
-int
-force_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *t)
+static int
+force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t)
 {
 	unsigned long int flags;
 	int ret, blocked, ignored;
 	struct k_sigaction *action;
+	int sig = info->si_signo;
 
 	spin_lock_irqsave(&t->sighand->siglock, flags);
 	action = &t->sighand->action[sig-1];
@@ -1324,6 +1325,11 @@ force_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *t)
 	return ret;
 }
 
+int force_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *t)
+{
+	return force_sig_info_to_task(info, t);
+}
+
 /*
  * Nuke all other threads in the group.
  */
@@ -1656,7 +1662,7 @@ int force_sig_fault_to_task(int sig, int code, void __user *addr
 	info.si_flags = flags;
 	info.si_isr = isr;
 #endif
-	return force_sig_info(info.si_signo, &info, t);
+	return force_sig_info_to_task(&info, t);
 }
 
 int force_sig_fault(int sig, int code, void __user *addr
-- 
2.21.0
