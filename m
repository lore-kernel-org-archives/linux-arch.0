From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 17/17] xtensa: implement CPU hotplug
Date: Thu, 17 Oct 2013 02:42:28 +0400
Message-ID: <1381963348-29448-18-git-send-email-jcmvbkbc@gmail.com>
References: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:58474 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762061Ab3JPWnL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2013 18:43:11 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so1112758lab.5
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2013 15:43:10 -0700 (PDT)
In-Reply-To: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig           |   9 +++
 arch/xtensa/include/asm/irq.h |   1 +
 arch/xtensa/include/asm/smp.h |   9 +++
 arch/xtensa/kernel/head.S     |  51 ++++++++++++++++-
 arch/xtensa/kernel/irq.c      |  49 ++++++++++++++++
 arch/xtensa/kernel/setup.c    |   1 +
 arch/xtensa/kernel/smp.c      | 128 +++++++++++++++++++++++++++++++++++++++++-
 arch/xtensa/kernel/traps.c    |   4 +-
 8 files changed, 248 insertions(+), 4 deletions(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 9cfb514..e3af36b 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -147,6 +147,15 @@ config NR_CPUS
 	range 2 32
 	default "4"
 
+config HOTPLUG_CPU
+	bool "Enable CPU hotplug support"
+	depends on SMP
+	help
+	  Say Y here to allow turning CPUs off and on. CPUs can be
+	  controlled through /sys/devices/system/cpu.
+
+	  Say N if you want to disable CPU hotplug.
+
 config MATH_EMULATION
 	bool "Math emulation"
 	help
diff --git a/arch/xtensa/include/asm/irq.h b/arch/xtensa/include/asm/irq.h
index 7d194d4..f71f88e 100644
--- a/arch/xtensa/include/asm/irq.h
+++ b/arch/xtensa/include/asm/irq.h
@@ -45,6 +45,7 @@ static __inline__ int irq_canonicalize(int irq)
 struct irqaction;
 struct irq_domain;
 
+void migrate_irqs(void);
 int xtensa_irq_domain_xlate(const u32 *intspec, unsigned int intsize,
 		unsigned long int_irq, unsigned long ext_irq,
 		unsigned long *out_hwirq, unsigned int *out_type);
diff --git a/arch/xtensa/include/asm/smp.h b/arch/xtensa/include/asm/smp.h
index 30ac58c..4e43f56 100644
--- a/arch/xtensa/include/asm/smp.h
+++ b/arch/xtensa/include/asm/smp.h
@@ -29,6 +29,15 @@ void ipi_init(void);
 struct seq_file;
 void show_ipi_list(struct seq_file *p, int prec);
 
+#ifdef CONFIG_HOTPLUG_CPU
+
+void __cpu_die(unsigned int cpu);
+int __cpu_disable(void);
+void cpu_die(void);
+void cpu_restart(void);
+
+#endif /* CONFIG_HOTPLUG_CPU */
+
 #endif /* CONFIG_SMP */
 
 #endif	/* _XTENSA_SMP_H */
diff --git a/arch/xtensa/kernel/head.S b/arch/xtensa/kernel/head.S
index 74ec62c..aeeb3cc 100644
--- a/arch/xtensa/kernel/head.S
+++ b/arch/xtensa/kernel/head.S
@@ -103,7 +103,7 @@ _SetupMMU:
 
 ENDPROC(_start)
 
-	__INIT
+	__REF
 	.literal_position
 
 ENTRY(_startup)
@@ -302,6 +302,55 @@ should_never_return:
 
 ENDPROC(_startup)
 
+#ifdef CONFIG_HOTPLUG_CPU
+
+ENTRY(cpu_restart)
+
+#if XCHAL_DCACHE_IS_WRITEBACK
+	___flush_invalidate_dcache_all a2 a3
+#else
+	___invalidate_dcache_all a2 a3
+#endif
+	memw
+	movi	a2, CCON	# MX External Register to Configure Cache
+	movi	a3, 0
+	wer	a3, a2
+	extw
+
+	rsr	a0, prid
+	neg	a2, a0
+	movi	a3, cpu_start_id
+	s32i	a2, a3, 0
+#if XCHAL_DCACHE_IS_WRITEBACK
+	dhwbi	a3, 0
+#endif
+1:
+	l32i	a2, a3, 0
+	dhi	a3, 0
+	bne	a2, a0, 1b
+
+	/*
+	 * Initialize WB, WS, and clear PS.EXCM (to allow loop instructions).
+	 * Set Interrupt Level just below XCHAL_DEBUGLEVEL to allow
+	 * xt-gdb to single step via DEBUG exceptions received directly
+	 * by ocd.
+	 */
+	movi	a1, 1
+	movi	a0, 0
+	wsr	a1, windowstart
+	wsr	a0, windowbase
+	rsync
+
+	movi	a1, LOCKLEVEL
+	wsr	a1, ps
+	rsync
+
+	j	_startup
+
+ENDPROC(cpu_restart)
+
+#endif  /* CONFIG_HOTPLUG_CPU */
+
 /*
  * DATA section
  */
diff --git a/arch/xtensa/kernel/irq.c b/arch/xtensa/kernel/irq.c
index fad9e00..482868a 100644
--- a/arch/xtensa/kernel/irq.c
+++ b/arch/xtensa/kernel/irq.c
@@ -153,3 +153,52 @@ void __init init_IRQ(void)
 #endif
 	variant_init_irq();
 }
