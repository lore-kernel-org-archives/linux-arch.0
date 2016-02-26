From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 17/20] arch/hotplug: Call into idle with a proper state
Date: Fri, 26 Feb 2016 18:43:40 -0000
Message-ID: <20160226182341.614102639@linutronix.de>
References: <20160226164321.657646833@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=arch-hotplug--Call-into-idle-with-a-proper-state.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>
List-Id: linux-arch.vger.kernel.org

Let the non boot cpus call into idle with the corresponding hotplug state, so
the hotplug core can handle the further bringup. That's a first step to
convert the boot side of the hotplugged cpus to do all the synchronization
with the other side through the state machine. For now it'll only start the
hotplug thread and kick the full bringup of the cpu.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/alpha/kernel/smp.c         |    2 +-
 arch/arc/kernel/smp.c           |    2 +-
 arch/arm/kernel/smp.c           |    2 +-
 arch/arm64/kernel/smp.c         |    2 +-
 arch/blackfin/mach-common/smp.c |    2 +-
 arch/hexagon/kernel/smp.c       |    2 +-
 arch/ia64/kernel/smpboot.c      |    2 +-
 arch/m32r/kernel/smpboot.c      |    2 +-
 arch/metag/kernel/smp.c         |    2 +-
 arch/mips/kernel/smp.c          |    2 +-
 arch/mn10300/kernel/smp.c       |    2 +-
 arch/parisc/kernel/smp.c        |    2 +-
 arch/powerpc/kernel/smp.c       |    2 +-
 arch/s390/kernel/smp.c          |    2 +-
 arch/sh/kernel/smp.c            |    2 +-
 arch/sparc/kernel/smp_32.c      |    2 +-
 arch/sparc/kernel/smp_64.c      |    2 +-
 arch/tile/kernel/smpboot.c      |    2 +-
 arch/x86/kernel/smpboot.c       |    2 +-
 arch/x86/xen/smp.c              |    2 +-
 arch/xtensa/kernel/smp.c        |    2 +-
 include/linux/cpuhotplug.h      |    1 +
 22 files changed, 22 insertions(+), 21 deletions(-)

Index: b/arch/alpha/kernel/smp.c
===================================================================
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -168,7 +168,7 @@ smp_callin(void)
 	      cpuid, current, current->active_mm));
 
 	preempt_disable();
-	cpu_startup_entry(CPUHP_ONLINE);
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
 /* Wait until hwrpb->txrdy is clear for cpu.  Return -1 on timeout.  */
Index: b/arch/arc/kernel/smp.c
===================================================================
--- a/arch/arc/kernel/smp.c
+++ b/arch/arc/kernel/smp.c
@@ -142,7 +142,7 @@ void start_kernel_secondary(void)
 
 	local_irq_enable();
 	preempt_disable();
-	cpu_startup_entry(CPUHP_ONLINE);
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
 /*
Index: b/arch/arm/kernel/smp.c
===================================================================
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -409,7 +409,7 @@ asmlinkage void secondary_start_kernel(v
 	/*
 	 * OK, it's off to the idle thread for us
 	 */
-	cpu_startup_entry(CPUHP_ONLINE);
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
 void __init smp_cpus_done(unsigned int max_cpus)
Index: b/arch/arm64/kernel/smp.c
===================================================================
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -195,7 +195,7 @@ asmlinkage void secondary_start_kernel(v
 	/*
 	 * OK, it's off to the idle thread for us
 	 */
-	cpu_startup_entry(CPUHP_ONLINE);
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
Index: b/arch/blackfin/mach-common/smp.c
===================================================================
--- a/arch/blackfin/mach-common/smp.c
+++ b/arch/blackfin/mach-common/smp.c
@@ -333,7 +333,7 @@ void secondary_start_kernel(void)
 
 	/* We are done with local CPU inits, unblock the boot CPU. */
 	set_cpu_online(cpu, true);
-	cpu_startup_entry(CPUHP_ONLINE);
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
 void __init smp_prepare_boot_cpu(void)
Index: b/arch/hexagon/kernel/smp.c
===================================================================
--- a/arch/hexagon/kernel/smp.c
+++ b/arch/hexagon/kernel/smp.c
@@ -180,7 +180,7 @@ void start_secondary(void)
 
 	local_irq_enable();
 
-	cpu_startup_entry(CPUHP_ONLINE);
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
 
Index: b/arch/ia64/kernel/smpboot.c
===================================================================
--- a/arch/ia64/kernel/smpboot.c
+++ b/arch/ia64/kernel/smpboot.c
@@ -454,7 +454,7 @@ start_secondary (void *unused)
 	preempt_disable();
 	smp_callin();
 
-	cpu_startup_entry(CPUHP_ONLINE);
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 	return 0;
 }
 
Index: b/arch/m32r/kernel/smpboot.c
===================================================================
--- a/arch/m32r/kernel/smpboot.c
+++ b/arch/m32r/kernel/smpboot.c
@@ -432,7 +432,7 @@ int __init start_secondary(void *unused)
 	 */
 	local_flush_tlb_all();
 
-	cpu_startup_entry(CPUHP_ONLINE);
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 	return 0;
 }
 
