From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 13/28] ARC: make plat_smp_ops weak to allow over-rides
Date: Tue, 9 Jun 2015 17:18:13 +0530
Message-ID: <1433850508-26317-14-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:33099 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753841AbbFILuZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 07:50:25 -0400
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

This allows platforms to provide their own cpu wakeup routines
as well as IPI send / clear backends, while allowing a SMP kernel w/o
any such backend to build/boot

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/Kconfig             |  21 +++++---
 arch/arc/include/asm/irq.h   |   1 +
 arch/arc/include/asm/mcip.h  |  91 +++++++++++++++++++++++++++++++++
 arch/arc/kernel/Makefile     |   1 +
 arch/arc/kernel/intc-arcv2.c |   2 +-
 arch/arc/kernel/mcip.c       | 117 +++++++++++++++++++++++++++++++++++++++++++
 arch/arc/kernel/smp.c        |   2 +-
 arch/arc/plat-sim/platform.c |   5 ++
 8 files changed, 231 insertions(+), 9 deletions(-)
 create mode 100644 arch/arc/include/asm/mcip.h
 create mode 100644 arch/arc/kernel/mcip.c

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index f09e03a0d604..301525020af7 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -160,12 +160,12 @@ config CPU_BIG_ENDIAN
 	  Build kernel for Big Endian Mode of ARC CPU
 
 config SMP
-	bool "Symmetric Multi-Processing (Incomplete)"
+	bool "Symmetric Multi-Processing"
 	default n
+	select ARC_HAS_COH_CACHES if ISA_ARCV2
+	select ARC_MCIP if ISA_ARCV2
 	help
-	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, say N. If you have a system with more
-	  than one CPU, say Y.
+	  This enables support for systems with more than one CPU.
 
 if SMP
 
@@ -175,13 +175,20 @@ config ARC_HAS_COH_CACHES
 config ARC_HAS_REENTRANT_IRQ_LV2
 	def_bool n
 
-endif	#SMP
+config ARC_MCIP
+	bool "ARConnect Multicore IP (MCIP) Support "
+	depends on ISA_ARCV2
+	help
+	  This IP block enables SMP in ARC-HS38 cores.
+	  It provides for cross-core interrupts, multi-core debug
+	  hardware semaphores, shared memory,....
 
 config NR_CPUS
 	int "Maximum number of CPUs (2-4096)"
 	range 2 4096
-	depends on SMP
-	default "2"
+	default "4"
+
+endif	#SMP
 
 menuconfig ARC_CACHE
 	bool "Enable Cache Support"
diff --git a/arch/arc/include/asm/irq.h b/arch/arc/include/asm/irq.h
index 49014f0ef36d..bc5103637326 100644
--- a/arch/arc/include/asm/irq.h
+++ b/arch/arc/include/asm/irq.h
@@ -19,6 +19,7 @@
 #else
 #define TIMER0_IRQ      16
 #define TIMER1_IRQ      17
+#define IPI_IRQ         19
 #endif
 
 #include <linux/interrupt.h>
