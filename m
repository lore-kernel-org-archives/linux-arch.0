From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v7 36/37] irqchip: Andestech Internal Vector Interrupt Controller driver
Date: Tue, 13 Feb 2018 17:09:40 +0800
Message-ID: <0ed65d44279ff34d91f3aa198309d1a04df3b911.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Sender: netdev-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com, Rick Chen <rick@andestech.com>
List-Id: linux-arch.vger.kernel.org

This patch adds the Andestech Internal Vector Interrupt Controller
driver. You can find the spec here. Ch4.9 of AndeStar SPA V3 Manual.
http://www.andestech.com/product.php?cls=9

Signed-off-by: Rick Chen <rick@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/Makefile       |   1 +
 drivers/irqchip/irq-ativic32.c | 107 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)
 create mode 100644 drivers/irqchip/irq-ativic32.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d27e3e3619e0..de7cf483e1b7 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -85,3 +85,4 @@ obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+= irq-uniphier-aidet.o
 obj-$(CONFIG_ARCH_SYNQUACER)		+= irq-sni-exiu.o
 obj-$(CONFIG_MESON_IRQ_GPIO)		+= irq-meson-gpio.o
 obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
+obj-$(CONFIG_NDS32)			+= irq-ativic32.o
diff --git a/drivers/irqchip/irq-ativic32.c b/drivers/irqchip/irq-ativic32.c
new file mode 100644
index 000000000000..f69a8588521c
--- /dev/null
+++ b/drivers/irqchip/irq-ativic32.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
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
+	__nds32__mtsr_dsb(BIT(data->hwirq), NDS32_SR_INT_PEND2);
+}
+
+static void ativic32_mask_irq(struct irq_data *data)
+{
+	unsigned long int_mask2 = __nds32__mfsr(NDS32_SR_INT_MASK2);
+	__nds32__mtsr_dsb(int_mask2 & (~(BIT(data->hwirq))), NDS32_SR_INT_MASK2);
+}
+
+static void ativic32_unmask_irq(struct irq_data *data)
+{
+	unsigned long int_mask2 = __nds32__mfsr(NDS32_SR_INT_MASK2);
+	__nds32__mtsr_dsb(int_mask2 | (BIT(data->hwirq)), NDS32_SR_INT_MASK2);
+}
+
+static struct irq_chip ativic32_chip = {
+	.name = "ativic32",
+	.irq_ack = ativic32_ack_irq,
+	.irq_mask = ativic32_mask_irq,
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
+	u32 type;
+	struct irq_data *irq_data;
+	int_trigger_type = __nds32__mfsr(NDS32_SR_INT_TRIGGER);
+	irq_data = irq_get_irq_data(virq);
+	if (!irq_data)
+		return -EINVAL;
+
+	if (int_trigger_type & (BIT(hw))) {
+		irq_set_chip_and_handler(virq, &ativic32_chip, handle_edge_irq);
+		type = IRQ_TYPE_EDGE_RISING;
+	} else {
+		irq_set_chip_and_handler(virq, &ativic32_chip, handle_level_irq);
+		type = IRQ_TYPE_LEVEL_HIGH;
+	}
+
+	irqd_set_trigger_type(irq_data, type);
+	return 0;
+}
+
+static struct irq_domain_ops ativic32_ops = {
+	.map = ativic32_irq_domain_map,
+	.xlate = irq_domain_xlate_onecell
+};
+
+static irq_hw_number_t get_intr_src(void)
+{
+	return ((__nds32__mfsr(NDS32_SR_ITYPE) & ITYPE_mskVECTOR) >> ITYPE_offVECTOR)
+		- NDS32_VECTOR_offINTERRUPT;
+}
+
+asmlinkage void asm_do_IRQ(struct pt_regs *regs)
+{
+	irq_hw_number_t hwirq = get_intr_src();
+	handle_domain_irq(root_domain, hwirq, regs);
+}
+
+int __init ativic32_init_irq(struct device_node *node, struct device_node *parent)
+{
+	unsigned long int_vec_base, nivic, nr_ints;
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
+	if (nivic >= ARRAY_SIZE(nivic_map))
+		panic("The number of input for ativic32 is not supported.\n");
+
+	nr_ints = nivic_map[nivic];
+
+	root_domain = irq_domain_add_linear(node, nr_ints,
+			&ativic32_ops, NULL);
+
+	if (!root_domain)
+		panic("%s: unable to create IRQ domain\n", node->full_name);
+
+	return 0;
+}
+IRQCHIP_DECLARE(ativic32, "andestech,ativic32", ativic32_init_irq);
-- 
2.16.1
