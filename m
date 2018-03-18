From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 02/19] csky: Exception handling and syscall
Date: Mon, 19 Mar 2018 03:51:24 +0800
Message-ID: <fe603a94a7755528ff6f5ac288a017e2a20071c4.1521399976.git.ren_guo@c-sky.com>
References: <cover.1521399976.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
 arch/csky/abiv1/inc/abi/entry.h     | 171 ++++++++++++
 arch/csky/abiv1/src/alignment.c     | 513 ++++++++++++++++++++++++++++++++++++
 arch/csky/abiv2/inc/abi/entry.h     | 154 +++++++++++
 arch/csky/include/asm/syscalls.h    |  14 +
 arch/csky/include/asm/traps.h       |  39 +++
 arch/csky/include/asm/unistd.h      |   4 +
 arch/csky/include/uapi/asm/unistd.h | 100 +++++++
 arch/csky/kernel/cpu-probe.c        |  63 +++++
 arch/csky/kernel/entry.S            | 408 ++++++++++++++++++++++++++++
 arch/csky/kernel/syscall.c          |  65 +++++
 arch/csky/kernel/syscall_table.c    |  12 +
 arch/csky/kernel/traps.c            | 152 +++++++++++
 arch/csky/mm/fault.c                | 246 +++++++++++++++++
 13 files changed, 1941 insertions(+)
 create mode 100644 arch/csky/abiv1/inc/abi/entry.h
 create mode 100644 arch/csky/abiv1/src/alignment.c
 create mode 100644 arch/csky/abiv2/inc/abi/entry.h
 create mode 100644 arch/csky/include/asm/syscalls.h
 create mode 100644 arch/csky/include/asm/traps.h
 create mode 100644 arch/csky/include/asm/unistd.h
 create mode 100644 arch/csky/include/uapi/asm/unistd.h
 create mode 100644 arch/csky/kernel/cpu-probe.c
 create mode 100644 arch/csky/kernel/entry.S
 create mode 100644 arch/csky/kernel/syscall.c
 create mode 100644 arch/csky/kernel/syscall_table.c
 create mode 100644 arch/csky/kernel/traps.c
 create mode 100644 arch/csky/mm/fault.c

