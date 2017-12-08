From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 32/33] irqchip: Andestech Internal Vector Interrupt Controller driver
Date: Fri,  8 Dec 2017 17:12:15 +0800
Message-ID: <4fb7bd1cd2619287061fd68a38a774c8aef7dbe9.1512723245.git.green.hu@gmail.com>
References: <cover.1512723245.git.green.hu@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1512723245.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1512723245.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1512723245.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org
Cc: green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Rick Chen <rick-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>

This patch adds the Andestech Internal Vector Interrupt Controller
driver. You can find the spec here. Ch4.9 of AndeStar SPA V3 Manual.
http://www.andestech.com/product.php?cls=9

Signed-off-by: Rick Chen <rick-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
---
 drivers/irqchip/Makefile       |    1 +
 drivers/irqchip/irq-ativic32.c |  120 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)
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
index 0000000..709b65c
--- /dev/null
+++ b/drivers/irqchip/irq-ativic32.c
@@ -0,0 +1,120 @@
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
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
