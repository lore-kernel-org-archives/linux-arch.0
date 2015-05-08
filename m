From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v11 11/19] h8300: CPU depend helpers
Date: Sat,  9 May 2015 00:04:31 +0900
Message-ID: <1431097479-21101-12-git-send-email-ysato@users.sourceforge.jp>
References: <1431097479-21101-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:14393 "EHLO
	mail2.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbbEHPEy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 May 2015 11:04:54 -0400
In-Reply-To: <1431097479-21101-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/kernel/cpu/Makefile   |   2 +
 arch/h8300/kernel/cpu/irq_h.c    |  62 ++++++++++
 arch/h8300/kernel/cpu/irq_s.c    |  70 +++++++++++
 arch/h8300/kernel/cpu/ptrace_h.c | 256 +++++++++++++++++++++++++++++++++++++++
 arch/h8300/kernel/cpu/ptrace_s.c |  44 +++++++
 5 files changed, 434 insertions(+)
 create mode 100644 arch/h8300/kernel/cpu/Makefile
 create mode 100644 arch/h8300/kernel/cpu/irq_h.c
 create mode 100644 arch/h8300/kernel/cpu/irq_s.c
 create mode 100644 arch/h8300/kernel/cpu/ptrace_h.c
 create mode 100644 arch/h8300/kernel/cpu/ptrace_s.c

diff --git a/arch/h8300/kernel/cpu/Makefile b/arch/h8300/kernel/cpu/Makefile
new file mode 100644
index 0000000..1318128
--- /dev/null
+++ b/arch/h8300/kernel/cpu/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_CPU_H8300H) += ptrace_h.o irq_h.o
+obj-$(CONFIG_CPU_H8S) += ptrace_s.o irq_s.o
diff --git a/arch/h8300/kernel/cpu/irq_h.c b/arch/h8300/kernel/cpu/irq_h.c
new file mode 100644
index 0000000..f95ae42
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
+struct irq_chip h8300_irq_chip = {
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
index 0000000..2c811fe
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
+struct irq_chip h8300_irq_chip = {
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
