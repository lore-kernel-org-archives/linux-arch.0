From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v12 19/21] h8300: IRQ chip driver
Date: Mon, 11 May 2015 15:26:38 +0900
Message-ID: <1431325600-12333-20-git-send-email-ysato@users.sourceforge.jp>
References: <1431325600-12333-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431325600-12333-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../interrupt-controller/renesas,h8300h-intc.txt   |  22 +++++
 .../interrupt-controller/renesas,h8s-intc.txt      |  22 +++++
 drivers/irqchip/Kconfig                            |   8 ++
 drivers/irqchip/Makefile                           |   2 +
 drivers/irqchip/irq-renesas-h8300h.c               |  95 +++++++++++++++++++
 drivers/irqchip/irq-renesas-h8s.c                  | 101 +++++++++++++++++++++
 6 files changed, 250 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,h8300h-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,h8s-intc.txt
 create mode 100644 drivers/irqchip/irq-renesas-h8300h.c
 create mode 100644 drivers/irqchip/irq-renesas-h8s.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,h8300h-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,h8300h-intc.txt
new file mode 100644
index 0000000..56e8d82
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,h8300h-intc.txt
@@ -0,0 +1,22 @@
+* H8/300H Interrupt controller
+
+Required properties:
+
+- compatible: has to be "renesas,h8300h-intc", "renesas,h8300-intc" as fallback.
+- #interrupt-cells: has to be <2>: an interrupt index and flags, as defined in
+  interrupts.txt in this directory
+- regs: Base address of interrupt controller registers.
+
+Optional properties:
+
+- any properties, listed in interrupts.txt, and any standard resource allocation
+  properties
+
+Example:
+
+	h8intc: interrupt-controller@fee012 {
+		compatible = "renesas,h8300h-intc", "renesas,h8300-intc";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0xfee012 7>;
+	};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,h8s-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,h8s-intc.txt
new file mode 100644
index 0000000..faded2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,h8s-intc.txt
@@ -0,0 +1,22 @@
+* H8S Interrupt controller
+
+Required properties:
+
+- compatible: has to be "renesas,h8s-intc", "renesas,h8300-intc" as fallback.
+- #interrupt-cells: has to be <2>: an interrupt index and flags, as defined in
+  interrupts.txt in this directory
+- regs: Base address of interrupt controller registers.
+
+Optional properties:
+
+- any properties, listed in interrupts.txt, and any standard resource allocation
+  properties
+
+Example:
+
+	h8intc: interrupt-controller@fffe00 {
+		compatible = "renesas,h8s-intc", "renesas,h8300-intc";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0xfffe00 24>;
+	};
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 6de62a9..9986815 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -158,3 +158,11 @@ config KEYSTONE_IRQ
 config MIPS_GIC
 	bool
 	select MIPS_CM
+
+config RENESAS_H8300H_INTC
+        bool
+	select IRQ_DOMAIN
+
+config RENESAS_H8S_INTC
+        bool
+	select IRQ_DOMAIN
\ No newline at end of file
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index dda4927..f8efb70 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -47,3 +47,5 @@ obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
 obj-$(CONFIG_MIPS_GIC)			+= irq-mips-gic.o
 obj-$(CONFIG_ARCH_MEDIATEK)		+= irq-mtk-sysirq.o
 obj-$(CONFIG_ARCH_DIGICOLOR)		+= irq-digicolor.o
