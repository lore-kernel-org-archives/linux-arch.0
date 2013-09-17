Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54495 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514Ab3IQSxJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Sep 2013 14:53:09 -0400
Message-ID: <20130917183628.758421136@linutronix.de>
Date: Tue, 17 Sep 2013 18:53:07 -0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 3/6] m32r: Use preempt_schedule_irq
References: <20130917082838.218329307@infradead.org>
 <20130917182350.449685712@linutronix.de>
Content-Disposition: inline; filename=m32r-use-preempt-schedule-irq.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andi Kleen <ak@linux.intel.com>, Peter Anvin <hpa@zytor.com>, Mike Galbraith <bitbucket@online.de>, Arjan van de Ven <arjan@linux.intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, Hirokazu Takata <takata@linux-m32r.org>
Message-ID: <20130917185307.atBqhdccauu_0jG9PDJZwELvJVq7TViLbL31zSd70h0@z>

Use the proper core function instead of fiddling with preempt_active
and interrupt enable in the low level code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-m32r-ja@ml.linux-m32r.org

---
 arch/m32r/kernel/entry.S |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

Index: linux-2.6/arch/m32r/kernel/entry.S
===================================================================
--- linux-2.6.orig/arch/m32r/kernel/entry.S
+++ linux-2.6/arch/m32r/kernel/entry.S
@@ -182,13 +182,7 @@ need_resched:
 	ld	r4, PSW(sp)		; interrupts off (exception path) ?
 	and3	r4, r4, #0x4000
 	beqz	r4, restore_all
-	LDIMM	(r4, PREEMPT_ACTIVE)
-	st	r4, @(TI_PRE_COUNT, r8)
-	ENABLE_INTERRUPTS(r4)
-	bl	schedule
-	ldi	r4, #0
-	st	r4, @(TI_PRE_COUNT, r8)
-	DISABLE_INTERRUPTS(r4)
+	bl	preempt_schedule_irq
 	bra	need_resched
 #endif
 