+
+#ifdef CONFIG_HOTPLUG_CPU
+static void route_irq(struct irq_data *data, unsigned int irq, unsigned int cpu)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+	struct irq_chip *chip = irq_data_get_irq_chip(data);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&desc->lock, flags);
+	if (chip->irq_set_affinity)
+		chip->irq_set_affinity(data, cpumask_of(cpu), false);
+	raw_spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+/*
+ * The CPU has been marked offline.  Migrate IRQs off this CPU.  If
+ * the affinity settings do not allow other CPUs, force them onto any
+ * available CPU.
+ */
+void migrate_irqs(void)
+{
+	unsigned int i, cpu = smp_processor_id();
+	struct irq_desc *desc;
+
+	for_each_irq_desc(i, desc) {
+		struct irq_data *data = irq_desc_get_irq_data(desc);
+		unsigned int newcpu;
+
+		if (irqd_is_per_cpu(data))
+			continue;
+
+		if (!cpumask_test_cpu(cpu, data->affinity))
+			continue;
+
+		newcpu = cpumask_any_and(data->affinity, cpu_online_mask);
+
+		if (newcpu >= nr_cpu_ids) {
+			pr_info_ratelimited("IRQ%u no longer affine to CPU%u\n",
+					    i, cpu);
+
+			cpumask_setall(data->affinity);
+			newcpu = cpumask_any_and(data->affinity,
+						 cpu_online_mask);
+		}
+
+		route_irq(data, i, newcpu);
+	}
+}
+#endif /* CONFIG_HOTPLUG_CPU */
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 1f6e377..963a4b2 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -554,6 +554,7 @@ static int __init topology_init(void)
 
 	for_each_possible_cpu(i) {
 		struct cpu *cpu = &per_cpu(cpu_data, i);
+		cpu->hotpluggable = !!i;
 		register_cpu(cpu, i);
 	}
 
diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index 46bdd14..1c7a209 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -40,6 +40,11 @@
 # endif
 #endif
 
+static void system_invalidate_dcache_range(unsigned long start,
+		unsigned long size);
+static void system_flush_invalidate_dcache_range(unsigned long start,
+		unsigned long size);
+
 /* IPI (Inter Process Interrupt) */
 
 #define IPI_IRQ	0
@@ -106,7 +111,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
 static int boot_secondary_processors = 1; /* Set with xt-gdb via .xt-gdb */
 static DECLARE_COMPLETION(cpu_running);
 
-void __init secondary_start_kernel(void)
+void secondary_start_kernel(void)
 {
 	struct mm_struct *mm = &init_mm;
 	unsigned int cpu = smp_processor_id();
@@ -174,6 +179,9 @@ static void mx_cpu_stop(void *p)
 			__func__, cpu, run_stall_mask, get_er(MPSCORE));
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+unsigned long cpu_start_id __cacheline_aligned;
+#endif
 unsigned long cpu_start_ccount;
 
 static int boot_secondary(unsigned int cpu, struct task_struct *ts)
@@ -182,6 +190,11 @@ static int boot_secondary(unsigned int cpu, struct task_struct *ts)
 	unsigned long ccount;
 	int i;
 
