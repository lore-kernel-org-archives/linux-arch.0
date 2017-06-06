From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 10/17] irqchip: New RISC-V PLIC Driver
Date: Tue,  6 Jun 2017 16:00:00 -0700
Message-ID: <20170606230007.19101-11-palmer@dabbelt.com>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606230007.19101-1-palmer@dabbelt.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net
Cc: albert@sifive.com, patches@groups.riscv.org, Palmer Dabbelt <palmer@dabbelt.com>
List-Id: linux-arch.vger.kernel.org

This patch adds a driver for the Platform Level Interrupt Controller
(PLIC) specified as part of the RISC-V supervisor level ISA manual.
The PLIC connocts global interrupt sources to the local interrupt
controller on each hart.  A PLIC is present on all RISC-V systems.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 drivers/irqchip/Kconfig          |  12 ++
 drivers/irqchip/Makefile         |   1 +
 drivers/irqchip/irq-riscv-plic.c | 253 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 266 insertions(+)
 create mode 100644 drivers/irqchip/irq-riscv-plic.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 478f8ace2664..2906d63934ef 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -301,3 +301,15 @@ config QCOM_IRQ_COMBINER
 	help
 	  Say yes here to add support for the IRQ combiner devices embedded
 	  in Qualcomm Technologies chips.
