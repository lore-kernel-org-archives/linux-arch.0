From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 16/19] csky: SMP support
Date: Mon,  2 Jul 2018 01:30:19 +0800
Message-ID: <21d859826fe19aecaa2aefe3103d6d33e6f1b925.1530465326.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530465325.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1530465325.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/smp.h |  26 +++++
 arch/csky/kernel/smp.c      | 256 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 282 insertions(+)
 create mode 100644 arch/csky/include/asm/smp.h
 create mode 100644 arch/csky/kernel/smp.c

diff --git a/arch/csky/include/asm/smp.h b/arch/csky/include/asm/smp.h
new file mode 100644
index 0000000..9a53abf
--- /dev/null
+++ b/arch/csky/include/asm/smp.h
@@ -0,0 +1,26 @@
+#ifndef __ASM_CSKY_SMP_H
+#define __ASM_CSKY_SMP_H
+
+#include <linux/cpumask.h>
+#include <linux/irqreturn.h>
+#include <linux/threads.h>
+
+#ifdef CONFIG_SMP
+
+void __init setup_smp(void);
+
+void __init setup_smp_ipi(void);
+
+void __init enable_smp_ipi(void);
+
+void arch_send_call_function_ipi_mask(struct cpumask *mask);
+
+void arch_send_call_function_single_ipi(int cpu);
+
+void __init set_send_ipi(void (*func)(const unsigned long *, unsigned long));
+
+#define raw_smp_processor_id()	(current_thread_info()->cpu)
+
+#endif /* CONFIG_SMP */
+
+#endif /* __ASM_CSKY_SMP_H */
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
new file mode 100644
index 0000000..42308cd
--- /dev/null
+++ b/arch/csky/kernel/smp.c
@@ -0,0 +1,256 @@
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/kernel_stat.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
+#include <linux/percpu.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/sched/task_stack.h>
+#include <linux/sched/mm.h>
+#include <asm/irq.h>
+#include <asm/traps.h>
+#include <asm/sections.h>
+#include <asm/mmu_context.h>
+#include <asm/pgalloc.h>
+
+#define IPI_IRQ	15
+
+static struct {
+	unsigned long bits ____cacheline_aligned;
+} ipi_data[NR_CPUS] __cacheline_aligned;
+
+enum ipi_message_type {
+	IPI_EMPTY,
+	IPI_RESCHEDULE,
+	IPI_CALL_FUNC,
+	IPI_MAX
+};
+
+static irqreturn_t handle_ipi(int irq, void *dev)
+{
+	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
+
+	while (true) {
+		unsigned long ops;
+
+		/* Order bit clearing and data access. */
+		mb();
+
+		ops = xchg(pending_ipis, 0);
+		if (ops == 0)
+			return IRQ_HANDLED;
+
+		if (ops & (1 << IPI_RESCHEDULE))
+			scheduler_ipi();
+
+		if (ops & (1 << IPI_CALL_FUNC))
+			generic_smp_call_function_interrupt();
+
+		BUG_ON((ops >> IPI_MAX) != 0);
+
+		/* Order data access and bit testing. */
+		mb();
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void (*send_arch_ipi)(const unsigned long *mask, unsigned long irq) = NULL;
+
+void __init set_send_ipi(void (*func)(const unsigned long *, unsigned long))
+{
+	if (send_arch_ipi)
+		return;
+
+	send_arch_ipi = func;
+}
+
+static void
+send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
+{
+	int i;
+
+	mb();
+	for_each_cpu(i, to_whom)
+		set_bit(operation, &ipi_data[i].bits);
+
+	mb();
+	send_arch_ipi(cpumask_bits(to_whom), IPI_IRQ);
+}
+
+void arch_send_call_function_ipi_mask(struct cpumask *mask)
+{
+	send_ipi_message(mask, IPI_CALL_FUNC);
+}
+
+void arch_send_call_function_single_ipi(int cpu)
+{
+	send_ipi_message(cpumask_of(cpu), IPI_CALL_FUNC);
+}
+
+static void ipi_stop(void *unused)
+{
+	while (1);
+}
+
+void smp_send_stop(void)
+{
+	on_each_cpu(ipi_stop, NULL, 1);
+}
+
+void smp_send_reschedule(int cpu)
+{
+	send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);
+}
+
+void *__cpu_up_stack_pointer[NR_CPUS];
+void *__cpu_up_task_pointer[NR_CPUS];
+
+void __init smp_prepare_boot_cpu(void)
+{
+}
+
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+}
+
+static int ipi_dummy_dev;
+
+void __init enable_smp_ipi(void)
+{
+	enable_percpu_irq(IPI_IRQ, 0);
+}
+
+void __init setup_smp_ipi(void)
+{
+	int rc;
+
+	irq_create_mapping(NULL, IPI_IRQ);
+
+	rc = request_percpu_irq(IPI_IRQ, handle_ipi, "IPI Interrupt", &ipi_dummy_dev);
+	if (rc)
+		panic("%s IRQ request failed\n", __func__);
+
+	enable_smp_ipi();
+}
+
+static int csky_of_cpu(struct device_node *node)
+{
+	const char *status;
+	int cpu;
+
+	if (of_property_read_u32(node, "reg", &cpu))
+		goto error;
+
+	if (cpu >= NR_CPUS)
+		goto error;
+
+	if (of_property_read_string(node, "status", &status))
+		status = "enable";
+
+	if (strcmp(status, "disable") == 0)
+		goto error;
+
+	return cpu;
+error:
+	return -ENODEV;
+}
+
+void __init setup_smp(void)
+{
+	struct device_node *node = NULL;
+	int cpu;
+
+	while ((node = of_find_node_by_type(node, "cpu"))) {
+		cpu = csky_of_cpu(node);
+		if (cpu >= 0) {
+			set_cpu_possible(cpu, true);
+			set_cpu_present(cpu, true);
+		}
+	}
+}
+
+extern void _start_smp_secondary(void);
+
+static unsigned int secondary_hint;
+static unsigned int secondary_ccr;
+
+unsigned int secondary_stack;
+
+int __cpu_up(unsigned int cpu, struct task_struct *tidle)
+{
+	unsigned int tmp;
+
+	secondary_stack = (unsigned int)tidle->stack + THREAD_SIZE;
+
+	secondary_hint = mfcr("cr31");
+
+	secondary_ccr  = mfcr("cr18");
+
+	pr_info("%s: CPU%u\n", __func__, cpu);
+
+	tmp = mfcr("cr<29, 0>");
+	tmp |= 1 << cpu;
+	mtcr("cr<29, 0>", tmp);
+
+	while (!cpu_online(cpu));
+
+	secondary_stack = 0;
+
+	return 0;
+}
+
+void __init smp_cpus_done(unsigned int max_cpus)
+{
+}
+
+int setup_profiling_timer(unsigned int multiplier)
+{
+	return -EINVAL;
+}
+
+void csky_start_secondary(void)
+{
+	struct mm_struct *mm = &init_mm;
+	unsigned int cpu = smp_processor_id();
+
+	mtcr("cr31", secondary_hint);
+	mtcr("cr18", secondary_ccr);
+
+	mtcr("vbr", vec_base);
+
+	flush_tlb_all();
+	write_mmu_pagemask(0);
+	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir);
+	TLBMISS_HANDLER_SETUP_PGD_KERNEL(swapper_pg_dir);
+
+	asid_cache(smp_processor_id()) = ASID_FIRST_VERSION;
+
+#ifdef CONFIG_CPU_HAS_FPU
+	init_fpu();
+#endif
+
+	enable_smp_ipi();
+
+	mmget(mm);
+	mmgrab(mm);
+	current->active_mm = mm;
+	cpumask_set_cpu(cpu, mm_cpumask(mm));
+
+	notify_cpu_starting(cpu);
+	set_cpu_online(cpu, true);
+
+	pr_info("CPU%u Online: %s...\n", cpu, __func__);
+
+	local_irq_enable();
+	preempt_disable();
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
+}
+
-- 
2.7.4
