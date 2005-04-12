Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 12 Apr 2005 01:01:32 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: i386-cpu-hotplug-updated-for-mm.patch
Message-Id: <20050412010132.5610d973.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: Zwane Mwaikambo <zwane@holomorphy.com>
List-ID: <linux-arch.vger.kernel.org>


This is the i386 cpu hotplug patch.  It's been in -mm for eons.

I was planning on merging it post-2.6.12 because several power-management
related projects will use infrastructure which it provides.

It diddles with ia64, s390 and x86_64 a bit, so, please review...



From: Zwane Mwaikambo <zwane@linuxpower.ca>

(The i386 CPU hotplug patch provides infrastructure for some work which Pavel
is doing as well as for ACPI S3 (suspend-to-RAM) work which Li Shaohua
<shaohua.li@intel.com> is doing)

The following provides i386 architecture support for safely unregistering and
registering processors during runtime, updated for the current -mm tree.  In
order to avoid dumping cpu hotplug code into kernel/irq/* i dropped the
cpu_online check in do_IRQ() by modifying fixup_irqs().  The difference being
that on cpu offline, fixup_irqs() is called before we clear the cpu from
cpu_online_map and a long delay in order to ensure that we never have any
queued external interrupts on the APICs.  There are additional changes to s390
and ppc64 to account for this change.

1) Add CONFIG_HOTPLUG_CPU
2) disable local APIC timer on dead cpus.
3) Disable preempt around irq balancing to prevent CPUs going down.
4) Print irq stats for all possible cpus.
5) Debugging check for interrupts on offline cpus.
6) Hacky fixup_irqs() to redirect irqs when cpus go off/online.
7) play_dead() for offline cpus to spin inside.
8) Handle offline cpus set in flush_tlb_others().
9) Grab lock earlier in smp_call_function() to prevent CPUs going down.
10) Implement __cpu_disable() and __cpu_die().
11) Enable local interrupts in cpu_enable() after fixup_irqs()
12) Don't fiddle with NMI on dead cpu, but leave intact on other cpus.
13) Program IRQ affinity whilst cpu is still in cpu_online_map on offline.

Signed-off-by: Zwane Mwaikambo <zwane@linuxpower.ca>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/i386/Kconfig               |    9 ++
 25-akpm/arch/i386/kernel/apic.c         |    3 
 25-akpm/arch/i386/kernel/io_apic.c      |    2 
 25-akpm/arch/i386/kernel/irq.c          |   67 +++++++++++++++++----
 25-akpm/arch/i386/kernel/msr.c          |    2 
 25-akpm/arch/i386/kernel/process.c      |   39 ++++++++++++
 25-akpm/arch/i386/kernel/smp.c          |   25 +++++---
 25-akpm/arch/i386/kernel/smpboot.c      |   98 ++++++++++++++++++++++++++++++--
 25-akpm/arch/i386/kernel/traps.c        |    8 ++
 25-akpm/arch/ia64/kernel/smpboot.c      |    1 
 25-akpm/arch/ppc64/kernel/pSeries_smp.c |    5 +
 25-akpm/arch/s390/kernel/smp.c          |    4 -
 25-akpm/include/asm-i386/cpu.h          |    2 
 25-akpm/include/asm-i386/irq.h          |    4 +
 25-akpm/include/asm-i386/smp.h          |    3 
 25-akpm/kernel/cpu.c                    |   14 +---
 arch/ppc64/kernel/smp.c                 |    0 
 17 files changed, 245 insertions(+), 41 deletions(-)

diff -puN arch/i386/Kconfig~i386-cpu-hotplug-updated-for-mm arch/i386/Kconfig
--- 25/arch/i386/Kconfig~i386-cpu-hotplug-updated-for-mm	2005-04-12 00:57:40.000000000 -0700
+++ 25-akpm/arch/i386/Kconfig	2005-04-12 00:57:40.000000000 -0700
@@ -1231,6 +1231,15 @@ config SCx200
 	  This support is also available as a module.  If compiled as a
 	  module, it will be called scx200.
 
+config HOTPLUG_CPU
+	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
+	depends on SMP && HOTPLUG && EXPERIMENTAL
+	---help---
+	  Say Y here to experiment with turning CPUs off and on.  CPUs
+	  can be controlled through /sys/devices/system/cpu.
+
+	  Say N.
+
 source "drivers/pcmcia/Kconfig"
 
 source "drivers/pci/hotplug/Kconfig"
diff -puN arch/i386/kernel/apic.c~i386-cpu-hotplug-updated-for-mm arch/i386/kernel/apic.c
--- 25/arch/i386/kernel/apic.c~i386-cpu-hotplug-updated-for-mm	2005-04-12 00:57:40.000000000 -0700
+++ 25-akpm/arch/i386/kernel/apic.c	2005-04-12 00:57:40.000000000 -0700
@@ -26,6 +26,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
+#include <linux/cpu.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -1048,7 +1049,7 @@ void __init setup_secondary_APIC_clock(v
 	setup_APIC_timer(calibration_result);
 }
 
-void __init disable_APIC_timer(void)
+void __devinit disable_APIC_timer(void)
 {
 	if (using_apic_timer) {
 		unsigned long v;
diff -puN arch/i386/kernel/io_apic.c~i386-cpu-hotplug-updated-for-mm arch/i386/kernel/io_apic.c
--- 25/arch/i386/kernel/io_apic.c~i386-cpu-hotplug-updated-for-mm	2005-04-12 00:57:40.000000000 -0700
+++ 25-akpm/arch/i386/kernel/io_apic.c	2005-04-12 00:57:40.000000000 -0700
@@ -576,9 +576,11 @@ static int balanced_irq(void *unused)
 		try_to_freeze(PF_FREEZE);
 		if (time_after(jiffies,
 				prev_balance_time+balanced_irq_interval)) {
+			preempt_disable();
 			do_irq_balance();
 			prev_balance_time = jiffies;
 			time_remaining = balanced_irq_interval;
+			preempt_enable();
 		}
 	}
 	return 0;
diff -puN arch/i386/kernel/irq.c~i386-cpu-hotplug-updated-for-mm arch/i386/kernel/irq.c
--- 25/arch/i386/kernel/irq.c~i386-cpu-hotplug-updated-for-mm	2005-04-12 00:57:40.000000000 -0700
+++ 25-akpm/arch/i386/kernel/irq.c	2005-04-12 00:57:40.000000000 -0700
@@ -15,6 +15,9 @@
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
+#include <linux/delay.h>
 
 DEFINE_PER_CPU(irq_cpustat_t, irq_stat) ____cacheline_maxaligned_in_smp;
 EXPORT_PER_CPU_SYMBOL(irq_stat);
@@ -210,9 +213,8 @@ int show_interrupts(struct seq_file *p, 
 
 	if (i == 0) {
 		seq_printf(p, "           ");
-		for (j=0; j<NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "CPU%d       ",j);
+		for_each_cpu(j)
+			seq_printf(p, "CPU%d       ",j);
 		seq_putc(p, '\n');
 	}
 
@@ -225,9 +227,8 @@ int show_interrupts(struct seq_file *p, 
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
-		for (j = 0; j < NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
+		for_each_cpu(j)
+			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
 #endif
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
 		seq_printf(p, "  %s", action->name);
@@ -240,16 +241,14 @@ skip:
 		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
 	} else if (i == NR_IRQS) {
 		seq_printf(p, "NMI: ");
-		for (j = 0; j < NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "%10u ", nmi_count(j));
+		for_each_cpu(j)
+			seq_printf(p, "%10u ", nmi_count(j));
 		seq_putc(p, '\n');
 #ifdef CONFIG_X86_LOCAL_APIC
 		seq_printf(p, "LOC: ");
-		for (j = 0; j < NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "%10u ",
-					per_cpu(irq_stat,j).apic_timer_irqs);
+		for_each_cpu(j)
+			seq_printf(p, "%10u ",
+				per_cpu(irq_stat,j).apic_timer_irqs);
 		seq_putc(p, '\n');
 #endif
 		seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
@@ -259,3 +258,45 @@ skip:
 	}
 	return 0;
 }
+
+#ifdef CONFIG_HOTPLUG_CPU
+#include <mach_apic.h>
+
+void fixup_irqs(cpumask_t map)
+{
+	unsigned int irq;
+	static int warned;
+
+	for (irq = 0; irq < NR_IRQS; irq++) {
+		cpumask_t mask;
+		if (irq == 2)
+			continue;
+
+		cpus_and(mask, irq_affinity[irq], map);
+		if (any_online_cpu(mask) == NR_CPUS) {
+			printk("Breaking affinity for irq %i\n", irq);
+			mask = map;
+		}
+		if (irq_desc[irq].handler->set_affinity)
+			irq_desc[irq].handler->set_affinity(irq, mask);
+		else if (irq_desc[irq].action && !(warned++))
+			printk("Cannot set affinity for irq %i\n", irq);
+	}
+
+#if 0
+	barrier();
+	/* Ingo Molnar says: "after the IO-APIC masks have been redirected
+	   [note the nop - the interrupt-enable boundary on x86 is two
+	   instructions from sti] - to flush out pending hardirqs and
+	   IPIs. After this point nothing is supposed to reach this CPU." */
+	__asm__ __volatile__("sti; nop; cli");
+	barrier();
+#else
+	/* That doesn't seem sufficient.  Give it 1ms. */
+	local_irq_enable();
+	mdelay(1);
+	local_irq_disable();
+#endif
+}
+#endif
+
diff -puN arch/i386/kernel/msr.c~i386-cpu-hotplug-updated-for-mm arch/i386/kernel/msr.c
--- 25/arch/i386/kernel/msr.c~i386-cpu-hotplug-updated-for-mm	2005-04-12 00:57:40.000000000 -0700
+++ 25-akpm/arch/i386/kernel/msr.c	2005-04-12 00:57:40.000000000 -0700
@@ -260,7 +260,7 @@ static struct file_operations msr_fops =
 	.open = msr_open,
 };
 
