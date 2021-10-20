Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FA9C433F5
	for <linux-arch@archiver.kernel.org>; Wed, 20 Oct 2021 17:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F5AB611C7
	for <linux-arch@archiver.kernel.org>; Wed, 20 Oct 2021 17:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhJTRrz (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 20 Oct 2021 13:47:55 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43460 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbhJTRrf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 13:47:35 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:50546)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeL-00EwLs-CW; Wed, 20 Oct 2021 11:45:13 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeK-001NdN-BG; Wed, 20 Oct 2021 11:45:12 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed, 20 Oct 2021 12:43:59 -0500
Message-Id: <20211020174406.17889-13-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFeK-001NdN-BG;;;mid=<20211020174406.17889-13-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/LrFZ5WNu6xf41vTwYm9k00qKFq3OyObA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 13/20] signal: Implement force_fatal_sig
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a simple helper force_fatal_sig that causes a signal to be
delivered to a process as if the signal handler was set to SIG_DFL.

Reimplement force_sigsegv based upon this new helper.  This fixes
force_sigsegv so that when it forces the default signal handler
to be used the code now forces the signal to be unblocked as well.

Reusing the tested logic in force_sig_info_to_task that was built for
force_sig_seccomp this makes the implementation trivial.

This is interesting both because it makes force_sigsegv simpler and
because there are a couple of buggy places in the kernel that call
do_exit(SIGILL) or do_exit(SIGSYS) because there is no straight
forward way today for those places to simply force the exit of a
process with the chosen signal.  Creating force_fatal_sig allows
those places to be implemented with normal signal exits.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h |  1 +
 kernel/signal.c              | 26 +++++++++++++++++---------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index e5f4ce622ee6..e2dc9f119ada 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -338,6 +338,7 @@ extern int kill_pid(struct pid *pid, int sig, int priv);
 extern __must_check bool do_notify_parent(struct task_struct *, int);
 extern void __wake_up_parent(struct task_struct *p, struct task_struct *parent);
 extern void force_sig(int);
+extern void force_fatal_sig(int);
 extern int send_sig(int, struct task_struct *, int);
 extern int zap_other_threads(struct task_struct *p);
 extern struct sigqueue *sigqueue_alloc(void);
diff --git a/kernel/signal.c b/kernel/signal.c
index 952741f6d0f9..6a5e1802b9a2 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1662,6 +1662,19 @@ void force_sig(int sig)
 }
 EXPORT_SYMBOL(force_sig);
 
+void force_fatal_sig(int sig)
+{
+	struct kernel_siginfo info;
+
+	clear_siginfo(&info);
+	info.si_signo = sig;
+	info.si_errno = 0;
+	info.si_code = SI_KERNEL;
+	info.si_pid = 0;
+	info.si_uid = 0;
+	force_sig_info_to_task(&info, current, true);
+}
+
 /*
  * When things go south during signal handling, we
  * will force a SIGSEGV. And if the signal that caused
@@ -1670,15 +1683,10 @@ EXPORT_SYMBOL(force_sig);
  */
 void force_sigsegv(int sig)
 {
-	struct task_struct *p = current;
-
-	if (sig == SIGSEGV) {
-		unsigned long flags;
-		spin_lock_irqsave(&p->sighand->siglock, flags);
-		p->sighand->action[sig - 1].sa.sa_handler = SIG_DFL;
-		spin_unlock_irqrestore(&p->sighand->siglock, flags);
-	}
-	force_sig(SIGSEGV);
+	if (sig == SIGSEGV)
+		force_fatal_sig(SIGSEGV);
+	else
+		force_sig(SIGSEGV);
 }
 
 int force_sig_fault_to_task(int sig, int code, void __user *addr
-- 
2.20.1

