From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 04/19] csky: Exception handling
Date: Mon,  2 Jul 2018 01:30:07 +0800
Message-ID: <ad971c1bb53c4077a1d3b4a8d97c899e80774d54.1530465326.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
 arch/csky/abiv1/alignment.c     | 332 ++++++++++++++++++++++++++++++++
 arch/csky/abiv1/inc/abi/entry.h | 152 +++++++++++++++
 arch/csky/abiv2/inc/abi/entry.h | 149 +++++++++++++++
 arch/csky/include/asm/traps.h   |  39 ++++
 arch/csky/include/asm/unistd.h  |   4 +
 arch/csky/kernel/cpu-probe.c    |  83 ++++++++
 arch/csky/kernel/entry.S        | 407 ++++++++++++++++++++++++++++++++++++++++
 arch/csky/kernel/traps.c        | 167 +++++++++++++++++
 arch/csky/mm/fault.c            | 223 ++++++++++++++++++++++
 9 files changed, 1556 insertions(+)
 create mode 100644 arch/csky/abiv1/alignment.c
 create mode 100644 arch/csky/abiv1/inc/abi/entry.h
 create mode 100644 arch/csky/abiv2/inc/abi/entry.h
 create mode 100644 arch/csky/include/asm/traps.h
 create mode 100644 arch/csky/include/asm/unistd.h
 create mode 100644 arch/csky/kernel/cpu-probe.c
 create mode 100644 arch/csky/kernel/entry.S
 create mode 100644 arch/csky/kernel/traps.c
 create mode 100644 arch/csky/mm/fault.c

