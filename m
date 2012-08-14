Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55113 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756822Ab2HNRxI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Aug 2012 13:53:08 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 11/31] arm64: IRQ handling
Date: Tue, 14 Aug 2012 18:52:12 +0100
Message-ID: <1344966752-16102-12-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>
Message-ID: <20120814175212.tmXxQRzGJ15sOYO4qYwezKCYt1ngNqmPrJhdq74kRe4@z>

From: Marc Zyngier <marc.zyngier@arm.com>

This patch adds the support for IRQ handling. The actual interrupt
controller will be part of a separate patch (going into
drivers/irqchip/).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/hardirq.h  |   47 +++++++++++++++++++
 arch/arm64/include/asm/irq.h      |    8 +++
 arch/arm64/include/asm/irqflags.h |   91 +++++++++++++++++++++++++++++++++=
++++
 arch/arm64/kernel/irq.c           |   84 +++++++++++++++++++++++++++++++++=
+
 4 files changed, 230 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/hardirq.h
 create mode 100644 arch/arm64/include/asm/irq.h
 create mode 100644 arch/arm64/include/asm/irqflags.h
 create mode 100644 arch/arm64/kernel/irq.c

diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hard=
irq.h
new file mode 100644
index 0000000..c6c9514
--- /dev/null
+++ b/arch/arm64/include/asm/hardirq.h
@@ -0,0 +1,47 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
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
+#ifndef __ASM_HARDIRQ_H
+#define __ASM_HARDIRQ_H
+
+#include <linux/cache.h>
+#include <linux/threads.h>
+#include <asm/irq.h>
+
+typedef struct {
+=09unsigned int __softirq_pending;
+} ____cacheline_aligned irq_cpustat_t;
+
+#include <linux/irq_cpustat.h>=09/* Standard mappings for irq_cpustat_t ab=
ove */
+
+#define __inc_irq_stat(cpu, member)=09__IRQ_STAT(cpu, member)++
+#define __get_irq_stat(cpu, member)=09__IRQ_STAT(cpu, member)
+
+#ifdef CONFIG_SMP
+u64 smp_irq_stat_cpu(unsigned int cpu);
+#define arch_irq_stat_cpu=09smp_irq_stat_cpu
+#endif
+
+#define __ARCH_IRQ_EXIT_IRQS_DISABLED=091
+
+static inline void ack_bad_irq(unsigned int irq)
+{
+=09extern unsigned long irq_err_count;
+=09irq_err_count++;
+}
+
+extern void handle_IRQ(unsigned int, struct pt_regs *);
+
+#endif /* __ASM_HARDIRQ_H */
diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
new file mode 100644
index 0000000..a4e1cad
--- /dev/null
+++ b/arch/arm64/include/asm/irq.h
@@ -0,0 +1,8 @@
+#ifndef __ASM_IRQ_H
+#define __ASM_IRQ_H
+
+#include <asm-generic/irq.h>
+
+extern void (*handle_arch_irq)(struct pt_regs *);
+
+#endif
diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irq=
flags.h
new file mode 100644
index 0000000..aa11943
--- /dev/null
+++ b/arch/arm64/include/asm/irqflags.h
@@ -0,0 +1,91 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
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
+#ifndef __ASM_IRQFLAGS_H
+#define __ASM_IRQFLAGS_H
+
+#ifdef __KERNEL__
+
+#include <asm/ptrace.h>
+
+/*
+ * CPU interrupt mask handling.
+ */
+static inline unsigned long arch_local_irq_save(void)
+{
+=09unsigned long flags;
+=09asm volatile(
+=09=09"mrs=09%0, daif=09=09// arch_local_irq_save\n"
+=09=09"msr=09daifset, #2"
+=09=09: "=3Dr" (flags)
+=09=09:
+=09=09: "memory");
+=09return flags;
+}
+
+static inline void arch_local_irq_enable(void)
+{
+=09asm volatile(
+=09=09"msr=09daifclr, #2=09=09// arch_local_irq_enable"
+=09=09:
+=09=09:
+=09=09: "memory");
+}
+
+static inline void arch_local_irq_disable(void)
+{
+=09asm volatile(
+=09=09"msr=09daifset, #2=09=09// arch_local_irq_disable"
+=09=09:
+=09=09:
+=09=09: "memory");
+}
+
+#define local_fiq_enable()=09asm("msr=09daifclr, #1" : : : "memory")
+#define local_fiq_disable()=09asm("msr=09daifset, #1" : : : "memory")
+
+/*
+ * Save the current interrupt enable state.
+ */
+static inline unsigned long arch_local_save_flags(void)
+{
+=09unsigned long flags;
+=09asm volatile(
+=09=09"mrs=09%0, daif=09=09// arch_local_save_flags"
+=09=09: "=3Dr" (flags)
+=09=09:
+=09=09: "memory");
+=09return flags;
+}
+
+/*
+ * restore saved IRQ state
+ */
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+=09asm volatile(
+=09=09"msr=09daif, %0=09=09// arch_local_irq_restore"
+=09:
+=09: "r" (flags)
+=09: "memory");
+}
+
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+=09return flags & PSR_I_BIT;
+}
+
+#endif
+#endif
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
new file mode 100644
index 0000000..d346241
--- /dev/null
+++ b/arch/arm64/kernel/irq.c
@@ -0,0 +1,84 @@
+/*
+ * Based on arch/arm/kernel/irq.c
+ *
+ * Copyright (C) 1992 Linus Torvalds
+ * Modifications for ARM processor Copyright (C) 1995-2000 Russell King.
+ * Support for Dynamic Tick Timer Copyright (C) 2004-2005 Nokia Corporatio=
n.
+ * Dynamic Tick Timer written by Tony Lindgren <tony@atomide.com> and
+ * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>.
+ * Copyright (C) 2012 ARM Ltd.
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
+#include <linux/kernel_stat.h>
+#include <linux/irq.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <linux/of_irq.h>
+#include <linux/seq_file.h>
+
+unsigned long irq_err_count;
+
+int arch_show_interrupts(struct seq_file *p, int prec)
+{
+#ifdef CONFIG_SMP
+=09show_ipi_list(p, prec);
+#endif
+=09seq_printf(p, "%*s: %10lu\n", prec, "Err", irq_err_count);
+=09return 0;
+}
+
+/*
+ * handle_IRQ handles all hardware IRQ's.  Decoded IRQs should
+ * not come via this function.  Instead, they should provide their
+ * own 'handler'.  Used by platform code implementing C-based 1st
+ * level decoding.
+ */
+void handle_IRQ(unsigned int irq, struct pt_regs *regs)
+{
+=09struct pt_regs *old_regs =3D set_irq_regs(regs);
+
+=09irq_enter();
+
+=09/*
+=09 * Some hardware gives randomly wrong interrupts.  Rather
+=09 * than crashing, do something sensible.
+=09 */
+=09if (unlikely(irq >=3D nr_irqs)) {
+=09=09if (printk_ratelimit())
+=09=09=09pr_warning("Bad IRQ%u\n", irq);
+=09=09ack_bad_irq(irq);
+=09} else {
+=09=09generic_handle_irq(irq);
+=09}
+
+=09irq_exit();
+=09set_irq_regs(old_regs);
+}
+
+/*
+ * Interrupt controllers supported by the kernel.
+ */
+static const struct of_device_id intctrl_of_match[] __initconst =3D {
+=09/* IRQ controllers { .compatible, .data } info to go here */
+=09{}
+};
+
+void __init init_IRQ(void)
+{
+=09of_irq_init(intctrl_of_match);
+
+=09if (!handle_arch_irq)
+=09=09panic("No interrupt controller found.");
+}

