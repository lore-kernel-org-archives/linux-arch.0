From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 06/19] csky: IRQ handling
Date: Mon, 19 Mar 2018 03:51:28 +0800
Message-ID: <28baa2d92e5c3145afdff68ca784075afbb64d88.1521399976.git.ren_guo@c-sky.com>
References: <cover.1521399976.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1521399976.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1521399976.git.ren_guo@c-sky.com>
References: <cover.1521399976.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/irq.h      | 12 +++++++++
 arch/csky/include/asm/irqflags.h | 55 ++++++++++++++++++++++++++++++++++++++++
 arch/csky/kernel/irq.c           | 41 ++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+)
 create mode 100644 arch/csky/include/asm/irq.h
 create mode 100644 arch/csky/include/asm/irqflags.h
 create mode 100644 arch/csky/kernel/irq.c

diff --git a/arch/csky/include/asm/irq.h b/arch/csky/include/asm/irq.h
new file mode 100644
index 0000000..f68e868
--- /dev/null
+++ b/arch/csky/include/asm/irq.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_IRQ_H
+#define __ASM_CSKY_IRQ_H
+
+#define NR_IRQS CONFIG_CSKY_NR_IRQS
+
+#include <asm-generic/irq.h>
+
+extern unsigned int (*csky_get_auto_irqno) (void);
+
+#endif /* __ASM_CSKY_IRQ_H */
diff --git a/arch/csky/include/asm/irqflags.h b/arch/csky/include/asm/irqflags.h
new file mode 100644
index 0000000..ac8035a
--- /dev/null
+++ b/arch/csky/include/asm/irqflags.h
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_IRQFLAGS_H
+#define __ASM_CSKY_IRQFLAGS_H
+
+static inline unsigned long arch_local_irq_save(void)
+{
+	unsigned long flags;
+	asm volatile(
+		"mfcr	%0, psr	\n"
+		"psrclr	ie	\n"
+		:"=r"(flags));
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
+	unsigned long flags;
+	asm volatile("mfcr %0, psr\n":"=r"(flags));
+	return flags;
+}
+#define arch_local_save_flags arch_local_save_flags
+
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	asm volatile(
+		"mtcr 	%0, psr \n"
+		::"r" (flags)
+		:"memory"
+		);
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
index 0000000..0cdb4fe
--- /dev/null
+++ b/arch/csky/kernel/irq.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+
+unsigned int (*csky_get_auto_irqno) (void) = NULL;
+
+void csky_do_IRQ(int irq, struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	irq_enter();
+	generic_handle_irq(irq);
+	irq_exit();
+
+	set_irq_regs(old_regs);
+}
+
+asmlinkage void csky_do_auto_IRQ(struct pt_regs *regs)
+{
+	unsigned long irq, psr;
+
+	asm volatile("mfcr %0, psr":"=r"(psr));
+
+	irq = (psr >> 16) & 0xff;
+
+	if (irq == 10)
+		irq = csky_get_auto_irqno();
+	else
+		irq -= 32;
+
+	csky_do_IRQ(irq, regs);
+}
+
+void __init init_IRQ(void)
+{
+	irqchip_init();
+}
+
-- 
2.7.4
