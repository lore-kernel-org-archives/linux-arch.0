From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 05/11] xtensa: check thread flags atomically on return from user exception
Date: Fri, 30 Aug 2013 19:34:57 +0400
Message-ID: <1377876903-27860-6-git-send-email-jcmvbkbc@gmail.com>
References: <1377876903-27860-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:58834 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756563Ab3H3PfV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 Aug 2013 11:35:21 -0400
Received: by mail-la0-f50.google.com with SMTP id es20so1693987lab.9
        for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2013 08:35:19 -0700 (PDT)
In-Reply-To: <1377876903-27860-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

Check pending signals and rescheduling thread flags with interrupts
disabled, and don't enable them if no flags are set. Call
trace_hardirqs_on after thread flags handling, so that rescheduling is
done and hardirqs tracking flag is updated in the correct task context.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- remove unneeded call to trace_hardirqs_off from the loop after
  rsil a2, LOCKLEVEL

 arch/xtensa/kernel/entry.S |   39 +++++++++++++++++++++------------------
 1 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index 9298742..03709ef 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -423,29 +423,14 @@ common_exception:
 	.global common_exception_return
 common_exception_return:
 
-#ifdef CONFIG_TRACE_IRQFLAGS
-	l32i	a4, a1, PT_DEPC
-	/* Double exception means we came here with an exception
-	 * while PS.EXCM was set, i.e. interrupts disabled.
-	 */
-	bgeui	a4, VALID_DOUBLE_EXCEPTION_ADDRESS, 1f
-	l32i	a4, a1, PT_EXCCAUSE
-	bnei	a4, EXCCAUSE_LEVEL1_INTERRUPT, 1f
-	/* We came here with an interrupt means interrupts were enabled
-	 * and we'll reenable them on return.
-	 */
-	movi	a4, trace_hardirqs_on
-	callx4	a4
 1:
-#endif
+	rsil	a2, LOCKLEVEL
 
 	/* Jump if we are returning from kernel exceptions. */
 
-1:	l32i	a3, a1, PT_PS
+	l32i	a3, a1, PT_PS
 	_bbci.l	a3, PS_UM_BIT, 4f
 
-	rsil	a2, 0
-
 	/* Specific to a user exception exit:
 	 * We need to check some flags for signal handling and rescheduling,
 	 * and have to restore WB and WS, extra states, and all registers
@@ -465,6 +450,7 @@ common_exception_return:
 
 	/* Call do_signal() */
 
+	rsil	a2, 0
 	movi	a4, do_notify_resume	# int do_notify_resume(struct pt_regs*)
 	mov	a6, a1
 	callx4	a4
@@ -472,6 +458,7 @@ common_exception_return:
 
 3:	/* Reschedule */
 
+	rsil	a2, 0
 	movi	a4, schedule	# void schedule (void)
 	callx4	a4
 	j	1b
@@ -483,7 +470,23 @@ common_exception_return:
 	movi	a4, check_tlb_sanity
 	callx4	a4
 #endif
-4:	/* Restore optional registers. */
+4:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	l32i	a4, a1, PT_DEPC
+	/* Double exception means we came here with an exception
+	 * while PS.EXCM was set, i.e. interrupts disabled.
+	 */
+	bgeui	a4, VALID_DOUBLE_EXCEPTION_ADDRESS, 1f
+	l32i	a4, a1, PT_EXCCAUSE
+	bnei	a4, EXCCAUSE_LEVEL1_INTERRUPT, 1f
+	/* We came here with an interrupt means interrupts were enabled
+	 * and we'll reenable them on return.
+	 */
+	movi	a4, trace_hardirqs_on
+	callx4	a4
+1:
+#endif
+	/* Restore optional registers. */
 
 	load_xtregs_opt a1 a2 a4 a5 a6 a7 PT_XTREGS_OPT
 
-- 
1.7.7.6
