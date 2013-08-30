From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 06/11] xtensa: enable kernel preemption
Date: Fri, 30 Aug 2013 19:34:58 +0400
Message-ID: <1377876903-27860-7-git-send-email-jcmvbkbc@gmail.com>
References: <1377876903-27860-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:38554 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756580Ab3H3PfW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 Aug 2013 11:35:22 -0400
Received: by mail-lb0-f177.google.com with SMTP id p5so1942237lbi.8
        for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2013 08:35:20 -0700 (PDT)
In-Reply-To: <1377876903-27860-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/entry.S |   45 ++++++++++++++++---------------------------
 1 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index 03709ef..3f3de28 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -31,7 +31,6 @@
 /* Unimplemented features. */
 
 #undef KERNEL_STACK_OVERFLOW_CHECK
-#undef PREEMPTIBLE_KERNEL
 #undef ALLOCA_EXCEPTION_IN_IRAM
 
 /* Not well tested.
@@ -429,7 +428,9 @@ common_exception_return:
 	/* Jump if we are returning from kernel exceptions. */
 
 	l32i	a3, a1, PT_PS
-	_bbci.l	a3, PS_UM_BIT, 4f
+	GET_THREAD_INFO(a2, a1)
+	l32i	a4, a2, TI_FLAGS
+	_bbci.l	a3, PS_UM_BIT, 6f
 
 	/* Specific to a user exception exit:
 	 * We need to check some flags for signal handling and rescheduling,
@@ -438,9 +439,6 @@ common_exception_return:
 	 * Note that we don't disable interrupts here. 
 	 */
 
-	GET_THREAD_INFO(a2,a1)
-	l32i	a4, a2, TI_FLAGS
-
 	_bbsi.l	a4, TIF_NEED_RESCHED, 3f
 	_bbsi.l	a4, TIF_NOTIFY_RESUME, 2f
 	_bbci.l	a4, TIF_SIGPENDING, 5f
@@ -463,6 +461,19 @@ common_exception_return:
 	callx4	a4
 	j	1b
 
+#ifdef CONFIG_PREEMPT
+6:
+	_bbci.l	a4, TIF_NEED_RESCHED, 4f
+
+	/* Check current_thread_info->preempt_count */
+
+	l32i	a4, a2, TI_PRE_COUNT
+	bnez	a4, 4f
+	movi	a4, preempt_schedule_irq
+	callx4	a4
+	j	1b
+#endif
+
 5:
 #ifdef CONFIG_DEBUG_TLB_SANITY
 	l32i	a4, a1, PT_DEPC
@@ -470,6 +481,7 @@ common_exception_return:
 	movi	a4, check_tlb_sanity
 	callx4	a4
 #endif
+6:
 4:
 #ifdef CONFIG_TRACE_IRQFLAGS
 	l32i	a4, a1, PT_DEPC
@@ -573,29 +585,6 @@ user_exception_exit:
 
 kernel_exception_exit:
 
-#ifdef PREEMPTIBLE_KERNEL
-
-#ifdef CONFIG_PREEMPT
-
-	/*
-	 * Note: We've just returned from a call4, so we have
-	 * at least 4 addt'l regs.
-	 */
-
-	/* Check current_thread_info->preempt_count */
-
-	GET_THREAD_INFO(a2)
-	l32i	a3, a2, TI_PREEMPT
-	bnez	a3, 1f
-
-	l32i	a2, a2, TI_FLAGS
-
-1:
-
-#endif
-
-#endif
-
 	/* Check if we have to do a movsp.
 	 *
 	 * We only have to do a movsp if the previous window-frame has
-- 
1.7.7.6
