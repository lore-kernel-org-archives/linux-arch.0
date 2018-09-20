From: Vincent Chen <vincentc@andestech.com>
Subject: [PATCH 2/5] nds32: Support FP emulation
Date: Thu, 20 Sep 2018 10:46:19 +0800
Message-ID: <1537411582-23723-3-git-send-email-vincentc@andestech.com>
References: <1537411582-23723-1-git-send-email-vincentc@andestech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537411582-23723-1-git-send-email-vincentc@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, deanbo422@gmail.com, vincentc@andestech.com
List-Id: linux-arch.vger.kernel.org

  Andes FPU hardware does not support denormalized number handling.
From Andes FPU spec, FPU generates a denorm input to require kernel
to deal with this instrution operation when encountering a denormalized
operand. Hence an emulator for nds32 FPU ISA in kernel is needed to
satisfy the requirement.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
---
 arch/nds32/Makefile                     |    1 +
 arch/nds32/include/asm/fpu.h            |    1 +
 arch/nds32/include/asm/fpuemu.h         |   32 +++
 arch/nds32/include/asm/nds32_fpu_inst.h |  109 ++++++++++
 arch/nds32/include/asm/sfp-machine.h    |  158 ++++++++++++++
 arch/nds32/kernel/fpu.c                 |   31 +++-
 arch/nds32/math-emu/Makefile            |    7 +
 arch/nds32/math-emu/faddd.c             |   24 ++
 arch/nds32/math-emu/fadds.c             |   24 ++
 arch/nds32/math-emu/fcmpd.c             |   24 ++
 arch/nds32/math-emu/fcmps.c             |   24 ++
 arch/nds32/math-emu/fd2s.c              |   22 ++
 arch/nds32/math-emu/fdivd.c             |   27 +++
 arch/nds32/math-emu/fdivs.c             |   26 +++
 arch/nds32/math-emu/fmuld.c             |   23 ++
 arch/nds32/math-emu/fmuls.c             |   23 ++
 arch/nds32/math-emu/fnegd.c             |   21 ++
 arch/nds32/math-emu/fnegs.c             |   21 ++
 arch/nds32/math-emu/fpuemu.c            |  361 +++++++++++++++++++++++++++++++
 arch/nds32/math-emu/fs2d.c              |   23 ++
 arch/nds32/math-emu/fsqrtd.c            |   21 ++
 arch/nds32/math-emu/fsqrts.c            |   21 ++
 arch/nds32/math-emu/fsubd.c             |   27 +++
 arch/nds32/math-emu/fsubs.c             |   27 +++
 24 files changed, 1073 insertions(+), 5 deletions(-)
 create mode 100644 arch/nds32/include/asm/fpuemu.h
 create mode 100644 arch/nds32/include/asm/nds32_fpu_inst.h
 create mode 100644 arch/nds32/include/asm/sfp-machine.h
 create mode 100644 arch/nds32/math-emu/Makefile
 create mode 100644 arch/nds32/math-emu/faddd.c
 create mode 100644 arch/nds32/math-emu/fadds.c
 create mode 100644 arch/nds32/math-emu/fcmpd.c
 create mode 100644 arch/nds32/math-emu/fcmps.c
 create mode 100644 arch/nds32/math-emu/fd2s.c
 create mode 100644 arch/nds32/math-emu/fdivd.c
 create mode 100644 arch/nds32/math-emu/fdivs.c
 create mode 100644 arch/nds32/math-emu/fmuld.c
 create mode 100644 arch/nds32/math-emu/fmuls.c
 create mode 100644 arch/nds32/math-emu/fnegd.c
 create mode 100644 arch/nds32/math-emu/fnegs.c
 create mode 100644 arch/nds32/math-emu/fpuemu.c
 create mode 100644 arch/nds32/math-emu/fs2d.c
 create mode 100644 arch/nds32/math-emu/fsqrtd.c
 create mode 100644 arch/nds32/math-emu/fsqrts.c
 create mode 100644 arch/nds32/math-emu/fsubd.c
 create mode 100644 arch/nds32/math-emu/fsubs.c

diff --git a/arch/nds32/Makefile b/arch/nds32/Makefile
index 599ee62..e034e30 100644
--- a/arch/nds32/Makefile
+++ b/arch/nds32/Makefile
@@ -36,6 +36,7 @@ export	TEXTADDR
 
 # If we have a machine-specific directory, then include it in the build.
 core-y				+= arch/nds32/kernel/ arch/nds32/mm/
+core-$(CONFIG_FPU)              += arch/nds32/math-emu/
 libs-y				+= arch/nds32/lib/
 
 ifneq '$(CONFIG_NDS32_BUILTIN_DTB)' '""'
diff --git a/arch/nds32/include/asm/fpu.h b/arch/nds32/include/asm/fpu.h
index 3132400..10df5f0 100644
--- a/arch/nds32/include/asm/fpu.h
+++ b/arch/nds32/include/asm/fpu.h
@@ -13,6 +13,7 @@
 extern void save_fpu(struct task_struct *__tsk);
 extern void fpload(const struct fpu_struct *fpregs);
 extern bool do_fpu_exception(unsigned int subtype, struct pt_regs *regs);
+extern int do_fpuemu(struct pt_regs *regs, struct fpu_struct *fpu);
 
 #define test_tsk_fpu(regs)	(regs->fucop_ctl & FUCOP_CTL_mskCP0EN)
 