diff --git a/arch/csky/abiv1/inc/abi/entry.h b/arch/csky/abiv1/inc/abi/entry.h
new file mode 100644
index 0000000..bff3ff2
--- /dev/null
+++ b/arch/csky/abiv1/inc/abi/entry.h
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_ENTRY_H
+#define __ASM_CSKY_ENTRY_H
+
+#include <asm/setup.h>
+#include <abi/regdef.h>
+
+/*
+ * Stack layout for exception (sp=r0):
+ *
+ *	 0(sp) - pc
+ *	 4(sp) - orig_a0
+ *	 8(sp) - sr
+ *	 C(sp) - a0/r2
+ *	10(sp) - a1/r3
+ *	14(sp) - a2/r4
+ *	18(sp) - a3/r5
+ *	1C(sp) - r6
+ *	20(sp) - r7
+ *	24(sp) - r8
+ *	28(sp) - r9
+ *	2C(sp) - r10
+ *	30(sp) - r11
+ *	34(sp) - r12
+ *	38(sp) - r13
+ *	3C(sp) - r14
+ *	40(sp) - r1
+ *	44(sp) - r15
+ */
+
+#define LSAVE_A0	0xc
+#define LSAVE_A1	0x10
+#define LSAVE_A2	0x14
+#define LSAVE_A3	0x18
+#define LSAVE_A4	0x1C
+#define LSAVE_A5	0x20
+
+.macro USPTOKSP
+	mtcr	sp, ss1
+	mfcr	sp, ss0
+.endm
+
+.macro KSPTOUSP
+	mtcr	sp, ss0
+	mfcr	sp, ss1
+.endm
+
+.macro GET_USP rx
+	mfcr	\rx, ss1
+.endm
+
+.macro SET_USP rx
+	mtcr	\rx, ss1
+.endm
+
+.macro INCTRAP	rx
+	addi	\rx, 2
+.endm
+
+/*
+ * SAVE_ALL: save the pt_regs to the stack.
+ */
+.macro	SAVE_ALL
+	mtcr    r13, ss2
+	mfcr    r13, epsr
+	btsti   r13, 31
+	bt      1f
+	USPTOKSP
+1:
+	subi    sp, 32
+	subi    sp, 32
+	stw     r13,	(sp, 0)
+	mfcr    r13,	ss2
+	stw     a0,	(sp, 4)
+	stw     a1,	(sp, 8)
+	stw     a2,	(sp, 12)
+	stw     a3,	(sp, 16)
+	stw     r6,	(sp, 20)
+	stw     r7,	(sp, 24)
+	stw     r8,	(sp, 28)
+	stw     r9,	(sp, 32)
+	stw     r10,	(sp, 36)
+	stw     r11,	(sp, 40)
+	stw     r12,	(sp, 44)
+	stw     r13,	(sp, 48)
+	stw     r14,	(sp, 52)
+	stw     r1,	(sp, 56)
+	stw     r15,	(sp, 60)
+
+	subi    sp,	8
+	stw     a0,	(sp, 4)
+	mfcr    r13,	epc
+	stw     r13,	(sp)
+.endm
+
+.macro SAVE_ALL_TRAP
+	SAVE_ALL
+	INCTRAP r13
+	stw     r13,	(sp)
+.endm
+
+.macro	RESTORE_ALL
+	psrclr  ie
+	ldw     a0, (sp)
+	mtcr    a0, epc
+	ldw     a0, (sp, 8)
+	mtcr    a0, epsr
+	btsti   a0, 31
+
+	addi    sp, 12
+	ldw     a0, (sp, 0)
+	ldw     a1, (sp, 4)
+	ldw     a2, (sp, 8)
+	ldw     a3, (sp, 12)
+	ldw     r6, (sp, 16)
+	ldw     r7, (sp, 20)
+	ldw     r8, (sp, 24)
+	ldw     r9, (sp, 28)
+	ldw     r10, (sp, 32)
+	ldw     r11, (sp, 36)
+	ldw     r12, (sp, 40)
+	ldw     r13, (sp, 44)
+	ldw     r14, (sp, 48)
+	ldw     r1, (sp, 52)
+	ldw     r15, (sp, 56)
+	addi    sp, 32
+	addi    sp, 28
+
+	bt      1f
+	KSPTOUSP
+1:
+	rte
+.endm
+
+.macro SAVE_SWITCH_STACK
+	subi    sp, 32
+	stm     r8-r15,(sp)
+.endm
+
+.macro RESTORE_SWITCH_STACK
+        ldm     r8-r15,(sp)
+        addi    sp, 32
+.endm
+
+/* MMU registers operators. */
+.macro RD_MIR	rx
+	cprcr   \rx, cpcr0
+.endm
+
+.macro RD_MEH	rx
+	cprcr   \rx, cpcr4
+.endm
+
+.macro RD_MCIR	rx
+	cprcr   \rx, cpcr8
+.endm
+
+.macro RD_PGDR  rx
+        cprcr   \rx, cpcr29
+.endm
+
+.macro WR_MEH	rx
+	cpwcr   \rx, cpcr4
+.endm
+
+.macro WR_MCIR	rx
+	cpwcr   \rx, cpcr8
+.endm
+
+#endif /* __ASM_CSKY_ENTRY_H */
diff --git a/arch/csky/abiv1/src/alignment.c b/arch/csky/abiv1/src/alignment.c
new file mode 100644
index 0000000..436c389
--- /dev/null
+++ b/arch/csky/abiv1/src/alignment.c
@@ -0,0 +1,513 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/ptrace.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/uaccess.h>
+
+#include <asm/siginfo.h>
+#include <asm/unaligned.h>
+
+extern void die_if_kernel(char *, struct pt_regs *, long);
+
+#define HANDLER_SUCCESS 0
+#define HANDLER_FAILURE	1
+#define SP_NUM 0
+#define R4_NUM 4
+#define R15_NUM 4
+#define R16_NUM 16
+#define R28_NUM 28
+
+#define CODING_BITS(i)  (i & 0xFC000000)
+#define LDST_TYPE(i)    (i & 0xf000)
+
+static unsigned long ai_user;
+static unsigned long ai_sys;
+static unsigned long ai_skipped;
+static unsigned long ai_half;
+static unsigned long ai_word;
+static unsigned long ai_qword;
+static int ai_usermode;
+
+#define UM_WARN		(1 << 0)
+#define UM_FIXUP	(1 << 1)
+#define UM_SIGNAL	(1 << 2)
+
+static const char *usermode_action[] = {
+	"ignored",
+	"warn",
+	"fixup",
+	"fixup+warn",
+	"signal",
+	"signal+warn"
+};
+
+static int alignment_proc_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "User:\t\t%lu\n", ai_user);
+	seq_printf(m, "System:\t\t%lu\n", ai_sys);
+	seq_printf(m, "Skipped:\t%lu\n", ai_skipped);
+	seq_printf(m, "Half:\t\t%lu\n", ai_half);
+	seq_printf(m, "Word:\t\t%lu\n", ai_word);
+	seq_printf(m, "Qword:\t\t%lu\n", ai_qword);
+	seq_printf(m, "User faults:\t%i (%s)\n", ai_usermode,
+			usermode_action[ai_usermode]);
+
+	return 0;
+}
+
+static int alignment_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, alignment_proc_show, NULL);
+}
+
+static int proc_alignment_write(struct file *file, const char __user *buffer,
+				size_t count, loff_t *pos)
+{
+	char mode;
+
+	if (count > 0) {
+		if (get_user(mode, buffer))
+			return -EFAULT;
+		if (mode >= '0' && mode <= '5')
+			ai_usermode = mode - '0';
+	}
+	return count;
+}
+
+static const struct file_operations alignment_proc_fops = {
+	.open		= alignment_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= proc_alignment_write,
+};
+
+#ifdef  __cskyBE__
+#define BE		1
+#define FIRST_BYTE_16	"rotri	%1, 8\n"
+#define FIRST_BYTE_32	"rotri	%1, 24\n"
+#define NEXT_BYTE	"rotri  %1, 24\n"
+#else
+#define BE		0
+#define FIRST_BYTE_16
+#define FIRST_BYTE_32
+#define NEXT_BYTE	"lsri   %1, 8\n"
+#endif
+
+#define __get8_unaligned_check(val,addr,err)		\
+	asm(					\
+	"1:	ldb	%1, (%2)\n"			\
+	"	addi	%2, 1\n"			\
+	"	br	3f\n"				\
+	"2:	movi	%0, 1\n"			\
+	"	br	3f\n"				\
+	"	.section __ex_table,\"a\"\n"		\
+	"	.align	2\n"				\
+	"	.long	1b, 2b\n"			\
+	"	.previous\n"				\
+	"3:\n"						\
+	: "=r" (err), "=r" (val), "=r" (addr)		\
+	: "0" (err), "2" (addr))
+
+#define get16_unaligned_check(val,addr)				\
+	do {							\
+		unsigned int err = 0, v, a = addr;		\
+		__get8_unaligned_check(v,a,err);		\
+		val =  v << ((BE) ? 8 : 0);			\
+		__get8_unaligned_check(v,a,err);		\
+		val |= v << ((BE) ? 0 : 8);			\
+		if (err)					\
+			goto fault;				\
+	} while (0)
+
+#define get32_unaligned_check(val,addr)				\
+	do {							\
+		unsigned int err = 0, v, a = addr;		\
+		__get8_unaligned_check(v,a,err);		\
+		val =  v << ((BE) ? 24 :  0);			\
+		__get8_unaligned_check(v,a,err);		\
+		val |= v << ((BE) ? 16 :  8);			\
+		__get8_unaligned_check(v,a,err);		\
+		val |= v << ((BE) ?  8 : 16);			\
+		__get8_unaligned_check(v,a,err);		\
+		val |= v << ((BE) ?  0 : 24);			\
+		if (err)					\
+			goto fault;				\
+	} while (0)
+
+#define put16_unaligned_check(val,addr)				\
+	do {							\
+		unsigned int err = 0, v = val, a = addr;	\
+		asm( FIRST_BYTE_16				\
+		"1:	stb	%1, (%2)\n"			\
+		"	addi	%2, 1\n"			\
+			NEXT_BYTE				\
+		"2:	stb	%1, (%2)\n"			\
+		"	br	4f\n"				\
+		"3:	movi	%0, 1\n"			\
+		"	br	4f\n"				\
+		"	.section __ex_table,\"a\"\n"		\
+		"	.align	2\n"				\
+		"	.long	1b, 3b\n"			\
+		"	.long	2b, 3b\n"			\
+		"	.previous\n"				\
+		"4:\n"						\
+		: "=r" (err), "=r" (v), "=r" (a)		\
+		: "0" (err), "1" (v), "2" (a));			\
+		if (err)					\
+			goto fault;				\
+	} while (0)
+
+#define put32_unaligned_check(val,addr)				\
+	do {							\
+		unsigned int err = 0, v = val, a = addr;	\
+		asm( FIRST_BYTE_32				\
+		"1:	stb	%1, (%2)\n"			\
+		"	addi	%2, 1\n"			\
+			NEXT_BYTE				\
+		"2:	stb	%1, (%2)\n"			\
+		"	addi	%2, 1\n"			\
+			NEXT_BYTE				\
+		"3:	stb	%1, (%2)\n"			\
+		"	addi	%2, 1\n"			\
+			NEXT_BYTE				\
+		"4:	stb	%1, (%2)\n"			\
+		"	br	6f\n"				\
+		"5:	movi	%0, 1\n"			\
+		"	br	6f\n"				\
+		"	.section __ex_table,\"a\"\n"		\
+		"	.align	2\n"				\
+		"	.long	1b, 5b\n"			\
+		"	.long	2b, 5b\n"			\
+		"	.long	3b, 5b\n"			\
+		"	.long	4b, 5b\n"			\
+		"	.previous\n"				\
+		"6:\n"						\
+		: "=r" (err), "=r" (v), "=r" (a)		\
+		: "0" (err), "1" (v), "2" (a));			\
+		if (err)					\
+			goto fault;				\
+	} while (0)
+
+inline static unsigned int
+get_regs_value(unsigned int rx, struct pt_regs *regs)
+{
+	unsigned int value;
+
+	if(rx == 0){
+		if(user_mode(regs)){
+			asm volatile("mfcr %0, ss1\n":"=r"(value));
+		}else{
+			value = sizeof(struct pt_regs) + ((unsigned int)regs);
+		}
+	}else if(rx == 1){
+		value = regs->regs[9];
+	}else if(rx == 15){
+		value = regs->r15;
+	}else{
+		value = *((int *)regs + rx + 1);
+	}
+
+	return value;
+}
+
+inline static int
+put_regs_value(unsigned int value, unsigned int rx, struct pt_regs *regs){
+	if(rx == 0){
+		printk("alignment handler trying to write sp.\n");
+		goto fault;
+	}else if(rx == 1){
+		regs->regs[9] = value;
+	}else if(rx == 15){
+		regs->r15 = value;
+	}else{
+		*((int *)regs + rx + 1) = value;
+	}
+	return 0;
+fault:
+	return 1;
+}
+
+static int
+handle_ldh_ldw_v1(unsigned long instr, struct pt_regs *regs){
+	unsigned int regx = instr & 0xf;
+	unsigned int regz = (instr >> 8) & 0xf;
+	unsigned int imm4 = (instr >> 4) & 0xf;
+	unsigned int destaddr, ldh_ldw;
+	unsigned int dataregx, tmpval32;
+	unsigned short tmpval16;
+
+	dataregx = get_regs_value(regx, regs);
+
+	ldh_ldw = instr & 0x6000;
+	if(ldh_ldw == 0x4000){ // ldh
+		destaddr = dataregx + (imm4 << 1);
+		get16_unaligned_check(tmpval16, destaddr);
+		if(put_regs_value((unsigned int)tmpval16, regz, regs) != 0){
+			goto fault;
+		}
+		ai_half += 1;
+	}else if(ldh_ldw == 0x0000){ // ldw
+		destaddr = dataregx + (imm4 << 2);
+		get32_unaligned_check(tmpval32, destaddr);
+		if(put_regs_value(tmpval32, regz, regs) != 0){
+			goto fault;
+		}
+		ai_word += 1;
+	}else{
+		goto fault;
+	}
+
+	return HANDLER_SUCCESS;
+fault:
+	return HANDLER_FAILURE;
+}
+
+static int
+handle_ldm_v1(unsigned long instr, struct pt_regs *regs){
+	unsigned int regf = instr & 0xf;
+	unsigned int datasp;
+	unsigned int tmpval32, i;
+
+	// regf can not be r0 or r15.
+	if(regf == 0 || regf == 15){
+		goto fault;
+	}
+
+	datasp = get_regs_value(SP_NUM, regs);
+	for(i = regf; i <= R15_NUM; i++){
+		get32_unaligned_check(tmpval32, datasp + (i - regf) * 4);
+		if(put_regs_value(tmpval32, i, regs) != 0){
+			goto fault;
+		}
+	}
+	ai_qword += 1;
+
+	return HANDLER_SUCCESS;
+fault:
+	return HANDLER_FAILURE;
+}
+
+static int
+handle_ldq_v1(unsigned long instr, struct pt_regs *regs){
+	unsigned int regf = instr & 0xf;
+	unsigned int datarf;
+	unsigned int tmpval32, i;
+
+	// regf can not be r4 - r7.
+	if(regf > 3 && regf < 8){
+		goto fault;
+	}
+
+	datarf = get_regs_value(regf, regs);
+	for(i = 4; i <= 8; i++){
+		get32_unaligned_check(tmpval32, datarf + (i - 4) * 4);
+		if(put_regs_value(tmpval32, i, regs) != 0){
+			goto fault;
+		}
+	}
+	ai_qword += 1;
+
+	return HANDLER_SUCCESS;
+fault:
+	return HANDLER_FAILURE;
+}
+
+static int
+handle_sth_stw_v1(unsigned long instr, struct pt_regs *regs){
+	unsigned int regx = instr & 0xf;
+	unsigned int regz = (instr >> 8) & 0xf;
+	unsigned int imm4 = (instr >> 4) & 0xf;
+	unsigned int destaddr, sth_stw;
+	unsigned int dataregx, dataregz;
+
+	dataregx = get_regs_value(regx, regs);
+	dataregz = get_regs_value(regz, regs);
+
+	sth_stw = instr & 0x6000;
+	if(sth_stw == 0x4000){ // sth
+		destaddr = dataregx + (imm4 << 1);
+		put16_unaligned_check(dataregz, destaddr);
+		ai_half += 1;
+	}else if(sth_stw == 0x0000){ //stw
+		destaddr = dataregx + (imm4 << 2);
+		put32_unaligned_check(dataregz, destaddr);
+		ai_word += 1;
+	}else{
+		goto fault;
+	}
+
+	return HANDLER_SUCCESS;
+fault:
+	return HANDLER_FAILURE;
+}
+
+static int
+handle_stq_v1(unsigned long instr, struct pt_regs *regs){
+	unsigned int regf = instr & 0xf;
+	unsigned int datarf;
+	unsigned int tmpval32, i;
+
+	// regf can not be r4 - r7.
+	if(regf > 3 && regf < 8){
+		goto fault;
+	}
+
+	datarf = get_regs_value(regf, regs);
+	for(i = 4; i <= 7; i++){
+		tmpval32 = get_regs_value(i, regs);
+		put32_unaligned_check(tmpval32, datarf + (i - 4) * 4);
+	}
+	ai_qword += 1;
+
+	return HANDLER_SUCCESS;
+fault:
+	return HANDLER_FAILURE;
+}
+
+static int
+handle_stm_v1(unsigned long instr, struct pt_regs *regs){
+	unsigned int regf = instr & 0xf;
+	unsigned int datasp;
+	unsigned int tmpval32, i;
+
+	// regf can not be r0 or r15.
+	if(regf == 0 || regf == 15){
+		goto fault;
+	}
+
+	datasp = get_regs_value(SP_NUM, regs);
+	for(i = regf; i <= R15_NUM; i++){
+		tmpval32 = get_regs_value(i, regs);
+		put32_unaligned_check(tmpval32, datasp + (i - regf) * 4);
+	}
+	ai_qword += 1;
+
+	return HANDLER_SUCCESS;
+fault:
+	return HANDLER_FAILURE;
+}
+
+void csky_alignment(struct pt_regs *regs)
+{
+	int err;
+	unsigned long instr = 0, instrptr;
+	unsigned int fault;
+	u16 tinstr = 0;
+	int (*handler)(unsigned long inst, struct pt_regs *regs) = NULL;
+	int isize = 2;
+	siginfo_t info;
+
+
+	mm_segment_t fs;
+
+	instrptr = instruction_pointer(regs);
+
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+	fault = __get_user(tinstr, (u16 *)(instrptr & ~1));
+	instr = (unsigned long)tinstr;
+
+	set_fs(fs);
+	if (fault) {
+		goto bad_or_fault;
+	}
+
+	if (user_mode(regs)) {
+		goto user;
+	}
+
+	ai_sys += 1;
+fixup:
+	regs->pc += isize;
+
+	if((instr & 0x9000) == 0x9000){ // sth, stw
+		handler = handle_sth_stw_v1;
+	}else if((instr & 0x9000) == 0x8000){ // ldh, ldw
+		handler = handle_ldh_ldw_v1;
+	}else if((instr & 0xfff0) == 0x0070){ // stm
+		handler = handle_stm_v1;
+	}else if((instr & 0xfff0) == 0x0060){ // ldm
+		handler = handle_ldm_v1;
+	}else if((instr & 0xfff0) == 0x0050){ // stq
+		handler = handle_stq_v1;
+	}else if((instr & 0xfff0) == 0x0040){ // ldq
+		handler = handle_ldq_v1;
+	}else{
+		goto bad_or_fault;
+	}
+
+	if (!handler)
+		goto bad_or_fault;
+
+	err = handler(instr, regs);
+	if (err != HANDLER_SUCCESS)
+	{
+		regs->pc -=2;
+		goto bad_or_fault;
+	}
+
+	return;
+
+bad_or_fault:
+	if(fixup_exception(regs)) {
+		ai_skipped += 1;
+		return;
+	}
+
+	die_if_kernel("Alignment trap: not handle this instruction", regs, 0);
+	return;
+
+user:
+	ai_user += 1;
+
+	if (ai_usermode & UM_WARN)
+		printk("Alignment trap: %s(pid=%d) PC=0x%x Ins=0x%x\n",
+			current->comm, current->pid,
+			(unsigned int)regs->pc, (unsigned int)instr);
+
+	if (ai_usermode & UM_FIXUP)
+		goto fixup;
+
+	if (ai_usermode & UM_SIGNAL) {
+		info.si_code = NSIGBUS;
+		info.si_signo = SIGBUS;
+		info.si_errno = 0;
+		force_sig_info(SIGBUS, &info, current);
+	}
+
+	return;
+}
+
+/*
+ * This needs to be done after sysctl_init, otherwise sys/ will be
+ * overwritten.  Actually, this shouldn't be in sys/ at all since
+ * it isn't a sysctl, and it doesn't contain sysctl information.
+ * We now locate it in /proc/cpu/alignment instead.
+ */
+static int __init alignment_init(void)
+{
+	struct proc_dir_entry *res;
+
+	res = proc_mkdir("cpu", NULL);
+	if (!res)
+		return -ENOMEM;
+
+	res = proc_create("alignment", S_IWUSR | S_IRUGO, res, &alignment_proc_fops);
+	if (!res)
+		return -ENOMEM;
+
+	ai_usermode = UM_FIXUP;
+
+	return 0;
+}
+fs_initcall(alignment_init);
diff --git a/arch/csky/abiv2/inc/abi/entry.h b/arch/csky/abiv2/inc/abi/entry.h
new file mode 100644
index 0000000..fc6deab
--- /dev/null
+++ b/arch/csky/abiv2/inc/abi/entry.h
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_ENTRY_H
+#define __ASM_CSKY_ENTRY_H
+
+#include <asm/setup.h>
+#include <abi/regdef.h>
+
+#define LSAVE_A0       0xc
+#define LSAVE_A1       0x10
+#define LSAVE_A2       0x14
+#define LSAVE_A3       0x18
+
+#define KSPTOUSP
+#define USPTOKSP
+
+.macro GET_USP rx
+	mfcr	\rx, cr<14, 1>
+.endm
+
+.macro SET_USP rx
+	mtcr	\rx, cr<14, 1>
+.endm
+
+.macro INCTRAP	rx
+	addi	\rx, 4
+.endm
+
+.macro SAVE_ALL
+	subi    sp,  144
+	stw     a0, (sp, 4)
+	stw     a0, (sp, 12)
+	stw     a1, (sp, 16)
+	stw     a2, (sp, 20)
+	stw     a3, (sp, 24)
+	stw     r4, (sp, 28)
+	stw     r5, (sp, 32)
+	stw     r6, (sp, 36)
+	stw     r7, (sp, 40)
+	stw     r8, (sp, 44)
+	stw     r9, (sp, 48)
+	stw     r10, (sp, 52)
+	stw     r11, (sp, 56)
+	stw     r12, (sp, 60)
+	stw     r13, (sp, 64)
+	stw     r15, (sp, 68)
+	addi    sp, 72
+	stm     r16-r31,(sp)
+#ifdef CONFIG_CPU_HAS_HILO
+	mfhi    r22
+	mflo    r23
+	stw     r22, (sp, 64)
+        stw     r23, (sp, 68)
+#endif
+	subi    sp,  72
+
+	mfcr    r22, epsr
+	stw     r22, (sp, 8)
+	mfcr    r22, epc
+	stw     r22, (sp)
+.endm
+.macro SAVE_ALL_TRAP
+	SAVE_ALL
+	INCTRAP	r22
+	stw     r22, (sp)
+.endm
+
+.macro	RESTORE_ALL
+	psrclr  ie
+	ldw     a0, (sp)
+	mtcr    a0, epc
+	ldw     a0, (sp, 8)
+	mtcr    a0, epsr
+	addi    sp, 12
+#ifdef CONFIG_CPU_HAS_HILO
+	ldw     a0, (sp, 124)
+	ldw     a1, (sp, 128)
+	mthi    a0
+	mtlo    a1
+#endif
+	ldw     a0, (sp, 0)
+	ldw     a1, (sp, 4)
+	ldw     a2, (sp, 8)
+	ldw     a3, (sp, 12)
+	ldw     r4, (sp, 16)
+	ldw     r5, (sp, 20)
+	ldw     r6, (sp, 24)
+	ldw     r7, (sp, 28)
+	ldw     r8, (sp, 32)
+	ldw     r9, (sp, 36)
+	ldw     r10, (sp, 40)
+	ldw     r11, (sp, 44)
+	ldw     r12, (sp, 48)
+	ldw     r13, (sp, 52)
+	ldw     r15, (sp, 56)
+	addi    sp, 60
+	ldm     r16-r31,(sp)
+	addi    sp,  72
+1:
+	rte
+.endm
+
+.macro SAVE_SWITCH_STACK
+        subi    sp, 64
+        stm     r4-r11,(sp)
+        stw     r15, (sp, 32)
+        stw     r16, (sp, 36)
+        stw     r17, (sp, 40)
+        stw     r26, (sp, 44)
+        stw     r27, (sp, 48)
+        stw     r28, (sp, 52)
+        stw     r29, (sp, 56)
+        stw     r30, (sp, 60)
+.endm
+
+.macro RESTORE_SWITCH_STACK
+        ldm     r4-r11,(sp)
+        ldw     r15, (sp, 32)
+        ldw     r16, (sp, 36)
+        ldw     r17, (sp, 40)
+        ldw     r26, (sp, 44)
+        ldw     r27, (sp, 48)
+        ldw     r28, (sp, 52)
+        ldw     r29, (sp, 56)
+        ldw     r30, (sp, 60)
+        addi    sp, 64
+.endm
+
+/* MMU registers operators. */
+.macro RD_MIR	rx
+	mfcr    \rx, cr<0, 15>
+.endm
+
+.macro RD_MEH	rx
+	mfcr    \rx, cr<4, 15>
+.endm
+
+.macro RD_MCIR	rx
+	mfcr    \rx, cr<8, 15>
+.endm
+
+.macro RD_PGDR  rx
+        mfcr    \rx, cr<29, 15>
+.endm
+
+.macro WR_MEH	rx
+	mtcr    \rx, cr<4, 15>
+.endm
+
+.macro WR_MCIR	rx
+	mtcr    \rx, cr<8, 15>
+.endm
+
+#endif /* __ASM_CSKY_ENTRY_H */
diff --git a/arch/csky/include/asm/syscalls.h b/arch/csky/include/asm/syscalls.h
new file mode 100644
index 0000000..c478830
--- /dev/null
+++ b/arch/csky/include/asm/syscalls.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_SYSCALLS_H
+#define __ASM_CSKY_SYSCALLS_H
+
+#include <asm-generic/syscalls.h>
+
+long sys_cacheflush(void __user *, unsigned long, int);
+
+long sys_set_thread_area(unsigned long addr);
+
+long sys_csky_fadvise64_64(int fd, int advice, loff_t offset, loff_t len);
+
+#endif /* __ASM_CSKY_SYSCALLS_H */
diff --git a/arch/csky/include/asm/traps.h b/arch/csky/include/asm/traps.h
new file mode 100644
index 0000000..ca82b19
--- /dev/null
+++ b/arch/csky/include/asm/traps.h
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_TRAPS_H
+#define __ASM_CSKY_TRAPS_H
+
+#define VEC_RESET	0
+#define VEC_ALIGN	1
+#define VEC_ACCESS	2
+#define VEC_ZERODIV	3
+#define VEC_ILLEGAL	4
+#define VEC_PRIV	5
+#define VEC_TRACE	6
+#define VEC_BREAKPOINT	7
+#define VEC_UNRECOVER	8
+#define VEC_SOFTRESET	9
+#define VEC_AUTOVEC	10
+#define VEC_FAUTOVEC	11
+#define VEC_HWACCEL	12
+
+#define	VEC_TLBMISS	14
+#define	VEC_TLBMODIFIED	15
+
+#define VEC_TRAP0	16
+#define VEC_TRAP1	17
+#define VEC_TRAP2	18
+#define VEC_TRAP3	19
+
+#define	VEC_TLBINVALIDL	20
+#define	VEC_TLBINVALIDS	21
+
+#define VEC_PRFL	29
+#define VEC_FPE		30
+
+extern void * vec_base[];
+#define VEC_INIT(i, func) vec_base[i] = (void *)func
+
+void csky_alignment(struct pt_regs*);
+
+#endif /* __ASM_CSKY_TRAPS_H */
diff --git a/arch/csky/include/asm/unistd.h b/arch/csky/include/asm/unistd.h
new file mode 100644
index 0000000..704526c
--- /dev/null
+++ b/arch/csky/include/asm/unistd.h
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <uapi/asm/unistd.h>
+
diff --git a/arch/csky/include/uapi/asm/unistd.h b/arch/csky/include/uapi/asm/unistd.h
new file mode 100644
index 0000000..12ebbba
--- /dev/null
+++ b/arch/csky/include/uapi/asm/unistd.h
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#define __ARCH_WANT_IPC_PARSE_VERSION
+#define __ARCH_WANT_OLD_READDIR
+#define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SYNC_FILE_RANGE2
+#define __ARCH_WANT_SYS_ALARM
+#define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SYS_FORK
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_IPC
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+#define __ARCH_WANT_SYS_OLD_GETRLIMIT
+#define __ARCH_WANT_SYS_OLD_SELECT
+#define __ARCH_WANT_SYS_OLDUMOUNT
+#define __ARCH_WANT_SYS_PAUSE
+#define __ARCH_WANT_SYS_RT_SIGACTION
+#define __ARCH_WANT_SYS_RT_SIGSUSPEND
+#define __ARCH_WANT_SYS_SGETMASK
+#define __ARCH_WANT_SYS_SIGNAL
+#define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_SIGPROCMASK
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_VFORK
+#define __ARCH_WANT_SYS_WAITPID
+#define __ARCH_WANT_SYSCALL_DEPRECATED
+#define __ARCH_WANT_SYSCALL_OFF_T
+#define __ARCH_WANT_SYSCALL_NO_AT
+#define __ARCH_WANT_SYSCALL_NO_FLAGS
+
+#undef	__NR_rt_sigreturn
+#undef	__NR_getppid
+
+#include <asm-generic/unistd.h>
+
+/*
+ * __NR_rt_sigreturn must be 173
+ * Because gcc/config/csky/linux-unwind.h use hard-code 173
+ * to parse rt_sigframe.
+ */
+#if __NR_rt_sigreturn != 139
+#error __NR_rt_sigreturn has changed.
+#endif
+
+#if __NR_getppid != 173
+#error __NR_getppid has changed.
+#endif
+
+#undef	__NR_rt_sigreturn
+#define	__NR_rt_sigreturn 173
+__SC_COMP(__NR_rt_sigreturn, sys_rt_sigreturn, compat_sys_rt_sigreturn)
+
+#undef	__NR_getppid
+#define	__NR_getppid 139
+__SYSCALL(__NR_getppid, sys_getppid)
+
+
+/*
+ * other define
+ */
+#define __NR_set_thread_area	(__NR_arch_specific_syscall + 0)
+__SYSCALL(__NR_set_thread_area, sys_set_thread_area)
+#define __NR_ipc		(__NR_arch_specific_syscall + 1)
+__SYSCALL(__NR_ipc, sys_ipc)
+#define __NR_socketcall		(__NR_arch_specific_syscall + 2)
+__SYSCALL(__NR_socketcall, sys_socketcall)
+#define __NR_ugetrlimit		(__NR_arch_specific_syscall + 3)
+__SYSCALL(__NR_ugetrlimit, sys_getrlimit)
+#define __NR_cacheflush		(__NR_arch_specific_syscall + 4)
+__SYSCALL(__NR_cacheflush, sys_cacheflush)
+#define __NR_sysfs		(__NR_arch_specific_syscall + 5)
+__SYSCALL(__NR_sysfs, sys_sysfs)
+
+__SYSCALL(__NR_fadvise64_64, sys_csky_fadvise64_64)
+
+#define __NR_setgroups32	__NR_setgroups
+#define __NR_getgid32		__NR_getgid
+#define __NR_getgroups32	__NR_getgroups
+#define __NR_setuid32		__NR_setuid
+#define __NR_setgid32		__NR_setgid
+#define __NR_getresgid32	__NR_getresgid
+#define __NR_chown32		__NR_chown
+#define __NR_setfsuid32		__NR_setfsuid
+#define __NR_setfsgid32		__NR_setfsgid
+#define __NR_lchown32		__NR_lchown
+#define __NR_fchown32		__NR_fchown
+#define __NR_geteuid32		__NR_geteuid
+#define __NR_getegid32		__NR_getegid
+#define __NR_getresuid32	__NR_getresuid
+#define __NR_setresuid32	__NR_setresuid
+#define __NR_setresgid32	__NR_setresgid
+#define __NR_setreuid32		__NR_setreuid
+#define __NR_setregid32		__NR_setregid
+#define __NR__llseek		__NR_llseek
+
diff --git a/arch/csky/kernel/cpu-probe.c b/arch/csky/kernel/cpu-probe.c
new file mode 100644
index 0000000..8934583
--- /dev/null
+++ b/arch/csky/kernel/cpu-probe.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/of.h>
+#include <linux/init.h>
+#include <linux/seq_file.h>
+#include <abi/reg_ops.h>
+#include <linux/memblock.h>
+
+static __init void setup_cpu_msa(void)
+{
+	if (memblock_start_of_DRAM() != (PHYS_OFFSET + CONFIG_RAM_BASE)) {
+		pr_err("C-SKY: dts-DRAM doesn't fit .config: %x-%x.\n",
+			memblock_start_of_DRAM(),
+			PHYS_OFFSET + CONFIG_RAM_BASE);
+		return;
+	}
+
+	mtcr_msa0(PHYS_OFFSET | 0xe);
+	mtcr_msa1(PHYS_OFFSET | 0x6);
+}
+
+__init void cpu_dt_probe(void)
+{
+	setup_cpu_msa();
+}
+
+static int c_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "C-SKY CPU : %s\n", CSKYCPU_DEF_NAME);
+	seq_printf(m, "revision  : 0x%08x\n", mfcr_cpuidrr());
+	seq_printf(m, "ccr reg   : 0x%08x\n", mfcr_ccr());
+	seq_printf(m, "ccr2 reg  : 0x%08x\n", mfcr_ccr2());
+	seq_printf(m, "hint reg  : 0x%08x\n", mfcr_hint());
+	seq_printf(m, "msa0 reg  : 0x%08x\n", mfcr_msa0());
+	seq_printf(m, "msa1 reg  : 0x%08x\n", mfcr_msa1());
+	seq_printf(m, "\n");
+#ifdef CSKY_ARCH_VERSION
+	seq_printf(m, "arch-version : %s\n", CSKY_ARCH_VERSION);
+	seq_printf(m, "\n");
+#endif
+	return 0;
+}
+
+static void *c_start(struct seq_file *m, loff_t *pos)
+{
+	return *pos < 1 ? (void *)1 : NULL;
+}
+
+static void *c_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	++*pos;
+	return NULL;
+}
+
+static void c_stop(struct seq_file *m, void *v) {}
+
+const struct seq_operations cpuinfo_op = {
+	.start	= c_start,
+	.next	= c_next,
+	.stop	= c_stop,
+	.show	= c_show,
+};
+
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
new file mode 100644
index 0000000..f0ab7d7
--- /dev/null
+++ b/arch/csky/kernel/entry.S
@@ -0,0 +1,408 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/linkage.h>
+#include <abi/entry.h>
+#include <abi/pgtable-bits.h>
+#include <asm/errno.h>
+#include <asm/setup.h>
+#include <asm/unistd.h>
+#include <asm/asm-offsets.h>
+#include <linux/threads.h>
+#include <asm/setup.h>
+#include <asm/page.h>
+#include <asm/thread_info.h>
+#ifdef CONFIG_CPU_HAS_FPU
+#include <abi/fpu.h>
+#endif
+
+#define PTE_INDX_MSK    0xffc
+#define PTE_INDX_SHIFT  10
+#define _PGDIR_SHIFT    22
+#define THREADSIZE_MASK_BIT 13
+
+.macro tlbop_begin name, val0, val1, val2
+ENTRY(csky_\name)
+	mtcr    a3, ss2
+	mtcr    r6, ss3
+	mtcr    a2, ss4
+
+	RD_MEH	a3
+#ifdef CONFIG_CPU_HAS_TLBI
+	tlbi.va	a3
+#else
+	bgeni	a2, 31
+	WR_MCIR	a2
+	bgeni	a2, 25
+	WR_MCIR	a2
+#endif
+
+	RD_PGDR	r6
+	bclri   r6, 0
+	lrw	a2, PHYS_OFFSET
+	subu	r6, a2
+	bseti	r6, 31
+
+	mov     a2, a3
+   	lsri    a2, _PGDIR_SHIFT
+	lsli    a2, 2
+	addu    r6, a2
+	ldw     r6, (r6)
+
+	lrw	a2, PHYS_OFFSET
+	subu	r6, a2
+	bseti	r6, 31
+
+	lsri    a3, PTE_INDX_SHIFT
+	lrw     a2, PTE_INDX_MSK
+	and     a3, a2
+	addu    r6, a3
+	ldw     a3, (r6)
+
+	movi	a2, (_PAGE_PRESENT | \val0)
+	and     a3, a2
+	cmpne   a3, a2
+	bt	\name
+
+	/* First read/write the page, just update the flags */
+	ldw     a3, (r6)
+	bgeni   a2, PAGE_VALID_BIT
+	bseti   a2, PAGE_ACCESSED_BIT
+	bseti   a2, \val1
+	bseti   a2, \val2
+	or      a3, a2
+	stw     a3, (r6)
+
+	/* Some cpu tlb-hardrefill bypass the cache */
+#ifdef CONFIG_CPU_NEED_TLBSYNC
+	movi	a2, 0x22
+	bseti	a2, 6
+	mtcr	r6, cr22
+	mtcr	a2, cr17
+	sync
+#endif
+
+	mfcr    a3, ss2
+	mfcr    r6, ss3
+	mfcr    a2, ss4
+	rte
+\name:
+	mfcr    a3, ss2
+	mfcr    r6, ss3
+	mfcr    a2, ss4
+	SAVE_ALL
+.endm
+.macro tlbop_end is_write
+	RD_MEH	a2
+	psrset  ee, ie
+	mov     a0, sp
+	movi    a1, \is_write
+	jbsr    do_page_fault
+	movi    r11_sig, 0             /* r11 = 0, Not a syscall. */
+	jmpi    ret_from_exception
+.endm
+
+.text
+
+tlbop_begin tlbinvalidl, _PAGE_READ, PAGE_VALID_BIT, PAGE_ACCESSED_BIT
+tlbop_end 0
+
+tlbop_begin tlbinvalids, _PAGE_WRITE, PAGE_DIRTY_BIT, PAGE_MODIFIED_BIT
+tlbop_end 1
+
+tlbop_begin tlbmodified, _PAGE_WRITE, PAGE_DIRTY_BIT, PAGE_MODIFIED_BIT
+jbsr csky_cmpxchg_fixup
+tlbop_end 1
+
+ENTRY(csky_systemcall)
+	SAVE_ALL_TRAP
+
+	psrset  ee, ie
+
+	/* Stack frame for syscall, origin call set_esp0 */
+	mov     r12, sp
+
+	bmaski  r11, 13
+	andn    r12, r11
+	bgeni   r11, 9
+	addi    r11, 32
+	addu    r12, r11
+	st      sp, (r12, 0)
+
+	lrw     r11, __NR_syscalls
+	cmphs   syscallid, r11                 /* Check nr of syscall */
+	bt      ret_from_exception
+
+	lrw     r13, sys_call_table
+	ixw     r13, syscallid                 /* Index into syscall table */
+	ldw     r11, (r13)               /* Get syscall function */
+	cmpnei  r11, 0                  /* Check for not null */
+	bf      ret_from_exception
+
+	mov     r9, sp				 /* Get task pointer */
+	bmaski  r10, THREADSIZE_MASK_BIT
+	andn    r9, r10                      /* Get thread_info */
+	ldw     r8, (r9, TINFO_FLAGS)       /* Get thread_info.flags value */
+	btsti   r8, TIF_SYSCALL_TRACE       /* Check if TIF_SYSCALL_TRACE set */
+	bt      1f
+#if defined(__CSKYABIV2__)
+	subi    sp, 8
+	stw  	r5, (sp, 0x4)
+	stw  	r4, (sp, 0x0)
+	jsr     r11                      /* Do system call */
+	addi 	sp, 8
+#else
+	jsr     r11
+#endif
+	stw     a0, (sp, LSAVE_A0)      /* Save return value */
+	jmpi    ret_from_exception
+
+1:
+	movi    a0, 0                   /* enter system call */
+	mov     a1, sp                  /* right now, sp --> pt_regs */
+	jbsr    syscall_trace
+	/* Prepare args before do system call */
+	ldw     a0, (sp, LSAVE_A0)
+	ldw     a1, (sp, LSAVE_A1)
+	ldw     a2, (sp, LSAVE_A2)
+	ldw     a3, (sp, LSAVE_A3)
+#if defined(__CSKYABIV2__)
+	subi    sp, 8
+	stw     r5, (sp, 0x4)
+	stw     r4, (sp, 0x0)
+#else
+	ldw     r6, (sp, LSAVE_A4)
+	ldw     r7, (sp, LSAVE_A5)
+#endif
+	jsr     r11                     /* Do system call */
+#if defined(__CSKYABIV2__)
+	addi    sp, 8
+#endif
+	stw     a0, (sp, LSAVE_A0)     /* Save return value */
+
+	movi    a0, 1                   /* leave system call */
+	mov     a1, sp                  /* right now, sp --> pt_regs */
+	jbsr    syscall_trace
+
+syscall_exit_work:
+	ld       syscallid, (sp, 8)     /* get psr, is user mode? */
+	btsti    syscallid, 31
+	bt       2f
+
+	jmpi     resume_userspace
+
+2:      RESTORE_ALL
+
+ENTRY(ret_from_kernel_thread)
+	jbsr     schedule_tail
+	mov	 a0, r8
+	jsr	 r9
+	jbsr     ret_from_exception
+
+ENTRY(ret_from_fork)
+	jbsr     schedule_tail
+	mov      r9, sp				 /* Get task pointer */
+	bmaski   r10, THREADSIZE_MASK_BIT
+	andn     r9, r10                     /* Get thread_info */
+	ldw      r8, (r9, TINFO_FLAGS)       /* Get thread_info.flags value */
+	movi     r11_sig, 1                  /* is a syscall */
+	btsti    r8, TIF_SYSCALL_TRACE       /* Check if TIF_SYSCALL_TRACE set */
+	bf       3f
+	movi     a0, 1                       /* leave system call */
+	mov      a1, sp                      /* right now, sp --> pt_regs */
+	jbsr     syscall_trace
+3:
+	jbsr     ret_from_exception
+
+ret_from_exception:
+	ld       syscallid, (sp,8)     /* get psr, is user mode? */
+	btsti    syscallid, 31
+	bt       1f
+	/*
+	 * Load address of current->thread_info, Then get address of task_struct
+	 * Get task_needreshed in task_struct
+	 */
+	mov     r9, sp     					 /* Get current stack  pointer */
+	bmaski  r10, THREADSIZE_MASK_BIT
+	andn    r9, r10                      /* Get task_struct */
+
+resume_userspace:
+	ldw      r8, (r9, TINFO_FLAGS)
+	andi     r8, (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED)
+	cmpnei   r8, 0
+	bt       exit_work
+1:  RESTORE_ALL
+
+exit_work:
+	mov      a0, sp                 /* Stack address is arg[0] */
+	jbsr     set_esp0               /* Call C level */
+	btsti    r8, TIF_NEED_RESCHED
+	bt       work_resched
+	cmpnei   r8, 0		/* If thread_info->flag is empty, RESTORE_ALL. */
+	bf       1b
+	mov      a1, sp
+	mov      a0, r8
+	mov      a2, r11_sig        /* syscall? */
+	btsti    r8, TIF_SIGPENDING /* delivering a signal? */
+	clrt     r11_sig            /* prevent further restarts(set r11 = 0) */
+	jbsr     do_notify_resume	/* do signals */
+	br       resume_userspace
+
+work_resched:
+	lrw      syscallid, ret_from_exception
+	mov      r15, syscallid                /* Return address in link */
+	jmpi     schedule
+
+ENTRY(sys_rt_sigreturn)
+	movi	r11_sig, 0
+	jmpi	do_rt_sigreturn
+
+/*
+ * Common trap handler. Standard traps come through here first
+ */
+
+ENTRY(csky_trap)
+	SAVE_ALL
+	psrset   ee
+	movi     r11_sig, 0             /* r11 = 0, Not a syscall. */
+	mov      a0, sp                 /* Push Stack pointer arg */
+	jbsr     trap_c                 /* Call C-level trap handler */
+	jmpi     ret_from_exception
+
+/*
+ * Prototype from libc:
+ * register unsigned int __result asm("a0");
+ * asm( "trap 3" :"=r"(__result)::);
+ */
+ENTRY(csky_get_tls)
+	USPTOKSP
+
+	/* increase epc for continue */
+	mfcr	a0, epc
+	INCTRAP	a0
+	mtcr	a0, epc
+
+	/* get current task thread_info with kernel 8K stack */
+	bmaski   a0, (PAGE_SHIFT + 1)
+	not      a0
+	subi     sp, 1
+	and      a0, sp
+	addi     sp, 1
+
+	/* get tls */
+	ldw      a0, (a0, TINFO_TP_VALUE)
+
+	KSPTOUSP
+	rte
+
+ENTRY(csky_irq)
+	SAVE_ALL
+	psrset  ee       // enable exception
+	movi    r11_sig, 0                   /* r11 = 0, Not a syscall. */
+
+#ifdef CONFIG_PREEMPT
+	mov     r9, sp                       /* Get current stack  pointer */
+	bmaski  r10, THREADSIZE_MASK_BIT
+	andn    r9, r10                      /* Get thread_info */
+
+	/*
+	 * Get task_struct->stack.preempt_count for current,
+	 * and increase 1.
+	 */
+	ldw      r8, (r9, TINFO_PREEMPT)
+	addi     r8, 1
+	stw      r8, (r9, TINFO_PREEMPT)
+#endif
+
+	mov      a0, sp                      /* arg[0] is stack pointer */
+	jbsr     csky_do_auto_IRQ          /* Call handler */
+
+#ifdef CONFIG_PREEMPT
+	subi     r8, 1
+	stw      r8, (r9, TINFO_PREEMPT)
+	cmpnei   r8, 0
+	bt       2f
+	ldw      r8, (r9, TINFO_FLAGS)
+	btsti    r8, TIF_NEED_RESCHED
+	bf       2f
+1:
+	jbsr     preempt_schedule_irq   /* irq en/disable is done inside */
+	ldw      r7, (r9, TINFO_FLAGS)  /* get new tasks TI_FLAGS */
+	btsti    r7, TIF_NEED_RESCHED
+	bt       1b                     /* go again */
+#endif
+2:
+	jmpi     ret_from_exception
+
+/*
+ * a0 =  prev task_struct *
+ * a1 =  next task_struct *
+ * a0 =  return next
+ */
+ENTRY(__switch_to)
+	lrw      a3, TASK_THREAD        /* struct_thread offset in task_struct */
+	addu     a3, a0                 /* a3 point to thread in prev task_struct */
+
+	mfcr     a2, psr                /* Save PSR value */
+	stw      a2, (a3, THREAD_SR)    /* Save PSR in task struct */
+	bclri    a2, 6                  /* Disable interrupts */
+	mtcr     a2, psr
+
+	SAVE_SWITCH_STACK
+
+	GET_USP	 r6
+
+	stw      r6, (a3, THREAD_USP)   /* Save usp in task struct */
+	stw      sp, (a3, THREAD_KSP)   /* Save ksp in task struct */
+
+#ifdef CONFIG_CPU_HAS_FPU
+	FPU_SAVE_REGS
+#endif
+
+#ifdef CONFIG_CPU_HAS_HILO
+	lrw      r10, THREAD_DSPHI
+	add      r10, a3
+	mfhi     r6
+	mflo     r7
+	stw      r6, (r10, 0)           /* THREAD_DSPHI */
+	stw      r7, (r10, 4)           /* THREAD_DSPLO */
+	mfcr     r6, cr14
+	stw      r6, (r10, 8)           /* THREAD_DSPCSR */
+#endif
+
+	/* Set up next process to run */
+	lrw      a3, TASK_THREAD	/* struct_thread offset in task_struct */
+	addu     a3, a1			/* a3 point to thread in next task_struct */
+
+	ldw      sp, (a3, THREAD_KSP)	/* Set next ksp */
+	ldw      r6, (a3, THREAD_USP)	/* Set next usp */
+
+	SET_USP	 r6
+
+#ifdef CONFIG_CPU_HAS_FPU
+	FPU_RESTORE_REGS
+#endif
+
+#ifdef CONFIG_CPU_HAS_HILO
+	lrw      r10, THREAD_DSPHI
+	add      r10, a3
+	ldw      r6, (r10, 8)   /* THREAD_DSPCSR */
+	mtcr     r6, cr14
+	ldw      r6, (r10, 0)    /* THREAD_DSPHI */
+	ldw      r7, (r10, 4)    /* THREAD_DSPLO */
+	mthi     r6
+	mtlo     r7
+#endif
+
+	ldw      a2, (a3, THREAD_SR)    /* Set next PSR */
+	mtcr     a2, psr
+
+#if  defined(__CSKYABIV2__)
+	/* set TLS register (r31) */
+	addi     r7, a1, TASK_THREAD_INFO
+	ldw      r31, (r7, TINFO_TP_VALUE)
+#endif
+
+	RESTORE_SWITCH_STACK
+
+	rts
+ENDPROC(__switch_to)
diff --git a/arch/csky/kernel/syscall.c b/arch/csky/kernel/syscall.c
new file mode 100644
index 0000000..b45f497
--- /dev/null
+++ b/arch/csky/kernel/syscall.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/syscalls.h>
+
+SYSCALL_DEFINE1(set_thread_area, unsigned long, addr)
+{
+	struct thread_info *ti = task_thread_info(current);
+
+#if defined(__CSKYABIV2__)
+	struct pt_regs *reg = current_pt_regs();
+	reg->exregs[15] = (long)addr;
+#endif
+	ti->tp_value = addr;
+
+	return 0;
+}
+
+SYSCALL_DEFINE6(mmap2,
+	unsigned long, addr,
+	unsigned long, len,
+	unsigned long, prot,
+	unsigned long, flags,
+	unsigned long, fd,
+	off_t, offset)
+{
+	if (unlikely(offset & (~PAGE_MASK >> 12)))
+		return -EINVAL;
+	return sys_mmap_pgoff(addr, len, prot, flags, fd,
+		offset >> (PAGE_SHIFT - 12));
+}
+
+struct mmap_arg_struct {
+	unsigned long addr;
+	unsigned long len;
+	unsigned long prot;
+	unsigned long flags;
+	unsigned long fd;
+	unsigned long offset;
+};
+
+SYSCALL_DEFINE1(mmap,
+	struct mmap_arg_struct *, arg)
+{
+	struct mmap_arg_struct a;
+
+	if (copy_from_user(&a, arg, sizeof(a)))
+		return -EINVAL;
+
+	if (unlikely(a.offset & ~PAGE_MASK))
+		return -EINVAL;
+
+	return sys_mmap_pgoff(a.addr, a.len, a.prot, a.flags, a.fd, a.offset >> PAGE_SHIFT);
+}
+
+/*
+ * for abiv1 the 64bits args should be even th, So we need mov the advice forward.
+ */
+SYSCALL_DEFINE4(csky_fadvise64_64,
+	int, fd,
+	int, advice,
+	loff_t, offset,
+	loff_t, len)
+{
+	return sys_fadvise64_64(fd, offset, len, advice);
+}
diff --git a/arch/csky/kernel/syscall_table.c b/arch/csky/kernel/syscall_table.c
new file mode 100644
index 0000000..bea8558
--- /dev/null
+++ b/arch/csky/kernel/syscall_table.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/syscalls.h>
+#include <asm/syscalls.h>
+
+#undef __SYSCALL
+#define __SYSCALL(nr, call) [nr] = (call),
+
+void * const sys_call_table[__NR_syscalls] __page_aligned_data = {
+	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
+#include <asm/unistd.h>
+};
diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
new file mode 100644
index 0000000..17bcb08
--- /dev/null
+++ b/arch/csky/kernel/traps.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/user.h>
+#include <linux/string.h>
+#include <linux/linkage.h>
+#include <linux/init.h>
+#include <linux/ptrace.h>
+#include <linux/kallsyms.h>
+#include <linux/rtc.h>
+#include <linux/uaccess.h>
+
+#include <asm/setup.h>
+#include <asm/traps.h>
+#include <asm/pgalloc.h>
+#include <asm/siginfo.h>
+
+#include <asm/mmu_context.h>
+
+#ifdef CONFIG_CPU_HAS_FPU
+#include <abi/fpu.h>
+#endif
+
+/* Defined in entry.S */
+asmlinkage void csky_trap(void);
+
+asmlinkage void csky_systemcall(void);
+asmlinkage void csky_cmpxchg(void);
+asmlinkage void csky_get_tls(void);
+asmlinkage void csky_irq(void);
+
+asmlinkage void csky_tlbinvalidl(void);
+asmlinkage void csky_tlbinvalids(void);
+asmlinkage void csky_tlbmodified(void);
+
+void __init pre_trap_init(void)
+{
+	int i;
+
+	asm volatile(
+		"mtcr %0, vbr\n"
+		::"r"(vec_base));
+
+	for(i=1;i<128;i++) VEC_INIT(i, csky_trap);
+}
+
+void __init trap_init (void)
+{
+	int i;
+
+	/* setup irq */
+	for(i=32;i<128;i++)
+		  VEC_INIT(i, csky_irq);
+	VEC_INIT(VEC_AUTOVEC, csky_irq);
+
+	/* setup trap0 trap2 trap3 */
+	VEC_INIT(VEC_TRAP0, csky_systemcall);
+	VEC_INIT(VEC_TRAP2, csky_cmpxchg);
+	VEC_INIT(VEC_TRAP3, csky_get_tls);
+
+	/* setup MMU TLB exception */
+	VEC_INIT(VEC_TLBINVALIDL, csky_tlbinvalidl);
+	VEC_INIT(VEC_TLBINVALIDS, csky_tlbinvalids);
+	VEC_INIT(VEC_TLBMODIFIED, csky_tlbmodified);
+
+
+#ifdef CONFIG_CPU_HAS_FPU
+	init_fpu();
+#endif
+}
+
+void die_if_kernel (char *str, struct pt_regs *regs, int nr)
+{
+	if (user_mode(regs)) return;
+
+	console_verbose();
+	pr_err("%s: %08x\n",str,nr);
+        show_regs(regs);
+        add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
+	do_exit(SIGSEGV);
+}
+
+void buserr(struct pt_regs *regs)
+{
+	siginfo_t info;
+
+	die_if_kernel("Kernel mode BUS error", regs, 0);
+
+	pr_err("User mode Bus Error\n");
+	show_regs(regs);
+
+	current->thread.esp0 = (unsigned long) regs;
+	info.si_signo = SIGSEGV;
+	info.si_errno = 0;
+	force_sig_info(SIGSEGV, &info, current);
+}
+
+asmlinkage void trap_c(struct pt_regs *regs)
+{
+	int sig;
+	unsigned long vector;
+	siginfo_t info;
+
+	asm volatile("mfcr %0, psr":"=r"(vector));
+
+	vector = (vector >> 16) & 0xff;
+
+	switch (vector) {
+		case VEC_ZERODIV:
+			sig = SIGFPE;
+			break;
+		/* ptrace */
+		case VEC_TRACE:
+			info.si_code = TRAP_TRACE;
+			sig = SIGTRAP;
+			break;
+
+		/* gdbserver  breakpoint */
+		case VEC_TRAP1:
+		/* jtagserver breakpoint */
+		case VEC_BREAKPOINT:
+			info.si_code = TRAP_BRKPT;
+			sig = SIGTRAP;
+			break;
+		case VEC_ACCESS:
+			return buserr(regs);
+#ifdef CONFIG_CPU_NEED_SOFTALIGN
+		case VEC_ALIGN:
+			return csky_alignment(regs);
+#endif
+#ifdef CONFIG_CPU_HAS_FPU
+		case VEC_FPE:
+			return fpu_fpe(regs);
+		case VEC_PRIV:
+			if(fpu_libc_helper(regs)) return;
+#endif
+		default:
+			sig = SIGILL;
+			break;
+	}
+	send_sig(sig, current, 0);
+}
+
+asmlinkage void set_esp0 (unsigned long ssp)
+{
+	current->thread.esp0 = ssp;
+}
+
diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
new file mode 100644
index 0000000..fe85404
--- /dev/null
+++ b/arch/csky/mm/fault.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/signal.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/ptrace.h>
+#include <linux/mman.h>
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/version.h>
+#include <linux/vt_kern.h>
+#include <linux/kernel.h>
+#include <linux/extable.h>
+#include <linux/uaccess.h>
+
+#include <asm/hardirq.h>
+#include <asm/mmu_context.h>
+#include <asm/traps.h>
+#include <asm/page.h>
+
+extern void die_if_kernel(char *, struct pt_regs *, long);
+
+static inline int delay_slot(struct pt_regs *regs)
+{
+        return 0;
+}
+
+static inline unsigned long exception_epc(struct pt_regs *regs)
+{
+        if (!delay_slot(regs))
+                return regs->pc;
+
+        return regs->pc + 4;
+}
+
+int fixup_exception(struct pt_regs *regs)
+{
+        const struct exception_table_entry *fixup;
+
+        fixup = search_exception_tables(exception_epc(regs));
+        if (fixup) {
+                regs->pc = fixup->nextinsn;
+
+                return 1;
+        }
+
+        return 0;
+}
+
+/*
+ * This routine handles page faults.  It determines the address,
+ * and the problem, and then passes it off to one of the appropriate
+ * routines.
+ */
+asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
+                              unsigned long mmu_meh)
+{
+        struct vm_area_struct * vma = NULL;
+        struct task_struct *tsk = current;
+        struct mm_struct *mm = tsk->mm;
+        siginfo_t info;
+	int fault;
+	unsigned long address = mmu_meh & PAGE_MASK;
+
+        info.si_code = SEGV_MAPERR;
+
+        /*
+         * We fault-in kernel-space virtual memory on-demand. The
+         * 'reference' page table is init_mm.pgd.
+         *
+         * NOTE! We MUST NOT take any locks for this case. We may
+         * be in an interrupt or a critical region, and should
+         * only copy the information from the master page table,
+         * nothing more.
+         */
+        if (unlikely(address >= VMALLOC_START && address <= VMALLOC_END))
+                goto vmalloc_fault;
+
+        /*
+         * If we're in an interrupt or have no user
+         * context, we must not take the fault..
+         */
+        if (in_atomic() || !mm)
+                goto bad_area_nosemaphore;
+
+        down_read(&mm->mmap_sem);
+        vma = find_vma(mm, address);
+        if (!vma)
+                goto bad_area;
+        if (vma->vm_start <= address)
+                goto good_area;
+        if (!(vma->vm_flags & VM_GROWSDOWN))
+                goto bad_area;
+        if (expand_stack(vma, address))
+                goto bad_area;
+/*
+ * Ok, we have a good vm_area for this memory access, so
+ * we can handle it..
+ */
+good_area:
+info.si_code = SEGV_ACCERR;
+
+        if (write) {
+                if (!(vma->vm_flags & VM_WRITE))
+                        goto bad_area;
+        } else {
+                if (!(vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC)))
+                        goto bad_area;
+        }
+
+        /*
+         * If for any reason at all we couldn't handle the fault,
+         * make sure we exit gracefully rather than endlessly redo
+         * the fault.
+         */
+        fault = handle_mm_fault(vma, address, write ? FAULT_FLAG_WRITE : 0);
+        if (unlikely(fault & VM_FAULT_ERROR)) {
+                if (fault & VM_FAULT_OOM)
+                        goto out_of_memory;
+                else if (fault & VM_FAULT_SIGBUS)
+                        goto do_sigbus;
+                else if (fault & VM_FAULT_SIGSEGV)
+                        goto bad_area;
+                BUG();
+        }
+        if (fault & VM_FAULT_MAJOR)
+                tsk->maj_flt++;
+        else
+                tsk->min_flt++;
+
+        up_read(&mm->mmap_sem);
+        return;
+
+/*
+ * Something tried to access memory that isn't in our memory map..
+ * Fix it, but check if it's kernel or user first..
+ */
+bad_area:
+        up_read(&mm->mmap_sem);
+
+bad_area_nosemaphore:
+        /* User mode accesses just cause a SIGSEGV */
+        if (user_mode(regs)) {
+                tsk->thread.address = address;
+                tsk->thread.error_code = write;
+#if 0
+                printk(KERN_ERR "do_page_fault() #2: sending SIGSEGV to %s for"
+                       "invalid %s\n%08lx (epc == %08lx)\n",
+                       tsk->comm,
+                       write ? "write access to" : "read access from",
+                       address,
+                       regs->pc);
+#endif
+                info.si_signo = SIGSEGV;
+                info.si_errno = 0;
+                /* info.si_code has been set above */
+                info.si_addr = (void __user *) address;
+                force_sig_info(SIGSEGV, &info, tsk);
+                return;
+        }
+
+no_context:
+	/* Are we prepared to handle this kernel fault? */
+        if (fixup_exception(regs)) return;
+
+	/*
+         * Oops. The kernel tried to access some bad page. We'll have to
+         * terminate things with extreme prejudice.
+         */
+        bust_spinlocks(1);
+
+        printk(KERN_ALERT "Unable to handle kernel paging request at virtual "
+               "address %08lx, epc == %08lx\n",
+               address, regs->pc);
+	die_if_kernel("Oops", regs, write);
+
+out_of_memory:
+        /*
+         * We ran out of memory, call the OOM killer, and return the userspace
+         * (which will retry the fault, or kill us if we got oom-killed).
+         */
+        pagefault_out_of_memory();
+        return;
+
+do_sigbus:
+        up_read(&mm->mmap_sem);
+
+        /* Kernel mode? Handle exceptions or die */
+        if (!user_mode(regs))
+                goto no_context;
+
+        tsk->thread.address = address;
+        info.si_signo = SIGBUS;
+        info.si_errno = 0;
+        info.si_code = BUS_ADRERR;
+        info.si_addr = (void __user *) address;
+        force_sig_info(SIGBUS, &info, tsk);
+
+        return;
+vmalloc_fault:
+        {
+                /*
+                 * Synchronize this task's top level page-table
+                 * with the 'reference' page table.
+                 *
+                 * Do _not_ use "tsk" here. We might be inside
+                 * an interrupt in the middle of a task switch..
+                 */
+                int offset = __pgd_offset(address);
+                pgd_t *pgd, *pgd_k;
+                pud_t *pud, *pud_k;
+                pmd_t *pmd, *pmd_k;
+                pte_t *pte_k;
+
+                unsigned long pgd_base;
+		pgd_base = tlb_get_pgd();
+                pgd = (pgd_t *)pgd_base + offset;
+                pgd_k = init_mm.pgd + offset;
+
+                if (!pgd_present(*pgd_k))
+                        goto no_context;
+                set_pgd(pgd, *pgd_k);
+
+                pud = (pud_t *)pgd;
+                pud_k = (pud_t *)pgd_k;
+                if (!pud_present(*pud_k))
+                        goto no_context;
+
+                pmd = pmd_offset(pud, address);
+                pmd_k = pmd_offset(pud_k, address);
+                if (!pmd_present(*pmd_k))
+                        goto no_context;
+                set_pmd(pmd, *pmd_k);
+
+                pte_k = pte_offset_kernel(pmd_k, address);
+                if (!pte_present(*pte_k))
+                        goto no_context;
+                return;
+        }
+}
+
-- 
2.7.4
