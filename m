Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:8977 "EHLO
	mail1.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbbBUHyJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 21 Feb 2015 02:54:09 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v4 06/15] h8300: CPU depend helpers
Date: Sat, 21 Feb 2015 16:53:50 +0900
Message-ID: <1424505239-7082-7-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1424505239-7082-1-git-send-email-ysato@users.sourceforge.jp>
References: <1424505239-7082-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20150221075350.9YHUTFI0iHpwLTM2N6Uh2PKC8rgG8Q-1jyj5DX0icjc@z>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/kernel/cpu/Makefile         |   4 +
 arch/h8300/kernel/cpu/h83069/Makefile  |   1 +
 arch/h8300/kernel/cpu/h83069/setup.c   | 202 ++++++++++++++++++++++++++
 arch/h8300/kernel/cpu/h8s2678/Makefile |   1 +
 arch/h8300/kernel/cpu/h8s2678/setup.c  | 161 +++++++++++++++++++++
 arch/h8300/kernel/cpu/irq_h.c          |  62 ++++++++
 arch/h8300/kernel/cpu/irq_s.c          |  70 +++++++++
 arch/h8300/kernel/cpu/ptrace_h.c       | 256 +++++++++++++++++++++++++++++++++
 arch/h8300/kernel/cpu/ptrace_s.c       |  44 ++++++
 9 files changed, 801 insertions(+)
 create mode 100644 arch/h8300/kernel/cpu/Makefile
 create mode 100644 arch/h8300/kernel/cpu/h83069/Makefile
 create mode 100644 arch/h8300/kernel/cpu/h83069/setup.c
 create mode 100644 arch/h8300/kernel/cpu/h8s2678/Makefile
 create mode 100644 arch/h8300/kernel/cpu/h8s2678/setup.c
 create mode 100644 arch/h8300/kernel/cpu/irq_h.c
 create mode 100644 arch/h8300/kernel/cpu/irq_s.c
 create mode 100644 arch/h8300/kernel/cpu/ptrace_h.c
 create mode 100644 arch/h8300/kernel/cpu/ptrace_s.c