diff --git a/arch/arc/include/asm/mcip.h b/arch/arc/include/asm/mcip.h
new file mode 100644
index 000000000000..31f9bac77a27
--- /dev/null
+++ b/arch/arc/include/asm/mcip.h
@@ -0,0 +1,91 @@
+/*
+ * ARConnect IP Support (Multi core enabler: Cross core IPI, RTC ...)
+ *
+ * Copyright (C) 2014-15 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_MCIP_H
+#define __ASM_MCIP_H
+
+#ifdef CONFIG_ISA_ARCV2
+
+#include <asm/arcregs.h>
+
+#define ARC_REG_MCIP_BCR	0x0d0
+#define ARC_REG_MCIP_CMD	0x600
+#define ARC_REG_MCIP_WDATA	0x601
+#define ARC_REG_MCIP_READBACK	0x602
+
+struct mcip_cmd {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	unsigned int pad:8, param:16, cmd:8;
+#else
+	unsigned int cmd:8, param:16, pad:8;
+#endif
+
+#define CMD_INTRPT_GENERATE_IRQ		0x01
+#define CMD_INTRPT_GENERATE_ACK		0x02
+#define CMD_INTRPT_READ_STATUS		0x03
+#define CMD_INTRPT_CHECK_SOURCE		0x04
+
+/* Semaphore Commands */
+#define CMD_SEMA_CLAIM_AND_READ		0x11
+#define CMD_SEMA_RELEASE		0x12
+
+#define CMD_DEBUG_SET_MASK		0x34
+#define CMD_DEBUG_SET_SELECT		0x36
+
+#define CMD_IDU_ENABLE			0x71
+#define CMD_IDU_DISABLE			0x72
+#define CMD_IDU_SET_MODE		0x74
+#define CMD_IDU_SET_DEST		0x76
+#define CMD_IDU_SET_MASK		0x7C
+
+#define IDU_M_TRIG_LEVEL		0x0
+#define IDU_M_TRIG_EDGE			0x1
+
+#define IDU_M_DISTRI_RR			0x0
+#define IDU_M_DISTRI_DEST		0x2
+};
+
+/*
+ * MCIP programming model
+ *
+ * - Simple commands write {cmd:8,param:16} to MCIP_CMD aux reg
+ *   (param could be irq, common_irq, core_id ...)
+ * - More involved commands setup MCIP_WDATA with cmd specific data
+ *   before invoking the simple command
+ */
+static inline void __mcip_cmd(unsigned int cmd, unsigned int param)
+{
+	struct mcip_cmd buf;
+
+	buf.pad = 0;
+	buf.cmd = cmd;
+	buf.param = param;
+
+	WRITE_AUX(ARC_REG_MCIP_CMD, buf);
+}
+
+/*
+ * Setup additional data for a cmd
+ * Callers need to lock to ensure atomicity
+ */
+static inline void __mcip_cmd_data(unsigned int cmd, unsigned int param,
+				   unsigned int data)
+{
+	write_aux_reg(ARC_REG_MCIP_WDATA, data);
+
+	__mcip_cmd(cmd, param);
+}
+
+extern void mcip_init_early_smp(void);
+extern void mcip_init_smp(unsigned int cpu);
+
+#endif
+
+#endif
diff --git a/arch/arc/kernel/Makefile b/arch/arc/kernel/Makefile
index 0be7ba087260..e7f3625a19b5 100644
--- a/arch/arc/kernel/Makefile
+++ b/arch/arc/kernel/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_ISA_ARCV2)			+= entry-arcv2.o intc-arcv2.o
 
 obj-$(CONFIG_MODULES)			+= arcksyms.o module.o
 obj-$(CONFIG_SMP) 			+= smp.o
+obj-$(CONFIG_ARC_MCIP)			+= mcip.o
 obj-$(CONFIG_ARC_DW2_UNWIND)		+= unwind.o
 obj-$(CONFIG_KPROBES)      		+= kprobes.o
 obj-$(CONFIG_ARC_EMUL_UNALIGNED) 	+= unaligned.o
