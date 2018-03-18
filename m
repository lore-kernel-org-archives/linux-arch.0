From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 14/19] csky: Misc headers
Date: Mon, 19 Mar 2018 03:51:36 +0800
Message-ID: <9cb4cf158b8c73325dc524cba8d575e41647131f.1521399976.git.ren_guo@c-sky.com>
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
 arch/csky/abiv1/inc/abi/reg_ops.h      |  79 +++++++++
 arch/csky/abiv1/inc/abi/regdef.h       |  27 +++
 arch/csky/abiv2/inc/abi/fpu.h          | 296 +++++++++++++++++++++++++++++++++
 arch/csky/abiv2/inc/abi/reg_ops.h      |  86 ++++++++++
 arch/csky/abiv2/inc/abi/regdef.h       |  28 ++++
 arch/csky/include/uapi/asm/byteorder.h |  14 ++
 arch/csky/include/uapi/asm/fcntl.h     |  13 ++
 arch/csky/include/uapi/asm/stat.h      |  86 ++++++++++
 8 files changed, 629 insertions(+)
 create mode 100644 arch/csky/abiv1/inc/abi/reg_ops.h
 create mode 100644 arch/csky/abiv1/inc/abi/regdef.h
 create mode 100644 arch/csky/abiv2/inc/abi/fpu.h
 create mode 100644 arch/csky/abiv2/inc/abi/reg_ops.h
 create mode 100644 arch/csky/abiv2/inc/abi/regdef.h
 create mode 100644 arch/csky/include/uapi/asm/byteorder.h
 create mode 100644 arch/csky/include/uapi/asm/fcntl.h
 create mode 100644 arch/csky/include/uapi/asm/stat.h

