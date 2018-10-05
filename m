From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V7 10/20] csky: IRQ handling
Date: Fri,  5 Oct 2018 13:41:52 +0800
Message-ID: <b092fb59fe7e767fcff00d04ef9ef025139de782.1538715563.git.ren_guo@c-sky.com>
References: <cover.1538715563.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1538715563.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1538715563.git.ren_guo@c-sky.com>
References: <cover.1538715563.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de
Cc: green.hu@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

This patch adds IRQ handling files.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/irqflags.h | 49 ++++++++++++++++++++++++++++++++++++++++
 arch/csky/kernel/irq.c           | 22 ++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 arch/csky/include/asm/irqflags.h
 create mode 100644 arch/csky/kernel/irq.c

diff --git a/arch/csky/include/asm/irqflags.h b/arch/csky/include/asm/irqflags.h
new file mode 100644
index 0000000..9e3a569
--- /dev/null
+++ b/arch/csky/include/asm/irqflags.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_CSKY_IRQFLAGS_H
+#define __ASM_CSKY_IRQFLAGS_H
+#include <abi/reg_ops.h>
+
+static inline unsigned long arch_local_irq_save(void)
+{
+	unsigned long flags;
+
+	flags = mfcr("psr");
+	asm volatile("psrclr ie\n":::"memory");
+	return flags;
+}
+#define arch_local_irq_save arch_local_irq_save
+
+static inline void arch_local_irq_enable(void)
+{
+	asm volatile("psrset ee, ie\n":::"memory");
+}
+#define arch_local_irq_enable arch_local_irq_enable
+
+static inline void arch_local_irq_disable(void)
+{
+	asm volatile("psrclr ie\n":::"memory");
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
index 0000000..03a1930
--- /dev/null
+++ b/arch/csky/kernel/irq.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <asm/traps.h>
+#include <asm/smp.h>
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
