From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 34/34] xtensa: Use generic idle loop
Date: Thu, 21 Mar 2013 21:53:24 -0000
Message-ID: <20130321215235.546600507@linutronix.de>
References: <20130321214930.752934102@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=xtensa-use-generic-idle-loop.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Magnus Damm <magnus.damm@gmail.com>, Chris Zankel <chris@zankel.net>
List-Id: linux-arch.vger.kernel.org

Unfortunately this arch does not compile at all :(

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Chris Zankel <chris@zankel.net>
---
 arch/xtensa/Kconfig          |    1 +
 arch/xtensa/kernel/process.c |   14 ++------------
 2 files changed, 3 insertions(+), 12 deletions(-)

Index: linux-2.6/arch/xtensa/Kconfig
===================================================================
--- linux-2.6.orig/arch/xtensa/Kconfig
+++ linux-2.6/arch/xtensa/Kconfig
@@ -19,6 +19,7 @@ config XTENSA
 	select CLONE_BACKWARDS
 	select IRQ_DOMAIN
 	select HAVE_OPROFILE
+	select GENERIC_IDLE_LOOP
 	help
 	  Xtensa processors are 32-bit RISC machines designed by Tensilica
 	  primarily for embedded systems.  These processors are both
Index: linux-2.6/arch/xtensa/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/xtensa/kernel/process.c
+++ linux-2.6/arch/xtensa/kernel/process.c
@@ -105,19 +105,9 @@ void coprocessor_flush_all(struct thread
 /*
  * Powermanagement idle function, if any is provided by the platform.
  */
-
-void cpu_idle(void)
+void arch_cpu_idle(void)
 {
-	local_irq_enable();
-
-	/* endless idle loop with no priority at all */
-	while (1) {
-		rcu_idle_enter();
-		while (!need_resched())
-			platform_idle();
-		rcu_idle_exit();
-		schedule_preempt_disabled();
-	}
+	platform_idle();
 }
 
 /*