+obj-$(CONFIG_RENESAS_H8300H_INTC)	+= irq-renesas-h8300h.o
+obj-$(CONFIG_RENESAS_H8S_INTC)		+= irq-renesas-h8s.o
diff --git a/drivers/irqchip/irq-renesas-h8300h.c b/drivers/irqchip/irq-renesas-h8300h.c
new file mode 100644
index 0000000..1870e6b
--- /dev/null
+++ b/drivers/irqchip/irq-renesas-h8300h.c
@@ -0,0 +1,95 @@
+/*
+ * H8/300H interrupt controller driver
+ *
+ * Copyright 2015 Yoshinori Sato <ysato@users.sourceforge.jp>
+ */
+
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <asm/io.h>
+
+#include "irqchip.h"
+
+static const char ipr_bit[] = {
+	 7,  6,  5,  5,
+	 4,  4,  4,  4,  3,  3,  3,  3,
+	 2,  2,  2,  2,  1,  1,  1,  1,
+	 0,  0,  0,  0, 15, 15, 15, 15,
+	14, 14, 14, 14, 13, 13, 13, 13,
+	-1, -1, -1, -1, 11, 11, 11, 11,
+	10, 10, 10, 10,  9,  9,  9,  9,
+};
+
+static void *intc_baseaddr;
+
+#define IPR ((unsigned long)intc_baseaddr + 6)
+
+static void h8300h_disable_irq(struct irq_data *data)
+{
+	int bit;
+	int irq = data->irq - 12;
+
+	bit = ipr_bit[irq];
+	if (bit >= 0) {
+		if (bit < 8)
+			ctrl_bclr(bit & 7, IPR);
+		else
+			ctrl_bclr(bit & 7, (IPR+1));
+	}
+}
+
+static void h8300h_enable_irq(struct irq_data *data)
+{
+	int bit;
+	int irq = data->irq - 12;
+
+	bit = ipr_bit[irq];
+	if (bit >= 0) {
+		if (bit < 8)
+			ctrl_bset(bit & 7, IPR);
+		else
+			ctrl_bset(bit & 7, (IPR+1));
+	}
+}
+
+struct irq_chip h8300h_irq_chip = {
+	.name		= "H8/300H-INTC",
+	.irq_enable	= h8300h_enable_irq,
+	.irq_disable	= h8300h_disable_irq,
+};
+
+static int irq_map(struct irq_domain *h, unsigned int virq,
+		   irq_hw_number_t hw_irq_num)
+{
+       irq_set_chip_and_handler(virq, &h8300h_irq_chip, handle_simple_irq);
+
+       return 0;
+}
+
+static struct irq_domain_ops irq_ops = {
+       .map    = irq_map,
+       .xlate  = irq_domain_xlate_onecell,
+};
+
+static int __init h8300h_intc_of_init(struct device_node *intc,
+				      struct device_node *parent)
+{
+	struct irq_domain *domain;
+
+	intc_baseaddr = of_iomap(intc, 0);
+	BUG_ON(!intc_baseaddr);
+
+	/* All interrupt priority low */
+	ctrl_outb(0x00, IPR + 0);
+	ctrl_outb(0x00, IPR + 1);
+
+	domain = irq_domain_add_linear(intc, NR_IRQS, &irq_ops, NULL);
+	BUG_ON(!domain);
+	irq_set_default_host(domain);
+	return 0;
+}
+
+IRQCHIP_DECLARE(h8300h_intc, "renesas,h8300h-intc", h8300h_intc_of_init);
diff --git a/drivers/irqchip/irq-renesas-h8s.c b/drivers/irqchip/irq-renesas-h8s.c
new file mode 100644
index 0000000..64425f4
--- /dev/null
+++ b/drivers/irqchip/irq-renesas-h8s.c
@@ -0,0 +1,101 @@
+/*
+ * H8S interrupt contoller driver
+ *
+ * Copyright 2015 Yoshinori Sato <ysato@users.sourceforge.jp>
+ */
+
+#include <linux/irq.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <asm/io.h>
+#include "irqchip.h"
+
+static void *intc_baseaddr;
+#define IPRA ((unsigned long)intc_baseaddr)
+
+static const unsigned char ipr_table[] = {
+	0x03, 0x02, 0x01, 0x00, 0x13, 0x12, 0x11, 0x10, /* 16 - 23 */
+	0x23, 0x22, 0x21, 0x20, 0x33, 0x32, 0x31, 0x30, /* 24 - 31 */
+	0x43, 0x42, 0x41, 0x40, 0x53, 0x53, 0x52, 0x52, /* 32 - 39 */
+	0x51, 0x51, 0x51, 0x51, 0x51, 0x51, 0x51, 0x51, /* 40 - 47 */
+	0x50, 0x50, 0x50, 0x50, 0x63, 0x63, 0x63, 0x63, /* 48 - 55 */
+	0x62, 0x62, 0x62, 0x62, 0x62, 0x62, 0x62, 0x62, /* 56 - 63 */
+	0x61, 0x61, 0x61, 0x61, 0x60, 0x60, 0x60, 0x60, /* 64 - 71 */
+	0x73, 0x73, 0x73, 0x73, 0x72, 0x72, 0x72, 0x72, /* 72 - 79 */
+	0x71, 0x71, 0x71, 0x71, 0x70, 0x83, 0x82, 0x81, /* 80 - 87 */
+	0x80, 0x80, 0x80, 0x80, 0x93, 0x93, 0x93, 0x93, /* 88 - 95 */
+	0x92, 0x92, 0x92, 0x92, 0x91, 0x91, 0x91, 0x91, /* 96 - 103 */
+	0x90, 0x90, 0x90, 0x90, 0xa3, 0xa3, 0xa3, 0xa3, /* 104 - 111 */
+	0xa2, 0xa2, 0xa2, 0xa2, 0xa1, 0xa1, 0xa1, 0xa1, /* 112 - 119 */
+	0xa0, 0xa0, 0xa0, 0xa0, 0xa0, 0xa0, 0xa0, 0xa0, /* 120 - 127 */
+};
+
+static void h8s_disable_irq(struct irq_data *data)
+{
+	int pos;
+	unsigned int addr;
+	unsigned short pri;
+	int irq = data->irq;
+
+	addr = IPRA + ((ipr_table[irq - 16] & 0xf0) >> 3);
+	pos = (ipr_table[irq - 16] & 0x0f) * 4;
+	pri = ~(0x000f << pos);
+	pri &= ctrl_inw(addr);
+	ctrl_outw(pri, addr);
+}
+
+static void h8s_enable_irq(struct irq_data *data)
+{
+	int pos;
+	unsigned int addr;
+	unsigned short pri;
+	int irq = data->irq;
+
+	addr = IPRA + ((ipr_table[irq - 16] & 0xf0) >> 3);
+	pos = (ipr_table[irq - 16] & 0x0f) * 4;
+	pri = ~(0x000f << pos);
+	pri &= ctrl_inw(addr);
+	pri |= 1 << pos;
+	ctrl_outw(pri, addr);
+}
+
+struct irq_chip h8s_irq_chip = {
+	.name		= "H8S-INTC",
+	.irq_enable	= h8s_enable_irq,
+	.irq_disable	= h8s_disable_irq,
+};
+
+static __init int irq_map(struct irq_domain *h, unsigned int virq,
+			  irq_hw_number_t hw_irq_num)
+{
+       irq_set_chip_and_handler(virq, &h8s_irq_chip, handle_simple_irq);
+
+       return 0;
+}
+
+static struct irq_domain_ops irq_ops = {
+       .map    = irq_map,
+       .xlate  = irq_domain_xlate_onecell,
+};
+
+static int __init h8s_intc_of_init(struct device_node *intc,
+				   struct device_node *parent)
+{
+	struct irq_domain *domain;
+	int n;
+
+	intc_baseaddr = of_iomap(intc, 0);
+	BUG_ON(!intc_baseaddr);
+
+	/* All interrupt priority is 0 (disable) */
+	/* IPRA to IPRK */
+	for (n = 0; n <= 'k' - 'a'; n++)
+		ctrl_outw(0x0000, IPRA + (n * 2));
+
+	domain = irq_domain_add_linear(intc, NR_IRQS, &irq_ops, NULL);
+	BUG_ON(!domain);
+	irq_set_default_host(domain);
+	return 0;
+}
+
+IRQCHIP_DECLARE(h8s_intc, "renesas,h8s-intc", h8s_intc_of_init);
-- 
2.1.4
