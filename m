Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33201 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932300Ab3CUVxQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 Mar 2013 17:53:16 -0400
Message-ID: <20130321215234.754954871@linutronix.de>
Date: Thu, 21 Mar 2013 21:53:14 -0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 22/34] mips: Use generic idle loop
References: <20130321214930.752934102@linutronix.de>
Content-Disposition: inline; filename=mips-use-generic-idle-loop.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Magnus Damm <magnus.damm@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
Message-ID: <20130321215314.kMRe_2fuH0vOO0D1A_BYJkfCkZwn5iQz1O8k7ESFOSs@z>

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/Kconfig          |    1 
 arch/mips/kernel/process.c |   46 ++++++++++++---------------------------------
 arch/mips/kernel/smp.c     |    2 -
 3 files changed, 15 insertions(+), 34 deletions(-)

Index: linux-2.6/arch/mips/Kconfig
===================================================================
--- linux-2.6.orig/arch/mips/Kconfig
+++ linux-2.6/arch/mips/Kconfig
@@ -34,6 +34,7 @@ config MIPS
 	select HAVE_MEMBLOCK_NODE_MAP
 	select ARCH_DISCARD_MEMBLOCK
 	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_IDLE_LOOP
 	select BUILDTIME_EXTABLE_SORT
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CMOS_UPDATE
Index: linux-2.6/arch/mips/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/process.c
+++ linux-2.6/arch/mips/kernel/process.c
@@ -41,44 +41,24 @@
 #include <asm/inst.h>
 #include <asm/stacktrace.h>
 
-/*
- * The idle thread. There's no useful work to be done, so just try to conserve
- * power and have a low exit latency (ie sit in a loop waiting for somebody to
- * say that they'd like to reschedule)
- */
-void __noreturn cpu_idle(void)
+void arch_cpu_idle_dead(void)
 {
-	int cpu;
-
-	/* CPU is going idle. */
-	cpu = smp_processor_id();
+	/* What the heck is this check doing ? */
+	if (!cpu_isset(cpu, cpu_callin_map))
+		play_dead();}
+}
 
-	/* endless idle loop with no priority at all */
-	while (1) {
-		tick_nohz_idle_enter();
-		rcu_idle_enter();
-		while (!need_resched() && cpu_online(cpu)) {
+void arch__cpu_idle(void)
+{
 #ifdef CONFIG_MIPS_MT_SMTC
-			extern void smtc_idle_loop_hook(void);
+	extern void smtc_idle_loop_hook(void);
 
-			smtc_idle_loop_hook();
+	smtc_idle_loop_hook();
 #endif
-
-			if (cpu_wait) {
-				/* Don't trace irqs off for idle */
-				stop_critical_timings();
-				(*cpu_wait)();
-				start_critical_timings();
-			}
-		}
-#ifdef CONFIG_HOTPLUG_CPU
-		if (!cpu_online(cpu) && !cpu_isset(cpu, cpu_callin_map))
-			play_dead();
-#endif
-		rcu_idle_exit();
-		tick_nohz_idle_exit();
-		schedule_preempt_disabled();
-	}
+	if (cpu_wait)
+		(*cpu_wait)();
+	else
+		local_irq_enable();
 }
 
 asmlinkage void ret_from_fork(void);
Index: linux-2.6/arch/mips/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/smp.c
+++ linux-2.6/arch/mips/kernel/smp.c
@@ -139,7 +139,7 @@ asmlinkage __cpuinit void start_secondar
 	WARN_ON_ONCE(!irqs_disabled());
 	mp_ops->smp_finish();
 
-	cpu_idle();
+	cpu_startup_entry(CPUHP_ONLINE);
 }
 
 /*