+#ifdef CONFIG_HOTPLUG_CPU
+	cpu_start_id = cpu;
+	system_flush_invalidate_dcache_range(
+			(unsigned long)&cpu_start_id, sizeof(cpu_start_id));
+#endif
 	smp_call_function_single(0, mx_cpu_start, (void *)cpu, 1);
 
 	for (i = 0; i < 2; ++i) {
@@ -234,6 +247,85 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 	return ret;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+
+/*
+ * __cpu_disable runs on the processor to be shutdown.
+ */
+int __cpu_disable(void)
+{
+	unsigned int cpu = smp_processor_id();
+
+	/*
+	 * Take this CPU offline.  Once we clear this, we can't return,
+	 * and we must not schedule until we're ready to give up the cpu.
+	 */
+	set_cpu_online(cpu, false);
+
+	/*
+	 * OK - migrate IRQs away from this CPU
+	 */
+	migrate_irqs();
+
+	/*
+	 * Flush user cache and TLB mappings, and then remove this CPU
+	 * from the vm mask set of all processes.
+	 */
+	local_flush_cache_all();
+	local_flush_tlb_all();
+	invalidate_page_directory();
+
+	clear_tasks_mm_cpumask(cpu);
+
+	return 0;
+}
+
+static void platform_cpu_kill(unsigned int cpu)
+{
+	smp_call_function_single(0, mx_cpu_stop, (void *)cpu, true);
+}
+
+/*
+ * called on the thread which is asking for a CPU to be shutdown -
+ * waits until shutdown has completed, or it is timed out.
+ */
+void __cpu_die(unsigned int cpu)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
+	while (time_before(jiffies, timeout)) {
+		system_invalidate_dcache_range((unsigned long)&cpu_start_id,
+				sizeof(cpu_start_id));
+		if (cpu_start_id == -cpu) {
+			platform_cpu_kill(cpu);
+			return;
+		}
+	}
+	pr_err("CPU%u: unable to kill\n", cpu);
+}
+
+void arch_cpu_idle_dead(void)
+{
+	cpu_die();
+}
+/*
+ * Called from the idle thread for the CPU which has been shutdown.
+ *
+ * Note that we disable IRQs here, but do not re-enable them
+ * before returning to the caller. This is also the behaviour
+ * of the other hotplug-cpu capable cores, so presumably coming
+ * out of idle fixes this.
+ */
+void __ref cpu_die(void)
+{
+	idle_task_exit();
+	local_irq_disable();
+	__asm__ __volatile__(
+			"	movi	a2, cpu_restart\n"
+			"	jx	a2\n");
+}
+
+#endif /* CONFIG_HOTPLUG_CPU */
+
 enum ipi_msg_type {
 	IPI_RESCHEDULE = 0,
 	IPI_CALL_FUNC,
@@ -463,3 +555,37 @@ void flush_icache_range(unsigned long start, unsigned long end)
 	};
 	on_each_cpu(ipi_flush_icache_range, &fd, 1);
 }
+
+/* ------------------------------------------------------------------------- */
+
+static void ipi_invalidate_dcache_range(void *arg)
+{
+	struct flush_data *fd = arg;
+	__invalidate_dcache_range(fd->addr1, fd->addr2);
+}
+
+static void system_invalidate_dcache_range(unsigned long start,
+		unsigned long size)
+{
+	struct flush_data fd = {
+		.addr1 = start,
+		.addr2 = size,
+	};
+	on_each_cpu(ipi_invalidate_dcache_range, &fd, 1);
+}
+
+static void ipi_flush_invalidate_dcache_range(void *arg)
+{
+	struct flush_data *fd = arg;
+	__flush_invalidate_dcache_range(fd->addr1, fd->addr2);
+}
+
+static void system_flush_invalidate_dcache_range(unsigned long start,
+		unsigned long size)
+{
+	struct flush_data fd = {
+		.addr1 = start,
+		.addr2 = size,
+	};
+	on_each_cpu(ipi_flush_invalidate_dcache_range, &fd, 1);
+}
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 3c0ff57..eebbfd8 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -332,7 +332,7 @@ void * __init trap_set_handler(int cause, void *handler)
 }
 
 
-static void __init trap_init_excsave(void)
+static void trap_init_excsave(void)
 {
 	unsigned long excsave1 = (unsigned long)this_cpu_ptr(exc_table);
 	__asm__ __volatile__("wsr  %0, excsave1\n" : : "a" (excsave1));
@@ -384,7 +384,7 @@ void __init trap_init(void)
 }
 
 #ifdef CONFIG_SMP
-void __init secondary_trap_init(void)
+void secondary_trap_init(void)
 {
 	trap_init_excsave();
 }
-- 
1.8.1.4
