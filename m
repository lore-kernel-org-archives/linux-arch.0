Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from exmail.andestech.com ([59.124.169.137]:24608 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732658AbeITI2H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Sep 2018 04:28:07 -0400
From: Vincent Chen <vincentc@andestech.com>
Subject: [PATCH 3/5] nds32: support denormalized result through FP emulator
Date: Thu, 20 Sep 2018 10:46:20 +0800
Message-ID: <1537411582-23723-4-git-send-email-vincentc@andestech.com>
In-Reply-To: <1537411582-23723-1-git-send-email-vincentc@andestech.com>
References: <1537411582-23723-1-git-send-email-vincentc@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, deanbo422@gmail.com, vincentc@andestech.com
Cc: Nickhu <nickhu@andestech.com>
Message-ID: <20180920024620.FQ4bJy9MVf2wBSf6ATM9nm_wvgMPwXQb4vPbNZBMe84@z>

  For current nds32 FPU, arithmetic for denormalized number is unsupported.
When nds32 FPU finds the result of floating pointer instruction is a
denormlized number, nds32 FPU thinks an underflow condition is happened
and round the result to an appropriate number. It may cause precision
loss. This commit supposes to support the arithmetic which result is a
denormalized number through re-executing the instructions by FP emulator
in kernel. Hence the underflow trapped shall be enabled by default. Enable
this feature may cause some side effects:
  1. Performance loss due to extra FPU exception
  2. Need another scheme to control real underflow trap
       A new parameter, UDF_trap, which is belong to FPU context is used
     to control underflow trap.

User can though CONFIG_SUPPORT_DENORMAL_ARITHMETIC to configure this
feature.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Nickhu <nickhu@andestech.com>
---
 arch/nds32/Kconfig.cpu                   |   13 +++++++++
 arch/nds32/include/asm/elf.h             |   11 +++++++
 arch/nds32/include/asm/fpu.h             |   11 +++++++
 arch/nds32/include/asm/syscalls.h        |    1 +
 arch/nds32/include/uapi/asm/auxvec.h     |    7 +++++
 arch/nds32/include/uapi/asm/sigcontext.h |    9 ++++++
 arch/nds32/include/uapi/asm/udftrap.h    |   13 +++++++++
 arch/nds32/include/uapi/asm/unistd.h     |    2 +
 arch/nds32/kernel/fpu.c                  |   25 ++++++++++++++---
 arch/nds32/kernel/signal.c               |    3 ++
 arch/nds32/kernel/sys_nds32.c            |   32 +++++++++++++++++++++
 arch/nds32/math-emu/fpuemu.c             |   44 +++++++++++++----------------
 12 files changed, 143 insertions(+), 28 deletions(-)
 create mode 100644 arch/nds32/include/uapi/asm/udftrap.h

diff --git a/arch/nds32/Kconfig.cpu b/arch/nds32/Kconfig.cpu
index 7ee4e19..c6a69ee 100644
--- a/arch/nds32/Kconfig.cpu
+++ b/arch/nds32/Kconfig.cpu
@@ -29,6 +29,19 @@ config UNLAZY_FPU
 
 	  For nomal case, say N.
 
+config SUPPORT_DENORMAL_ARITHMETIC
+	bool "Denormal arithmetic support"
+	depends on FPU
+	default n
+	help
+	  Say Y here to enable arithmetic for denormalized number. Enable this
+	  feature can enhance the precision for tininess number. However, the
+	  performance loss in float pointer calculation is possibly significant
+	  due to extra FPU exception.
+
+	  If the tolerance for tininess number calculation is wide, say N to
+	  prevent performance loss.
+
 config HWZOL
 	bool "hardware zero overhead loop support"
 	depends on CPU_D10 || CPU_D15
diff --git a/arch/nds32/include/asm/elf.h b/arch/nds32/include/asm/elf.h
index f5f9cf7..95f3ea2 100644
--- a/arch/nds32/include/asm/elf.h
+++ b/arch/nds32/include/asm/elf.h
@@ -9,6 +9,7 @@
  */
 
 #include <asm/ptrace.h>
+#include <asm/fpu.h>
 
 typedef unsigned long elf_greg_t;
 typedef unsigned long elf_freg_t[3];
@@ -159,8 +160,18 @@ struct user_fp {
 
 #endif
 
+
+#if IS_ENABLED(CONFIG_FPU)
+#define FPU_AUX_ENT	NEW_AUX_ENT(AT_FPUCW, FPCSR_INIT)
+#else
+#define FPU_AUX_ENT	NEW_AUX_ENT(AT_IGNORE, 0)
+#endif
+
 #define ARCH_DLINFO						\
 do {								\
+	/* Optional FPU initialization */			\
+	FPU_AUX_ENT;						\
+								\
 	NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
 		    (elf_addr_t)current->mm->context.vdso);	\
 } while (0)
diff --git a/arch/nds32/include/asm/fpu.h b/arch/nds32/include/asm/fpu.h
index 10df5f0..2018fef 100644
--- a/arch/nds32/include/asm/fpu.h
+++ b/arch/nds32/include/asm/fpu.h
@@ -26,7 +26,18 @@
 #define sNAN64    0xFFFFFFFFFFFFFFFFULL
 #define sNAN32    0xFFFFFFFFUL
 
+#if IS_ENABLED(CONFIG_SUPPORT_DENORMAL_ARITHMETIC)
+/*
+ * Denormalized number is unsupported by nds32 FPU. Hence the operation
+ * is treated as underflow cases when the final result is a denormalized
+ * number. To enhance precision, underflow exception trap should be
+ * enabled by default and kerenl will re-execute it by fpu emulator
+ * when getting underflow exception.
+ */
+#define FPCSR_INIT  FPCSR_mskUDFE
+#else
 #define FPCSR_INIT  0x0UL
+#endif
 
 extern const struct fpu_struct init_fpuregs;
 
diff --git a/arch/nds32/include/asm/syscalls.h b/arch/nds32/include/asm/syscalls.h
index 78778ec..da32101 100644
--- a/arch/nds32/include/asm/syscalls.h
+++ b/arch/nds32/include/asm/syscalls.h
@@ -7,6 +7,7 @@
 asmlinkage long sys_cacheflush(unsigned long addr, unsigned long len, unsigned int op);
 asmlinkage long sys_fadvise64_64_wrapper(int fd, int advice, loff_t offset, loff_t len);
 asmlinkage long sys_rt_sigreturn_wrapper(void);
+asmlinkage long sys_udftrap(int option);
 
 #include <asm-generic/syscalls.h>
 
diff --git a/arch/nds32/include/uapi/asm/auxvec.h b/arch/nds32/include/uapi/asm/auxvec.h
index 56043ce..2d3213f 100644
--- a/arch/nds32/include/uapi/asm/auxvec.h
+++ b/arch/nds32/include/uapi/asm/auxvec.h
@@ -4,6 +4,13 @@
 #ifndef __ASM_AUXVEC_H
 #define __ASM_AUXVEC_H
 
+/*
+ * This entry gives some information about the FPU initialization
+ * performed by the kernel.
+ */
+#define AT_FPUCW	18	/* Used FPU control word.  */
+
+
 /* VDSO location */
 #define AT_SYSINFO_EHDR	33
 
diff --git a/arch/nds32/include/uapi/asm/sigcontext.h b/arch/nds32/include/uapi/asm/sigcontext.h
index 1257a78..58afc41 100644
--- a/arch/nds32/include/uapi/asm/sigcontext.h
+++ b/arch/nds32/include/uapi/asm/sigcontext.h
@@ -12,6 +12,15 @@
 struct fpu_struct {
 	unsigned long long fd_regs[32];
 	unsigned long fpcsr;
+	/*
+	 * UDF_trap is used to recognize whether underflow trap is enabled
+	 * or not. When UDF_trap == 1, this process will be traped and then
+	 * get a SIGFPE signal when encountering an underflow exception.
+	 * UDF_trap is only modified through setfputrap syscall. Therefore,
+	 * UDF_trap needn't be saved or loaded to context in each context
+	 * switch.
+	 */
+	unsigned long UDF_trap;
 };
 
 struct zol_struct {
diff --git a/arch/nds32/include/uapi/asm/udftrap.h b/arch/nds32/include/uapi/asm/udftrap.h
new file mode 100644
index 0000000..433f79d
--- /dev/null
+++ b/arch/nds32/include/uapi/asm/udftrap.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2005-2018 Andes Technology Corporation */
+#ifndef	_ASM_SETFPUTRAP
+#define	_ASM_SETFPUTRAP
+
+/*
+ * Options for setfputrap system call
+ */
+#define	DISABLE_UDFTRAP	0	/* disable underflow exception trap */
+#define	ENABLE_UDFTRAP	1	/* enable undeflos exception trap */
+#define	GET_UDFTRAP	2	/* only get undeflos exception trap status */
+
+#endif /* _ASM_CACHECTL */
diff --git a/arch/nds32/include/uapi/asm/unistd.h b/arch/nds32/include/uapi/asm/unistd.h
index 6e95901..199e675 100644
--- a/arch/nds32/include/uapi/asm/unistd.h
+++ b/arch/nds32/include/uapi/asm/unistd.h
@@ -8,4 +8,6 @@
 
 /* Additional NDS32 specific syscalls. */
 #define __NR_cacheflush		(__NR_arch_specific_syscall)
+#define __NR_udftrap		(__NR_arch_specific_syscall + 1)
 __SYSCALL(__NR_cacheflush, sys_cacheflush)
+__SYSCALL(__NR_udftrap, sys_udftrap)
diff --git a/arch/nds32/kernel/fpu.c b/arch/nds32/kernel/fpu.c
index 75f611b..de18b7d 100644
--- a/arch/nds32/kernel/fpu.c
+++ b/arch/nds32/kernel/fpu.c
@@ -12,7 +12,10 @@
 
 const struct fpu_struct init_fpuregs = {
 	.fd_regs = {[0 ... 31] = sNAN64},
-	.fpcsr = FPCSR_INIT
+	.fpcsr = FPCSR_INIT,
+#if IS_ENABLED(CONFIG_SUPPORT_DENORMAL_ARITHMETIC)
+	.UDF_trap = 0
+#endif
 };
 
 void save_fpu(struct task_struct *tsk)
@@ -162,6 +165,9 @@ inline void do_fpu_context_switch(struct pt_regs *regs)
 	} else {
 		/* First time FPU user.  */
 		fpload(&init_fpuregs);
+#if IS_ENABLED(CONFIG_SUPPORT_DENORMAL_ARITHMETIC)
+		current->thread.fpu.UDF_trap = init_fpuregs.UDF_trap;
+#endif
 		set_used_math();
 	}
 
@@ -171,10 +177,12 @@ inline void fill_sigfpe_signo(unsigned int fpcsr, int *signo)
 {
 	if (fpcsr & FPCSR_mskOVFT)
 		*signo = FPE_FLTOVF;
-	else if (fpcsr & FPCSR_mskIVOT)
-		*signo = FPE_FLTINV;
+#ifndef CONFIG_SUPPORT_DENORMAL_ARITHMETIC
 	else if (fpcsr & FPCSR_mskUDFT)
 		*signo = FPE_FLTUND;
+#endif
+	else if (fpcsr & FPCSR_mskIVOT)
+		*signo = FPE_FLTINV;
 	else if (fpcsr & FPCSR_mskDBZT)
 		*signo = FPE_FLTDIV;
 	else if (fpcsr & FPCSR_mskIEXT)
@@ -185,11 +193,20 @@ inline void handle_fpu_exception(struct pt_regs *regs)
 {
 	unsigned int fpcsr;
 	int si_code = 0, si_signo = SIGFPE;
+#if IS_ENABLED(CONFIG_SUPPORT_DENORMAL_ARITHMETIC)
+	unsigned long redo_except = FPCSR_mskDNIT|FPCSR_mskUDFT;
+#else
+	unsigned long redo_except = FPCSR_mskDNIT;
+#endif
 
 	lose_fpu();
 	fpcsr = current->thread.fpu.fpcsr;
 
-	if (fpcsr & FPCSR_mskDNIT) {
+	if (fpcsr & redo_except) {
+#if IS_ENABLED(CONFIG_SUPPORT_DENORMAL_ARITHMETIC)
+		if (fpcsr & FPCSR_mskUDFT)
+			current->thread.fpu.fpcsr &= ~FPCSR_mskIEX;
+#endif
 		si_signo = do_fpuemu(regs, &current->thread.fpu);
 		fpcsr = current->thread.fpu.fpcsr;
 		if (!si_signo)
diff --git a/arch/nds32/kernel/signal.c b/arch/nds32/kernel/signal.c
index 4612645..8004c9b 100644
--- a/arch/nds32/kernel/signal.c
+++ b/arch/nds32/kernel/signal.c
@@ -80,6 +80,9 @@ static inline int setup_sigcontext_fpu(struct pt_regs *regs,
 
 	enable_ptreg_fpu(task_pt_regs(tsk));
 	fpload(&init_fpuregs);
+#if IS_ENABLED(CONFIG_SUPPORT_DENORMAL_ARITHMETIC)
+	current->thread.fpu.UDF_trap = init_fpuregs.UDF_trap;
+#endif
 #if !IS_ENABLED(CONFIG_UNLAZY_FPU)	//Lazy FPU
 	last_task_used_math = current;
 #endif
diff --git a/arch/nds32/kernel/sys_nds32.c b/arch/nds32/kernel/sys_nds32.c
index 9de93ab..d7d002a 100644
--- a/arch/nds32/kernel/sys_nds32.c
+++ b/arch/nds32/kernel/sys_nds32.c
@@ -6,6 +6,8 @@
 
 #include <asm/cachectl.h>
 #include <asm/proc-fns.h>
+#include <asm/udftrap.h>
+#include <asm/fpu.h>
 
 SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
 	       unsigned long, prot, unsigned long, flags,
@@ -48,3 +50,33 @@
 
 	return 0;
 }
+
+SYSCALL_DEFINE1(udftrap, int, option)
+{
+#if IS_ENABLED(CONFIG_SUPPORT_DENORMAL_ARITHMETIC)
+	int old_udftrap;
+
+	if (!used_math()) {
+		fpload(&init_fpuregs);
+		current->thread.fpu.UDF_trap = init_fpuregs.UDF_trap;
+		set_used_math();
+	}
+
+	old_udftrap = current->thread.fpu.UDF_trap;
+	switch (option) {
+	case DISABLE_UDFTRAP:
+		current->thread.fpu.UDF_trap = 0;
+		break;
+	case ENABLE_UDFTRAP:
+		current->thread.fpu.UDF_trap = FPCSR_mskUDFE;
+		break;
+	case GET_UDFTRAP:
+		break;
+	default:
+		return -EINVAL;
+	}
+	return old_udftrap;
+#else
+	return -ENOTSUPP;
+#endif
+}
diff --git a/arch/nds32/math-emu/fpuemu.c b/arch/nds32/math-emu/fpuemu.c
index 4d88135..75cf164 100644
--- a/arch/nds32/math-emu/fpuemu.c
+++ b/arch/nds32/math-emu/fpuemu.c
@@ -304,7 +304,12 @@ static int fpu_emu(struct fpu_struct *fpu_reg, unsigned long insn)
 	/*
 	 * If an exception is required, generate a tidy SIGFPE exception.
 	 */
+#if IS_ENABLED(CONFIG_SUPPORT_DENORMAL_ARITHMETIC)
+	if (((fpu_reg->fpcsr << 5) & fpu_reg->fpcsr & FPCSR_mskALLE_NO_UDFE) ||
+	    ((fpu_reg->fpcsr & FPCSR_mskUDF) && (fpu_reg->UDF_trap)))
+#else
 	if ((fpu_reg->fpcsr << 5) & fpu_reg->fpcsr & FPCSR_mskALLE)
+#endif
 		return SIGFPE;
 	return 0;
 }
@@ -316,7 +321,7 @@ int do_fpuemu(struct pt_regs *regs, struct fpu_struct *fpu)
 	unsigned long emulpc, contpc;
 	unsigned char *pc = (void *)&insn;
 	char c;
-	int i = 0;
+	int i = 0, ret;
 
 	for (i = 0; i < 4; i++) {
 		if (__get_user(c, (unsigned char *)addr++))
@@ -329,33 +334,24 @@ int do_fpuemu(struct pt_regs *regs, struct fpu_struct *fpu)
 	emulpc = regs->ipc;
 	contpc = regs->ipc + 4;
 
-	switch (NDS32Insn_OPCODE(insn)) {
-	case cop0_op:
-		switch (NDS32Insn_OPCODE_COP0(insn)) {
-
-		case fs1_op:
-		case fs2_op:
-		case fd1_op:
-		case fd2_op:
-			{
-				/* Do fpu emulation */
-				int sig = fpu_emu(fpu, insn);
-
-				if (sig)
-					return sig;
-			}
-			break;
-
-		default:
-			return SIGILL;
+	if (NDS32Insn_OPCODE(insn) != cop0_op)
+		return SIGILL;
+	switch (NDS32Insn_OPCODE_COP0(insn)) {
+	case fs1_op:
+	case fs2_op:
+	case fd1_op:
+	case fd2_op:
+		{
+			/* a real fpu computation instruction */
+			ret = fpu_emu(fpu, insn);
+			if (!ret)
+				regs->ipc = contpc;
 		}
 		break;
+
 	default:
 		return SIGILL;
 	}
 
-	/* we did it !! */
-	regs->ipc = contpc;
-
-	return 0;
+	return ret;
 }
-- 
1.7.1