diff --git a/arch/csky/abiv1/alignment.c b/arch/csky/abiv1/alignment.c
new file mode 100644
index 0000000..5acc86f
--- /dev/null
+++ b/arch/csky/abiv1/alignment.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/kernel.h>
+#include <linux/uaccess.h>
+#include <linux/ptrace.h>
+
+static int align_enable = 1;
+static int align_count  = 0;
+
+static inline uint32_t get_ptreg(struct pt_regs *regs, uint32_t rx)
+{
+	return *((int *)&(regs->a0) - 2 + rx);
+}
+
+static inline void put_ptreg(struct pt_regs *regs, uint32_t rx, uint32_t val)
+{
+	*((int *)&(regs->a0) - 2 + rx) = val;
+}
+
+/*
+ * Get byte-value from addr and set it to *valp.
+ *
+ * Success: return 0
+ * Failure: return 1
+ */
+static int ldb_asm(uint32_t addr, uint32_t *valp)
+{
+	uint32_t val;
+	int err;
+
+	if (!access_ok(VERIFY_READ, (void *)addr, 1))
+		return 1;
+
+	asm volatile (
+		"movi	%0, 0			\n"
+		"1:				\n"
+		"ldb	%1, (%2)		\n"
+		"br	3f			\n"
+		"2:				\n"
+		"movi	%0, 1			\n"
+		"br	3f			\n"
+		".section __ex_table,\"a\"	\n"
+		".align 2			\n"
+		".long	1b, 2b			\n"
+		".previous			\n"
+		"3:				\n"
+		: "=&r"(err), "=r"(val)
+		: "r" (addr)
+	);
+
+	*valp = val;
+
+	return err;
+}
+
+/*
+ * Put byte-value to addr.
+ *
+ * Success: return 0
+ * Failure: return 1
+ */
+static volatile int stb_asm(uint32_t addr, uint32_t val)
+{
+	int err;
+
+	if (!access_ok(VERIFY_WRITE, (void *)addr, 1))
+		return 1;
+
+	asm volatile (
+		"movi	%0, 0			\n"
+		"1:				\n"
+		"stb	%1, (%2)		\n"
+		"br	3f			\n"
+		"2:				\n"
+		"movi	%0, 1			\n"
+		"br	3f			\n"
+		".section __ex_table,\"a\"	\n"
+		".align 2			\n"
+		".long	1b, 2b			\n"
+		".previous			\n"
+		"3:				\n"
+		: "=&r"(err)
+		: "r"(val), "r" (addr)
+	);
+
+	return err;
+}
+
+/*
+ * Get half-word from [rx + imm]
+ *
+ * Success: return 0
+ * Failure: return 1
+ */
+static int ldh_c(struct pt_regs *regs, uint32_t rz, uint32_t addr)
+{
+	uint32_t byte0, byte1;
+
+	if (ldb_asm(addr, &byte0))
+		return 1;
+	addr += 1;
+	if (ldb_asm(addr, &byte1))
+		return 1;
+
+	byte0 |= byte1 << 8;
+	put_ptreg(regs, rz, byte0);
+
+	return 0;
+}
+
+/*
+ * Store half-word to [rx + imm]
+ *
+ * Success: return 0
+ * Failure: return 1
+ */
+static int sth_c(struct pt_regs *regs, uint32_t rz, uint32_t addr)
+{
+	uint32_t byte0, byte1;
+
+	byte0 = byte1 = get_ptreg(regs, rz);
+
+	byte0 &= 0xff;
+
+	if (stb_asm(addr, byte0))
+		return 1;
+
+	addr += 1;
+	byte1 = (byte1 >> 8) & 0xff;
+	if (stb_asm(addr, byte1))
+		return 1;
+
+	return 0;
+}
+
+/*
+ * Get word from [rx + imm]
+ *
+ * Success: return 0
+ * Failure: return 1
+ */
+static int ldw_c(struct pt_regs *regs, uint32_t rz, uint32_t addr)
+{
+	uint32_t byte0, byte1, byte2, byte3;
+
+	if (ldb_asm(addr, &byte0))
+		return 1;
+
+	addr += 1;
+	if (ldb_asm(addr, &byte1))
+		return 1;
+
+	addr += 1;
+	if (ldb_asm(addr, &byte2))
+		return 1;
+
+	addr += 1;
+	if (ldb_asm(addr, &byte3))
+		return 1;
+
+	byte0 |= byte1 << 8;
+	byte0 |= byte2 << 16;
+	byte0 |= byte3 << 24;
+
+	put_ptreg(regs, rz, byte0);
+
+	return 0;
+}
+
+/*
+ * Store word to [rx + imm]
+ *
+ * Success: return 0
+ * Failure: return 1
+ */
+static int stw_c(struct pt_regs *regs, uint32_t rz, uint32_t addr)
+{
+	uint32_t byte0, byte1, byte2, byte3;
+
+	byte0 = byte1 = byte2 = byte3 = get_ptreg(regs, rz);
+
+	byte0 &= 0xff;
+
+	if (stb_asm(addr, byte0))
+		return 1;
+
+	addr += 1;
+	byte1 = (byte1 >> 8) & 0xff;
+	if (stb_asm(addr, byte1))
+		return 1;
+
+	addr += 1;
+	byte2 = (byte2 >> 16) & 0xff;
+	if (stb_asm(addr, byte2))
+		return 1;
+
+	addr += 1;
+	byte3 = (byte3 >> 24) & 0xff;
+	if (stb_asm(addr, byte3))
+		return 1;
+
+	align_count++;
+
+	return 0;
+}
+
+extern int fixup_exception(struct pt_regs *regs);
+
+#define OP_LDH 0xc000
+#define OP_STH 0xd000
+#define OP_LDW 0x8000
+#define OP_STW 0x9000
+
+void csky_alignment(struct pt_regs *regs)
+{
+	int ret;
+	uint16_t tmp;
+	uint32_t opcode = 0;
+	uint32_t rx     = 0;
+	uint32_t rz     = 0;
+	uint32_t imm    = 0;
+	uint32_t addr   = 0;
+
+	siginfo_t info;
+
+	if (!user_mode(regs))
+		goto bad_area;
+
+	ret = get_user(tmp, (uint16_t *)instruction_pointer(regs));
+	if (ret) {
+		pr_err("%s get_user failed.\n", __func__);
+		goto bad_area;
+	}
+
+	opcode = (uint32_t)tmp;
+
+	rx  = opcode & 0xf;
+	imm = (opcode >> 4) & 0xf;
+	rz  = (opcode >> 8) & 0xf;
+	opcode &= 0xf000;
+
+	if (rx == 0 || rx == 15 || rz == 0 || rz == 15)
+		goto bad_area;
+
+	switch(opcode) {
+	case OP_LDH:
+		addr = get_ptreg(regs, rx) + (imm << 1);
+		ret = ldh_c(regs, rz, addr);
+		break;
+	case OP_LDW:
+		addr = get_ptreg(regs, rx) + (imm << 2);
+		ret = ldw_c(regs, rz, addr);
+		break;
+	case OP_STH:
+		addr = get_ptreg(regs, rx) + (imm << 1);
+		ret = sth_c(regs, rz, addr);
+		break;
+	case OP_STW:
+		addr = get_ptreg(regs, rx) + (imm << 2);
+		ret = stw_c(regs, rz, addr);
+		break;
+	}
+
+	if(ret)
+		goto bad_area;
+
+	regs->pc += 2;
+
+	return;
+
+bad_area:
+	if (!user_mode(regs)) {
+		if (fixup_exception(regs))
+			return;
+
+		bust_spinlocks(1);
+		pr_alert("%s opcode: %x, rz: %d, rx: %d, imm: %d, addr: %x.\n",
+		          __func__, opcode, rz, rx, imm, addr);
+		show_regs(regs);
+		bust_spinlocks(0);
+		do_exit(SIGKILL);
+	}
+
+	info.si_signo = SIGBUS;
+	info.si_errno = 0;
+	info.si_code  = BUS_ADRALN;
+	info.si_addr  = (void __user *)addr;
+
+	force_sig_info(info.si_signo, &info, current);
+
+	return;
+}
+
+static struct ctl_table alignment_tbl[4] = {
+	{
+		.procname = "enable",
+		.data = &align_enable,
+		.maxlen = sizeof(align_enable),
+		.mode = 0666,
+		.proc_handler = &proc_dointvec
+	},
+	{
+		.procname = "count",
+		.data = &align_count,
+		.maxlen = sizeof(align_count),
+		.mode = 0666,
+		.proc_handler = &proc_dointvec
+	},
+	{}
+};
+
+static struct ctl_table sysctl_table[2] = {
+	{
+	 .procname = "csky_alignment",
+	 .mode = 0555,
+	 .child = alignment_tbl},
+	{}
+};
+
+static struct ctl_path sysctl_path[2] = {
+	{.procname = "csky"},
+	{}
+};
+
+static int __init csky_alignment_init(void)
+{
+	register_sysctl_paths(sysctl_path, sysctl_table);
+	return 0;
+}
+
+arch_initcall(csky_alignment_init);
+
diff --git a/arch/csky/abiv1/inc/abi/entry.h b/arch/csky/abiv1/inc/abi/entry.h
new file mode 100644
index 0000000..b4b5062
--- /dev/null
+++ b/arch/csky/abiv1/inc/abi/entry.h
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_ENTRY_H
+#define __ASM_CSKY_ENTRY_H
+
+#include <asm/setup.h>
+#include <abi/regdef.h>
+
+#define LSAVE_PC	8
+#define LSAVE_PSR	12
+#define LSAVE_A0	24
+#define LSAVE_A1	28
+#define LSAVE_A2	32
+#define LSAVE_A3	36
+#define LSAVE_A4	40
+#define LSAVE_A5	44
+
+#define EPC_INCREASE	2
+#define EPC_KEEP	0
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
+.macro INCTRAP	rx
+	addi	\rx, EPC_INCREASE
+.endm
+
+.macro	SAVE_ALL epc_inc
+	mtcr    r13, ss2
+	mfcr    r13, epsr
+	btsti   r13, 31
+	bt      1f
+	USPTOKSP
+1:
+	subi    sp, 32
+	subi    sp, 32
+	subi    sp, 16
+	stw     r13, (sp, 12)
+
+	stw     lr, (sp, 4)
+
+	mfcr	lr, epc
+	movi	r13, \epc_inc
+	add	lr, r13
+	stw     lr, (sp, 8)
+
+	mfcr	lr, ss1
+	stw     lr, (sp, 16)
+
+	stw     a0, (sp, 20)
+	stw     a0, (sp, 24)
+	stw     a1, (sp, 28)
+	stw     a2, (sp, 32)
+	stw     a3, (sp, 36)
+
+	addi	sp, 32
+	addi	sp, 8
+	mfcr    r13, ss2
+	stw	r6, (sp)
+	stw	r7, (sp, 4)
+	stw	r8, (sp, 8)
+	stw	r9, (sp, 12)
+	stw	r10, (sp, 16)
+	stw	r11, (sp, 20)
+	stw	r12, (sp, 24)
+	stw	r13, (sp, 28)
+	stw	r14, (sp, 32)
+	stw	r1, (sp, 36)
+	subi	sp, 32
+	subi	sp, 8
+.endm
+
+.macro	RESTORE_ALL
+	psrclr  ie
+	ldw	lr, (sp, 4)
+	ldw     a0, (sp, 8)
+	mtcr    a0, epc
+	ldw     a0, (sp, 12)
+	mtcr    a0, epsr
+	btsti   a0, 31
+	ldw     a0, (sp, 16)
+	mtcr	a0, ss1
+
+	ldw     a0, (sp, 24)
+	ldw     a1, (sp, 28)
+	ldw     a2, (sp, 32)
+	ldw     a3, (sp, 36)
+
+	addi	sp, 32
+	addi	sp, 8
+	ldw	r6, (sp)
+	ldw	r7, (sp, 4)
+	ldw	r8, (sp, 8)
+	ldw	r9, (sp, 12)
+	ldw	r10, (sp, 16)
+	ldw	r11, (sp, 20)
+	ldw	r12, (sp, 24)
+	ldw	r13, (sp, 28)
+	ldw	r14, (sp, 32)
+	ldw	r1, (sp, 36)
+	addi	sp, 32
+	addi	sp, 8
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
diff --git a/arch/csky/abiv2/inc/abi/entry.h b/arch/csky/abiv2/inc/abi/entry.h
new file mode 100644
index 0000000..398d02e
--- /dev/null
+++ b/arch/csky/abiv2/inc/abi/entry.h
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_ENTRY_H
+#define __ASM_CSKY_ENTRY_H
+
+#include <asm/setup.h>
+#include <abi/regdef.h>
+
+#define LSAVE_PC	8
+#define LSAVE_PSR	12
+#define LSAVE_A0	24
+#define LSAVE_A1	28
+#define LSAVE_A2	32
+#define LSAVE_A3	36
+
+#define EPC_INCREASE	4
+#define EPC_KEEP	0
+
+#define KSPTOUSP
+#define USPTOKSP
+
+#define usp cr<14, 1>
+
+.macro INCTRAP	rx
+	addi	\rx, EPC_INCREASE
+.endm
+
+.macro SAVE_ALL epc_inc
+	subi    sp, 152
+	stw	tls, (sp, 0)
+	stw	lr, (sp, 4)
+
+	mfcr	lr, epc
+	movi	tls, \epc_inc
+	add	lr, tls
+	stw	lr, (sp, 8)
+
+	mfcr	lr, epsr
+	stw	lr, (sp, 12)
+	mfcr	lr, usp
+	stw	lr, (sp, 16)
+
+	stw     a0, (sp, 20)
+	stw     a0, (sp, 24)
+	stw     a1, (sp, 28)
+	stw     a2, (sp, 32)
+	stw     a3, (sp, 36)
+
+	addi	sp, 40
+	stm	r4-r13, (sp)
+
+	addi    sp, 40
+	stm     r16-r30,(sp)
+#ifdef CONFIG_CPU_HAS_HILO
+	mfhi	lr
+	stw	lr, (sp, 60)
+	mflo	lr
+	stw	lr, (sp, 64)
+#endif
+	subi	sp, 80
+.endm
+
+.macro	RESTORE_ALL
+	psrclr  ie
+	ldw	tls, (sp, 0)
+	ldw	lr, (sp, 4)
+	ldw	a0, (sp, 8)
+	mtcr	a0, epc
+	ldw	a0, (sp, 12)
+	mtcr	a0, epsr
+	ldw	a0, (sp, 16)
+	mtcr	a0, usp
+
+#ifdef CONFIG_CPU_HAS_HILO
+	ldw	a0, (sp, 140)
+	mthi	a0
+	ldw	a0, (sp, 144)
+	mtlo	a0
+#endif
+
+	ldw     a0, (sp, 24)
+	ldw     a1, (sp, 28)
+	ldw     a2, (sp, 32)
+	ldw     a3, (sp, 36)
+
+	addi	sp, 40
+	ldm	r4-r13, (sp)
+	addi    sp, 40
+	ldm     r16-r30,(sp)
+	addi    sp, 72
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
+	mfcr    \rx, cr<29, 15>
+.endm
+
+.macro RD_PGDR_K  rx
+	mfcr    \rx, cr<28, 15>
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
diff --git a/arch/csky/kernel/cpu-probe.c b/arch/csky/kernel/cpu-probe.c
new file mode 100644
index 0000000..b898ec9
--- /dev/null
+++ b/arch/csky/kernel/cpu-probe.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/of.h>
+#include <linux/init.h>
+#include <linux/seq_file.h>
+#include <linux/memblock.h>
+
+#include <abi/reg_ops.h>
+
+static __init void setup_cpu_msa(void)
+{
+	if (memblock_start_of_DRAM() != CONFIG_RAM_BASE) {
+		panic("dts-ram-start doesn't equal CONFIG_RAM_BASE in .config: %x-%x.\n",
+			memblock_start_of_DRAM(), CONFIG_RAM_BASE);
+	}
+
+	mtcr_msa0(PHYS_OFFSET | 0xe);
+	mtcr_msa1(PHYS_OFFSET | 0x26);
+}
+
+__init void cpu_dt_probe(void)
+{
+	setup_cpu_msa();
+}
+
+static void percpu_print(void *arg)
+{
+	struct seq_file *m = (struct seq_file *)arg;
+
+	seq_printf(m, "processor       : %d\n", smp_processor_id());
+	seq_printf(m, "C-SKY CPU model : %s\n", CSKYCPU_DEF_NAME);
+
+	/* Read 4 times to get all the cpuid info */
+	seq_printf(m, "product info[0] : 0x%08x\n", mfcr("cr13"));
+	seq_printf(m, "product info[1] : 0x%08x\n", mfcr("cr13"));
+	seq_printf(m, "product info[2] : 0x%08x\n", mfcr("cr13"));
+	seq_printf(m, "product info[3] : 0x%08x\n", mfcr("cr13"));
+
+	seq_printf(m, "mpid reg        : 0x%08x\n", mfcr("cr30"));
+	seq_printf(m, "ccr reg         : 0x%08x\n", mfcr("cr18"));
+	seq_printf(m, "ccr2 reg        : 0x%08x\n", mfcr_ccr2());
+	seq_printf(m, "hint reg        : 0x%08x\n", mfcr_hint());
+	seq_printf(m, "msa0 reg        : 0x%08x\n", mfcr_msa0());
+	seq_printf(m, "msa1 reg        : 0x%08x\n", mfcr_msa1());
+	seq_printf(m, "\n");
+}
+
+static int c_show(struct seq_file *m, void *v)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu)
+		smp_call_function_single(cpu, percpu_print, m, true);
+
+#ifdef CSKY_ARCH_VERSION
+	seq_printf(m, "\n");
+	seq_printf(m, "arch-version : %s\n", CSKY_ARCH_VERSION);
+	seq_printf(m, "\n");
+#endif
+
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
index 0000000..2e59403
--- /dev/null
+++ b/arch/csky/kernel/entry.S
@@ -0,0 +1,407 @@
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
+
+.macro tlbop_begin name, val0, val1, val2
+ENTRY(csky_\name)
+	mtcr    a3, ss2
+	mtcr    r6, ss3
+	mtcr    a2, ss4
+
+	RD_PGDR	r6
+	RD_MEH	a3
+#ifdef CONFIG_CPU_HAS_TLBI
+	tlbi.alls
+	sync.is
+
+	btsti	a3, 31
+	bf	1f
+	RD_PGDR_K r6
+1:
+#else
+	bgeni	a2, 31
+	WR_MCIR	a2
+	bgeni	a2, 25
+	WR_MCIR	a2
+#endif
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
+	SAVE_ALL EPC_KEEP
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
+#ifndef CONFIG_CPU_HAS_LDSTEX
+jbsr csky_cmpxchg_fixup
+#endif
+tlbop_end 1
+
+ENTRY(csky_systemcall)
+	SAVE_ALL EPC_INCREASE
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
+	bmaski  r10, THREAD_SHIFT
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
+	ld       syscallid, (sp, LSAVE_PSR)
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
+	bmaski   r10, THREAD_SHIFT
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
+	ld       syscallid, (sp, LSAVE_PSR)
+	btsti    syscallid, 31
+	bt       1f
+	/*
+	 * Load address of current->thread_info, Then get address of task_struct
+	 * Get task_needreshed in task_struct
+	 */
+	mov     r9, sp     					 /* Get current stack  pointer */
+	bmaski  r10, THREAD_SHIFT
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
+	SAVE_ALL EPC_KEEP
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
+	bmaski   a0, THREAD_SHIFT
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
+	SAVE_ALL EPC_KEEP
+	psrset  ee       // enable exception
+	movi    r11_sig, 0                   /* r11 = 0, Not a syscall. */
+
+#ifdef CONFIG_PREEMPT
+	mov     r9, sp                       /* Get current stack  pointer */
+	bmaski  r10, THREAD_SHIFT
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
+	mov      a0, sp
+	jbsr     csky_do_IRQ
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
+	addi     r7, a1, TASK_THREAD_INFO
+	ldw      tls, (r7, TINFO_TP_VALUE)
+#endif
+
+	RESTORE_SWITCH_STACK
+
+	rts
+ENDPROC(__switch_to)
diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
new file mode 100644
index 0000000..0dbc6ce
--- /dev/null
+++ b/arch/csky/kernel/traps.c
@@ -0,0 +1,167 @@
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
+/* Defined in head.S */
+asmlinkage void _start_smp_secondary(void);
+
+void __init pre_trap_init(void)
+{
+	int i;
+
+	mtcr("vbr", vec_base);
+
+	for(i=1;i<128;i++) VEC_INIT(i, csky_trap);
+}
+
+void __init trap_init (void)
+{
+#ifdef CONFIG_CSKY_VECIRQ_LEGENCY
+	int i;
+
+	/* setup irq */
+	for(i=32;i<128;i++)
+		  VEC_INIT(i, csky_irq);
+#endif
+
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
+
+#ifdef CONFIG_SMP
+	mtcr("cr<28, 0>", virt_to_phys(vec_base));
+
+	VEC_INIT(VEC_RESET, (void *)virt_to_phys(_start_smp_secondary));
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
+	vector = (mfcr("psr") >> 16) & 0xff;
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
+		case VEC_ILLEGAL:
+#ifndef CONFIG_CPU_NO_USER_BKPT
+		if (*(uint16_t *)instruction_pointer(regs) != 0x1464)
+#endif
+		{
+			sig = SIGILL;
+			break;
+		}
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
+			sig = SIGSEGV;
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
index 0000000..3ff4491
--- /dev/null
+++ b/arch/csky/mm/fault.c
@@ -0,0 +1,223 @@
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
+int fixup_exception(struct pt_regs *regs)
+{
+        const struct exception_table_entry *fixup;
+
+        fixup = search_exception_tables(instruction_pointer(regs));
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
+#ifndef CONFIG_CPU_HAS_TLBI
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
+#endif
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
+        pr_alert("Unable to handle kernel paging request at virtual "
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
+}
+
-- 
2.7.4