diff --git a/arch/arc/kernel/intc-arcv2.c b/arch/arc/kernel/intc-arcv2.c
index 3876e11d4553..945162c1242d 100644
--- a/arch/arc/kernel/intc-arcv2.c
+++ b/arch/arc/kernel/intc-arcv2.c
@@ -90,7 +90,7 @@ static struct irq_chip arcv2_irq_chip = {
 static int arcv2_irq_map(struct irq_domain *d, unsigned int irq,
 			 irq_hw_number_t hw)
 {
-	if (irq == TIMER0_IRQ)
+	if (irq == TIMER0_IRQ || irq == IPI_IRQ)
 		irq_set_chip_and_handler(irq, &arcv2_irq_chip, handle_percpu_irq);
 	else
 		irq_set_chip_and_handler(irq, &arcv2_irq_chip, handle_level_irq);
diff --git a/arch/arc/kernel/mcip.c b/arch/arc/kernel/mcip.c
new file mode 100644
index 000000000000..e6ad6e64440a
--- /dev/null
+++ b/arch/arc/kernel/mcip.c
@@ -0,0 +1,117 @@
+/*
+ * ARC ARConnect (MultiCore IP) support (formerly known as MCIP)
+ *
+ * Copyright (C) 2013 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/smp.h>
+#include <linux/irq.h>
+#include <linux/spinlock.h>
+#include <asm/mcip.h>
+
+static char smp_cpuinfo_buf[128];
+
+static DEFINE_RAW_SPINLOCK(mcip_lock);
+
+
+/*
+ * Any SMP specific init any CPU does when it comes up.
+ * Here we setup the CPU to enable Inter-Processor-Interrupts
+ * Called for each CPU
+ * -Master      : init_IRQ()
+ * -Other(s)    : start_kernel_secondary()
+ */
+void mcip_init_smp(unsigned int cpu)
+{
+	smp_ipi_irq_setup(cpu, IPI_IRQ);
+}
+
+static void mcip_ipi_send(int cpu)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&mcip_lock, flags);
+	__mcip_cmd(CMD_INTRPT_GENERATE_IRQ, cpu);
+	raw_spin_unlock_irqrestore(&mcip_lock, flags);
+}
+
+static void mcip_ipi_clear(int irq)
+{
+	unsigned int cpu;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&mcip_lock, flags);
+
+	/* Who sent the IPI */
+	__mcip_cmd(CMD_INTRPT_CHECK_SOURCE, 0);
+
+	cpu = read_aux_reg(ARC_REG_MCIP_READBACK);	/* 1,2,4,8... */
+
+	__mcip_cmd(CMD_INTRPT_GENERATE_ACK, __ffs(cpu)); /* 0,1,2,3... */
+
+	raw_spin_unlock_irqrestore(&mcip_lock, flags);
+}
+
+volatile int wake_flag;
+
+static void mcip_wakeup_cpu(int cpu, unsigned long pc)
+{
+	BUG_ON(cpu == 0);
+	wake_flag = cpu;
+}
+
+void arc_platform_smp_wait_to_boot(int cpu)
+{
+	while (wake_flag != cpu)
+		;
+
+	wake_flag = 0;
+	__asm__ __volatile__("j @first_lines_of_secondary	\n");
+}
+
+struct plat_smp_ops plat_smp_ops = {
+	.info		= smp_cpuinfo_buf,
+	.cpu_kick	= mcip_wakeup_cpu,
+	.ipi_send	= mcip_ipi_send,
+	.ipi_clear	= mcip_ipi_clear,
+};
+
+void mcip_init_early_smp(void)
+{
+#define IS_AVAIL1(var, str)    ((var) ? str : "")
+
+	struct mcip_bcr {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+		unsigned int pad3:8,
+			     idu:1, llm:1, num_cores:6,
+			     iocoh:1,  grtc:1, dbg:1, pad2:1,
+			     msg:1, sem:1, ipi:1, pad:1,
+			     ver:8;
+#else
+		unsigned int ver:8,
+			     pad:1, ipi:1, sem:1, msg:1,
+			     pad2:1, dbg:1, grtc:1, iocoh:1,
+			     num_cores:6, llm:1, idu:1,
+			     pad3:8;
+#endif
+	} mp;
+
+	READ_BCR(ARC_REG_MCIP_BCR, mp);
+
+	sprintf(smp_cpuinfo_buf,
+		"Extn [SMP]\t: ARConnect (v%d): %d cores with %s%s%s%s\n",
+		mp.ver, mp.num_cores,
+		IS_AVAIL1(mp.ipi, "IPI "),
+		IS_AVAIL1(mp.idu, "IDU "),
+		IS_AVAIL1(mp.dbg, "DEBUG "),
+		IS_AVAIL1(mp.grtc, "GRTC"));
+
+	if (mp.dbg) {
+		__mcip_cmd_data(CMD_DEBUG_SET_SELECT, 0, 0xf);
+		__mcip_cmd_data(CMD_DEBUG_SET_MASK, 0xf, 0xf);
+	}
+}
diff --git a/arch/arc/kernel/smp.c b/arch/arc/kernel/smp.c
index ee2982dda5a6..d07cb53d7641 100644
--- a/arch/arc/kernel/smp.c
+++ b/arch/arc/kernel/smp.c
@@ -31,7 +31,7 @@ arch_spinlock_t smp_atomic_ops_lock = __ARCH_SPIN_LOCK_UNLOCKED;
 arch_spinlock_t smp_bitops_lock = __ARCH_SPIN_LOCK_UNLOCKED;
 #endif
 
-struct plat_smp_ops  plat_smp_ops;
+struct plat_smp_ops  __weak plat_smp_ops;
 
 /* XXX: per cpu ? Only needed once in early seconday boot */
 struct task_struct *secondary_idle_tsk;
diff --git a/arch/arc/plat-sim/platform.c b/arch/arc/plat-sim/platform.c
index 114fdc30941c..8795ae2ef48a 100644
--- a/arch/arc/plat-sim/platform.c
+++ b/arch/arc/plat-sim/platform.c
@@ -10,6 +10,7 @@
 
 #include <linux/init.h>
 #include <asm/mach_desc.h>
+#include <asm/mcip.h>
 
 /*----------------------- Machine Descriptions ------------------------------
  *
@@ -27,4 +28,8 @@ static const char *simulation_compat[] __initconst = {
 
 MACHINE_START(SIMULATION, "simulation")
 	.dt_compat	= simulation_compat,
+#ifdef CONFIG_ARC_MCIP
+	.init_early	= mcip_init_early_smp,
+	.init_smp	= mcip_init_smp,
+#endif
 MACHINE_END
-- 
1.9.1
