From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH RESEND] h8300: KGDB support
Date: Fri, 11 Dec 2015 12:16:00 +0900
Message-ID: <1449803760-21534-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:53964 "EHLO
	mail2.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbbLKDQK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Dec 2015 22:16:10 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Add KGDB helper for h8300.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/Kconfig            |   1 +
 arch/h8300/include/asm/kgdb.h |  45 ++++++++++++++
 arch/h8300/kernel/Makefile    |   2 +
 arch/h8300/kernel/entry.S     |  18 ++++++
 arch/h8300/kernel/kgdb.c      | 135 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 201 insertions(+)
 create mode 100644 arch/h8300/include/asm/kgdb.h
 create mode 100644 arch/h8300/kernel/kgdb.c

diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index dd3ac75..726d255 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -17,6 +17,7 @@ config H8300
 	select HAVE_MEMBLOCK
 	select HAVE_DMA_ATTRS
 	select CLKSRC_OF
+	select HAVE_ARCH_KGDB
 
 config RWSEM_GENERIC_SPINLOCK
 	def_bool y
diff --git a/arch/h8300/include/asm/kgdb.h b/arch/h8300/include/asm/kgdb.h
new file mode 100644
index 0000000..726ff8f
--- /dev/null
+++ b/arch/h8300/include/asm/kgdb.h
@@ -0,0 +1,45 @@
+/*
+ * Copyright (C) 2015 Yoshinori Sato <ysato@users.sourceforge.jp>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_H8300_KGDB_H
+#define _ASM_H8300_KGDB_H
+
+#define CACHE_FLUSH_IS_SAFE	1
+#define BUFMAX			2048
+
+enum regnames {
+	GDB_ER0, GDB_ER1, GDB_ER2, GDB_ER3,
+	GDB_ER4, GDB_ER5, GDB_ER6, GDB_SP,
+	GDB_CCR, GDB_PC,
+	GDB_CYCLLE,
+#if defined(CONFIG_CPU_H8S)
+	GDB_EXR,
+#endif
+	GDB_TICK, GDB_INST,
+#if defined(CONFIG_CPU_H8S)
+	GDB_MACH, GDB_MACL,
+#endif
+	/* do not change the last entry or anything below! */
+	GDB_NUMREGBYTES,		/* number of registers */
+};
+
+#define GDB_SIZEOF_REG		sizeof(u32)
+#if defined(CONFIG_CPU_H8300H)
+#define DBG_MAX_REG_NUM		(13)
+#elif defined(CONFIG_CPU_H8S)
+#define DBG_MAX_REG_NUM		(14)
+#endif
+#define NUMREGBYTES		(DBG_MAX_REG_NUM * GDB_SIZEOF_REG)
+
+#define BREAK_INSTR_SIZE	2
+static inline void arch_kgdb_breakpoint(void)
+{
+	__asm__ __volatile__("trapa #2");
+}
+
+#endif /* _ASM_H8300_KGDB_H */
diff --git a/arch/h8300/kernel/Makefile b/arch/h8300/kernel/Makefile
index 5bc33f2..253f8e3 100644
--- a/arch/h8300/kernel/Makefile
+++ b/arch/h8300/kernel/Makefile
@@ -17,3 +17,5 @@ obj-$(CONFIG_H8S_SIM) += sim-console.o
 
 obj-$(CONFIG_CPU_H8300H) += ptrace_h.o
 obj-$(CONFIG_CPU_H8S) += ptrace_s.o
+
+obj-$(CONFIG_KGDB) += kgdb.o
diff --git a/arch/h8300/kernel/entry.S b/arch/h8300/kernel/entry.S
index 797dfa8..2f045b67 100644
--- a/arch/h8300/kernel/entry.S
+++ b/arch/h8300/kernel/entry.S
@@ -188,7 +188,11 @@ _interrupt_redirect_table:
 	jsr	@_interrupt_entry		/* NMI */
 	jmp	@_system_call			/* TRAPA #0 (System call) */
 	.long	0
+#if defined(CONFIG_KGDB)
+	jmp	@_kgdb_trap
+#else
 	.long	0
+#endif
 	jmp	@_trace_break			/* TRAPA #3 (breakpoint) */
 	.rept	INTERRUPTS-12
 	jsr	@_interrupt_entry
@@ -405,6 +409,20 @@ _nmi:
 	mov.l	@sp+, er0
 	jmp	@_interrupt_entry
 
+#if defined(CONFIG_KGDB)
+_kgdb_trap:
+	subs	#4,sp
+	SAVE_ALL
+	mov.l	sp,er0
+	add.l	#LRET,er0
+	mov.l	er0,@(LSP,sp)
+	jsr	@set_esp0
+	mov.l	sp,er0
+	subs	#4,er0
+	jsr	@h8300_kgdb_trap
+	jmp	@ret_from_exception
+#endif
+
 	.section	.bss
 _sw_ksp:
 	.space	4
