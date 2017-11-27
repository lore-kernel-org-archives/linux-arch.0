From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v2 27/35] irqchip: Andestech Internal Vector Interrupt Controller driver
Date: Mon, 27 Nov 2017 20:28:14 +0800
Message-ID: <e82831165cd9e45a7d03af9c870560a6384e1603.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org
Cc: green.hu@gmail.com, Rick Chen <rick@andestech.com>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

This patch adds the Andestech Internal Vector Interrupt Controller
driver. You can find the spec here. Ch4.9 of AndeStar SPA V3 Manual.
http://www.andestech.com/product.php?cls=9

Signed-off-by: Rick Chen <rick@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 drivers/irqchip/Makefile       |    1 +
 drivers/irqchip/irq-ativic32.c |  119 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 drivers/irqchip/irq-ativic32.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index b842dfd..201ca9f 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -80,3 +80,4 @@ obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
 obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+= irq-uniphier-aidet.o
+obj-$(CONFIG_NDS32)			+= irq-ativic32.o
diff --git a/drivers/irqchip/irq-ativic32.c b/drivers/irqchip/irq-ativic32.c
new file mode 100644
index 0000000..c4d6f86
--- /dev/null
+++ b/drivers/irqchip/irq-ativic32.c
@@ -0,0 +1,119 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/irq.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip.h>
+#include <nds32_intrinsic.h>
+
+static void ativic32_ack_irq(struct irq_data *data)
+{
+	__nds32__mtsr_dsb(1 << data->hwirq, NDS32_SR_INT_PEND2);
+}
+
+static void ativic32_mask_irq(struct irq_data *data)
+{
+	unsigned long int_mask2 = __nds32__mfsr(NDS32_SR_INT_MASK2);
+	__nds32__mtsr_dsb(int_mask2 & (~(1 << data->hwirq)), NDS32_SR_INT_MASK2);
+}
+
+static void ativic32_mask_ack_irq(struct irq_data *data)
+{
+	unsigned long int_mask2 = __nds32__mfsr(NDS32_SR_INT_MASK2);
+	__nds32__mtsr_dsb(int_mask2 & (~(1 << data->hwirq)), NDS32_SR_INT_MASK2);
+	__nds32__mtsr_dsb((1 << data->hwirq), NDS32_SR_INT_PEND2);
+
+}
+
+static void ativic32_unmask_irq(struct irq_data *data)
+{
+	unsigned long int_mask2 = __nds32__mfsr(NDS32_SR_INT_MASK2);
+	__nds32__mtsr_dsb(int_mask2 | (1 << data->hwirq), NDS32_SR_INT_MASK2);
+}
+
+static struct irq_chip ativic32_chip = {
+	.name = "ativic32",
+	.irq_ack = ativic32_ack_irq,
+	.irq_mask = ativic32_mask_irq,
+	.irq_mask_ack = ativic32_mask_ack_irq,
+	.irq_unmask = ativic32_unmask_irq,
+};
+
+static unsigned int __initdata nivic_map[6] = { 6, 2, 10, 16, 24, 32 };
+
+static struct irq_domain *root_domain;
+static int ativic32_irq_domain_map(struct irq_domain *id, unsigned int virq,
+				  irq_hw_number_t hw)
+{
+
+	unsigned long int_trigger_type;
+	int_trigger_type = __nds32__mfsr(NDS32_SR_INT_TRIGGER);
+	if (int_trigger_type & (1 << hw))
+		irq_set_chip_and_handler(virq, &ativic32_chip, handle_edge_irq);
+	else
+		irq_set_chip_and_handler(virq, &ativic32_chip, handle_level_irq);
+
+	return 0;
+}
+
+static struct irq_domain_ops ativic32_ops = {
+	.map = ativic32_irq_domain_map,
+	.xlate = irq_domain_xlate_onecell
+};
+
+static int get_intr_src(void)
+{
+	return ((__nds32__mfsr(NDS32_SR_ITYPE)&ITYPE_mskVECTOR) >> ITYPE_offVECTOR)
+		- NDS32_VECTOR_offINTERRUPT;
+}
+
+asmlinkage void asm_do_IRQ(struct pt_regs *regs)
+{
+	int hwirq = get_intr_src();
+	handle_domain_irq(root_domain, hwirq, regs);
+}
+
+int __init ativic32_init_irq(struct device_node *node, struct device_node *parent)
+{
+	unsigned long int_vec_base, nivic;
+
+	if (WARN(parent, "non-root ativic32 are not supported"))
+		return -EINVAL;
+
+	int_vec_base = __nds32__mfsr(NDS32_SR_IVB);
+
+	if (((int_vec_base & IVB_mskIVIC_VER) >> IVB_offIVIC_VER) == 0)
+		panic("Unable to use atcivic32 for this cpu.\n");
+
+	nivic = (int_vec_base & IVB_mskNIVIC) >> IVB_offNIVIC;
+	if (nivic >= (sizeof nivic_map / sizeof nivic_map[0]))
+		panic("The number of input for ativic32 is not supported.\n");
+
+	nivic = nivic_map[nivic];
+
+	root_domain = irq_domain_add_linear(node, nivic,
+			&ativic32_ops, NULL);
+
+	if (!root_domain)
+		panic("%s: unable to create IRQ domain\n", node->full_name);
+
+	return 0;
+}
+IRQCHIP_DECLARE(ativic32, "andestech,ativic32", ativic32_init_irq);
-- 
1.7.9.5