-static int msr_class_device_create(int i)
+static int __devinit msr_class_device_create(int i)
 {
 	int err = 0;
 	struct class_device *class_err;
diff -puN arch/i386/kernel/process.c~i386-cpu-hotplug-updated-for-mm arch/i386/kernel/process.c
--- 25/arch/i386/kernel/process.c~i386-cpu-hotplug-updated-for-mm	2005-04-12 00:57:40.000000000 -0700
+++ 25-akpm/arch/i386/kernel/process.c	2005-04-12 00:57:40.000000000 -0700
@@ -13,6 +13,7 @@
 
 #include <stdarg.h>
 
+#include <linux/cpu.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
@@ -54,6 +55,9 @@
 #include <linux/irq.h>
 #include <linux/err.h>
 
+#include <asm/tlbflush.h>
+#include <asm/cpu.h>
+
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 
 static int hlt_counter;
@@ -138,14 +142,44 @@ static void poll_idle (void)
 	}
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+#include <asm/nmi.h>
+/* We don't actually take CPU down, just spin without interrupts. */
+static inline void play_dead(void)
+{
+	/* Ack it */
+	__get_cpu_var(cpu_state) = CPU_DEAD;
+
+	/* We shouldn't have to disable interrupts while dead, but
+	 * some interrupts just don't seem to go away, and this makes
+	 * it "work" for testing purposes. */
+	/* Death loop */
+	while (__get_cpu_var(cpu_state) != CPU_UP_PREPARE)
+		cpu_relax();
+
+	local_irq_disable();
+	__flush_tlb_all();
+	cpu_set(smp_processor_id(), cpu_online_map);
+	enable_APIC_timer();
+	local_irq_enable();
+}
+#else
+static inline void play_dead(void)
+{
+	BUG();
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
 /*
  * The idle thread. There's no useful work to be
  * done, so just try to conserve power and have a
  * low exit latency (ie sit in a loop waiting for
  * somebody to say that they'd like to reschedule)
  */
-void cpu_idle (void)
+void cpu_idle(void)
 {
+	int cpu = _smp_processor_id();
+
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
@@ -160,6 +194,9 @@ void cpu_idle (void)
 			if (!idle)
 				idle = default_idle;
 
+			if (cpu_is_offline(cpu))
+				play_dead();
+
 			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
 			idle();
 		}
diff -puN arch/i386/kernel/smpboot.c~i386-cpu-hotplug-updated-for-mm arch/i386/kernel/smpboot.c
--- 25/arch/i386/kernel/smpboot.c~i386-cpu-hotplug-updated-for-mm	2005-04-12 00:57:40.000000000 -0700
+++ 25-akpm/arch/i386/kernel/smpboot.c	2005-04-12 00:57:40.000000000 -0700
@@ -44,6 +44,9 @@
 #include <linux/smp_lock.h>
 #include <linux/irq.h>
 #include <linux/bootmem.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
+#include <linux/percpu.h>
 
 #include <linux/delay.h>
 #include <linux/mc146818rtc.h>
@@ -90,6 +93,9 @@ static int trampoline_exec;
 
 static void map_cpu_to_logical_apicid(void);
 
+/* State of each CPU. */
+DEFINE_PER_CPU(int, cpu_state) = { 0 };
+
 /*
  * Currently trivial. Write the real->protected mode
  * bootstrap into the page concerned. The caller
@@ -1105,6 +1111,9 @@ static void __init smp_boot_cpus(unsigne
    who understands all this stuff should rewrite it properly. --RR 15/Jul/02 */
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
+	smp_commenced_mask = cpumask_of_cpu(0);
+	cpu_callin_map = cpumask_of_cpu(0);
+	mb();
 	smp_boot_cpus(max_cpus);
 }
 
