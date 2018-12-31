From: guoren@kernel.org
Subject: [PATCH 07/14] csky: CPU-hotplug supported for SMP
Date: Mon, 31 Dec 2018 23:32:58 +0800
Message-ID: <1546270384-4590-6-git-send-email-guoren@kernel.org>
References: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: guoren@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, oleg@redhat.com, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

This is a simple implement of CPU-hotplug for power saving. CPU use
wait instruction to enter power saving mode and waiting for IPI wakeup
signal.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/Kconfig           |  9 ++++++
 arch/csky/include/asm/smp.h |  4 +++
 arch/csky/kernel/smp.c      | 71 +++++++++++++++++++++++++++++++++++----------
 3 files changed, 69 insertions(+), 15 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index cb64f8d..8bdbe92 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -198,6 +198,15 @@ config RAM_BASE
 	hex "DRAM start addr (the same with memory-section in dts)"
 	default 0x0
 
+config HOTPLUG_CPU
+	bool "Support for hot-pluggable CPUs"
+	select GENERIC_IRQ_MIGRATION
+	depends on SMP
+	help
+	  Say Y here to allow turning CPUs off and on. CPUs can be
+	  controlled through /sys/devices/system/cpu/cpu1/hotplug/target.
+
+	  Say N if you want to disable CPU hotplug.
 endmenu
 
 source "kernel/Kconfig.hz"
diff --git a/arch/csky/include/asm/smp.h b/arch/csky/include/asm/smp.h
index 4a929c4..668b79c 100644
--- a/arch/csky/include/asm/smp.h
+++ b/arch/csky/include/asm/smp.h
@@ -21,6 +21,10 @@ void __init set_send_ipi(void (*func)(const struct cpumask *mask), int irq);
 
 #define raw_smp_processor_id()	(current_thread_info()->cpu)
 
+int __cpu_disable(void);
+
+void __cpu_die(unsigned int cpu);
+
 #endif /* CONFIG_SMP */
 
 #endif /* __ASM_CSKY_SMP_H */
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 74d6273..ddc4dd7 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/mm.h>
+#include <linux/sched/hotplug.h>
 #include <asm/irq.h>
 #include <asm/traps.h>
 #include <asm/sections.h>
@@ -112,12 +113,8 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 }
 
-static void __init enable_smp_ipi(void)
-{
-	enable_percpu_irq(ipi_irq, 0);
-}
-
 static int ipi_dummy_dev;
+
 void __init setup_smp_ipi(void)
 {
 	int rc;
@@ -130,7 +127,7 @@ void __init setup_smp_ipi(void)
 	if (rc)
 		panic("%s IRQ request failed\n", __func__);
 
-	enable_smp_ipi();
+	enable_percpu_irq(ipi_irq, 0);
 }
 
 void __init setup_smp(void)
@@ -161,12 +158,10 @@ volatile unsigned int secondary_stack;
 
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
-	unsigned int tmp;
-
-	secondary_stack = (unsigned int)tidle->stack + THREAD_SIZE;
+	unsigned long mask = 1 << cpu;
 
+	secondary_stack = (unsigned int)tidle->stack + THREAD_SIZE - 8;
 	secondary_hint = mfcr("cr31");
-
 	secondary_ccr  = mfcr("cr18");
 
 	/*
@@ -176,10 +171,13 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	 */
 	mtcr("cr17", 0x22);
 
-	/* Enable cpu in SMP reset ctrl reg */
-	tmp = mfcr("cr<29, 0>");
-	tmp |= 1 << cpu;
-	mtcr("cr<29, 0>", tmp);
+	if (mask & mfcr("cr<29, 0>")) {
+		send_arch_ipi(cpumask_of(cpu));
+	} else {
+		/* Enable cpu in SMP reset ctrl reg */
+		mask |= mfcr("cr<29, 0>");
+		mtcr("cr<29, 0>", mask);
+	}
 
 	/* Wait for the cpu online */
 	while (!cpu_online(cpu));
@@ -219,7 +217,7 @@ void csky_start_secondary(void)
 	init_fpu();
 #endif
 
-	enable_smp_ipi();
+	enable_percpu_irq(ipi_irq, 0);
 
 	mmget(mm);
 	mmgrab(mm);
@@ -235,3 +233,46 @@ void csky_start_secondary(void)
 	preempt_disable();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
+
+#ifdef CONFIG_HOTPLUG_CPU
+int __cpu_disable(void)
+{
+	unsigned int cpu = smp_processor_id();
+
+	set_cpu_online(cpu, false);
+
+	irq_migrate_all_off_this_cpu();
+
+	clear_tasks_mm_cpumask(cpu);
+
+	return 0;
+}
+
+void __cpu_die(unsigned int cpu)
+{
+	if (!cpu_wait_death(cpu, 5)) {
+		pr_crit("CPU%u: shutdown failed\n", cpu);
+		return;
+	}
+	pr_notice("CPU%u: shutdown\n", cpu);
+}
+
+void arch_cpu_idle_dead(void)
+{
+	idle_task_exit();
+
+	cpu_report_death();
+
+	while (!secondary_stack)
+		arch_cpu_idle();
+
+	local_irq_disable();
+
+	asm volatile(
+		"mov	sp, %0\n"
+		"mov	r8, %0\n"
+		"jmpi	csky_start_secondary"
+		:
+		: "r" (secondary_stack));
+}
+#endif
-- 
2.7.4