diff --git a/arch/h8300/kernel/kgdb.c b/arch/h8300/kernel/kgdb.c
new file mode 100644
index 0000000..602e478
--- /dev/null
+++ b/arch/h8300/kernel/kgdb.c
@@ -0,0 +1,135 @@
+/*
+ * H8/300 KGDB support
+ *
+ * Copyright (C) 2015 Yoshinori Sato <ysato@users.sourceforge.jp>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/ptrace.h>
+#include <linux/kgdb.h>
+#include <linux/kdebug.h>
+#include <linux/io.h>
+
+struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
+	{ "er0", GDB_SIZEOF_REG, offsetof(struct pt_regs, er0) },
+	{ "er1", GDB_SIZEOF_REG, offsetof(struct pt_regs, er1) },
+	{ "er2", GDB_SIZEOF_REG, offsetof(struct pt_regs, er2) },
+	{ "er3", GDB_SIZEOF_REG, offsetof(struct pt_regs, er3) },
+	{ "er4", GDB_SIZEOF_REG, offsetof(struct pt_regs, er4) },
+	{ "er5", GDB_SIZEOF_REG, offsetof(struct pt_regs, er5) },
+	{ "er6", GDB_SIZEOF_REG, offsetof(struct pt_regs, er6) },
+	{ "sp", GDB_SIZEOF_REG, offsetof(struct pt_regs, sp) },
+	{ "ccr", GDB_SIZEOF_REG, offsetof(struct pt_regs, ccr) },
+	{ "pc", GDB_SIZEOF_REG, offsetof(struct pt_regs, pc) },
+	{ "cycles", GDB_SIZEOF_REG, -1 },
+#if defined(CONFIG_CPU_H8S)
+	{ "exr", GDB_SIZEOF_REG, offsetof(struct pt_regs, exr) },
+#endif
+	{ "tick", GDB_SIZEOF_REG, -1 },
+	{ "inst", GDB_SIZEOF_REG, -1 },
+};
+
+char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
+{
+	if (regno >= DBG_MAX_REG_NUM || regno < 0)
+		return NULL;
+
+	switch (regno) {
+	case GDB_CCR:
+#if defined(CONFIG_CPU_H8S)
+	case GDB_EXR:
+#endif
+		*(u32 *)mem = *(u16 *)((void *)regs +
+				       dbg_reg_def[regno].offset);
+		break;
+	default:
+		if (dbg_reg_def[regno].offset >= 0)
+			memcpy(mem, (void *)regs + dbg_reg_def[regno].offset,
+			       dbg_reg_def[regno].size);
+		else
+			memset(mem, 0, dbg_reg_def[regno].size);
+		break;
+	}
+	return dbg_reg_def[regno].name;
+}
+
+int dbg_set_reg(int regno, void *mem, struct pt_regs *regs)
+{
+	if (regno >= DBG_MAX_REG_NUM || regno < 0)
+		return -EINVAL;
+
+	switch (regno) {
+	case GDB_CCR:
+#if defined(CONFIG_CPU_H8S)
+	case GDB_EXR:
+#endif
+		*(u16 *)((void *)regs +
+			 dbg_reg_def[regno].offset) = *(u32 *)mem;
+		break;
+	default:
+		memcpy((void *)regs + dbg_reg_def[regno].offset, mem,
+		       dbg_reg_def[regno].size);
+	}
+	return 0;
+}
+
+asmlinkage void h8300_kgdb_trap(struct pt_regs *regs)
+{
+	regs->pc &= 0x00ffffff;
+	if (kgdb_handle_exception(10, SIGTRAP, 0, regs))
+		return;
+	if (*(u16 *)(regs->pc) == *(u16 *)&arch_kgdb_ops.gdb_bpt_instr)
+		regs->pc += BREAK_INSTR_SIZE;
+	regs->pc |= regs->ccr << 24;
+}
+
+void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
+{
+	memset((char *)gdb_regs, 0, NUMREGBYTES);
+	gdb_regs[GDB_SP] = p->thread.ksp;
+	gdb_regs[GDB_PC] = KSTK_EIP(p);
+}
+
+void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
+{
+	regs->pc = pc;
+}
+
+int kgdb_arch_handle_exception(int vector, int signo, int err_code,
+				char *remcom_in_buffer, char *remcom_out_buffer,
+				struct pt_regs *regs)
+{
+	char *ptr;
+	unsigned long addr;
+
+	switch (remcom_in_buffer[0]) {
+	case 's':
+	case 'c':
+		/* handle the optional parameters */
+		ptr = &remcom_in_buffer[1];
+		if (kgdb_hex2long(&ptr, &addr))
+			regs->pc = addr;
+
+		return 0;
+	}
+
+	return -1; /* this means that we do not want to exit from the handler */
+}
+
+int kgdb_arch_init(void)
+{
+	return 0;
+}
+
+void kgdb_arch_exit(void)
+{
+	/* Nothing to do */
+}
+
+const struct kgdb_arch arch_kgdb_ops = {
+	/* Breakpoint instruction: trapa #2 */
+	.gdb_bpt_instr = { 0x57, 0x20 },
+};
-- 
2.6.1