diff --git a/arch/nds32/include/asm/fpuemu.h b/arch/nds32/include/asm/fpuemu.h
new file mode 100644
index 0000000..c4bd0c7
--- /dev/null
+++ b/arch/nds32/include/asm/fpuemu.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2005-2018 Andes Technology Corporation */
+
+#ifndef __ARCH_NDS32_FPUEMU_H
+#define __ARCH_NDS32_FPUEMU_H
+
+/*
+ * single precision
+ */
+
+void fadds(void *ft, void *fa, void *fb);
+void fsubs(void *ft, void *fa, void *fb);
+void fmuls(void *ft, void *fa, void *fb);
+void fdivs(void *ft, void *fa, void *fb);
+void fs2d(void *ft, void *fa);
+void fsqrts(void *ft, void *fa);
+void fnegs(void *ft, void *fa);
+int fcmps(void *ft, void *fa, void *fb, int cop);
+
+/*
+ * double precision
+ */
+void faddd(void *ft, void *fa, void *fb);
+void fsubd(void *ft, void *fa, void *fb);
+void fmuld(void *ft, void *fa, void *fb);
+void fdivd(void *ft, void *fa, void *fb);
+void fsqrtd(void *ft, void *fa);
+void fd2s(void *ft, void *fa);
+void fnegd(void *ft, void *fa);
+int fcmpd(void *ft, void *fa, void *fb, int cop);
+
+#endif /* __ARCH_NDS32_FPUEMU_H */
diff --git a/arch/nds32/include/asm/nds32_fpu_inst.h b/arch/nds32/include/asm/nds32_fpu_inst.h
new file mode 100644
index 0000000..1e4b86a
--- /dev/null
+++ b/arch/nds32/include/asm/nds32_fpu_inst.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2005-2018 Andes Technology Corporation */
+
+#ifndef __NDS32_FPU_INST_H
+#define __NDS32_FPU_INST_H
+
+#define cop0_op	0x35
+
+/*
+ * COP0 field of opcodes.
+ */
+#define fs1_op	0x0
+#define fs2_op  0x4
+#define fd1_op  0x8
+#define fd2_op  0xc
+
+/*
+ * FS1 opcode.
+ */
+enum fs1 {
+	fadds_op, fsubs_op, fcpynss_op, fcpyss_op,
+	fmadds_op, fmsubs_op, fcmovns_op, fcmovzs_op,
+	fnmadds_op, fnmsubs_op,
+	fmuls_op = 0xc, fdivs_op,
+	fs1_f2op_op = 0xf
+};
+
+/*
+ * FS1/F2OP opcode.
+ */
+enum fs1_f2 {
+	fs2d_op, fsqrts_op,
+	fui2s_op = 0x8, fsi2s_op = 0xc,
+	fs2ui_op = 0x10, fs2ui_z_op = 0x14,
+	fs2si_op = 0x18, fs2si_z_op = 0x1c
+};
+
+/*
+ * FS2 opcode.
+ */
+enum fs2 {
+	fcmpeqs_op, fcmpeqs_e_op, fcmplts_op, fcmplts_e_op,
+	fcmples_op, fcmples_e_op, fcmpuns_op, fcmpuns_e_op
+};
+
+/*
+ * FD1 opcode.
+ */
+enum fd1 {
+	faddd_op, fsubd_op, fcpynsd_op, fcpysd_op,
+	fmaddd_op, fmsubd_op, fcmovnd_op, fcmovzd_op,
+	fnmaddd_op, fnmsubd_op,
+	fmuld_op = 0xc, fdivd_op, fd1_f2op_op = 0xf
+};
+
+/*
+ * FD1/F2OP opcode.
+ */
+enum fd1_f2 {
+	fd2s_op, fsqrtd_op,
+	fui2d_op = 0x8, fsi2d_op = 0xc,
+	fd2ui_op = 0x10, fd2ui_z_op = 0x14,
+	fd2si_op = 0x18, fd2si_z_op = 0x1c
+};
+
+/*
+ * FD2 opcode.
+ */
+enum fd2 {
+	fcmpeqd_op, fcmpeqd_e_op, fcmpltd_op, fcmpltd_e_op,
+	fcmpled_op, fcmpled_e_op, fcmpund_op, fcmpund_e_op
+};
+
+#define NDS32Insn(x) x
+
+#define I_OPCODE_off			25
+#define NDS32Insn_OPCODE(x)		(NDS32Insn(x) >> I_OPCODE_off)
+
+#define I_OPCODE_offRt			20
+#define I_OPCODE_mskRt			(0x1fUL << I_OPCODE_offRt)
+#define NDS32Insn_OPCODE_Rt(x) \
+	((NDS32Insn(x) & I_OPCODE_mskRt) >> I_OPCODE_offRt)
+
+#define I_OPCODE_offRa			15
+#define I_OPCODE_mskRa			(0x1fUL << I_OPCODE_offRa)
+#define NDS32Insn_OPCODE_Ra(x) \
+	((NDS32Insn(x) & I_OPCODE_mskRa) >> I_OPCODE_offRa)
+
+#define I_OPCODE_offRb			10
+#define I_OPCODE_mskRb			(0x1fUL << I_OPCODE_offRb)
+#define NDS32Insn_OPCODE_Rb(x) \
+	((NDS32Insn(x) & I_OPCODE_mskRb) >> I_OPCODE_offRb)
+
+#define I_OPCODE_offbit1014		10
+#define I_OPCODE_mskbit1014		(0x1fUL << I_OPCODE_offbit1014)
+#define NDS32Insn_OPCODE_BIT1014(x) \
+	((NDS32Insn(x) & I_OPCODE_mskbit1014) >> I_OPCODE_offbit1014)
+
+#define I_OPCODE_offbit69		6
+#define I_OPCODE_mskbit69		(0xfUL << I_OPCODE_offbit69)
+#define NDS32Insn_OPCODE_BIT69(x) \
+	((NDS32Insn(x) & I_OPCODE_mskbit69) >> I_OPCODE_offbit69)
+
+#define I_OPCODE_offCOP0		0
+#define I_OPCODE_mskCOP0		(0x3fUL << I_OPCODE_offCOP0)
+#define NDS32Insn_OPCODE_COP0(x) \
+	((NDS32Insn(x) & I_OPCODE_mskCOP0) >> I_OPCODE_offCOP0)
+
+#endif /* __NDS32_FPU_INST_H */
diff --git a/arch/nds32/include/asm/sfp-machine.h b/arch/nds32/include/asm/sfp-machine.h
new file mode 100644
index 0000000..b1a5caa
--- /dev/null
+++ b/arch/nds32/include/asm/sfp-machine.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2005-2018 Andes Technology Corporation */
+
+#include <asm/bitfield.h>
+
+#define _FP_W_TYPE_SIZE		32
+#define _FP_W_TYPE		unsigned long
+#define _FP_WS_TYPE		signed long
+#define _FP_I_TYPE		long
+
+#define __ll_B ((UWtype) 1 << (W_TYPE_SIZE / 2))
+#define __ll_lowpart(t) ((UWtype) (t) & (__ll_B - 1))
+#define __ll_highpart(t) ((UWtype) (t) >> (W_TYPE_SIZE / 2))
+
+#define _FP_MUL_MEAT_S(R, X, Y)				\
+	_FP_MUL_MEAT_1_wide(_FP_WFRACBITS_S, R, X, Y, umul_ppmm)
+#define _FP_MUL_MEAT_D(R, X, Y)				\
+	_FP_MUL_MEAT_2_wide(_FP_WFRACBITS_D, R, X, Y, umul_ppmm)
+#define _FP_MUL_MEAT_Q(R, X, Y)				\
+	_FP_MUL_MEAT_4_wide(_FP_WFRACBITS_Q, R, X, Y, umul_ppmm)
+
+#define _FP_MUL_MEAT_DW_S(R, X, Y)			\
+	_FP_MUL_MEAT_DW_1_wide(_FP_WFRACBITS_S, R, X, Y, umul_ppmm)
+#define _FP_MUL_MEAT_DW_D(R, X, Y)			\
+	_FP_MUL_MEAT_DW_2_wide(_FP_WFRACBITS_D, R, X, Y, umul_ppmm)
+
+#define _FP_DIV_MEAT_S(R, X, Y)	_FP_DIV_MEAT_1_udiv_norm(S, R, X, Y)
+#define _FP_DIV_MEAT_D(R, X, Y)	_FP_DIV_MEAT_2_udiv(D, R, X, Y)
+
+#define _FP_NANFRAC_S		((_FP_QNANBIT_S << 1) - 1)
+#define _FP_NANFRAC_D		((_FP_QNANBIT_D << 1) - 1), -1
+#define _FP_NANFRAC_Q		((_FP_QNANBIT_Q << 1) - 1), -1, -1, -1
+#define _FP_NANSIGN_S		0
+#define _FP_NANSIGN_D		0
+#define _FP_NANSIGN_Q		0
+
+#define _FP_KEEPNANFRACP 1
+#define _FP_QNANNEGATEDP 0
+
+#define _FP_CHOOSENAN(fs, wc, R, X, Y, OP)			\
+do {								\
+	if ((_FP_FRAC_HIGH_RAW_##fs(X) & _FP_QNANBIT_##fs)	\
+	  && !(_FP_FRAC_HIGH_RAW_##fs(Y) & _FP_QNANBIT_##fs)) { \
+		R##_s = Y##_s;					\
+		_FP_FRAC_COPY_##wc(R, Y);			\
+	} else {						\
+		R##_s = X##_s;					\
+		_FP_FRAC_COPY_##wc(R, X);			\
+	}							\
+	R##_c = FP_CLS_NAN;					\
+} while (0)
+
+#define __FPU_FPCSR	(current->thread.fpu.fpcsr)
+
+/* Obtain the current rounding mode. */
+#define FP_ROUNDMODE                    \
+({                                      \
+	__FPU_FPCSR & FPCSR_mskRM;      \
+})
+
+#define FP_RND_NEAREST		0
+#define FP_RND_PINF		1
+#define FP_RND_MINF		2
+#define FP_RND_ZERO		3
+
+#define FP_EX_INVALID		FPCSR_mskIVO
+#define FP_EX_DIVZERO		FPCSR_mskDBZ
+#define FP_EX_OVERFLOW		FPCSR_mskOVF
+#define FP_EX_UNDERFLOW		FPCSR_mskUDF
+#define FP_EX_INEXACT		FPCSR_mskIEX
+
+#define SF_CEQ	2
+#define SF_CLT	1
+#define SF_CGT	3
+#define SF_CUN	4
+
+#include <asm/byteorder.h>
+
+#ifdef __BIG_ENDIAN__
+#define __BYTE_ORDER __BIG_ENDIAN
+#define __LITTLE_ENDIAN 0
+#else
+#define __BYTE_ORDER __LITTLE_ENDIAN
+#define __BIG_ENDIAN 0
+#endif
+
+#define abort() do { } while (0)
+#define umul_ppmm(w1, w0, u, v)						\
+do {									\
+	UWtype __x0, __x1, __x2, __x3;                                  \
+	UHWtype __ul, __vl, __uh, __vh;                                 \
+									\
+	__ul = __ll_lowpart(u);						\
+	__uh = __ll_highpart(u);					\
+	__vl = __ll_lowpart(v);						\
+	__vh = __ll_highpart(v);					\
+									\
+	__x0 = (UWtype) __ul * __vl;                                    \
+	__x1 = (UWtype) __ul * __vh;                                    \
+	__x2 = (UWtype) __uh * __vl;                                    \
+	__x3 = (UWtype) __uh * __vh;                                    \
+									\
+	__x1 += __ll_highpart(__x0);					\
+	__x1 += __x2;							\
+	if (__x1 < __x2)						\
+		__x3 += __ll_B;						\
+									\
+	(w1) = __x3 + __ll_highpart(__x1);				\
+	(w0) = __ll_lowpart(__x1) * __ll_B + __ll_lowpart(__x0);	\
+} while (0)
+
+#define add_ssaaaa(sh, sl, ah, al, bh, bl) \
+do { \
+	UWtype __x; \
+	__x = (al) + (bl); \
+	(sh) = (ah) + (bh) + (__x < (al)); \
+	(sl) = __x; \
+} while (0)
+
+#define sub_ddmmss(sh, sl, ah, al, bh, bl) \
+do { \
+	UWtype __x; \
+	__x = (al) - (bl); \
+	(sh) = (ah) - (bh) - (__x > (al)); \
+	(sl) = __x; \
+} while (0)
+
+#define udiv_qrnnd(q, r, n1, n0, d)				\
+do {								\
+	UWtype __d1, __d0, __q1, __q0, __r1, __r0, __m;		\
+	__d1 = __ll_highpart(d);				\
+	__d0 = __ll_lowpart(d);					\
+								\
+	__r1 = (n1) % __d1;					\
+	__q1 = (n1) / __d1;					\
+	__m = (UWtype) __q1 * __d0;				\
+	__r1 = __r1 * __ll_B | __ll_highpart(n0);		\
+	if (__r1 < __m)	{					\
+		__q1--, __r1 += (d);				\
+		if (__r1 >= (d))				\
+			if (__r1 < __m)				\
+				__q1--, __r1 += (d);		\
+	}							\
+	__r1 -= __m;						\
+	__r0 = __r1 % __d1;					\
+	__q0 = __r1 / __d1;					\
+	__m = (UWtype) __q0 * __d0;				\
+	__r0 = __r0 * __ll_B | __ll_lowpart(n0);		\
+	if (__r0 < __m)	{					\
+		__q0--, __r0 += (d);				\
+		if (__r0 >= (d))				\
+			if (__r0 < __m)				\
+				__q0--, __r0 += (d);		\
+	}							\
+	__r0 -= __m;						\
+	(q) = (UWtype) __q1 * __ll_B | __q0;			\
+	(r) = __r0;						\
+} while (0)
diff --git a/arch/nds32/kernel/fpu.c b/arch/nds32/kernel/fpu.c
index 7353746..75f611b 100644
--- a/arch/nds32/kernel/fpu.c
+++ b/arch/nds32/kernel/fpu.c
@@ -171,10 +171,10 @@ inline void fill_sigfpe_signo(unsigned int fpcsr, int *signo)
 {
 	if (fpcsr & FPCSR_mskOVFT)
 		*signo = FPE_FLTOVF;
-	else if (fpcsr & FPCSR_mskUDFT)
-		*signo = FPE_FLTUND;
 	else if (fpcsr & FPCSR_mskIVOT)
 		*signo = FPE_FLTINV;
+	else if (fpcsr & FPCSR_mskUDFT)
+		*signo = FPE_FLTUND;
 	else if (fpcsr & FPCSR_mskDBZT)
 		*signo = FPE_FLTDIV;
 	else if (fpcsr & FPCSR_mskIEXT)
@@ -189,16 +189,37 @@ inline void handle_fpu_exception(struct pt_regs *regs)
 	lose_fpu();
 	fpcsr = current->thread.fpu.fpcsr;
 
-	if (fpcsr & FPCSR_mskRIT) {
+	if (fpcsr & FPCSR_mskDNIT) {
+		si_signo = do_fpuemu(regs, &current->thread.fpu);
+		fpcsr = current->thread.fpu.fpcsr;
+		if (!si_signo)
+			goto done;
+	} else if (fpcsr & FPCSR_mskRIT) {
 		if (!user_mode(regs))
 			do_exit(SIGILL);
 		si_signo = SIGILL;
+	}
+
+
+	switch (si_signo) {
+	case SIGFPE:
+		fill_sigfpe_signo(fpcsr, &si_code);
+		break;
+	case SIGILL:
 		show_regs(regs);
 		si_code = ILL_COPROC;
-	} else
-		fill_sigfpe_signo(fpcsr, &si_code);
+		break;
+	case SIGBUS:
+		si_code = BUS_ADRERR;
+		break;
+	default:
+		break;
+	}
+
 	force_sig_fault(si_signo, si_code,
 			(void __user *)instruction_pointer(regs), current);
+done:
+	own_fpu();
 }
 
 bool do_fpu_exception(unsigned int subtype, struct pt_regs *regs)
diff --git a/arch/nds32/math-emu/Makefile b/arch/nds32/math-emu/Makefile
new file mode 100644
index 0000000..947fe0c
--- /dev/null
+++ b/arch/nds32/math-emu/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for the Linux/nds32 kernel FPU emulation.
+#
+
+obj-y	:= fpuemu.o \
+	   fdivd.o fmuld.o fsubd.o faddd.o fs2d.o fsqrtd.o fcmpd.o fnegs.o \
+	   fdivs.o fmuls.o fsubs.o fadds.o fd2s.o fsqrts.o fcmps.o fnegd.o
diff --git a/arch/nds32/math-emu/faddd.c b/arch/nds32/math-emu/faddd.c
new file mode 100644
index 0000000..f7fd4e3
--- /dev/null
+++ b/arch/nds32/math-emu/faddd.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2018 Andes Technology Corporation
+#include <linux/uaccess.h>
+
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+void faddd(void *ft, void *fa, void *fb)
+{
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, fa);
+	FP_UNPACK_DP(B, fb);
+
+	FP_ADD_D(R, A, B);
+
+	FP_PACK_DP(ft, R);
+
+	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+
+}
diff --git a/arch/nds32/math-emu/fadds.c b/arch/nds32/math-emu/fadds.c
new file mode 100644
index 0000000..f5af6ca
--- /dev/null
+++ b/arch/nds32/math-emu/fadds.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2018 Andes Technology Corporation
+#include <linux/uaccess.h>
+
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/single.h>
+void fadds(void *ft, void *fa, void *fb)
+{
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, fa);
+	FP_UNPACK_SP(B, fb);
+
+	FP_ADD_S(R, A, B);
+
+	FP_PACK_SP(ft, R);
+
+	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+
+}
diff --git a/arch/nds32/math-emu/fcmpd.c b/arch/nds32/math-emu/fcmpd.c
new file mode 100644
index 0000000..0ea225a
--- /dev/null
+++ b/arch/nds32/math-emu/fcmpd.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2018 Andes Technology Corporation
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+int fcmpd(void *ft, void *fa, void *fb, int cmpop)
+{
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_EX;
+	long cmp;
+
+	FP_UNPACK_DP(A, fa);
+	FP_UNPACK_DP(B, fb);
+
+	FP_CMP_D(cmp, A, B, SF_CUN);
+	cmp += 2;
+	if (cmp == SF_CGT)
+		*(long *)ft = 0;
+	else
+		*(long *)ft = (cmp & cmpop) ? 1 : 0;
+
+	return 0;
+}
diff --git a/arch/nds32/math-emu/fcmps.c b/arch/nds32/math-emu/fcmps.c
new file mode 100644
index 0000000..6814807
--- /dev/null
+++ b/arch/nds32/math-emu/fcmps.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2018 Andes Technology Corporation
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/single.h>
+int fcmps(void *ft, void *fa, void *fb, int cmpop)
+{
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_EX;
+	long cmp;
+
+	FP_UNPACK_SP(A, fa);
+	FP_UNPACK_SP(B, fb);
+
+	FP_CMP_S(cmp, A, B, SF_CUN);
+	cmp += 2;
+	if (cmp == SF_CGT)
+		*(int *)ft = 0x0;
+	else
+		*(int *)ft = (cmp & cmpop) ? 0x1 : 0x0;
+
+	return 0;
+}
diff --git a/arch/nds32/math-emu/fd2s.c b/arch/nds32/math-emu/fd2s.c
new file mode 100644
index 0000000..1328371
--- /dev/null
+++ b/arch/nds32/math-emu/fd2s.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2018 Andes Technology Corporation
+#include <linux/uaccess.h>
+
+#include <asm/sfp-machine.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
+#include <math-emu/soft-fp.h>
+void fd2s(void *ft, void *fa)
+{
+	FP_DECL_D(A);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, fa);
+
+	FP_CONV(S, D, 1, 2, R, A);
+
+	FP_PACK_SP(ft, R);
+
+	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+}
diff --git a/arch/nds32/math-emu/fdivd.c b/arch/nds32/math-emu/fdivd.c
new file mode 100644
index 0000000..458e7e9
--- /dev/null
+++ b/arch/nds32/math-emu/fdivd.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2018 Andes Technology Corporation
+
+#include <linux/uaccess.h>
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+
+void fdivd(void *ft, void *fa, void *fb)
+{
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, fa);
+	FP_UNPACK_DP(B, fb);
+
+	if (B_c == FP_CLS_ZERO && A_c != FP_CLS_ZERO)
+		FP_SET_EXCEPTION(FP_EX_DIVZERO);
+
+	FP_DIV_D(R, A, B);
+
+	FP_PACK_DP(ft, R);
+
+	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+}
diff --git a/arch/nds32/math-emu/fdivs.c b/arch/nds32/math-emu/fdivs.c
new file mode 100644
index 0000000..c7d2021
--- /dev/null
+++ b/arch/nds32/math-emu/fdivs.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2018 Andes Technology Corporation
+#include <linux/uaccess.h>
+
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/single.h>
+void fdivs(void *ft, void *fa, void *fb)
+{
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, fa);
+	FP_UNPACK_SP(B, fb);
+
+	if (B_c == FP_CLS_ZERO && A_c != FP_CLS_ZERO)
+		FP_SET_EXCEPTION(FP_EX_DIVZERO);
+
+	FP_DIV_S(R, A, B);
+
+	FP_PACK_SP(ft, R);
+
+	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+}
diff --git a/arch/nds32/math-emu/fmuld.c b/arch/nds32/math-emu/fmuld.c
new file mode 100644
index 0000000..f3c77a4
--- /dev/null
+++ b/arch/nds32/math-emu/fmuld.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2018 Andes Technology Corporation
+#include <linux/uaccess.h>
+
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+void fmuld(void *ft, void *fa, void *fb)
+{
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, fa);
+	FP_UNPACK_DP(B, fb);
+
+	FP_MUL_D(R, A, B);
+
+	FP_PACK_DP(ft, R);
+
+	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+}
diff --git a/arch/nds32/math-emu/fmuls.c b/arch/nds32/math-emu/fmuls.c
new file mode 100644
index 0000000..cf150df
--- /dev/null
+++ b/arch/nds32/math-emu/fmuls.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2018 Andes Technology Corporation
+#include <linux/uaccess.h>
+
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/single.h>
+void fmuls(void *ft, void *fa, void *fb)
+{
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, fa);
+	FP_UNPACK_SP(B, fb);
+
+	FP_MUL_S(R, A, B);
+
+	FP_PACK_SP(ft, R);
+
+	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+}
diff --git a/arch/nds32/math-emu/fnegd.c b/arch/nds32/math-emu/fnegd.c
new file mode 100644
index 0000000..de7ea6a
--- /dev/null
+++ b/arch/nds32/math-emu/fnegd.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2018 Andes Technology Corporation
+#include <linux/uaccess.h>
+
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+void fnegd(void *ft, void *fa)
+{
+	FP_DECL_D(A);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, fa);
+
+	FP_NEG_D(R, A);
+
+	FP_PACK_DP(ft, R);
+
+	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+}
diff --git a/arch/nds32/math-emu/fnegs.c b/arch/nds32/math-emu/fnegs.c
new file mode 100644
index 0000000..07270b3
--- /dev/null
+++ b/arch/nds32/math-emu/fnegs.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2018 Andes Technology Corporation
+#include <linux/uaccess.h>
+
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/single.h>
+void fnegs(void *ft, void *fa)
+{
+	FP_DECL_S(A);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, fa);
+
+	FP_NEG_S(R, A);
+
+	FP_PACK_SP(ft, R);
+
+	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+}
diff --git a/arch/nds32/math-emu/fpuemu.c b/arch/nds32/math-emu/fpuemu.c
new file mode 100644
index 0000000..4d88135
--- /dev/null
+++ b/arch/nds32/math-emu/fpuemu.c
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2018 Andes Technology Corporation
+
+#include <asm/bitfield.h>
+#include <asm/uaccess.h>
+#include <asm/sfp-machine.h>
+#include <asm/fpuemu.h>
+#include <asm/nds32_fpu_inst.h>
+
+#define DPFROMREG(dp, x) (dp = (void *)((unsigned long *)fpu_reg + 2*x))
+#ifdef __NDS32_EL__
+#define SPFROMREG(sp, x)\
+	((sp) = (void *)((unsigned long *)fpu_reg + (x^1)))
+#else
+#define SPFROMREG(sp, x) ((sp) = (void *)((unsigned long *)fpu_reg + x))
+#endif
+
+#define DEF3OP(name, p, f1, f2) \
+void fpemu_##name##p(void *ft, void *fa, void *fb) \
+{ \
+	f1(fa, fa, fb); \
+	f2(ft, ft, fa); \
+}
+
+#define DEF3OPNEG(name, p, f1, f2, f3) \
+void fpemu_##name##p(void *ft, void *fa, void *fb) \
+{ \
+	f1(fa, fa, fb); \
+	f2(ft, ft, fa); \
+	f3(ft, ft); \
+}
+DEF3OP(fmadd, s, fmuls, fadds);
+DEF3OP(fmsub, s, fmuls, fsubs);
+DEF3OP(fmadd, d, fmuld, faddd);
+DEF3OP(fmsub, d, fmuld, fsubd);
+DEF3OPNEG(fnmadd, s, fmuls, fadds, fnegs);
+DEF3OPNEG(fnmsub, s, fmuls, fsubs, fnegs);
+DEF3OPNEG(fnmadd, d, fmuld, faddd, fnegd);
+DEF3OPNEG(fnmsub, d, fmuld, fsubd, fnegd);
+
+static const unsigned char cmptab[8] = {
+	SF_CEQ,
+	SF_CEQ,
+	SF_CLT,
+	SF_CLT,
+	SF_CLT | SF_CEQ,
+	SF_CLT | SF_CEQ,
+	SF_CUN,
+	SF_CUN
+};
+
+enum ARGTYPE {
+	S1S = 1,
+	S2S,
+	S1D,
+	CS,
+	D1D,
+	D2D,
+	D1S,
+	CD
+};
+union func_t {
+	void (*t)(void *ft, void *fa, void *fb);
+	void (*b)(void *ft, void *fa);
+};
+/*
+ * Emulate a single FPU arithmetic instruction.
+ */
+static int fpu_emu(struct fpu_struct *fpu_reg, unsigned long insn)
+{
+	int rfmt;		/* resulting format */
+	union func_t func;
+	int ftype = 0;
+
+	switch (rfmt = NDS32Insn_OPCODE_COP0(insn)) {
+	case fs1_op:{
+			switch (NDS32Insn_OPCODE_BIT69(insn)) {
+			case fadds_op:
+				func.t = fadds;
+				ftype = S2S;
+				break;
+			case fsubs_op:
+				func.t = fsubs;
+				ftype = S2S;
+				break;
+			case fmadds_op:
+				func.t = fpemu_fmadds;
+				ftype = S2S;
+				break;
+			case fmsubs_op:
+				func.t = fpemu_fmsubs;
+				ftype = S2S;
+				break;
+			case fnmadds_op:
+				func.t = fpemu_fnmadds;
+				ftype = S2S;
+				break;
+			case fnmsubs_op:
+				func.t = fpemu_fnmsubs;
+				ftype = S2S;
+				break;
+			case fmuls_op:
+				func.t = fmuls;
+				ftype = S2S;
+				break;
+			case fdivs_op:
+				func.t = fdivs;
+				ftype = S2S;
+				break;
+			case fs1_f2op_op:
+				switch (NDS32Insn_OPCODE_BIT1014(insn)) {
+				case fs2d_op:
+					func.b = fs2d;
+					ftype = S1D;
+					break;
+				case fsqrts_op:
+					func.b = fsqrts;
+					ftype = S1S;
+					break;
+				default:
+					return SIGILL;
+				}
+				break;
+			default:
+				return SIGILL;
+			}
+			break;
+		}
+	case fs2_op:
+		switch (NDS32Insn_OPCODE_BIT69(insn)) {
+		case fcmpeqs_op:
+		case fcmpeqs_e_op:
+		case fcmplts_op:
+		case fcmplts_e_op:
+		case fcmples_op:
+		case fcmples_e_op:
+		case fcmpuns_op:
+		case fcmpuns_e_op:
+			ftype = CS;
+			break;
+		default:
+			return SIGILL;
+		}
+		break;
+	case fd1_op:{
+			switch (NDS32Insn_OPCODE_BIT69(insn)) {
+			case faddd_op:
+				func.t = faddd;
+				ftype = D2D;
+				break;
+			case fsubd_op:
+				func.t = fsubd;
+				ftype = D2D;
+				break;
+			case fmaddd_op:
+				func.t = fpemu_fmaddd;
+				ftype = D2D;
+				break;
+			case fmsubd_op:
+				func.t = fpemu_fmsubd;
+				ftype = D2D;
+				break;
+			case fnmaddd_op:
+				func.t = fpemu_fnmaddd;
+				ftype = D2D;
+				break;
+			case fnmsubd_op:
+				func.t = fpemu_fnmsubd;
+				ftype = D2D;
+				break;
+			case fmuld_op:
+				func.t = fmuld;
+				ftype = D2D;
+				break;
+			case fdivd_op:
+				func.t = fdivd;
+				ftype = D2D;
+				break;
+			case fd1_f2op_op:
+				switch (NDS32Insn_OPCODE_BIT1014(insn)) {
+				case fd2s_op:
+					func.b = fd2s;
+					ftype = D1S;
+					break;
+				case fsqrtd_op:
+					func.b = fsqrtd;
+					ftype = D1D;
+					break;
+				default:
+					return SIGILL;
+				}
+				break;
+			default:
+				return SIGILL;
+
+			}
+			break;
+		}
+
+	case fd2_op:
+		switch (NDS32Insn_OPCODE_BIT69(insn)) {
+		case fcmpeqd_op:
+		case fcmpeqd_e_op:
+		case fcmpltd_op:
+		case fcmpltd_e_op:
+		case fcmpled_op:
+		case fcmpled_e_op:
+		case fcmpund_op:
+		case fcmpund_e_op:
+			ftype = CD;
+			break;
+		default:
+			return SIGILL;
+		}
+		break;
+
+	default:
+		return SIGILL;
+	}
+
+	switch (ftype) {
+	case S1S:{
+			void *ft, *fa;
+
+			SPFROMREG(ft, NDS32Insn_OPCODE_Rt(insn));
+			SPFROMREG(fa, NDS32Insn_OPCODE_Ra(insn));
+			func.b(ft, fa);
+			break;
+		}
+	case S2S:{
+			void *ft, *fa, *fb;
+
+			SPFROMREG(ft, NDS32Insn_OPCODE_Rt(insn));
+			SPFROMREG(fa, NDS32Insn_OPCODE_Ra(insn));
+			SPFROMREG(fb, NDS32Insn_OPCODE_Rb(insn));
+			func.t(ft, fa, fb);
+			break;
+		}
+	case S1D:{
+			void *ft, *fa;
+
+			DPFROMREG(ft, NDS32Insn_OPCODE_Rt(insn));
+			SPFROMREG(fa, NDS32Insn_OPCODE_Ra(insn));
+			func.b(ft, fa);
+			break;
+		}
+	case CS:{
+			unsigned int cmpop = NDS32Insn_OPCODE_BIT69(insn);
+			void *ft, *fa, *fb;
+
+			SPFROMREG(ft, NDS32Insn_OPCODE_Rt(insn));
+			SPFROMREG(fa, NDS32Insn_OPCODE_Ra(insn));
+			SPFROMREG(fb, NDS32Insn_OPCODE_Rb(insn));
+			if (cmpop < 0x8) {
+				cmpop = cmptab[cmpop];
+				fcmps(ft, fa, fb, cmpop);
+			} else
+				return SIGILL;
+			break;
+		}
+	case D1D:{
+			void *ft, *fa;
+
+			DPFROMREG(ft, NDS32Insn_OPCODE_Rt(insn));
+			DPFROMREG(fa, NDS32Insn_OPCODE_Ra(insn));
+			func.b(ft, fa);
+			break;
+		}
+	case D2D:{
+			void *ft, *fa, *fb;
+
+			DPFROMREG(ft, NDS32Insn_OPCODE_Rt(insn));
+			DPFROMREG(fa, NDS32Insn_OPCODE_Ra(insn));
+			DPFROMREG(fb, NDS32Insn_OPCODE_Rb(insn));
+			func.t(ft, fa, fb);
+			break;
+		}
+	case D1S:{
+			void *ft, *fa;
+
+			SPFROMREG(ft, NDS32Insn_OPCODE_Rt(insn));
+			DPFROMREG(fa, NDS32Insn_OPCODE_Ra(insn));
+			func.b(ft, fa);
+			break;
+		}
+	case CD:{
+			unsigned int cmpop = NDS32Insn_OPCODE_BIT69(insn);
+			void *ft, *fa, *fb;
+
+			SPFROMREG(ft, NDS32Insn_OPCODE_Rt(insn));
+			DPFROMREG(fa, NDS32Insn_OPCODE_Ra(insn));
+			DPFROMREG(fb, NDS32Insn_OPCODE_Rb(insn));
+			if (cmpop < 0x8) {
+				cmpop = cmptab[cmpop];
+				fcmpd(ft, fa, fb, cmpop);
+			} else
+				return SIGILL;
+			break;
+		}
+	default:
+		return SIGILL;
+	}
+
+	/*
+	 * If an exception is required, generate a tidy SIGFPE exception.
+	 */
+	if ((fpu_reg->fpcsr << 5) & fpu_reg->fpcsr & FPCSR_mskALLE)
+		return SIGFPE;
+	return 0;
+}
+
+
+int do_fpuemu(struct pt_regs *regs, struct fpu_struct *fpu)
+{
+	unsigned long insn = 0, addr = regs->ipc;
+	unsigned long emulpc, contpc;
+	unsigned char *pc = (void *)&insn;
+	char c;
+	int i = 0;
+
+	for (i = 0; i < 4; i++) {
+		if (__get_user(c, (unsigned char *)addr++))
+			return SIGBUS;
+		*pc++ = c;
+	}
+
+	insn = be32_to_cpu(insn);
+
+	emulpc = regs->ipc;
+	contpc = regs->ipc + 4;
+
+	switch (NDS32Insn_OPCODE(insn)) {
+	case cop0_op:
+		switch (NDS32Insn_OPCODE_COP0(insn)) {
+
+		case fs1_op:
+		case fs2_op:
+		case fd1_op:
+		case fd2_op:
+			{
+				/* Do fpu emulation */
+				int sig = fpu_emu(fpu, insn);
+
+				if (sig)
+					return sig;
+			}
+			break;
+
+		default:
+			return SIGILL;
+		}
+		break;
+	default:
+		return SIGILL;
+	}
+
+	/* we did it !! */
+	regs->ipc = contpc;
+
+	return 0;
+}
diff --git a/arch/nds32/math-emu/fs2d.c b/arch/nds32/math-emu/fs2d.c
new file mode 100644
index 0000000..0e8db90
--- /dev/null
+++ b/arch/nds32/math-emu/fs2d.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2018 Andes Technology Corporation
+
+#include <linux/uaccess.h>
+#include <asm/sfp-machine.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
+#include <math-emu/soft-fp.h>
+
+void fs2d(void *ft, void *fa)
+{
+	FP_DECL_S(A);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, fa);
+
+	FP_CONV(D, S, 2, 1, R, A);
+
+	FP_PACK_DP(ft, R);
+
+	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+}
diff --git a/arch/nds32/math-emu/fsqrtd.c b/arch/nds32/math-emu/fsqrtd.c
new file mode 100644
index 0000000..c3a8dbd
--- /dev/null
+++ b/arch/nds32/math-emu/fsqrtd.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2018 Andes Technology Corporation
+
+#include <linux/uaccess.h>
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+void fsqrtd(void *ft, void *fa)
+{
+	FP_DECL_D(A);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, fa);
+
+	FP_SQRT_D(R, A);
+
+	FP_PACK_DP(ft, R);
+
+	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+}
diff --git a/arch/nds32/math-emu/fsqrts.c b/arch/nds32/math-emu/fsqrts.c
new file mode 100644
index 0000000..4c6f94b
--- /dev/null
+++ b/arch/nds32/math-emu/fsqrts.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2018 Andes Technology Corporation
+
+#include <linux/uaccess.h>
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/single.h>
+void fsqrts(void *ft, void *fa)
+{
+	FP_DECL_S(A);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, fa);
+
+	FP_SQRT_S(R, A);
+
+	FP_PACK_SP(ft, R);
+
+	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+}
diff --git a/arch/nds32/math-emu/fsubd.c b/arch/nds32/math-emu/fsubd.c
new file mode 100644
index 0000000..81b6a0d
--- /dev/null
+++ b/arch/nds32/math-emu/fsubd.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2018 Andes Technology Corporation
+#include <linux/uaccess.h>
+
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+void fsubd(void *ft, void *fa, void *fb)
+{
+
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, fa);
+	FP_UNPACK_DP(B, fb);
+
+	if (B_c != FP_CLS_NAN)
+		B_s ^= 1;
+
+	FP_ADD_D(R, A, B);
+
+	FP_PACK_DP(ft, R);
+
+	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+}
diff --git a/arch/nds32/math-emu/fsubs.c b/arch/nds32/math-emu/fsubs.c
new file mode 100644
index 0000000..61ddd97
--- /dev/null
+++ b/arch/nds32/math-emu/fsubs.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2018 Andes Technology Corporation
+#include <linux/uaccess.h>
+
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/single.h>
+void fsubs(void *ft, void *fa, void *fb)
+{
+
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, fa);
+	FP_UNPACK_SP(B, fb);
+
+	if (B_c != FP_CLS_NAN)
+		B_s ^= 1;
+
+	FP_ADD_S(R, A, B);
+
+	FP_PACK_SP(ft, R);
+
+	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
+}
-- 
1.7.1
