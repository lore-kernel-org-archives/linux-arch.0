From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 16/28] ARCv2: SMP: intc: IDU 2nd level intc for dynamic IRQ distribution
Date: Tue, 9 Jun 2015 17:18:16 +0530
Message-ID: <1433850508-26317-17-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:33184 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752770AbbFILyl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 07:54:41 -0400
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 .../devicetree/bindings/arc/archs-idu-intc.txt     |  46 ++++++
 arch/arc/kernel/mcip.c                             | 183 ++++++++++++++++++++-
 2 files changed, 228 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arc/archs-idu-intc.txt

diff --git a/Documentation/devicetree/bindings/arc/archs-idu-intc.txt b/Documentation/devicetree/bindings/arc/archs-idu-intc.txt
new file mode 100644
index 000000000000..0dcb7c7d3e40
--- /dev/null
+++ b/Documentation/devicetree/bindings/arc/archs-idu-intc.txt
@@ -0,0 +1,46 @@
+* ARC-HS Interrupt Distribution Unit
+
+  This optional 2nd level interrupt controller can be used in SMP configurations for
+  dynamic IRQ routing, load balancing of common/external IRQs towards core intc.
+
+Properties:
+
+- compatible: "snps,archs-idu-intc"
+- interrupt-controller: This is an interrupt controller.
+- interrupt-parent: <reference to parent core intc>
+- #interrupt-cells: Must be <2>.
+- interrupts: <...> specifies the upstream core irqs
+
+  First cell specifies the "common" IRQ from peripheral to IDU
+  Second cell specifies the irq distribution mode to cores
+     0=Round Robin; 1=cpu0, 2=cpu1, 4=cpu2, 8=cpu3
+
+  intc accessed via the special ARC AUX register interface, hence "reg" property
+  is not specified.
+
+Example:
+	core_intc: core-interrupt-controller {
+		compatible = "snps,archs-intc";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	idu_intc: idu-interrupt-controller {
+		compatible = "snps,archs-idu-intc";
+		interrupt-controller;
+		interrupt-parent = <&core_intc>;
+
+		/*
+		 * <hwirq  distribution>
+		 * distribution: 0=RR; 1=cpu0, 2=cpu1, 4=cpu2, 8=cpu3
+		 */
+		#interrupt-cells = <2>;
+
+		/* upstream core irqs: downstream these are "COMMON" irq 0,1..  */
+		interrupts = <24 25 26 27 28 29 30 31>;
+	};
+
+	some_device: serial@c0fc1000 {
+		interrupt-parent = <&idu_intc>;
+		interrupts = <0 0>;	/* upstream idu IRQ #24, Round Robin */
+	};
diff --git a/arch/arc/kernel/mcip.c b/arch/arc/kernel/mcip.c
index ad7e90b97f6e..30284e8de6ff 100644
--- a/arch/arc/kernel/mcip.c
+++ b/arch/arc/kernel/mcip.c
@@ -14,10 +14,10 @@
 #include <asm/mcip.h>
 
 static char smp_cpuinfo_buf[128];
+static int idu_detected;
 
 static DEFINE_RAW_SPINLOCK(mcip_lock);
 
-
 /*
  * Any SMP specific init any CPU does when it comes up.
  * Here we setup the CPU to enable Inter-Processor-Interrupts
@@ -150,6 +150,8 @@ void mcip_init_early_smp(void)
 		IS_AVAIL1(mp.dbg, "DEBUG "),
 		IS_AVAIL1(mp.grtc, "GRTC"));
 
+	idu_detected = mp.idu;
+
 	if (mp.dbg) {
 		__mcip_cmd_data(CMD_DEBUG_SET_SELECT, 0, 0xf);
 		__mcip_cmd_data(CMD_DEBUG_SET_MASK, 0xf, 0xf);
@@ -158,3 +160,182 @@ void mcip_init_early_smp(void)
 	if (IS_ENABLED(CONFIG_ARC_HAS_GRTC) && !mp.grtc)
 		panic("kernel trying to use non-existent GRTC\n");
 }
+
+/***************************************************************************
+ * ARCv2 Interrupt Distribution Unit (IDU)
+ *
+ * Connects external "COMMON" IRQs to core intc, providing:
+ *  -dynamic routing (IRQ affinity)
+ *  -load balancing (Round Robin interrupt distribution)
+ *  -1:N distribution
+ *
+ * It physically resides in the MCIP hw block
+ */
+
+#include <linux/irqchip.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include "../../drivers/irqchip/irqchip.h"
+
+/*
+ * Set the DEST for @cmn_irq to @cpu_mask (1 bit per core)
+ */
+static void idu_set_dest(unsigned int cmn_irq, unsigned int cpu_mask)
+{
+	__mcip_cmd_data(CMD_IDU_SET_DEST, cmn_irq, cpu_mask);
+}
+
+static void idu_set_mode(unsigned int cmn_irq, unsigned int lvl,
+			   unsigned int distr)
+{
+	union {
+		unsigned int word;
+		struct {
+			unsigned int distr:2, pad:2, lvl:1, pad2:27;
+		};
+	} data;
+
+	data.distr = distr;
+	data.lvl = lvl;
+	__mcip_cmd_data(CMD_IDU_SET_MODE, cmn_irq, data.word);
+}
+
+static void idu_irq_mask(struct irq_data *data)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&mcip_lock, flags);
+	__mcip_cmd_data(CMD_IDU_SET_MASK, data->hwirq, 1);
+	raw_spin_unlock_irqrestore(&mcip_lock, flags);
+}
+
+static void idu_irq_unmask(struct irq_data *data)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&mcip_lock, flags);
+	__mcip_cmd_data(CMD_IDU_SET_MASK, data->hwirq, 0);
+	raw_spin_unlock_irqrestore(&mcip_lock, flags);
+}
+
+static int
+idu_irq_set_affinity(struct irq_data *d, const struct cpumask *cpumask, bool f)
+{
+	return IRQ_SET_MASK_OK;
+}
+
+static struct irq_chip idu_irq_chip = {
+	.name			= "MCIP IDU Intc",
+	.irq_mask		= idu_irq_mask,
+	.irq_unmask		= idu_irq_unmask,
+#ifdef CONFIG_SMP
+	.irq_set_affinity       = idu_irq_set_affinity,
+#endif
+
+};
+
+static int idu_first_irq;
+
+static void idu_cascade_isr(unsigned int core_irq, struct irq_desc *desc)
+{
+	struct irq_domain *domain = irq_desc_get_handler_data(desc);
+	unsigned int idu_irq;
+
+	idu_irq = core_irq - idu_first_irq;
+	generic_handle_irq(irq_find_mapping(domain, idu_irq));
+}
+
+static int idu_irq_map(struct irq_domain *d, unsigned int virq, irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(virq, &idu_irq_chip, handle_level_irq);
+	irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
+
+	return 0;
+}
+
+static int idu_irq_xlate(struct irq_domain *d, struct device_node *n,
+			 const u32 *intspec, unsigned int intsize,
+			 irq_hw_number_t *out_hwirq, unsigned int *out_type)
+{
+	irq_hw_number_t hwirq = *out_hwirq = intspec[0];
+	int distri = intspec[1];
+	unsigned long flags;
+
+	*out_type = IRQ_TYPE_NONE;
+
+	/* XXX: validate distribution scheme again online cpu mask */
+	if (distri == 0) {
+		/* 0 - Round Robin to all cpus, otherwise 1 bit per core */
+		raw_spin_lock_irqsave(&mcip_lock, flags);
+		idu_set_dest(hwirq, BIT(num_online_cpus()) - 1);
+		idu_set_mode(hwirq, IDU_M_TRIG_LEVEL, IDU_M_DISTRI_RR);
+		raw_spin_unlock_irqrestore(&mcip_lock, flags);
+	} else {
+		/*
+		 * DEST based distribution for Level Triggered intr can only
+		 * have 1 CPU, so generalize it to always contain 1 cpu
+		 */
+		int cpu = ffs(distri);
+
+		if (cpu != fls(distri))
+			pr_warn("IDU irq %lx distri mode set to cpu %x\n",
+				hwirq, cpu);
+
+		raw_spin_lock_irqsave(&mcip_lock, flags);
+		idu_set_dest(hwirq, cpu);
+		idu_set_mode(hwirq, IDU_M_TRIG_LEVEL, IDU_M_DISTRI_DEST);
+		raw_spin_unlock_irqrestore(&mcip_lock, flags);
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops idu_irq_ops = {
+	.xlate	= idu_irq_xlate,
+	.map	= idu_irq_map,
+};
+
+/*
+ * [16, 23]: Statically assigned always private-per-core (Timers, WDT, IPI)
+ * [24, 23+C]: If C > 0 then "C" common IRQs
+ * [24+C, N]: Not statically assigned, private-per-core
+ */
+
+
+static int __init
+idu_of_init(struct device_node *intc, struct device_node *parent)
+{
+	struct irq_domain *domain;
+	/* Read IDU BCR to confirm nr_irqs */
+	int nr_irqs = of_irq_count(intc);
+	int i, irq;
+
+	if (!idu_detected)
+		panic("IDU not detected, but DeviceTree using it");
+
+	pr_info("MCIP: IDU referenced from Devicetree %d irqs\n", nr_irqs);
+
+	domain = irq_domain_add_linear(intc, nr_irqs, &idu_irq_ops, NULL);
+
+	/* Parent interrupts (core-intc) are already mapped */
+
+	for (i = 0; i < nr_irqs; i++) {
+		/*
+		 * Return parent uplink IRQs (towards core intc) 24,25,.....
+		 * this step has been done before already
+		 * however we need it to get the parent virq and set IDU handler
+		 * as first level isr
+		 */
+		irq = irq_of_parse_and_map(intc, i);
+		if (!i)
+			idu_first_irq = irq;
+
+		irq_set_handler_data(irq, domain);
+		irq_set_chained_handler(irq, idu_cascade_isr);
+	}
+
+	__mcip_cmd(CMD_IDU_ENABLE, 0);
+
+	return 0;
+}
+IRQCHIP_DECLARE(arcv2_idu_intc, "snps,archs-idu-intc", idu_of_init);
-- 
1.9.1
