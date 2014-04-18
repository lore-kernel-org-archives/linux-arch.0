From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 13/28] nios2: Interrupt handling
Date: Fri, 18 Apr 2014 20:26:57 +0800
Message-ID: <1397824031-4892-11-git-send-email-lftan@altera.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1on0111.outbound.protection.outlook.com ([157.56.110.111]:22782
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752904AbaDRMn4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 Apr 2014 08:43:56 -0400
In-Reply-To: <1397824031-4892-1-git-send-email-lftan@altera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com

This patch adds the support for IRQ handling.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/nios2/include/asm/irq.h      | 34 +++++++++++++++
 arch/nios2/include/asm/irqflags.h | 69 ++++++++++++++++++++++++++++++
 arch/nios2/kernel/irq.c           | 90 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 193 insertions(+)
 create mode 100644 arch/nios2/include/asm/irq.h
 create mode 100644 arch/nios2/include/asm/irqflags.h
 create mode 100644 arch/nios2/kernel/irq.c

diff --git a/arch/nios2/include/asm/irq.h b/arch/nios2/include/asm/irq.h
new file mode 100644
index 0000000..f7e94b9
--- /dev/null
+++ b/arch/nios2/include/asm/irq.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2013 Altera Corporation
+ * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef _ASM_NIOS2_IRQ_H
+#define _ASM_NIOS2_IRQ_H
+
+#define NIOS2_CPU_NR_IRQS	32
+/* Reserve 32 additional interrupts for GPIO IRQs */
+#define NR_IRQS			(NIOS2_CPU_NR_IRQS + 32)
+
+#ifndef NO_IRQ
+#define NO_IRQ			(-1)
+#endif
+
+#include <asm-generic/irq.h>
+#include <linux/irqdomain.h>
+
+#endif
diff --git a/arch/nios2/include/asm/irqflags.h b/arch/nios2/include/asm/irqflags.h
new file mode 100644
index 0000000..e91f4f0b7c69454f7dd89590ddebccff73aad62a
--- /dev/null
+++ b/arch/nios2/include/asm/irqflags.h
@@ -0,0 +1,69 @@
+/*
+ * Copyright (C) 2010 Thomas Chou <thomas@wytron.com.tw>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+#ifndef _ASM_IRQFLAGS_H
+#define _ASM_IRQFLAGS_H
+
+#include <asm/registers.h>
+
+static inline unsigned long arch_local_save_flags(void)
+{
+	return RDCTL(CTL_STATUS);
+}
+
+/*
+ * This will restore ALL status register flags, not only the interrupt
+ * mask flag.
+ */
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	WRCTL(CTL_STATUS, flags);
+}
+
+static inline void arch_local_irq_disable(void)
+{
+	unsigned long flags;
+	flags = arch_local_save_flags();
+	arch_local_irq_restore(flags & ~STATUS_PIE);
+}
+
+static inline void arch_local_irq_enable(void)
+{
+	unsigned long flags;
+	flags = arch_local_save_flags();
+	arch_local_irq_restore(flags | STATUS_PIE);
+}
+
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	return (flags & STATUS_PIE) == 0;
+}
+
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
+}
+
+static inline unsigned long arch_local_irq_save(void)
+{
+	unsigned long flags;
+	flags = arch_local_save_flags();
+	arch_local_irq_restore(flags & ~STATUS_PIE);
+	return flags;
+}
+
+#endif /* _ASM_IRQFLAGS_H */
diff --git a/arch/nios2/kernel/irq.c b/arch/nios2/kernel/irq.c
new file mode 100644
index 0000000..e9265bd
--- /dev/null
+++ b/arch/nios2/kernel/irq.c
@@ -0,0 +1,90 @@
+/*
+ * Copyright (C) 2013 Altera Corporation
+ * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
+ * Copyright (C) 2008 Thomas Chou <thomas@wytron.com.tw>
+ *
+ * based on irq.c from m68k which is:
+ *
+ * Copyright (C) 2007 Greg Ungerer <gerg@snapgear.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+
+asmlinkage void do_IRQ(int hwirq, struct pt_regs *regs)
+{
+	struct pt_regs *oldregs = set_irq_regs(regs);
+	int irq;
+
+	irq_enter();
+	irq = irq_find_mapping(NULL, hwirq);
+	generic_handle_irq(irq);
+	irq_exit();
+
+	set_irq_regs(oldregs);
+}
+
+static void chip_unmask(struct irq_data *d)
+{
+	u32 ien;
+	ien = RDCTL(CTL_IENABLE);
+	ien |= (1 << d->hwirq);
+	WRCTL(CTL_IENABLE, ien);
+}
+
+static void chip_mask(struct irq_data *d)
+{
+	u32 ien;
+	ien = RDCTL(CTL_IENABLE);
+	ien &= ~(1 << d->hwirq);
+	WRCTL(CTL_IENABLE, ien);
+}
+
+static struct irq_chip m_irq_chip = {
+	.name		= "NIOS2-INTC",
+	.irq_unmask	= chip_unmask,
+	.irq_mask	= chip_mask,
+};
+
+static int irq_map(struct irq_domain *h, unsigned int virq,
+				irq_hw_number_t hw_irq_num)
+{
+	irq_set_chip_and_handler(virq, &m_irq_chip, handle_level_irq);
+
+	return 0;
+}
+
+static struct irq_domain_ops irq_ops = {
+	.map	= irq_map,
+	.xlate	= irq_domain_xlate_onecell,
+};
+
+void __init init_IRQ(void)
+{
+	struct irq_domain *domain;
+	struct device_node *node;
+
+	node = of_find_compatible_node(NULL, NULL, "ALTR,nios2-1.0");
+	BUG_ON(!node);
+
+	domain = irq_domain_add_linear(node, NIOS2_CPU_NR_IRQS, &irq_ops, NULL);
+	BUG_ON(!domain);
+
+	irq_set_default_host(domain);
+	of_node_put(node);
+}
-- 
1.8.3.2