diff --git a/arch/h8300/kernel/cpu/Makefile b/arch/h8300/kernel/cpu/Makefile
new file mode 100644
index 0000000..684475c
--- /dev/null
+++ b/arch/h8300/kernel/cpu/Makefile
@@ -0,0 +1,4 @@
+obj-$(CONFIG_CPU_H8300H) += ptrace_h.o irq_h.o
+obj-$(CONFIG_CPU_H8S) += ptrace_s.o irq_s.o
+obj-$(CONFIG_H83069) += h83069/
+obj-$(CONFIG_H8S2678) += h8s2678/
diff --git a/arch/h8300/kernel/cpu/h83069/Makefile b/arch/h8300/kernel/cpu/h83069/Makefile
new file mode 100644
index 0000000..49d283e
--- /dev/null
+++ b/arch/h8300/kernel/cpu/h83069/Makefile
@@ -0,0 +1 @@
+obj-y = setup.o
diff --git a/arch/h8300/kernel/cpu/h83069/setup.c b/arch/h8300/kernel/cpu/h83069/setup.c
new file mode 100644
index 0000000..99c2716
--- /dev/null
+++ b/arch/h8300/kernel/cpu/h83069/setup.c
@@ -0,0 +1,202 @@
+/*
+ * H8/3069 Internal peripheral setup
+ *
+ *  Copyright (C) 2009,2014 Yoshinori Sato <ysato@users.sourceforge.jp>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/serial_sci.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <asm/timer.h>
+
+static struct resource sci0_resources[] = {
+	DEFINE_RES_MEM(0xffffb0, 8),
+	DEFINE_RES_IRQ(52),
+	DEFINE_RES_IRQ(53),
+	DEFINE_RES_IRQ(54),
+	DEFINE_RES_IRQ(55),
+};
+
+
+static struct plat_sci_port sci0_platform_data = {
+	.flags		= UPF_BOOT_AUTOCONF,
+	.scscr		= SCSCR_RE | SCSCR_TE,
+	.type		= PORT_SCI,
+};
+
+static struct resource sci1_resources[] = {
+	DEFINE_RES_MEM(0xffffb8, 8),
+	DEFINE_RES_IRQ(56),
+	DEFINE_RES_IRQ(57),
+	DEFINE_RES_IRQ(58),
+	DEFINE_RES_IRQ(59),
+};
+
+static struct plat_sci_port sci1_platform_data = {
+	.flags		= UPF_BOOT_AUTOCONF,
+	.scscr		= SCSCR_RE | SCSCR_TE,
+	.type		= PORT_SCI,
+};
+
+static struct platform_device sci0_device = {
+	.name		= "sh-sci",
+	.id		= 0,
+	.resource	= sci0_resources,
+	.num_resources	= ARRAY_SIZE(sci0_resources),
+	.dev		= {
+		.platform_data	= &sci0_platform_data,
+	},
+};
+
+static struct platform_device sci1_device = {
+	.name		= "sh-sci",
+	.id		= 1,
+	.resource	= sci1_resources,
+	.num_resources	= ARRAY_SIZE(sci1_resources),
+	.dev		= {
+		.platform_data	= &sci1_platform_data,
+	},
+};
+
+static struct h8300_timer8_config tm8_unit0_platform_data = {
+	.mode	= H8300_TMR8_CLKEVTDEV,
+	.div	= H8300_TMR8_DIV_8,
+};
+
+static struct resource tm8_unit0_resources[] = {
+	DEFINE_RES_MEM(0xffff80, 9),
+	DEFINE_RES_IRQ(36),
+	DEFINE_RES_IRQ(39),
+};
+
+static struct platform_device timer8_unit0_device = {
+	.name		= "h8300-8timer",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &tm8_unit0_platform_data,
+	},
+	.resource	= tm8_unit0_resources,
+	.num_resources	= ARRAY_SIZE(tm8_unit0_resources),
+};
+
+static struct h8300_timer8_config tm8_unit1_platform_data = {
+	.mode	= H8300_TMR8_CLKSRC,
+	.div	= H8300_TMR8_DIV_8,
+};
+
+static struct resource tm8_unit1_resources[] = {
+	DEFINE_RES_MEM(0xffff90, 9),
+	DEFINE_RES_IRQ(40),
+	DEFINE_RES_IRQ(43),
+};
+
+static struct platform_device timer8_unit1_device = {
+	.name		= "h8300-8timer",
+	.id		= 1,
+	.dev = {
+		.platform_data	= &tm8_unit1_platform_data,
+	},
+	.resource	= tm8_unit1_resources,
+	.num_resources	= ARRAY_SIZE(tm8_unit1_resources),
+};
+
+
+static struct h8300_timer16_config timer16data0 = {
+	.enb	= 0,
+	.imfa	= 0,
+	.imiea	= 4,
+};
+
+static struct h8300_timer16_config timer16data1 = {
+	.enb	= 1,
+	.imfa	= 1,
+	.imiea	= 5,
+};
+
+static struct h8300_timer16_config timer16data2 = {
+	.enb	= 2,
+	.imfa	= 2,
+	.imiea	= 6,
+};
+
+static struct resource tm16ch0_resources[] = {
+	DEFINE_RES_MEM(0xffff68, 8),
+	DEFINE_RES_MEM(0xffff60, 7),
+	DEFINE_RES_IRQ(24),
+};
+
+static struct resource tm16ch1_resources[] = {
+	DEFINE_RES_MEM(0xffff70, 8),
+	DEFINE_RES_MEM(0xffff60, 7),
+	DEFINE_RES_IRQ(28),
+};
+
+static struct resource tm16ch2_resources[] = {
+	DEFINE_RES_MEM(0xffff78, 8),
+	DEFINE_RES_MEM(0xffff60, 7),
+	DEFINE_RES_IRQ(32),
+};
+
+static struct platform_device timer16_ch0_device = {
+	.name	= "h8300h-16timer",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &timer16data0,
+	},
+	.resource	= tm16ch0_resources,
+	.num_resources	= ARRAY_SIZE(tm16ch0_resources),
+};
+
+static struct platform_device timer16_ch1_device = {
+	.name	= "h8300h-16timer",
+	.id		= 1,
+	.dev		= {
+		.platform_data	= &timer16data1,
+	},
+	.resource	= tm16ch1_resources,
+	.num_resources	= ARRAY_SIZE(tm16ch1_resources),
+};
+
+static struct platform_device timer16_ch2_device = {
+	.name	= "h8300h-16timer",
+	.id		= 2,
+	.dev		= {
+		.platform_data	= &timer16data2,
+	},
+	.resource	= tm16ch2_resources,
+	.num_resources	= ARRAY_SIZE(tm16ch2_resources),
+};
+
+static struct platform_device *devices[] __initdata = {
+	&timer8_unit1_device,
+	&timer16_ch0_device,
+	&timer16_ch1_device,
+	&timer16_ch2_device,
+	&sci0_device,
+	&sci1_device,
+};
+
+static struct platform_device *early_devices[] __initdata = {
+	&timer8_unit0_device,
+	&sci0_device,
+	&sci1_device,
+};
+
+static int __init devices_register(void)
+{
+	return platform_add_devices(devices,
+				    ARRAY_SIZE(devices));
+}
+
+arch_initcall(devices_register);
+
+void __init early_device_init(void)
+{
+	early_platform_add_devices(early_devices,
+				   ARRAY_SIZE(early_devices));
+}
diff --git a/arch/h8300/kernel/cpu/h8s2678/Makefile b/arch/h8300/kernel/cpu/h8s2678/Makefile
new file mode 100644
index 0000000..49d283e
--- /dev/null
+++ b/arch/h8300/kernel/cpu/h8s2678/Makefile
@@ -0,0 +1 @@
+obj-y = setup.o
diff --git a/arch/h8300/kernel/cpu/h8s2678/setup.c b/arch/h8300/kernel/cpu/h8s2678/setup.c
new file mode 100644
index 0000000..ea743ec
--- /dev/null
+++ b/arch/h8300/kernel/cpu/h8s2678/setup.c
@@ -0,0 +1,161 @@
+/*
+ * H8S2678 Internal peripheral setup
+ *
+ *  Copyright (C) 2014  Yoshinori Sato <ysato@users.sourceforge.jp>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/serial_sci.h>
+#include <asm/timer.h>
+
+static struct resource sci0_resources[] = {
+	DEFINE_RES_MEM(0xffff78, 8),
+	DEFINE_RES_IRQ(88),
+	DEFINE_RES_IRQ(89),
+	DEFINE_RES_IRQ(90),
+	DEFINE_RES_IRQ(91),
+};
+
+
+static struct plat_sci_port sci0_platform_data = {
+	.flags		= UPF_BOOT_AUTOCONF,
+	.scscr		= SCSCR_RE | SCSCR_TE,
+	.type		= PORT_SCI,
+};
+
+static struct resource sci1_resources[] = {
+	DEFINE_RES_MEM(0xffff80, 8),
+	DEFINE_RES_IRQ(92),
+	DEFINE_RES_IRQ(93),
+	DEFINE_RES_IRQ(94),
+	DEFINE_RES_IRQ(95),
+};
+
+static struct plat_sci_port sci1_platform_data = {
+	.flags		= UPF_BOOT_AUTOCONF,
+	.scscr		= SCSCR_RE | SCSCR_TE,
+	.type		= PORT_SCI,
+};
+
+static struct resource sci2_resources[] = {
+	DEFINE_RES_MEM(0xffff88, 8),
+	DEFINE_RES_IRQ(96),
+	DEFINE_RES_IRQ(97),
+	DEFINE_RES_IRQ(98),
+	DEFINE_RES_IRQ(99),
+};
+
+static struct plat_sci_port sci2_platform_data = {
+	.flags		= UPF_BOOT_AUTOCONF,
+	.scscr		= SCSCR_RE | SCSCR_TE,
+	.type		= PORT_SCI,
+};
+
+static struct platform_device sci0_device = {
+	.name		= "sh-sci",
+	.id		= 0,
+	.resource	= sci0_resources,
+	.num_resources	= ARRAY_SIZE(sci0_resources),
+	.dev		= {
+		.platform_data	= &sci0_platform_data,
+	},
+};
+
+static struct platform_device sci1_device = {
+	.name		= "sh-sci",
+	.id		= 1,
+	.resource	= sci1_resources,
+	.num_resources	= ARRAY_SIZE(sci1_resources),
+	.dev		= {
+		.platform_data	= &sci1_platform_data,
+	},
+};
+
+static struct platform_device sci2_device = {
+	.name		= "sh-sci",
+	.id		= 2,
+	.resource	= sci2_resources,
+	.num_resources	= ARRAY_SIZE(sci2_resources),
+	.dev		= {
+		.platform_data	= &sci2_platform_data,
+	},
+};
+
+static struct h8300_timer8_config timer8_platform_data = {
+	.mode	= H8300_TMR8_CLKEVTDEV,
+	.div	= H8300_TMR8_DIV_8,
+};
+
+static struct resource tm8_unit0_resources[] = {
+	DEFINE_RES_MEM(0xffffb0, 10),
+	DEFINE_RES_IRQ(72),
+	DEFINE_RES_IRQ(75),
+};
+
+static struct platform_device tm8_unit0_device = {
+	.name		= "h8300-8timer",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &timer8_platform_data,
+	},
+	.resource	= tm8_unit0_resources,
+	.num_resources	= ARRAY_SIZE(tm8_unit0_resources),
+};
+
+static struct resource tpu12_resources[] = {
+	DEFINE_RES_MEM(0xffffe0, 16),
+	DEFINE_RES_MEM(0xfffff0, 12),
+};
+
+static struct resource tpu45_resources[] = {
+	DEFINE_RES_MEM(0xfffe90, 16),
+	DEFINE_RES_MEM(0xfffea0, 12),
+};
+
+static struct platform_device tpu12_device = {
+	.name	= "h8s-tpu",
+	.id		= 0,
+	.resource	= tpu12_resources,
+	.num_resources	= ARRAY_SIZE(tpu12_resources),
+};
+
+static struct platform_device tpu45_device = {
+	.name	= "h8s-tpu",
+	.id		= 1,
+	.resource	= tpu45_resources,
+	.num_resources	= ARRAY_SIZE(tpu45_resources),
+};
+
+static struct platform_device *devices[] __initdata = {
+	&tpu12_device,
+	&tpu45_device,
+	&sci0_device,
+	&sci1_device,
+	&sci2_device,
+};
+
+static struct platform_device *early_devices[] __initdata = {
+	&tm8_unit0_device,
+	&sci0_device,
+	&sci1_device,
+	&sci2_device,
+};
+
+static int __init devices_register(void)
+{
+	return platform_add_devices(devices,
+				    ARRAY_SIZE(devices));
+}
+arch_initcall(devices_register);
+
+void __init early_device_init(void)
+{
+	/* SCI / Timer enable */
+	ctrl_outw(0x07f0, 0xffff40);
+	early_platform_add_devices(early_devices,
+				   ARRAY_SIZE(early_devices));
+}
diff --git a/arch/h8300/kernel/cpu/irq_h.c b/arch/h8300/kernel/cpu/irq_h.c
new file mode 100644
index 0000000..90021d8
--- /dev/null
+++ b/arch/h8300/kernel/cpu/irq_h.c
@@ -0,0 +1,62 @@
+/*
+ * linux/arch/h8300/kernel/irq_h.c
+ *
+ * Copyright 2014 Yoshinori Sato <ysato@users.sourceforge.jp>
+ */
+
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <asm/io.h>
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
+#define IPR 0xffee18
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
+void __init h8300_init_ipr(void)
+{
+	/* All interrupt priority high */
+	ctrl_outb(0xff, IPR + 0);
+	ctrl_outb(0xee, IPR + 1);
+}
diff --git a/arch/h8300/kernel/cpu/irq_s.c b/arch/h8300/kernel/cpu/irq_s.c
new file mode 100644
index 0000000..71c322e
--- /dev/null
+++ b/arch/h8300/kernel/cpu/irq_s.c
@@ -0,0 +1,70 @@
+/*
+ * linux/arch/h8300/kernel/irq_s.c
+ *
+ * Copyright 2014 Yoshinori Sato <ysato@users.sourceforge.jp>
+ */
+
+#include <linux/irq.h>
+#include <asm/io.h>
+#define IPRA 0xfffe00
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
+void __init h8300_init_ipr(void)
+{
+	int n;
+	/* All interrupt priority is 1 */
+	/* IPRA to IPRK */
+	for (n = 0; n <= 'k' - 'a'; n++)
+		ctrl_outw(0x1111, IPRA + (n * 2));
+}
diff --git a/arch/h8300/kernel/cpu/ptrace_h.c b/arch/h8300/kernel/cpu/ptrace_h.c
new file mode 100644
index 0000000..fe3b567
--- /dev/null
+++ b/arch/h8300/kernel/cpu/ptrace_h.c
@@ -0,0 +1,256 @@
+/*
+ *    ptrace cpu depend helper functions
+ *
+ *  Copyright 2003, 2015 Yoshinori Sato <ysato@users.sourceforge.jp>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of
+ * this archive for more details.
+ */
+
+#include <linux/linkage.h>
+#include <linux/sched.h>
+#include <asm/ptrace.h>
+
+#define BREAKINST 0x5730 /* trapa #3 */
+
+/* disable singlestep */
+void user_disable_single_step(struct task_struct *child)
+{
+	if ((long)child->thread.breakinfo.addr != -1L) {
+		*(child->thread.breakinfo.addr) = child->thread.breakinfo.inst;
+		child->thread.breakinfo.addr = (unsigned short *)-1L;
+	}
+}
+
+/* calculate next pc */
+enum jump_type {none,	 /* normal instruction */
+		jabs,	 /* absolute address jump */
+		ind,	 /* indirect address jump */
+		ret,	 /* return to subrutine */
+		reg,	 /* register indexed jump */
+		relb,	 /* pc relative jump (byte offset) */
+		relw,	 /* pc relative jump (word offset) */
+	       };
+
+/* opcode decode table define
+   ptn: opcode pattern
+   msk: opcode bitmask
+   len: instruction length (<0 next table index)
+   jmp: jump operation mode */
+struct optable {
+	unsigned char bitpattern;
+	unsigned char bitmask;
+	signed char length;
+	signed char type;
+} __packed __aligned(1);
+
+#define OPTABLE(ptn, msk, len, jmp)	\
+	{				\
+		.bitpattern = ptn,	\
+		.bitmask    = msk,	\
+		.length	    = len,	\
+		.type	    = jmp,	\
+	}
+
+static const struct optable optable_0[] = {
+	OPTABLE(0x00, 0xff,  1, none), /* 0x00 */
+	OPTABLE(0x01, 0xff, -1, none), /* 0x01 */
+	OPTABLE(0x02, 0xfe,  1, none), /* 0x02-0x03 */
+	OPTABLE(0x04, 0xee,  1, none), /* 0x04-0x05/0x14-0x15 */
+	OPTABLE(0x06, 0xfe,  1, none), /* 0x06-0x07 */
+	OPTABLE(0x08, 0xea,  1, none), /* 0x08-0x09/0x0c-0x0d/0x18-0x19/0x1c-0x1d */
+	OPTABLE(0x0a, 0xee,  1, none), /* 0x0a-0x0b/0x1a-0x1b */
+	OPTABLE(0x0e, 0xee,  1, none), /* 0x0e-0x0f/0x1e-0x1f */
+	OPTABLE(0x10, 0xfc,  1, none), /* 0x10-0x13 */
+	OPTABLE(0x16, 0xfe,  1, none), /* 0x16-0x17 */
+	OPTABLE(0x20, 0xe0,  1, none), /* 0x20-0x3f */
+	OPTABLE(0x40, 0xf0,  1, relb), /* 0x40-0x4f */
+	OPTABLE(0x50, 0xfc,  1, none), /* 0x50-0x53 */
+	OPTABLE(0x54, 0xfd,  1, ret), /* 0x54/0x56 */
+	OPTABLE(0x55, 0xff,  1, relb), /* 0x55 */
+	OPTABLE(0x57, 0xff,  1, none), /* 0x57 */
+	OPTABLE(0x58, 0xfb,  2, relw), /* 0x58/0x5c */
+	OPTABLE(0x59, 0xfb,  1, reg), /* 0x59/0x5b */
+	OPTABLE(0x5a, 0xfb,  2, jabs), /* 0x5a/0x5e */
+	OPTABLE(0x5b, 0xfb,  2, ind), /* 0x5b/0x5f */
+	OPTABLE(0x60, 0xe8,  1, none), /* 0x60-0x67/0x70-0x77 */
+	OPTABLE(0x68, 0xfa,  1, none), /* 0x68-0x69/0x6c-0x6d */
+	OPTABLE(0x6a, 0xfe, -2, none), /* 0x6a-0x6b */
+	OPTABLE(0x6e, 0xfe,  2, none), /* 0x6e-0x6f */
+	OPTABLE(0x78, 0xff,  4, none), /* 0x78 */
+	OPTABLE(0x79, 0xff,  2, none), /* 0x79 */
+	OPTABLE(0x7a, 0xff,  3, none), /* 0x7a */
+	OPTABLE(0x7b, 0xff,  2, none), /* 0x7b */
+	OPTABLE(0x7c, 0xfc,  2, none), /* 0x7c-0x7f */
+	OPTABLE(0x80, 0x80,  1, none), /* 0x80-0xff */
+};
+
+static const struct optable optable_1[] = {
+	OPTABLE(0x00, 0xff, -3, none), /* 0x0100 */
+	OPTABLE(0x40, 0xf0, -3, none), /* 0x0140-0x14f */
+	OPTABLE(0x80, 0xf0,  1, none), /* 0x0180-0x018f */
+	OPTABLE(0xc0, 0xc0,  2, none), /* 0x01c0-0x01ff */
+};
+
+static const struct optable optable_2[] = {
+	OPTABLE(0x00, 0x20,  2, none), /* 0x6a0?/0x6a8?/0x6b0?/0x6b8? */
+	OPTABLE(0x20, 0x20,  3, none), /* 0x6a2?/0x6aa?/0x6b2?/0x6ba? */
+};
+
+static const struct optable optable_3[] = {
+	OPTABLE(0x69, 0xfb,  2, none), /* 0x010069/0x01006d/014069/0x01406d */
+	OPTABLE(0x6b, 0xff, -4, none), /* 0x01006b/0x01406b */
+	OPTABLE(0x6f, 0xff,  3, none), /* 0x01006f/0x01406f */
+	OPTABLE(0x78, 0xff,  5, none), /* 0x010078/0x014078 */
+};
+
+static const struct optable optable_4[] = {
+/* 0x0100690?/0x01006d0?/0140690?/0x01406d0?/
+   0x0100698?/0x01006d8?/0140698?/0x01406d8? */
+	OPTABLE(0x00, 0x78, 3, none),
+/* 0x0100692?/0x01006d2?/0140692?/0x01406d2?/
+   0x010069a?/0x01006da?/014069a?/0x01406da? */
+	OPTABLE(0x20, 0x78, 4, none),
+};
+
+static const struct optables_list {
+	const struct optable *ptr;
+	int size;
+} optables[] = {
+#define OPTABLES(no)                                                   \
+	{                                                              \
+		.ptr  = optable_##no,                                  \
+		.size = sizeof(optable_##no) / sizeof(struct optable), \
+	}
+	OPTABLES(0),
+	OPTABLES(1),
+	OPTABLES(2),
+	OPTABLES(3),
+	OPTABLES(4),
+
+};
+
+const unsigned char condmask[] = {
+	0x00, 0x40, 0x01, 0x04, 0x02, 0x08, 0x10, 0x20
+};
+
+static int isbranch(struct task_struct *task, int reson)
+{
+	unsigned char cond = h8300_get_reg(task, PT_CCR);
+
+	/* encode complex conditions */
+	/* B4: N^V
+	   B5: Z|(N^V)
+	   B6: C|Z */
+	__asm__("bld #3,%w0\n\t"
+		"bxor #1,%w0\n\t"
+		"bst #4,%w0\n\t"
+		"bor #2,%w0\n\t"
+		"bst #5,%w0\n\t"
+		"bld #2,%w0\n\t"
+		"bor #0,%w0\n\t"
+		"bst #6,%w0\n\t"
+		: "=&r"(cond) : "0"(cond) : "cc");
+	cond &= condmask[reson >> 1];
+	if (!(reson & 1))
+		return cond == 0;
+	else
+		return cond != 0;
+}
+
+static unsigned short *decode(struct task_struct *child,
+			      const struct optable *op,
+			      char *fetch_p, unsigned short *pc,
+			      unsigned char inst)
+{
+	unsigned long addr;
+	unsigned long *sp;
+	int regno;
+
+	switch (op->type) {
+	case none:
+		return (unsigned short *)pc + op->length;
+	case jabs:
+		addr = *(unsigned long *)pc;
+		return (unsigned short *)(addr & 0x00ffffff);
+	case ind:
+		addr = *pc & 0xff;
+		return (unsigned short *)(*(unsigned long *)addr);
+	case ret:
+		sp = (unsigned long *)h8300_get_reg(child, PT_USP);
+		/* user stack frames
+		   |   er0  | temporary saved
+		   +--------+
+		   |   exp  | exception stack frames
+		   +--------+
+		   | ret pc | userspace return address
+		*/
+		return (unsigned short *)(*(sp+2) & 0x00ffffff);
+	case reg:
+		regno = (*pc >> 4) & 0x07;
+		if (regno == 0)
+			addr = h8300_get_reg(child, PT_ER0);
+		else
+			addr = h8300_get_reg(child, regno-1 + PT_ER1);
+		return (unsigned short *)addr;
+	case relb:
+		if (inst == 0x55 || isbranch(child, inst & 0x0f))
+			pc = (unsigned short *)((unsigned long)pc +
+						((signed char)(*fetch_p)));
+		return pc+1; /* skip myself */
+	case relw:
+		if (inst == 0x5c || isbranch(child, (*fetch_p & 0xf0) >> 4))
+			pc = (unsigned short *)((unsigned long)pc +
+						((signed short)(*(pc+1))));
+		return pc+2; /* skip myself */
+	default:
+		return NULL;
+	}
+}
+
+static unsigned short *nextpc(struct task_struct *child, unsigned short *pc)
+{
+	const struct optable *op;
+	unsigned char *fetch_p;
+	int op_len;
+	unsigned char inst;
+
+	op = optables[0].ptr;
+	op_len = optables[0].size;
+	fetch_p = (unsigned char *)pc;
+	inst = *fetch_p++;
+	do {
+		if ((inst & op->bitmask) == op->bitpattern) {
+			if (op->length < 0) {
+				op = optables[-op->length].ptr;
+				op_len = optables[-op->length].size + 1;
+				inst = *fetch_p++;
+			} else
+				return decode(child, op, fetch_p, pc, inst);
+		} else
+			op++;
+	} while (--op_len > 0);
+	return NULL;
+}
+
+/* Set breakpoint(s) to simulate a single step from the current PC.  */
+
+void user_enable_single_step(struct task_struct *child)
+{
+	unsigned short *next;
+
+	next = nextpc(child, (unsigned short *)h8300_get_reg(child, PT_PC));
+	child->thread.breakinfo.addr = next;
+	child->thread.breakinfo.inst = *next;
+	*next = BREAKINST;
+}
+
+asmlinkage void trace_trap(unsigned long bp)
+{
+	if ((unsigned long)current->thread.breakinfo.addr == bp) {
+		user_disable_single_step(current);
+		force_sig(SIGTRAP, current);
+	} else
+		force_sig(SIGILL, current);
+}
diff --git a/arch/h8300/kernel/cpu/ptrace_s.c b/arch/h8300/kernel/cpu/ptrace_s.c
new file mode 100644
index 0000000..ef5a9c1
--- /dev/null
+++ b/arch/h8300/kernel/cpu/ptrace_s.c
@@ -0,0 +1,44 @@
+/*
+ *  linux/arch/h8300/kernel/ptrace_h8s.c
+ *    ptrace cpu depend helper functions
+ *
+ *  Yoshinori Sato <ysato@users.sourceforge.jp>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of
+ * this archive for more details.
+ */
+
+#include <linux/linkage.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <asm/ptrace.h>
+
+#define CCR_MASK  0x6f
+#define EXR_TRACE 0x80
+
+/* disable singlestep */
+void user_disable_single_step(struct task_struct *child)
+{
+	unsigned char exr;
+
+	exr = h8300_get_reg(child, PT_EXR);
+	exr &= ~EXR_TRACE;
+	h8300_put_reg(child, PT_EXR, exr);
+}
+
+/* enable singlestep */
+void user_enable_single_step(struct task_struct *child)
+{
+	unsigned char exr;
+
+	exr = h8300_get_reg(child, PT_EXR);
+	exr |= EXR_TRACE;
+	h8300_put_reg(child, PT_EXR, exr);
+}
+
+asmlinkage void trace_trap(unsigned long bp)
+{
+	(void)bp;
+	force_sig(SIGTRAP, current);
+}
-- 
2.1.4