+
+config RISCV_PLIC
+        bool "Platform-Level Interrupt Controller"
+	depends on RISCV
+        default y
+        help
+	   This enables support for the PLIC chip found in standard RISC-V
+	   systems. The PLIC is the top-most interrupt controller found in
+	   the system, connected directly to the core complex. All other
+	   interrupt sources (MSI, GPIO, etc) are subordinate to the PLIC.
+
+	   If you don't know what to do here, say Y.
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index b64c59b838a0..bed94cc89146 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -76,3 +76,4 @@ obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
+obj-$(CONFIG_RISCV_PLIC)		+= irq-riscv-plic.o
diff --git a/drivers/irqchip/irq-riscv-plic.c b/drivers/irqchip/irq-riscv-plic.c
new file mode 100644
index 000000000000..906c8a62a911
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-plic.c
@@ -0,0 +1,253 @@
+/*
+ * Copyright (C) 2017 SiFive
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+
+/* From the RISC-V Privlidged Spec v1.10:
+ *
+ * Global interrupt sources are assigned small unsigned integer identifiers,
+ * beginning at the value 1.  An interrupt ID of 0 is reserved to mean “no
+ * interrupt”.  Interrupt identifiers are also used to break ties when two or
+ * more interrupt sources have the same assigned priority. Smaller values of
+ * interrupt ID take precedence over larger values of interrupt ID.
+ *
+ * It's not defined what the largest device ID is, so we're just fixing
+ * MAX_DEVICES right here (which is named oddly, as there will never be a
+ * device 0).
+ */
+#define MAX_DEVICES	1024
+#define MAX_CONTEXTS	15872
+
+#define PRIORITY_BASE	0
+#define ENABLE_BASE	0x2000
+#define ENABLE_SIZE	0x80
+#define HART_BASE	0x200000
+#define HART_SIZE	0x1000
+
+struct plic_hart_context {
+	u32 threshold;
+	u32 claim;
+};
+
+struct plic_enable_context {
+	atomic_t mask[32]; // 32-bit * 32-entry
+};
+
+struct plic_priority {
+	u32 prio[MAX_DEVICES];
+};
+
+struct plic_data {
+	struct irq_chip		chip;
+	struct irq_domain	*domain;
+	u32			ndev;
+	void __iomem		*reg;
+	int			handlers;
+	struct plic_handler	*handler;
+	char			name[30];
+};
+
+struct plic_handler {
+	struct plic_hart_context	*context;
+	struct plic_data		*data;
+};
+
+static inline
+struct plic_hart_context *plic_hart_context(struct plic_data *data, size_t i)
+{
+	return (struct plic_hart_context *)((char *)data->reg + HART_BASE + HART_SIZE*i);
+}
+
+static inline
+struct plic_enable_context *plic_enable_context(struct plic_data *data, size_t i)
+{
+	return (struct plic_enable_context *)((char *)data->reg + ENABLE_BASE + ENABLE_SIZE*i);
+}
+
+static inline
+struct plic_priority *plic_priority(struct plic_data *data)
+{
+	return (struct plic_priority *)((char *)data->reg + PRIORITY_BASE);
+}
+
+static void plic_disable(struct plic_data *data, int i, int hwirq)
+{
+	struct plic_enable_context *enable = plic_enable_context(data, i);
+
+	atomic_and(~(1 << (hwirq % 32)), &enable->mask[hwirq / 32]);
+}
+
+static void plic_enable(struct plic_data *data, int i, int hwirq)
+{
+	struct plic_enable_context *enable = plic_enable_context(data, i);
+
+	atomic_or((1 << (hwirq % 32)), &enable->mask[hwirq / 32]);
+}
+
+// There is no need to mask/unmask PLIC interrupts
+// They are "masked" by reading claim and "unmasked" when writing it back.
+static void plic_irq_mask(struct irq_data *d) { }
+static void plic_irq_unmask(struct irq_data *d) { }
+
+static void plic_irq_enable(struct irq_data *d)
+{
+	struct plic_data *data = irq_data_get_irq_chip_data(d);
+	struct plic_priority *priority = plic_priority(data);
+	int i;
+
+	iowrite32(1, &priority->prio[d->hwirq]);
+	for (i = 0; i < data->handlers; ++i)
+		if (data->handler[i].context)
+			plic_enable(data, i, d->hwirq);
+}
+
+static void plic_irq_disable(struct irq_data *d)
+{
+	struct plic_data *data = irq_data_get_irq_chip_data(d);
+	struct plic_priority *priority = plic_priority(data);
+	int i;
+
+	iowrite32(0, &priority->prio[d->hwirq]);
+	for (i = 0; i < data->handlers; ++i)
+		if (data->handler[i].context)
+			plic_disable(data, i, d->hwirq);
+}
+
+static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
+			      irq_hw_number_t hwirq)
+{
+	struct plic_data *data = d->host_data;
+
+	irq_set_chip_and_handler(irq, &data->chip, handle_simple_irq);
+	irq_set_chip_data(irq, data);
+	irq_set_noprobe(irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops plic_irqdomain_ops = {
+	.map	= plic_irqdomain_map,
+	.xlate	= irq_domain_xlate_onecell,
+};
+
+static void plic_chained_handle_irq(struct irq_desc *desc)
+{
+	struct plic_handler *handler = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irq_domain *domain = handler->data->domain;
+	u32 what;
+
+	chained_irq_enter(chip, desc);
+
+	while ((what = ioread32(&handler->context->claim))) {
+		int irq = irq_find_mapping(domain, what);
+
+		if (irq > 0)
+			generic_handle_irq(irq);
+		else
+			handle_bad_irq(desc);
+		iowrite32(what, &handler->context->claim);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static int plic_init(struct device_node *node, struct device_node *parent)
+{
+	struct plic_data *data;
+	struct resource resource;
+	int i, ok = 0;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (WARN_ON(!data))
+		return -ENOMEM;
+
+	data->reg = of_iomap(node, 0);
+	if (WARN_ON(!data->reg))
+		return -EIO;
+
+	of_property_read_u32(node, "riscv,ndev", &data->ndev);
+	if (WARN_ON(!data->ndev))
+		return -EINVAL;
+
+	data->handlers = of_irq_count(node);
+	if (WARN_ON(!data->handlers))
+		return -EINVAL;
+
+	data->handler =
+		kcalloc(data->handlers, sizeof(*data->handler), GFP_KERNEL);
+	if (WARN_ON(!data->handler))
+		return -ENOMEM;
+
+	data->domain = irq_domain_add_linear(node, data->ndev+1, &plic_irqdomain_ops, data);
+	if (WARN_ON(!data->domain))
+		return -ENOMEM;
+
+	of_address_to_resource(node, 0, &resource);
+	snprintf(data->name, sizeof(data->name),
+		 "riscv,plic0,%llx", resource.start);
+	data->chip.name = data->name;
+	data->chip.irq_mask = plic_irq_mask;
+	data->chip.irq_unmask = plic_irq_unmask;
+	data->chip.irq_enable = plic_irq_enable;
+	data->chip.irq_disable = plic_irq_disable;
+
+	for (i = 0; i < data->handlers; ++i) {
+		struct plic_handler *handler = &data->handler[i];
+		struct of_phandle_args parent;
+		int parent_irq, hwirq;
+
+		if (of_irq_parse_one(node, i, &parent))
+			continue;
+		// skip context holes
+		if (parent.args[0] == -1)
+			continue;
+
+		// skip any contexts that lead to inactive harts
+		if (of_device_is_compatible(parent.np, "riscv,cpu-intc") &&
+		    parent.np->parent &&
+		    riscv_of_processor_hart(parent.np->parent) < 0)
+			continue;
+
+		parent_irq = irq_create_of_mapping(&parent);
+		if (!parent_irq)
+			continue;
+
+		handler->context = plic_hart_context(data, i);
+		handler->data = data;
+		// hwirq prio must be > this to trigger an interrupt
+		iowrite32(0, &handler->context->threshold);
+
+		for (hwirq = 1; hwirq <= data->ndev; ++hwirq)
+			plic_disable(data, i, hwirq);
+		irq_set_chained_handler_and_data(parent_irq, plic_chained_handle_irq, handler);
+		++ok;
+	}
+
+	printk(KERN_INFO "%s: mapped %d interrupts to %d/%d handlers\n",
+	       data->name, data->ndev, ok, data->handlers);
+	WARN_ON(!ok);
+	return 0;
+}
+
+IRQCHIP_DECLARE(plic0, "riscv,plic0", plic_init);
-- 
2.13.0
