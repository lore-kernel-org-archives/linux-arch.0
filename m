From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 10/19] csky: IRQ handling
Date: Mon,  2 Jul 2018 01:30:13 +0800
Message-ID: <feb6f4269c498e4f7d7db05aae34617f870ec89f.1530465326.git.ren_guo@c-sky.com>
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
 arch/csky/include/asm/irq.h      | 10 ++++++++
 arch/csky/include/asm/irqflags.h | 49 ++++++++++++++++++++++++++++++++++++++++
 arch/csky/kernel/irq.c           | 31 +++++++++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 arch/csky/include/asm/irq.h
 create mode 100644 arch/csky/include/asm/irqflags.h
 create mode 100644 arch/csky/kernel/irq.c

diff --git a/arch/csky/include/asm/irq.h b/arch/csky/include/asm/irq.h
new file mode 100644
index 0000000..9390cb0
--- /dev/null
+++ b/arch/csky/include/asm/irq.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_IRQ_H
+#define __ASM_CSKY_IRQ_H
+
+#include <asm-generic/irq.h>
+
+extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
+
+#endif /* __ASM_CSKY_IRQ_H */
diff --git a/arch/csky/include/asm/irqflags.h b/arch/csky/include/asm/irqflags.h
new file mode 100644
index 0000000..5216ec0
--- /dev/null
+++ b/arch/csky/include/asm/irqflags.h
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_IRQFLAGS_H
+#define __ASM_CSKY_IRQFLAGS_H
+#include <abi/reg_ops.h>
+
+static inline unsigned long arch_local_irq_save(void)
+{
+	unsigned long flags;
+
+	flags = mfcr("psr");
+	asm volatile("psrclr ie\n");
+	return flags;
+}
+#define arch_local_irq_save arch_local_irq_save
+
+static inline void arch_local_irq_enable(void)
+{
+	asm volatile("psrset ee, ie\n");
+}
+#define arch_local_irq_enable arch_local_irq_enable
+
+static inline void arch_local_irq_disable(void)
+{
+	asm volatile("psrclr ie\n");
+}
+#define arch_local_irq_disable arch_local_irq_disable
+
+static inline unsigned long arch_local_save_flags(void)
+{
+	return mfcr("psr");
+}
+#define arch_local_save_flags arch_local_save_flags
+
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	mtcr("psr", flags);
+}
+#define arch_local_irq_restore arch_local_irq_restore
+
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	return !(flags & (1<<6));
+}
+#define arch_irqs_disabled_flags arch_irqs_disabled_flags
+
+#include <asm-generic/irqflags.h>
+
+#endif /* __ASM_CSKY_IRQFLAGS_H */
diff --git a/arch/csky/kernel/irq.c b/arch/csky/kernel/irq.c
new file mode 100644
index 0000000..ef2600d
--- /dev/null
+++ b/arch/csky/kernel/irq.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <asm/traps.h>
+#include <asm/smp.h>
+
+static void (*handle_arch_irq)(struct pt_regs *regs) = NULL;
+
+void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
+{
+	if (handle_arch_irq)
+		return;
+
+	handle_arch_irq = handle_irq;
+}
+
+void __init init_IRQ(void)
+{
+	irqchip_init();
+#ifdef CONFIG_SMP
+	setup_smp_ipi();
+#endif
+}
+
+asmlinkage void __irq_entry csky_do_IRQ(struct pt_regs *regs)
+{
+	handle_arch_irq(regs);
+}
-- 
2.7.4
