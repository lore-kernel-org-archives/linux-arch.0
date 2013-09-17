From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 5/6] sparc: Use preempt_schedule_irq
Date: Tue, 17 Sep 2013 18:53:08 -0000
Message-ID: <20130917183628.966769884@linutronix.de>
References: <20130917082838.218329307@infradead.org>
 <20130917182350.449685712@linutronix.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54509 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667Ab3IQSxL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Sep 2013 14:53:11 -0400
Content-Disposition: inline; filename=sparc-use-preempt-schedule-irq.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andi Kleen <ak@linux.intel.com>, Peter Anvin <hpa@zytor.com>, Mike Galbraith <bitbucket@online.de>, Arjan van de Ven <arjan@linux.intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, "David S. Miller" <davem@davemloft.net>

The low level preemption code fiddles with the PREEMPT_ACTIVE bit for
no reason and calls schedule() with interrupts disabled, which is
wrong to begin with. Remove the PREEMPT_ACTIVE fiddling and call the
proper schedule_preempt_irq() function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org

---
 arch/sparc/kernel/rtrap_64.S |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: linux-2.6/arch/sparc/kernel/rtrap_64.S
===================================================================
--- linux-2.6.orig/arch/sparc/kernel/rtrap_64.S
+++ linux-2.6/arch/sparc/kernel/rtrap_64.S
@@ -306,12 +306,9 @@ to_kernel:
 		 nop
 		cmp			%l4, 0
 		bne,pn			%xcc, kern_fpucheck
-		 sethi			%hi(PREEMPT_ACTIVE), %l6
-		stw			%l6, [%g6 + TI_PRE_COUNT]
-		call			schedule
+		call			preempt_schedule_irq
 		 nop
 		ba,pt			%xcc, rtrap
-		 stw			%g0, [%g6 + TI_PRE_COUNT]
 #endif
 kern_fpucheck:	ldub			[%g6 + TI_FPDEPTH], %l5
 		brz,pt			%l5, rt_continue
