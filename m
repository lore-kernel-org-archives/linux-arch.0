Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1C0C49EA6
	for <linux-arch@archiver.kernel.org>; Thu, 24 Jun 2021 19:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A7D613D3
	for <linux-arch@archiver.kernel.org>; Thu, 24 Jun 2021 19:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhFXTDt (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:03:49 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:36308 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhFXTDs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Jun 2021 15:03:48 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lwUbQ-0009Qk-PD; Thu, 24 Jun 2021 13:01:28 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47150 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lwUbP-003Rm9-NH; Thu, 24 Jun 2021 13:01:28 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
References: <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
        <87sg1lwhvm.fsf@disp2133>
        <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
        <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
        <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
        <87eed4v2dc.fsf@disp2133>
        <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
        <87fsxjorgs.fsf@disp2133>
        <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
        <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
        <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
        <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
        <87a6njf0ia.fsf@disp2133>
        <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
        <87tulpbp19.fsf@disp2133>
        <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
        <87zgvgabw1.fsf@disp2133> <875yy3850g.fsf_-_@disp2133>
Date:   Thu, 24 Jun 2021 14:01:20 -0500
In-Reply-To: <875yy3850g.fsf_-_@disp2133> (Eric W. Biederman's message of
        "Thu, 24 Jun 2021 13:57:35 -0500")
Message-ID: <87czsb6q9r.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lwUbP-003Rm9-NH;;;mid=<87czsb6q9r.fsf_-_@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+PJXbb1itesHXgjxe+XHQIzMBZMGxsoRk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 4/9] signal: Factor start_group_exit out of complete_signal
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h |  2 ++
 kernel/signal.c              | 52 +++++++++++++++++++++++++-----------
 2 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 774be5d3ac3e..c007e55cb119 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -428,6 +428,8 @@ static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
 	signal_wake_up_state(t, resume ? __TASK_TRACED : 0);
 }
 
+void start_group_exit(int exit_code);
+
 void task_join_group_stop(struct task_struct *task);
 
 #ifdef TIF_RESTORE_SIGMASK
diff --git a/kernel/signal.c b/kernel/signal.c
index da37cc4515f2..c79c010ca5f3 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1027,6 +1027,42 @@ static inline bool wants_signal(int sig, struct task_struct *p)
 	return task_curr(p) || !task_sigpending(p);
 }
 
+static void start_group_exit_locked(struct signal_struct *signal, int exit_code)
+{
+	/*
+	 * Start a group exit and wake everybody up.
+	 * This way we don't have other threads
+	 * running and doing things after a slower
+	 * thread has the fatal signal pending.
+	 */
+	struct task_struct *t;
+
+	signal->flags = SIGNAL_GROUP_EXIT;
+	signal->group_exit_code = exit_code;
+	signal->group_stop_count = 0;
+	__for_each_thread(signal, t) {
+		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
+
+		/* Don't bother with already dead threads */
+		if (t->exit_state)
+			continue;
+		sigaddset(&t->pending.signal, SIGKILL);
+		signal_wake_up(t, 1);
+	}
+}
+
+void start_group_exit(int exit_code)
+{
+	if (!fatal_signal_pending(current)) {
+		struct sighand_struct *const sighand = current->sighand;
+
+		spin_lock_irq(&sighand->siglock);
+		if (!fatal_signal_pending(current))
+			start_group_exit_locked(current->signal, exit_code);
+		spin_unlock_irq(&sighand->siglock);
+	}
+}
+
 static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 {
 	struct signal_struct *signal = p->signal;
@@ -1076,21 +1112,7 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 		 * This signal will be fatal to the whole group.
 		 */
 		if (!sig_kernel_coredump(sig)) {
-			/*
-			 * Start a group exit and wake everybody up.
-			 * This way we don't have other threads
-			 * running and doing things after a slower
-			 * thread has the fatal signal pending.
-			 */
-			signal->flags = SIGNAL_GROUP_EXIT;
-			signal->group_exit_code = sig;
-			signal->group_stop_count = 0;
-			t = p;
-			do {
-				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
-				sigaddset(&t->pending.signal, SIGKILL);
-				signal_wake_up(t, 1);
-			} while_each_thread(p, t);
+			start_group_exit_locked(signal, sig);
 			return;
 		}
 	}
-- 
2.20.1

