From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 2/6] h8300: Use schedule_preempt_irq
Date: Tue, 17 Sep 2013 18:53:06 -0000
Message-ID: <20130917183628.646285522@linutronix.de>
References: <20130917082838.218329307@infradead.org>
 <20130917182350.449685712@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=h8300-use-schedule-preempt-irq.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andi Kleen <ak@linux.intel.com>, Peter Anvin <hpa@zytor.com>, Mike Galbraith <bitbucket@online.de>, Arjan van de Ven <arjan@linux.intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-arch.vger.kernel.org

Use the proper function instead of fiddling with PREEMPT_ACTIVE and
interrupt enable/disable in the low level code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>

---
 arch/h8300/kernel/entry.S |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Index: linux-2.6/arch/h8300/kernel/entry.S
===================================================================
--- linux-2.6.orig/arch/h8300/kernel/entry.S
+++ linux-2.6/arch/h8300/kernel/entry.S
@@ -316,13 +316,9 @@ need_resched:
 	beq	restore_all:8
 	mov.b	@(LCCR+1:16,sp),r0l	/* Interrupt Enabled? */
 	bmi	restore_all:8
-	mov.l	#PREEMPT_ACTIVE,er0
-	mov.l	er0,@(TI_PRE_COUNT:16,er4)
-	andc	#0x7f,ccr
 	mov.l	sp,er0
 	jsr	@_set_esp0
-	jsr	@_schedule
-	orc	#0x80,ccr
+	jsr	@_preempt_schedule_irq
 	bra	need_resched:8
 #endif
 