@@ -1114,20 +1123,99 @@ void __devinit smp_prepare_boot_cpu(void
 	cpu_set(smp_processor_id(), cpu_callout_map);
 }
 
-int __devinit __cpu_up(unsigned int cpu)
+#ifdef CONFIG_HOTPLUG_CPU
+
+/* must be called with the cpucontrol mutex held */
+static int __devinit cpu_enable(unsigned int cpu)
 {
-	/* This only works at boot for x86.  See "rewrite" above. */
-	if (cpu_isset(cpu, smp_commenced_mask)) {
-		local_irq_enable();
-		return -ENOSYS;
+	/* get the target out of its holding state */
+	per_cpu(cpu_state, cpu) = CPU_UP_PREPARE;
+	wmb();
+
+	/* wait for the processor to ack it. timeout? */
+	while (!cpu_online(cpu))
+		cpu_relax();
+
+	fixup_irqs(cpu_online_map);
+	/* counter the disable in fixup_irqs() */
+	local_irq_enable();
+	return 0;
+}
+
+int __cpu_disable(void)
+{
+	cpumask_t map = cpu_online_map;
+	int cpu = smp_processor_id();
+
+	/*
+	 * Perhaps use cpufreq to drop frequency, but that could go
+	 * into generic code.
+ 	 *
+	 * We won't take down the boot processor on i386 due to some
+	 * interrupts only being able to be serviced by the BSP.
+	 * Especially so if we're not using an IOAPIC	-zwane
+	 */
+	if (cpu == 0)
+		return -EBUSY;
+
+	/* We enable the timer again on the exit path of the death loop */
+	disable_APIC_timer();
+	/* Allow any queued timer interrupts to get serviced */
+	local_irq_enable();
+	mdelay(1);
+	local_irq_disable();
+
+	cpu_clear(cpu, map);
+	fixup_irqs(map);
+	/* It's now safe to remove this processor from the online map */
+	cpu_clear(cpu, cpu_online_map);
+	return 0;
+}
+
+void __cpu_die(unsigned int cpu)
+{
+	/* We don't do anything here: idle task is faking death itself. */
+	unsigned int i;
+
+	for (i = 0; i < 10; i++) {
+		/* They ack this in play_dead by setting CPU_DEAD */
+		if (per_cpu(cpu_state, cpu) == CPU_DEAD)
+			return;
+		current->state = TASK_UNINTERRUPTIBLE;
+		schedule_timeout(HZ/10);
 	}
+ 	printk(KERN_ERR "CPU %u didn't die...\n", cpu);
+}
+#else /* ... !CONFIG_HOTPLUG_CPU */
+int __cpu_disable(void)
+{
+	return -ENOSYS;
+}
 
+void __cpu_die(unsigned int cpu)
+{
+	/* We said "no" in __cpu_disable */
+	BUG();
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
+int __devinit __cpu_up(unsigned int cpu)
+{
 	/* In case one didn't come up */
 	if (!cpu_isset(cpu, cpu_callin_map)) {
+		printk(KERN_DEBUG "skipping cpu%d, didn't come online\n", cpu);
 		local_irq_enable();
 		return -EIO;
 	}
 
+#ifdef CONFIG_HOTPLUG_CPU
+	/* Already up, and in cpu_quiescent now? */
+	if (cpu_isset(cpu, smp_commenced_mask)) {
+		cpu_enable(cpu);
+		return 0;
+	}
+#endif
+
 	local_irq_enable();
 	/* Unleash the CPU! */
 	cpu_set(cpu, smp_commenced_mask);
diff -puN arch/i386/kernel/smp.c~i386-cpu-hotplug-updated-for-mm arch/i386/kernel/smp.c
--- 25/arch/i386/kernel/smp.c~i386-cpu-hotplug-updated-for-mm	2005-04-12 00:57:40.000000000 -0700
+++ 25-akpm/arch/i386/kernel/smp.c	2005-04-12 00:57:40.000000000 -0700
@@ -19,6 +19,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/cache.h>
 #include <linux/interrupt.h>
+#include <linux/cpu.h>
 
 #include <asm/mtrr.h>
 #include <asm/tlbflush.h>
@@ -163,7 +164,7 @@ void send_IPI_mask_bitmask(cpumask_t cpu
 	unsigned long flags;
 
 	local_irq_save(flags);
-		
+	WARN_ON(mask & ~cpus_addr(cpu_online_map)[0]);
 	/*
 	 * Wait for idle.
 	 */
@@ -345,21 +346,21 @@ out:
 static void flush_tlb_others(cpumask_t cpumask, struct mm_struct *mm,
 						unsigned long va)
 {
-	cpumask_t tmp;
 	/*
 	 * A couple of (to be removed) sanity checks:
 	 *
-	 * - we do not send IPIs to not-yet booted CPUs.
 	 * - current CPU must not be in mask
 	 * - mask must exist :)
 	 */
 	BUG_ON(cpus_empty(cpumask));
-
-	cpus_and(tmp, cpumask, cpu_online_map);
-	BUG_ON(!cpus_equal(cpumask, tmp));
 	BUG_ON(cpu_isset(smp_processor_id(), cpumask));
 	BUG_ON(!mm);
 
+	/* If a CPU which we ran on has gone down, OK. */
+	cpus_and(cpumask, cpumask, cpu_online_map);
+	if (cpus_empty(cpumask))
+		return;
+
 	/*
 	 * i'm not happy about this global shared spinlock in the
 	 * MM hot path, but we'll see how contended it is.
@@ -474,6 +475,7 @@ void flush_tlb_all(void)
  */
 void smp_send_reschedule(int cpu)
 {
+	WARN_ON(cpu_is_offline(cpu));
 	send_IPI_mask(cpumask_of_cpu(cpu), RESCHEDULE_VECTOR);
 }
 
@@ -514,10 +516,16 @@ int smp_call_function (void (*func) (voi
  */
 {
 	struct call_data_struct data;
-	int cpus = num_online_cpus()-1;
+	int cpus;
 
-	if (!cpus)
+	/* Holding any lock stops cpus from going down. */
+	spin_lock(&call_lock);
+	cpus = num_online_cpus()-1;
+
+	if (!cpus) {
+		spin_unlock(&call_lock);
 		return 0;
+	}
 
 	/* Can deadlock when called with interrupts disabled */
 	WARN_ON(irqs_disabled());
@@ -529,7 +537,6 @@ int smp_call_function (void (*func) (voi
 	if (wait)
 		atomic_set(&data.finished, 0);
 
-	spin_lock(&call_lock);
 	call_data = &data;
 	mb();
 	
diff -puN arch/i386/kernel/traps.c~i386-cpu-hotplug-updated-for-mm arch/i386/kernel/traps.c
--- 25/arch/i386/kernel/traps.c~i386-cpu-hotplug-updated-for-mm	2005-04-12 00:57:40.000000000 -0700
+++ 25-akpm/arch/i386/kernel/traps.c	2005-04-12 00:57:40.000000000 -0700
@@ -623,6 +623,14 @@ fastcall void do_nmi(struct pt_regs * re
 	nmi_enter();
 
 	cpu = smp_processor_id();
+
+#ifdef CONFIG_HOTPLUG_CPU
+	if (!cpu_online(cpu)) {
+		nmi_exit();
+		return;
+	}
+#endif
+
 	++nmi_count(cpu);
 
 	if (!nmi_callback(regs, cpu))
diff -puN arch/ia64/kernel/smpboot.c~i386-cpu-hotplug-updated-for-mm arch/ia64/kernel/smpboot.c
--- 25/arch/ia64/kernel/smpboot.c~i386-cpu-hotplug-updated-for-mm	2005-04-12 00:57:40.000000000 -0700
+++ 25-akpm/arch/ia64/kernel/smpboot.c	2005-04-12 00:57:40.000000000 -0700
@@ -688,6 +688,7 @@ int __cpu_disable(void)
 		return -EBUSY;
 
 	remove_siblinginfo(cpu);
+	cpu_clear(cpu, cpu_online_map);
 	fixup_irqs();
 	local_flush_tlb_all();
 	cpu_clear(cpu, cpu_callin_map);
diff -puN arch/ppc64/kernel/smp.c~i386-cpu-hotplug-updated-for-mm arch/ppc64/kernel/smp.c
diff -puN arch/s390/kernel/smp.c~i386-cpu-hotplug-updated-for-mm arch/s390/kernel/smp.c
--- 25/arch/s390/kernel/smp.c~i386-cpu-hotplug-updated-for-mm	2005-04-12 00:57:40.000000000 -0700
+++ 25-akpm/arch/s390/kernel/smp.c	2005-04-12 00:57:40.000000000 -0700
@@ -679,12 +679,14 @@ __cpu_disable(void)
 {
 	unsigned long flags;
 	ec_creg_mask_parms cr_parms;
+	int cpu = smp_processor_id();
 
 	spin_lock_irqsave(&smp_reserve_lock, flags);
-	if (smp_cpu_reserved[smp_processor_id()] != 0) {
+	if (smp_cpu_reserved[cpu] != 0) {
 		spin_unlock_irqrestore(&smp_reserve_lock, flags);
 		return -EBUSY;
 	}
+	cpu_clear(cpu, cpu_online_map);
 
 #ifdef CONFIG_PFAULT
 	/* Disable pfault pseudo page faults on this cpu. */
diff -puN include/asm-i386/cpu.h~i386-cpu-hotplug-updated-for-mm include/asm-i386/cpu.h
--- 25/include/asm-i386/cpu.h~i386-cpu-hotplug-updated-for-mm	2005-04-12 00:57:40.000000000 -0700
+++ 25-akpm/include/asm-i386/cpu.h	2005-04-12 00:57:40.000000000 -0700
@@ -5,6 +5,7 @@
 #include <linux/cpu.h>
 #include <linux/topology.h>
 #include <linux/nodemask.h>
+#include <linux/percpu.h>
 
 #include <asm/node.h>
 
@@ -16,4 +17,5 @@ extern int arch_register_cpu(int num);
 extern void arch_unregister_cpu(int);
 #endif
 
+DECLARE_PER_CPU(int, cpu_state);
 #endif /* _ASM_I386_CPU_H_ */
diff -puN include/asm-i386/irq.h~i386-cpu-hotplug-updated-for-mm include/asm-i386/irq.h
--- 25/include/asm-i386/irq.h~i386-cpu-hotplug-updated-for-mm	2005-04-12 00:57:40.000000000 -0700
+++ 25-akpm/include/asm-i386/irq.h	2005-04-12 00:57:40.000000000 -0700
@@ -38,4 +38,8 @@ extern void release_vm86_irqs(struct tas
 extern int irqbalance_disable(char *str);
 #endif
 
+#ifdef CONFIG_HOTPLUG_CPU
+extern void fixup_irqs(cpumask_t map);
+#endif
+
 #endif /* _ASM_IRQ_H */
diff -puN include/asm-i386/smp.h~i386-cpu-hotplug-updated-for-mm include/asm-i386/smp.h
--- 25/include/asm-i386/smp.h~i386-cpu-hotplug-updated-for-mm	2005-04-12 00:57:40.000000000 -0700
+++ 25-akpm/include/asm-i386/smp.h	2005-04-12 00:57:40.000000000 -0700
@@ -83,6 +83,9 @@ static __inline int logical_smp_processo
 }
 
 #endif
+
+extern int __cpu_disable(void);
+extern void __cpu_die(unsigned int cpu);
 #endif /* !__ASSEMBLY__ */
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
diff -puN kernel/cpu.c~i386-cpu-hotplug-updated-for-mm kernel/cpu.c
--- 25/kernel/cpu.c~i386-cpu-hotplug-updated-for-mm	2005-04-12 00:57:40.000000000 -0700
+++ 25-akpm/kernel/cpu.c	2005-04-12 00:57:40.000000000 -0700
@@ -63,19 +63,15 @@ static int take_cpu_down(void *unused)
 {
 	int err;
 
-	/* Take offline: makes arch_cpu_down somewhat easier. */
-	cpu_clear(smp_processor_id(), cpu_online_map);
-
 	/* Ensure this CPU doesn't handle any more interrupts. */
 	err = __cpu_disable();
 	if (err < 0)
-		cpu_set(smp_processor_id(), cpu_online_map);
-	else
-		/* Force idle task to run as soon as we yield: it should
-		   immediately notice cpu is offline and die quickly. */
-		sched_idle_next();
+		return err;
 
-	return err;
+	/* Force idle task to run as soon as we yield: it should
+	   immediately notice cpu is offline and die quickly. */
+	sched_idle_next();
+	return 0;
 }
 
 int cpu_down(unsigned int cpu)
diff -puN arch/ppc64/kernel/pSeries_smp.c~i386-cpu-hotplug-updated-for-mm arch/ppc64/kernel/pSeries_smp.c
--- 25/arch/ppc64/kernel/pSeries_smp.c~i386-cpu-hotplug-updated-for-mm	2005-04-12 00:57:40.000000000 -0700
+++ 25-akpm/arch/ppc64/kernel/pSeries_smp.c	2005-04-12 00:57:40.000000000 -0700
@@ -92,10 +92,13 @@ static int query_cpu_stopped(unsigned in
 
 int pSeries_cpu_disable(void)
 {
+	int cpu = smp_processor_id();
+
+	cpu_clear(cpu, cpu_online_map);
 	systemcfg->processorCount--;
 
 	/*fix boot_cpuid here*/
-	if (smp_processor_id() == boot_cpuid)
+	if (cpu == boot_cpuid)
 		boot_cpuid = any_online_cpu(cpu_online_map);
 
 	/* FIXME: abstract this to not be platform specific later on */
_