diff --git a/arch/csky/abiv1/inc/abi/reg_ops.h b/arch/csky/abiv1/inc/abi/reg_ops.h
new file mode 100644
index 0000000..224acff
--- /dev/null
+++ b/arch/csky/abiv1/inc/abi/reg_ops.h
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_REG_OPS_H
+#define __ASM_REG_OPS_H
+
+static inline unsigned int mfcr_cpuidrr(void)
+{
+	unsigned int ret;
+	asm volatile(
+		"mfcr %0, cr13\t\n"
+		:"=r"(ret));
+	return ret;
+}
+
+static inline unsigned int mfcr_hint(void)
+{
+	unsigned int ret;
+	asm volatile(
+		"mfcr %0, cr30\t\n"
+		:"=r"(ret));
+	return ret;
+}
+
+static inline unsigned int mfcr_ccr(void)
+{
+	unsigned int ret;
+	asm volatile(
+		"mfcr %0, cr18\t\n"
+		:"=r"(ret));
+	return ret;
+}
+
+static inline unsigned int mfcr_msa0(void)
+{
+	unsigned int ret;
+	asm volatile(
+		"cprcr %0, cpcr30\t\n"
+		:"=r"(ret));
+	return ret;
+}
+
+static inline void mtcr_msa0(unsigned int value)
+{
+	asm volatile(
+		"cpwcr %0, cpcr30\t\n"
+		::"r"(value));
+}
+
+static inline unsigned int mfcr_msa1(void)
+{
+	unsigned int ret;
+	asm volatile(
+		"cprcr %0, cpcr31\t\n"
+		:"=r"(ret));
+	return ret;
+}
+
+static inline void mtcr_msa1(unsigned int value)
+{
+	asm volatile(
+		"cpwcr %0, cpcr31\t\n"
+		::"r"(value));
+}
+
+static inline unsigned int mfcr_ccr2(void){return 0;}
+
+/* read/write user stack pointer */
+static inline unsigned long rdusp(void) {
+	register unsigned long usp;
+	asm volatile("mfcr %0, ss1\n\r":"=r"(usp));
+	return usp;
+}
+
+static inline void wrusp(unsigned long usp) {
+	asm volatile("mtcr %0, ss1\n\r"::"r"(usp));
+}
+
+#endif /* __ASM_REG_OPS_H */
+
diff --git a/arch/csky/abiv1/inc/abi/regdef.h b/arch/csky/abiv1/inc/abi/regdef.h
new file mode 100644
index 0000000..f694e8e
--- /dev/null
+++ b/arch/csky/abiv1/inc/abi/regdef.h
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef  __ASM_CSKY_REGDEF_H
+#define  __ASM_CSKY_REGDEF_H
+
+#define syscallid	r1
+#define r11_sig		r11
+
+#define DEFAULT_PSR_VALUE	0x8f000000
+
+#define PTRACE_REGOFF_ABI \
+{ \
+	-1,       PT_REGS9,  PT_A0,    PT_A1,\
+	PT_A2,    PT_A3,     PT_REGS0, PT_REGS1,\
+	PT_REGS2, PT_REGS3,  PT_REGS4, PT_REGS5,\
+	PT_REGS6, PT_REGS7,  PT_REGS8, PT_R15,\
+	-1,       -1,        -1,       -1,\
+	-1,       -1,        -1,       -1,\
+	-1,       -1,        -1,       -1,\
+	-1,       -1,        -1,       -1,\
+	PT_SR,    PT_PC,     -1,       -1,\
+}
+
+#define SYSTRACE_SAVENUM	2
+#define REGNO_USP		0
+
+#endif /* __ASM_CSKY_REGDEF_H */
diff --git a/arch/csky/abiv2/inc/abi/fpu.h b/arch/csky/abiv2/inc/abi/fpu.h
new file mode 100644
index 0000000..5f82f04
--- /dev/null
+++ b/arch/csky/abiv2/inc/abi/fpu.h
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_FPU_H
+#define __ASM_CSKY_FPU_H
+
+#ifndef __ASSEMBLY__ /* C source */
+
+#include <asm/sigcontext.h>
+#include <asm/ptrace.h>
+
+int fpu_libc_helper(struct pt_regs *regs);
+void fpu_fpe(struct pt_regs *regs);
+void __init init_fpu(void);
+
+int restore_fpu_state(struct sigcontext *sc);
+int save_fpu_state(struct sigcontext *sc, struct pt_regs *regs);
+
+/*
+ * Define the fesr bit for fpe handle.
+ */
+#define  FPE_ILLE  (1 << 16)    /* Illegal instruction  */
+#define  FPE_FEC   (1 << 7)     /* Input float-point arithmetic exception */
+#define  FPE_IDC   (1 << 5)     /* Input denormalized exception */
+#define  FPE_IXC   (1 << 4)     /* Inexact exception */
+#define  FPE_UFC   (1 << 3)     /* Underflow exception */
+#define  FPE_OFC   (1 << 2)     /* Overflow exception */
+#define  FPE_DZC   (1 << 1)     /* Divide by zero exception */
+#define  FPE_IOC   (1 << 0)     /* Invalid operation exception */
+#define  FPE_REGULAR_EXCEPTION (FPE_IXC | FPE_UFC | FPE_OFC | FPE_DZC | FPE_IOC)
+
+#ifdef CONFIG_OPEN_FPU_IDE
+#define IDE_STAT   (1 << 5)
+#else
+#define IDE_STAT   0
+#endif
+
+#ifdef CONFIG_OPEN_FPU_IXE
+#define IXE_STAT   (1 << 4)
+#else
+#define IXE_STAT   0
+#endif
+
+#ifdef CONFIG_OPEN_FPU_UFE
+#define UFE_STAT   (1 << 3)
+#else
+#define UFE_STAT   0
+#endif
+
+#ifdef CONFIG_OPEN_FPU_OFE
+#define OFE_STAT   (1 << 2)
+#else
+#define OFE_STAT   0
+#endif
+
+#ifdef CONFIG_OPEN_FPU_DZE
+#define DZE_STAT   (1 << 1)
+#else
+#define DZE_STAT   0
+#endif
+
+#ifdef CONFIG_OPEN_FPU_IOE
+#define IOE_STAT   (1 << 0)
+#else
+#define IOE_STAT   0
+#endif
+
+#define FMFS_FPU_REGS(frw, frx, fry, frz) \
+	"fmfs   %0, "#frw" \n" \
+	"fmfs   %1, "#frx" \n" \
+	"fmfs   %2, "#fry" \n" \
+	"fmfs   %3, "#frz" \n"
+
+#define FMTS_FPU_REGS(frw, frx, fry, frz) \
+	"fmts   %0, "#frw" \n" \
+	"fmts   %1, "#frx" \n" \
+	"fmts   %2, "#fry" \n" \
+	"fmts   %3, "#frz" \n"
+
+#define FMFVR_FPU_REGS(vrx, vry) \
+	"fmfvrl %0, "#vrx" \n" \
+	"fmfvrh %1, "#vrx" \n" \
+	"fmfvrl %2, "#vry" \n" \
+	"fmfvrh %3, "#vry" \n"
+
+#define FMTVR_FPU_REGS(vrx, vry) \
+	"fmtvrl "#vrx", %0 \n" \
+	"fmtvrh "#vrx", %1 \n" \
+	"fmtvrl "#vry", %2 \n" \
+	"fmtvrh "#vry", %3 \n"
+
+#define STW_FPU_REGS(a, b, c, d) \
+	"stw    %0, (%4, "#a") \n" \
+	"stw    %1, (%4, "#b") \n" \
+	"stw    %2, (%4, "#c") \n" \
+	"stw    %3, (%4, "#d") \n"
+
+#define LDW_FPU_REGS(a, b, c, d) \
+	"ldw    %0, (%4, "#a") \n" \
+	"ldw    %1, (%4, "#b") \n" \
+	"ldw    %2, (%4, "#c") \n" \
+	"ldw    %3, (%4, "#d") \n"
+
+static inline void save_fp_to_thread(unsigned long  * fpregs,
+	   unsigned long * fcr, unsigned long * fsr, unsigned long * fesr)
+{
+	unsigned long flg;
+	unsigned long tmp1, tmp2, tmp3, tmp4;
+
+	local_save_flags(flg);
+
+	asm volatile(
+		"mfcr    %0, cr<1, 2> \n"
+		"mfcr    %1, cr<2, 2> \n"
+		:"+r"(tmp1),"+r"(tmp2));
+
+	*fcr = tmp1;
+	/* not use in fpuv2 */
+	*fsr = 0;
+	*fesr = tmp2;
+	asm volatile(
+		FMFVR_FPU_REGS(vr0, vr1)
+		STW_FPU_REGS(0, 4, 8, 12)
+		FMFVR_FPU_REGS(vr2, vr3)
+		STW_FPU_REGS(16, 20, 24, 28)
+		FMFVR_FPU_REGS(vr4, vr5)
+		STW_FPU_REGS(32, 36, 40, 44)
+		FMFVR_FPU_REGS(vr6, vr7)
+		STW_FPU_REGS(48, 52, 56, 60)
+		"addi    %4, 32 \n"
+		"addi    %4, 32 \n"
+		FMFVR_FPU_REGS(vr8, vr9)
+		STW_FPU_REGS(0, 4, 8, 12)
+		FMFVR_FPU_REGS(vr10, vr11)
+		STW_FPU_REGS(16, 20, 24, 28)
+		FMFVR_FPU_REGS(vr12, vr13)
+		STW_FPU_REGS(32, 36, 40, 44)
+		FMFVR_FPU_REGS(vr14, vr15)
+		STW_FPU_REGS(48, 52, 56, 60)
+		:"=a"(tmp1),"=a"(tmp2),"=a"(tmp3),
+		"=a"(tmp4),"+a"(fpregs));
+	local_irq_restore(flg);
+}
+
+#else  /* __ASSEMBLY__ */
+
+#include <asm/asm-offsets.h>
+
+.macro  FPU_SAVE_REGS
+	/* Save FPU control regs task struct */
+	mfcr     r7, cr<1, 2>
+	mfcr     r6, cr<2, 2>
+	stw      r7, (a3, THREAD_FCR)
+	stw      r6, (a3, THREAD_FESR)
+	/* Save FPU general regs task struct */
+	fmfvrl   r6, vr0
+	fmfvrh   r7, vr0
+	fmfvrl   r8, vr1
+	fmfvrh   r9, vr1
+	stw      r6, (a3, THREAD_FPREG + 0)  /* In aviv2: stw can load longer */
+	stw      r7, (a3, THREAD_FPREG + 4)
+	stw      r8, (a3, THREAD_FPREG + 8)
+	stw      r9, (a3, THREAD_FPREG + 12)
+	fmfvrl   r6, vr2
+	fmfvrh   r7, vr2
+	fmfvrl   r8, vr3
+	fmfvrh   r9, vr3
+	stw      r6, (a3, THREAD_FPREG + 16)
+	stw      r7, (a3, THREAD_FPREG + 20)
+	stw      r8, (a3, THREAD_FPREG + 24)
+	stw      r9, (a3, THREAD_FPREG + 28)
+	fmfvrl   r6, vr4
+	fmfvrh   r7, vr4
+	fmfvrl   r8, vr5
+	fmfvrh   r9, vr5
+	stw      r6, (a3, THREAD_FPREG + 32)
+	stw      r7, (a3, THREAD_FPREG + 36)
+	stw      r8, (a3, THREAD_FPREG + 40)
+	stw      r9, (a3, THREAD_FPREG + 44)
+	fmfvrl   r6, vr6
+	fmfvrh   r7, vr6
+	fmfvrl   r8, vr7
+	fmfvrh   r9, vr7
+	stw      r6, (a3, THREAD_FPREG + 48)
+	stw      r7, (a3, THREAD_FPREG + 52)
+	stw      r8, (a3, THREAD_FPREG + 56)
+	stw      r9, (a3, THREAD_FPREG + 60)
+	fmfvrl   r6, vr8
+	fmfvrh   r7, vr8
+	fmfvrl   r8, vr9
+	fmfvrh   r9, vr9
+	stw      r6, (a3, THREAD_FPREG + 64)
+	stw      r7, (a3, THREAD_FPREG + 68)
+	stw      r8, (a3, THREAD_FPREG + 72)
+	stw      r9, (a3, THREAD_FPREG + 76)
+	fmfvrl   r6, vr10
+	fmfvrh   r7, vr10
+	fmfvrl   r8, vr11
+	fmfvrh   r9, vr11
+	stw      r6, (a3, THREAD_FPREG + 80)
+	stw      r7, (a3, THREAD_FPREG + 84)
+	stw      r8, (a3, THREAD_FPREG + 88)
+	stw      r9, (a3, THREAD_FPREG + 92)
+	fmfvrl   r6, vr12
+	fmfvrh   r7, vr12
+	fmfvrl   r8, vr13
+	fmfvrh   r9, vr13
+	stw      r6, (a3, THREAD_FPREG + 96)
+	stw      r7, (a3, THREAD_FPREG + 100)
+	stw      r8, (a3, THREAD_FPREG + 104)
+	stw      r9, (a3, THREAD_FPREG + 108)
+	fmfvrl   r6, vr14
+	fmfvrh   r7, vr14
+	fmfvrl   r8, vr15
+	fmfvrh   r9, vr15
+	stw      r6, (a3, THREAD_FPREG + 112)
+	stw      r7, (a3, THREAD_FPREG + 116)
+	stw      r8, (a3, THREAD_FPREG + 120)
+	stw      r9, (a3, THREAD_FPREG + 124)
+.endm
+
+.macro  FPU_RESTORE_REGS
+	/* Save FPU control regs task struct */
+	ldw      r6, (a3, THREAD_FCR)
+	ldw      r7, (a3, THREAD_FESR)
+	mtcr     r6, cr<1, 2>
+	mtcr     r7, cr<2, 2>
+	/* restore FPU general regs task struct */
+	ldw      r6, (a3, THREAD_FPREG + 0)
+	ldw      r7, (a3, THREAD_FPREG + 4)
+	ldw      r8, (a3, THREAD_FPREG + 8)
+	ldw      r9, (a3, THREAD_FPREG + 12)
+	fmtvrl   vr0, r6
+	fmtvrh   vr0, r7
+	fmtvrl   vr1, r8
+	fmtvrh   vr1, r9
+	ldw      r6, (a3, THREAD_FPREG + 16)
+	ldw      r7, (a3, THREAD_FPREG + 20)
+	ldw      r8, (a3, THREAD_FPREG + 24)
+	ldw      r9, (a3, THREAD_FPREG + 28)
+	fmtvrl   vr2, r6
+	fmtvrh   vr2, r7
+	fmtvrl   vr3, r8
+	fmtvrh   vr3, r9
+	ldw      r6, (a3, THREAD_FPREG + 32)
+	ldw      r7, (a3, THREAD_FPREG + 36)
+	ldw      r8, (a3, THREAD_FPREG + 40)
+	ldw      r9, (a3, THREAD_FPREG + 44)
+	fmtvrl   vr4, r6
+	fmtvrh   vr4, r7
+	fmtvrl   vr5, r8
+	fmtvrh   vr5, r9
+	ldw      r6, (a3, THREAD_FPREG + 48)
+	ldw      r7, (a3, THREAD_FPREG + 52)
+	ldw      r8, (a3, THREAD_FPREG + 56)
+	ldw      r9, (a3, THREAD_FPREG + 60)
+	fmtvrl   vr6, r6
+	fmtvrh   vr6, r7
+	fmtvrl   vr7, r8
+	fmtvrh   vr7, r9
+	ldw      r6, (a3, THREAD_FPREG + 64)
+	ldw      r7, (a3, THREAD_FPREG + 68)
+	ldw      r8, (a3, THREAD_FPREG + 72)
+	ldw      r9, (a3, THREAD_FPREG + 76)
+	fmtvrl   vr8, r6
+	fmtvrh   vr8, r7
+	fmtvrl   vr9, r8
+	fmtvrh   vr9, r9
+	ldw      r6, (a3, THREAD_FPREG + 80)
+	ldw      r7, (a3, THREAD_FPREG + 84)
+	ldw      r8, (a3, THREAD_FPREG + 88)
+	ldw      r9, (a3, THREAD_FPREG + 92)
+	fmtvrl   vr10, r6
+	fmtvrh   vr10, r7
+	fmtvrl   vr11, r8
+	fmtvrh   vr11, r9
+	ldw      r6, (a3, THREAD_FPREG + 96)
+	ldw      r7, (a3, THREAD_FPREG + 100)
+	ldw      r8, (a3, THREAD_FPREG + 104)
+	ldw      r9, (a3, THREAD_FPREG + 108)
+	fmtvrl   vr12, r6
+	fmtvrh   vr12, r7
+	fmtvrl   vr13, r8
+	fmtvrh   vr13, r9
+	ldw      r6, (a3, THREAD_FPREG + 112)
+	ldw      r7, (a3, THREAD_FPREG + 116)
+	ldw      r8, (a3, THREAD_FPREG + 120)
+	ldw      r9, (a3, THREAD_FPREG + 124)
+	fmtvrl   vr14, r6
+	fmtvrh   vr14, r7
+	fmtvrl   vr15, r8
+	fmtvrh   vr15, r9
+.endm
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_CSKY_FPU_H */
diff --git a/arch/csky/abiv2/inc/abi/reg_ops.h b/arch/csky/abiv2/inc/abi/reg_ops.h
new file mode 100644
index 0000000..7f66bd6
--- /dev/null
+++ b/arch/csky/abiv2/inc/abi/reg_ops.h
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_REG_OPS_H
+#define __ASM_REG_OPS_H
+
+static inline unsigned int mfcr_cpuidrr(void)
+{
+	unsigned int ret;
+	asm volatile(
+		"mfcr %0, cr13\t\n"
+		:"=r"(ret));
+	return ret;
+}
+
+static inline unsigned int mfcr_hint(void)
+{
+	unsigned int ret;
+	asm volatile(
+		"mfcr %0, cr31\t\n"
+		:"=r"(ret));
+	return ret;
+}
+
+static inline unsigned int mfcr_ccr(void)
+{
+	unsigned int ret;
+	asm volatile(
+		"mfcr %0, cr18\t\n"
+		:"=r"(ret));
+	return ret;
+}
+
+static inline unsigned int mfcr_ccr2(void)
+{
+	unsigned int ret;
+	asm volatile(
+		"mfcr %0, cr23\t\n"
+		:"=r"(ret));
+	return ret;
+}
+
+static inline unsigned int mfcr_msa0(void)
+{
+	unsigned int ret;
+	asm volatile(
+		"mfcr %0, cr<30, 15>\t\n"
+		:"=r"(ret));
+	return ret;
+}
+
+static inline void mtcr_msa0(unsigned int value)
+{
+	asm volatile(
+		"mtcr %0, cr<30, 15>\t\n"
+		::"r"(value));
+}
+
+static inline unsigned int mfcr_msa1(void)
+{
+	unsigned int ret;
+	asm volatile(
+		"mfcr %0, cr<31, 15>\t\n"
+		:"=r"(ret));
+	return ret;
+}
+
+static inline void mtcr_msa1(unsigned int value)
+{
+	asm volatile(
+		"mtcr %0, cr<31, 15>\t\n"
+		::"r"(value));
+}
+
+/* read/write user stack pointer */
+static inline unsigned long rdusp(void) {
+	register unsigned long usp;
+	asm volatile("mfcr %0, cr<14, 1> \n\r":"=r" (usp));
+	return usp;
+}
+
+static inline void wrusp(unsigned long usp) {
+	asm volatile("mtcr %0, cr<14, 1> \n\r"::"r" (usp));
+}
+
+#endif /* __ASM_REG_OPS_H */
+
diff --git a/arch/csky/abiv2/inc/abi/regdef.h b/arch/csky/abiv2/inc/abi/regdef.h
new file mode 100644
index 0000000..11bdc3a
--- /dev/null
+++ b/arch/csky/abiv2/inc/abi/regdef.h
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef  __ASM_CSKY_REGDEF_H
+#define  __ASM_CSKY_REGDEF_H
+
+#define syscallid	r7
+#define r11_sig		r11
+
+#define DEFAULT_PSR_VALUE	0x8f000200
+
+#define PTRACE_REGOFF_ABI \
+{ \
+	PT_A0,    PT_A1,     PT_A2,    PT_A3,\
+	PT_REGS0, PT_REGS1,  PT_REGS2, PT_REGS3,\
+	PT_REGS4, PT_REGS5,  PT_REGS6, PT_REGS7,\
+	PT_REGS8, PT_REGS9,  -1,       PT_R15,\
+	PT_R16,   PT_R17,    PT_R18,   PT_R19,\
+	PT_R20,   PT_R21,    PT_R22,   PT_R23,\
+	PT_R24,   PT_R25,    PT_R26,   PT_R27,\
+	PT_R28,   PT_R29,    PT_R30,   PT_R31,\
+	PT_SR,    PT_PC,     PT_RHI,   PT_RLO,\
+}
+
+#define SYSTRACE_SAVENUM	5
+
+#define REGNO_USP		14
+
+#endif /* __ASM_CSKY_REGDEF_H */
diff --git a/arch/csky/include/uapi/asm/byteorder.h b/arch/csky/include/uapi/asm/byteorder.h
new file mode 100644
index 0000000..d254522
--- /dev/null
+++ b/arch/csky/include/uapi/asm/byteorder.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_BYTEORDER_H
+#define __ASM_CSKY_BYTEORDER_H
+
+#if defined(__cskyBE__)
+#include <linux/byteorder/big_endian.h>
+#elif defined(__cskyLE__)
+#include <linux/byteorder/little_endian.h>
+#else
+# error "There is no __cskyBE__, __cskyLE__"
+#endif
+
+#endif /* __ASM_CSKY_BYTEORDER_H */
diff --git a/arch/csky/include/uapi/asm/fcntl.h b/arch/csky/include/uapi/asm/fcntl.h
new file mode 100644
index 0000000..2ee1af2
--- /dev/null
+++ b/arch/csky/include/uapi/asm/fcntl.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_FCNTL_H
+#define __ASM_CSKY_FCNTL_H
+
+#define O_DIRECTORY	040000
+#define O_NOFOLLOW	0100000
+#define O_DIRECT	0200000
+#define O_LARGEFILE	0400000
+
+#include <asm-generic/fcntl.h>
+
+#endif /* __ASM_CSKY_FCNTL_H */
diff --git a/arch/csky/include/uapi/asm/stat.h b/arch/csky/include/uapi/asm/stat.h
new file mode 100644
index 0000000..2273042
--- /dev/null
+++ b/arch/csky/include/uapi/asm/stat.h
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef _CSKY_STAT_H
+#define _CSKY_STAT_H
+
+struct __old_kernel_stat {
+	unsigned short st_dev;
+	unsigned short st_ino;
+	unsigned short st_mode;
+	unsigned short st_nlink;
+	unsigned short st_uid;
+	unsigned short st_gid;
+	unsigned short st_rdev;
+	unsigned long  st_size;
+	unsigned long  st_atime;
+	unsigned long  st_mtime;
+	unsigned long  st_ctime;
+};
+
+#define STAT_HAVE_NSEC 
+
+struct stat {
+#if defined(__cskyBE__)
+	unsigned short st_dev;
+	unsigned short __pad1;
+#else
+	unsigned long  st_dev;
+#endif
+	unsigned long  st_ino;
+	unsigned short st_mode;
+	unsigned short st_nlink;
+	unsigned short st_uid;
+	unsigned short st_gid;
+#if defined(__cskyBE__)
+	unsigned short st_rdev;
+	unsigned short __pad2;
+#else
+	unsigned long  st_rdev;
+#endif
+	unsigned long  st_size;
+	unsigned long  st_blksize;
+	unsigned long  st_blocks;
+	unsigned long  st_atime;
+	unsigned long  st_atime_nsec;
+	unsigned long  st_mtime;
+	unsigned long  st_mtime_nsec;
+	unsigned long  st_ctime;
+	unsigned long  st_ctime_nsec;
+	unsigned long  __unused4;
+	unsigned long  __unused5;
+};
+
+/* This matches struct stat64 in glibc2.1, hence the absolutely
+ * insane amounts of padding around dev_t's.
+ */
+struct stat64 {
+	unsigned long long 	st_dev;
+	unsigned char	__pad0[4];
+
+#define STAT64_HAS_BROKEN_ST_INO	1
+	unsigned long	__st_ino;
+	unsigned int	st_mode;
+	unsigned int	st_nlink;
+
+	unsigned long	st_uid;
+	unsigned long	st_gid;
+
+	unsigned long long	st_rdev;
+	unsigned char	__pad3[4];
+
+	long long		st_size;
+	unsigned long	st_blksize;
+	unsigned long long	st_blocks;		/* Number 512-byte blocks allocated. */
+
+	unsigned long   st_atime;
+	unsigned long   st_atime_nsec;
+
+	unsigned long	st_mtime;
+	unsigned long   st_mtime_nsec;
+
+	unsigned long	st_ctime;
+	unsigned long   st_ctime_nsec;
+	unsigned long long	st_ino;
+};
+
+#endif /* _CSKY_STAT_H */
-- 
2.7.4
