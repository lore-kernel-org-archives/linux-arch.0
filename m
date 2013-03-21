From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 06/34] arc: Use generic idle loop
Date: Thu, 21 Mar 2013 21:53:00 -0000
Message-ID: <20130321215233.711253792@linutronix.de>
References: <20130321214930.752934102@linutronix.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33052 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932171Ab3CUVxC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 Mar 2013 17:53:02 -0400
Content-Disposition: inline; filename=arc-use-generic-idle-loop.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Magnus Damm <magnus.damm@gmail.com>, Vineet Gupta <vgupta@synopsys.com>

The generic idle loop implements all functionality. Aside of that it
allows arc to implement the tsk_is_polling() functionality correctly,
despite the patently (now gone) comment in the original arc cpu_idle()
function:
/* Since we SLEEP in idle loop, TIF_POLLING_NRFLAG can't be set */
See kernel/cpu/idle.c

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/Kconfig          |    1 +
 arch/arc/kernel/process.c |   27 +--------------------------
 arch/arc/kernel/smp.c     |    2 +-
 3 files changed, 3 insertions(+), 27 deletions(-)

Index: linux-2.6/arch/arc/Kconfig
===================================================================
--- linux-2.6.orig/arch/arc/Kconfig
+++ linux-2.6/arch/arc/Kconfig
@@ -20,6 +20,7 @@ config ARC
 	select GENERIC_KERNEL_THREAD
 	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_IDLE_LOOP
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_GENERIC_HARDIRQS
Index: linux-2.6/arch/arc/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/arc/kernel/process.c
+++ linux-2.6/arch/arc/kernel/process.c
@@ -41,37 +41,12 @@ SYSCALL_DEFINE0(arc_gettls)
 	return task_thread_info(current)->thr_ptr;
 }
 
-static inline void arch_idle(void)
+void arch_cpu_idle(void)
 {
 	/* sleep, but enable all interrupts before committing */
 	__asm__("sleep 0x3");
 }
 
-void cpu_idle(void)
-{
-	/* Since we SLEEP in idle loop, TIF_POLLING_NRFLAG can't be set */
-
-	/* endless idle loop with no priority at all */
-	while (1) {
-		tick_nohz_idle_enter();
-		rcu_idle_enter();
-
-doze:
-		local_irq_disable();
-		if (!need_resched()) {
-			arch_idle();
-			goto doze;
-		} else {
-			local_irq_enable();
-		}
-
-		rcu_idle_exit();
-		tick_nohz_idle_exit();
-
-		schedule_preempt_disabled();
-	}
-}
-
 asmlinkage void ret_from_fork(void);
 
 /* Layout of Child kernel mode stack as setup at the end of this function is
Index: linux-2.6/arch/arc/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/arc/kernel/smp.c
+++ linux-2.6/arch/arc/kernel/smp.c
@@ -141,7 +141,7 @@ void __cpuinit start_kernel_secondary(vo
 
 	local_irq_enable();
 	preempt_disable();
-	cpu_idle();
+	cpu_startup_entry(CPUHP_ONLINE);
 }
 
 /*