Index: b/arch/metag/kernel/smp.c
===================================================================
--- a/arch/metag/kernel/smp.c
+++ b/arch/metag/kernel/smp.c
@@ -396,7 +396,7 @@ asmlinkage void secondary_start_kernel(v
 	/*
 	 * OK, it's off to the idle thread for us
 	 */
-	cpu_startup_entry(CPUHP_ONLINE);
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
 void __init smp_cpus_done(unsigned int max_cpus)
Index: b/arch/mips/kernel/smp.c
===================================================================
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -191,7 +191,7 @@ asmlinkage void start_secondary(void)
 	WARN_ON_ONCE(!irqs_disabled());
 	mp_ops->smp_finish();
 
-	cpu_startup_entry(CPUHP_ONLINE);
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
 static void stop_this_cpu(void *dummy)
Index: b/arch/mn10300/kernel/smp.c
===================================================================
--- a/arch/mn10300/kernel/smp.c
+++ b/arch/mn10300/kernel/smp.c
@@ -675,7 +675,7 @@ int __init start_secondary(void *unused)
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 	init_clockevents();
 #endif
-	cpu_startup_entry(CPUHP_ONLINE);
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 	return 0;
 }
 
Index: b/arch/parisc/kernel/smp.c
===================================================================
--- a/arch/parisc/kernel/smp.c
+++ b/arch/parisc/kernel/smp.c
@@ -305,7 +305,7 @@ void __init smp_callin(void)
 
 	local_irq_enable();  /* Interrupts have been off until now */
 
-	cpu_startup_entry(CPUHP_ONLINE);
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 
 	/* NOTREACHED */
 	panic("smp_callin() AAAAaaaaahhhh....\n");
Index: b/arch/powerpc/kernel/smp.c
===================================================================
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -727,7 +727,7 @@ void start_secondary(void *unused)
 
 	local_irq_enable();
 
-	cpu_startup_entry(CPUHP_ONLINE);
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 
 	BUG();
 }
Index: b/arch/s390/kernel/smp.c
===================================================================
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -798,7 +798,7 @@ static void smp_start_secondary(void *cp
 	set_cpu_online(smp_processor_id(), true);
 	inc_irq_stat(CPU_RST);
 	local_irq_enable();
-	cpu_startup_entry(CPUHP_ONLINE);
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
 /* Upping and downing of CPUs */
Index: b/arch/sh/kernel/smp.c
===================================================================
--- a/arch/sh/kernel/smp.c
+++ b/arch/sh/kernel/smp.c
@@ -203,7 +203,7 @@ asmlinkage void start_secondary(void)
 	set_cpu_online(cpu, true);
 	per_cpu(cpu_state, cpu) = CPU_ONLINE;
 
-	cpu_startup_entry(CPUHP_ONLINE);
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
 extern struct {
Index: b/arch/sparc/kernel/smp_32.c
===================================================================
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -364,7 +364,7 @@ static void sparc_start_secondary(void *
 	local_irq_enable();
 
 	wmb();
-	cpu_startup_entry(CPUHP_ONLINE);
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 
 	/* We should never reach here! */
 	BUG();
Index: b/arch/sparc/kernel/smp_64.c
===================================================================
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -134,7 +134,7 @@ void smp_callin(void)
 
 	local_irq_enable();
 
-	cpu_startup_entry(CPUHP_ONLINE);
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
 void cpu_panic(void)
Index: b/arch/tile/kernel/smpboot.c
===================================================================
--- a/arch/tile/kernel/smpboot.c
+++ b/arch/tile/kernel/smpboot.c
@@ -208,7 +208,7 @@ void online_secondary(void)
 	/* Set up tile-timer clock-event device on this cpu */
 	setup_tile_timer();
 
-	cpu_startup_entry(CPUHP_ONLINE);
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
Index: b/arch/x86/kernel/smpboot.c
===================================================================
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -248,7 +248,7 @@ static void notrace start_secondary(void
 	x86_cpuinit.setup_percpu_clockev();
 
 	wmb();
-	cpu_startup_entry(CPUHP_ONLINE);
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
 void __init smp_store_boot_cpu_info(void)
Index: b/arch/x86/xen/smp.c
===================================================================
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -112,7 +112,7 @@ asmlinkage __visible void cpu_bringup_an
 		xen_pvh_secondary_vcpu_init(cpu);
 #endif
 	cpu_bringup();
-	cpu_startup_entry(CPUHP_ONLINE);
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
 static void xen_smp_intr_free(unsigned int cpu)
Index: b/arch/xtensa/kernel/smp.c
===================================================================
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -157,7 +157,7 @@ void secondary_start_kernel(void)
 
 	complete(&cpu_running);
 
-	cpu_startup_entry(CPUHP_ONLINE);
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
 static void mx_cpu_start(void *p)
Index: b/include/linux/cpuhotplug.h
===================================================================
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -13,6 +13,7 @@ enum cpuhp_state {
 	CPUHP_CPU_SET_ACTIVE,
 	CPUHP_KICK_AP_THREAD,
 	CPUHP_BP_ONLINE,
+	CPUHP_AP_ONLINE_IDLE,
 	CPUHP_AP_SMPBOOT_THREADS,
 	CPUHP_AP_NOTIFY_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
