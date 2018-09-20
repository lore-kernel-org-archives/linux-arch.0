From: Vincent Chen <vincentc@andestech.com>
Subject: [PATCH 1/5] nds32: nds32 FPU port
Date: Thu, 20 Sep 2018 10:46:18 +0800
Message-ID: <1537411582-23723-2-git-send-email-vincentc@andestech.com>
References: <1537411582-23723-1-git-send-email-vincentc@andestech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537411582-23723-1-git-send-email-vincentc@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, deanbo422@gmail.com, vincentc@andestech.com
List-Id: linux-arch.vger.kernel.org

  This commit contains basic components for nds32 FPU support such as
FPU exception handler and context switch for FPU register.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
---
 arch/nds32/Kconfig                       |    1 +
 arch/nds32/Kconfig.cpu                   |   22 +++
 arch/nds32/Makefile                      |   10 ++
 arch/nds32/include/asm/bitfield.h        |   15 ++
 arch/nds32/include/asm/fpu.h             |  116 ++++++++++++++++
 arch/nds32/include/asm/processor.h       |    7 +
 arch/nds32/include/uapi/asm/sigcontext.h |    5 +
 arch/nds32/kernel/Makefile               |    9 ++
 arch/nds32/kernel/ex-entry.S             |    9 ++
 arch/nds32/kernel/ex-exit.S              |    8 +-
 arch/nds32/kernel/ex-scall.S             |    8 +-
 arch/nds32/kernel/fpu.c                  |  219 ++++++++++++++++++++++++++++++
 arch/nds32/kernel/process.c              |   64 ++++++++-
 arch/nds32/kernel/setup.c                |    5 +
 arch/nds32/kernel/signal.c               |   74 ++++++++++-
 arch/nds32/kernel/traps.c                |   16 ++
 16 files changed, 577 insertions(+), 11 deletions(-)
 create mode 100644 arch/nds32/include/asm/fpu.h
 create mode 100644 arch/nds32/kernel/fpu.c

diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 7068f34..4f4a580 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -29,6 +29,7 @@ config NDS32
 	select HANDLE_DOMAIN_IRQ
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_DEBUG_KMEMLEAK
+	select HAVE_EXIT_THREAD
 	select HAVE_MEMBLOCK
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select IRQ_DOMAIN
diff --git a/arch/nds32/Kconfig.cpu b/arch/nds32/Kconfig.cpu
index b8c8984..7ee4e19 100644
--- a/arch/nds32/Kconfig.cpu
+++ b/arch/nds32/Kconfig.cpu
@@ -7,6 +7,28 @@ config CPU_LITTLE_ENDIAN
 	bool "Little endian"
 	default y
 
+config FPU
+	bool "FPU support"
+	default n
+	help
+	  If FPU ISA is used in user space, this configure shall be Y to make
+	  the fpu context switch and fpu exception handler is enabled in kernel.
+	  Lazy FPU is the default scheme for fpu context switch. If user wants
+	  to disable Lazy FPU scheme, please enable CONFIG_UNLAZY_FPU.
+
+	  If no FPU ISA is used in user space, say N.
+
+config UNLAZY_FPU
+	bool "Unlazy FPU support"
+	depends on FPU
+	default n
+	help
+	  Say Y here to disable lazy FPU scheme. Disable lazy FPU scheme causes
+	  some performance loss because the fpu register are loaded and stored
+	  in each context switch.
+
+	  For nomal case, say N.
+
 config HWZOL
 	bool "hardware zero overhead loop support"
 	depends on CPU_D10 || CPU_D15
diff --git a/arch/nds32/Makefile b/arch/nds32/Makefile
index 3509fac..599ee62 100644
--- a/arch/nds32/Makefile
+++ b/arch/nds32/Makefile
@@ -5,9 +5,19 @@ KBUILD_DEFCONFIG := defconfig
 
 comma = ,
 
+
 ifdef CONFIG_FUNCTION_TRACER
 arch-y += -malways-save-lp -mno-relax
 endif
+ifdef CONFIG_FPU
+arch-y  += \
+        $(shell $(CC) -E -dM -xc /dev/null | \
+                grep -o -m1 NDS32_EXT_FPU_SP | \
+                sed -e 's/NDS32_EXT_FPU_SP/-mno-ext-fpu-sp -mfloat-abi=soft/') \
+        $(shell $(CC) -E -dM -xc /dev/null | \
+                grep -o -m1 NDS32_EXT_FPU_DP | \
+                sed -e 's/NDS32_EXT_FPU_DP/-mno-ext-fpu-dp -mfloat-abi=soft/')
+endif
 
 KBUILD_CFLAGS	+= $(call cc-option, -mno-sched-prolog-epilog)
 KBUILD_CFLAGS	+= -mcmodel=large
diff --git a/arch/nds32/include/asm/bitfield.h b/arch/nds32/include/asm/bitfield.h
index 8e84fc3..bbb1c08 100644
--- a/arch/nds32/include/asm/bitfield.h
+++ b/arch/nds32/include/asm/bitfield.h
@@ -251,6 +251,11 @@
 #define ITYPE_mskSTYPE		( 0xF  << ITYPE_offSTYPE )
 #define ITYPE_mskCPID		( 0x3  << ITYPE_offCPID )
 
+/* Additional definitions for FPU coprocessor in ITYPE register */
+#define FPU_DISABLE_EXCEPTION	(0x1  << ITYPE_offSTYPE)
+#define FPU_EXCEPTION		(0x2  << ITYPE_offSTYPE)
+#define FPU_CPID		0	/* The Co-Processor ID of FPU is 0 */
+
 #define NDS32_VECTOR_mskNONEXCEPTION	0x78
 #define NDS32_VECTOR_offEXCEPTION	8
 #define NDS32_VECTOR_offINTERRUPT	9
@@ -926,6 +931,7 @@
 #define FPCSR_mskDNIT           ( 0x1  << FPCSR_offDNIT )
 #define FPCSR_mskRIT		( 0x1  << FPCSR_offRIT )
 #define FPCSR_mskALL		(FPCSR_mskIVO | FPCSR_mskDBZ | FPCSR_mskOVF | FPCSR_mskUDF | FPCSR_mskIEX)
+#define FPCSR_mskALLE_NO_UDFE	(FPCSR_mskIVOE | FPCSR_mskDBZE | FPCSR_mskOVFE | FPCSR_mskIEXE)
 #define FPCSR_mskALLE		(FPCSR_mskIVOE | FPCSR_mskDBZE | FPCSR_mskOVFE | FPCSR_mskUDFE | FPCSR_mskIEXE)
 #define FPCSR_mskALLT           (FPCSR_mskIVOT | FPCSR_mskDBZT | FPCSR_mskOVFT | FPCSR_mskUDFT | FPCSR_mskIEXT |FPCSR_mskDNIT | FPCSR_mskRIT)
 
@@ -946,6 +952,15 @@
 #define FPCFG_mskIMVER		( 0x1F  << FPCFG_offIMVER )
 #define FPCFG_mskAVER		( 0x1F  << FPCFG_offAVER )
 
+/* 8 Single precision or 4 double precision registers are available */
+#define SP8_DP4_reg		0
+/* 16 Single precision or 8 double precision registers are available */
+#define SP16_DP8_reg		1
+/* 32 Single precision or 16 double precision registers are available */
+#define SP32_DP16_reg		2
+/* 32 Single precision or 32 double precision registers are available */
+#define SP32_DP32_reg		3
+
 /******************************************************************************
  * fucpr: FUCOP_CTL (FPU and Coprocessor Enable Control Register)
  *****************************************************************************/
diff --git a/arch/nds32/include/asm/fpu.h b/arch/nds32/include/asm/fpu.h
new file mode 100644
index 0000000..3132400
--- /dev/null
+++ b/arch/nds32/include/asm/fpu.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2005-2018 Andes Technology Corporation */
+
+#ifndef __ASM_NDS32_FPU_H
+#define __ASM_NDS32_FPU_H
+
+#if IS_ENABLED(CONFIG_FPU)
+#ifndef __ASSEMBLY__
+#include <linux/sched/task_stack.h>
+#include <linux/preempt.h>
+#include <asm/ptrace.h>
+
+extern void save_fpu(struct task_struct *__tsk);
+extern void fpload(const struct fpu_struct *fpregs);
+extern bool do_fpu_exception(unsigned int subtype, struct pt_regs *regs);
+
+#define test_tsk_fpu(regs)	(regs->fucop_ctl & FUCOP_CTL_mskCP0EN)
+
+/*
+ * Initially load the FPU with signalling NANS.  This bit pattern
+ * has the property that no matter whether considered as single or as
+ * double precision, it still represents a signalling NAN.
+ */
+
+#define sNAN64    0xFFFFFFFFFFFFFFFFULL
+#define sNAN32    0xFFFFFFFFUL
+
+#define FPCSR_INIT  0x0UL
+
+extern const struct fpu_struct init_fpuregs;
+
+static inline void disable_ptreg_fpu(struct pt_regs *regs)
+{
+	regs->fucop_ctl &= ~FUCOP_CTL_mskCP0EN;
+}
+
+static inline void enable_ptreg_fpu(struct pt_regs *regs)
+{
+	regs->fucop_ctl |= FUCOP_CTL_mskCP0EN;
+}
+
+static inline void enable_fpu(void)
+{
+	unsigned long fucop_ctl;
+
+	fucop_ctl = __nds32__mfsr(NDS32_SR_FUCOP_CTL) | FUCOP_CTL_mskCP0EN;
+	__nds32__mtsr(fucop_ctl, NDS32_SR_FUCOP_CTL);
+	__nds32__isb();
+}
+
+static inline void disable_fpu(void)
+{
+	unsigned long fucop_ctl;
+
+	fucop_ctl = __nds32__mfsr(NDS32_SR_FUCOP_CTL) & ~FUCOP_CTL_mskCP0EN;
+	__nds32__mtsr(fucop_ctl, NDS32_SR_FUCOP_CTL);
+	__nds32__isb();
+}
+
+static inline void lose_fpu(void)
+{
+	preempt_disable();
+#if !IS_ENABLED(CONFIG_UNLAZY_FPU)
+	if (last_task_used_math == current) {
+#else
+	if (test_tsk_fpu(task_pt_regs(current))) {
+#endif
+		save_fpu(current);
+#if !IS_ENABLED(CONFIG_UNLAZY_FPU)
+		last_task_used_math = NULL;
+#endif
+	}
+	disable_ptreg_fpu(task_pt_regs(current));
+	preempt_enable();
+}
+
+static inline void own_fpu(void)
+{
+	preempt_disable();
+#if !IS_ENABLED(CONFIG_UNLAZY_FPU)
+	if (last_task_used_math != current) {
+#else
+	if (!test_tsk_fpu(task_pt_regs(current))) {
+#endif
+#if IS_ENABLED(CONFIG_UNLAZY_FPU)
+		fpload(&current->thread.fpu);
+#else
+		if (last_task_used_math != NULL)
+			save_fpu(last_task_used_math);
+		fpload(&current->thread.fpu);
+		last_task_used_math = current;
+#endif
+	}
+	enable_ptreg_fpu(task_pt_regs(current));
+	preempt_enable();
+}
+
+#if IS_ENABLED(CONFIG_UNLAZY_FPU)
+static inline void unlazy_fpu(struct task_struct *tsk)
+{
+	preempt_disable();
+	if (test_tsk_fpu(task_pt_regs(tsk)))
+		save_fpu(tsk);
+	preempt_enable();
+}
+#endif /* CONFIG_UNLAZY_FPU */
+static inline void clear_fpu(struct pt_regs *regs)
+{
+	preempt_disable();
+	if (test_tsk_fpu(regs))
+		disable_ptreg_fpu(regs);
+	preempt_enable();
+}
+#endif /* CONFIG_FPU */
+#endif /* __ASSEMBLY__ */
+#endif /* __ASM_NDS32_FPU_H */
diff --git a/arch/nds32/include/asm/processor.h b/arch/nds32/include/asm/processor.h
index 9c83caf..bf935d8 100644
--- a/arch/nds32/include/asm/processor.h
+++ b/arch/nds32/include/asm/processor.h
@@ -41,6 +41,8 @@ struct thread_struct {
 	unsigned long address;
 	unsigned long trap_no;
 	unsigned long error_code;
+
+	struct fpu_struct fpu;
 };
 
 #define INIT_THREAD  {	}
@@ -78,6 +80,11 @@ struct thread_struct {
 
 /* Free all resources held by a thread. */
 #define release_thread(thread) do { } while(0)
+#if IS_ENABLED(CONFIG_FPU)
+#if !IS_ENABLED(CONFIG_UNLAZU_FPU)
+extern struct task_struct *last_task_used_math;
+#endif
+#endif
 
 /* Prepare to copy thread state - unlazy all lazy status */
 #define prepare_to_copy(tsk)	do { } while (0)
diff --git a/arch/nds32/include/uapi/asm/sigcontext.h b/arch/nds32/include/uapi/asm/sigcontext.h
index 00567b2..1257a78 100644
--- a/arch/nds32/include/uapi/asm/sigcontext.h
+++ b/arch/nds32/include/uapi/asm/sigcontext.h
@@ -9,6 +9,10 @@
  * before the signal handler was invoked.  Note: only add new entries
  * to the end of the structure.
  */
+struct fpu_struct {
+	unsigned long long fd_regs[32];
+	unsigned long fpcsr;
+};
 
 struct zol_struct {
 	unsigned long nds32_lc;	/* $LC */
@@ -54,6 +58,7 @@ struct sigcontext {
 	unsigned long fault_address;
 	unsigned long used_math_flag;
 	/* FPU Registers */
+	struct fpu_struct fpu;
 	struct zol_struct zol;
 };
 
diff --git a/arch/nds32/kernel/Makefile b/arch/nds32/kernel/Makefile
index 27cded3..42eb5b2 100644
--- a/arch/nds32/kernel/Makefile
+++ b/arch/nds32/kernel/Makefile
@@ -14,11 +14,20 @@ obj-y			:= ex-entry.o ex-exit.o ex-scall.o irq.o \
 
 obj-$(CONFIG_MODULES)		+= nds32_ksyms.o module.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
+obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_OF)		+= devtree.o
 obj-$(CONFIG_CACHE_L2)		+= atl2c.o
 
 extra-y := head.o vmlinux.lds
 
+CFLAGS_fpu.o += \
+        $(shell $(CC) -E -dM -xc /dev/null | \
+	grep -o -m1 NDS32_EXT_FPU_SP | \
+	sed -e 's/NDS32_EXT_FPU_SP/-mext-fpu-sp/') \
+        $(shell $(CC) -E -dM -xc /dev/null | \
+	grep -o -m1 NDS32_EXT_FPU_DP | \
+	sed -e 's/NDS32_EXT_FPU_DP/-mext-fpu-dp/')
+
 
 obj-y				+= vdso/
 
diff --git a/arch/nds32/kernel/ex-entry.S b/arch/nds32/kernel/ex-entry.S
index 21a1440..97d3430 100644
--- a/arch/nds32/kernel/ex-entry.S
+++ b/arch/nds32/kernel/ex-entry.S
@@ -18,9 +18,18 @@
 
 	.macro	save_user_regs
 
+#if defined(CONFIG_FPU)
+	mfsr    $p0, $FUCOP_CTL
+	smw.adm $p0, [$sp], $p0, #0x1
+	bclr    $p0, $p0, #FUCOP_CTL_offCP0EN
+	mtsr    $p0, $FUCOP_CTL
+	/* move $SP to the bottom of pt_regs */
+	addi    $sp, $sp, -FUCOP_CTL_OFFSET
+#else
 	smw.adm $sp, [$sp], $sp, #0x1
 	/* move $SP to the bottom of pt_regs */
 	addi    $sp, $sp, -OSP_OFFSET
+#endif
 
 	/* push $r0 ~ $r25 */
 	smw.bim $r0, [$sp], $r25
diff --git a/arch/nds32/kernel/ex-exit.S b/arch/nds32/kernel/ex-exit.S
index f00af92..304267e 100644
--- a/arch/nds32/kernel/ex-exit.S
+++ b/arch/nds32/kernel/ex-exit.S
@@ -22,10 +22,14 @@
 	.macro	restore_user_regs_first
 	setgie.d
 	isb
-
+#if defined(CONFIG_FPU)
+	addi    $sp, $sp, OSP_OFFSET
+	lmw.adm $r12, [$sp], $r25, #0x0
+	mtsr    $r25, $FUCOP_CTL
+#else
 	addi	$sp, $sp, FUCOP_CTL_OFFSET
-
 	lmw.adm $r12, [$sp], $r24, #0x0
+#endif
 	mtsr	$r12, $SP_USR
 	mtsr	$r13, $IPC
 #ifdef CONFIG_HWZOL
diff --git a/arch/nds32/kernel/ex-scall.S b/arch/nds32/kernel/ex-scall.S
index 36aa87e..3b4993d 100644
--- a/arch/nds32/kernel/ex-scall.S
+++ b/arch/nds32/kernel/ex-scall.S
@@ -19,11 +19,13 @@ ENTRY(__switch_to)
 
 	la	$p0, __entry_task
 	sw	$r1, [$p0]
-	move	$p1, $r0
-	addi	$p1, $p1, #THREAD_CPU_CONTEXT
+	addi	$p1, $r0, #THREAD_CPU_CONTEXT
 	smw.bi 	$r6, [$p1], $r14, #0xb		! push r6~r14, fp, lp, sp
 	move	$r25, $r1
-	addi	$r1, $r1, #THREAD_CPU_CONTEXT
+#if defined(CONFIG_FPU)
+	call	_switch
+#endif
+	addi	$r1, $r25, #THREAD_CPU_CONTEXT
 	lmw.bi 	$r6, [$r1], $r14, #0xb		! pop r6~r14, fp, lp, sp
 	ret
 
diff --git a/arch/nds32/kernel/fpu.c b/arch/nds32/kernel/fpu.c
new file mode 100644
index 0000000..7353746
--- /dev/null
+++ b/arch/nds32/kernel/fpu.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2018 Andes Technology Corporation
+
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/sched/signal.h>
+#include <asm/processor.h>
+#include <asm/user.h>
+#include <asm/io.h>
+#include <asm/bitfield.h>
+#include <asm/fpu.h>
+
+const struct fpu_struct init_fpuregs = {
+	.fd_regs = {[0 ... 31] = sNAN64},
+	.fpcsr = FPCSR_INIT
+};
+
+void save_fpu(struct task_struct *tsk)
+{
+	unsigned int fpcfg, fpcsr;
+
+	enable_fpu();
+	fpcfg = ((__nds32__fmfcfg() & FPCFG_mskFREG) >> FPCFG_offFREG);
+	switch (fpcfg) {
+	case SP32_DP32_reg:
+		asm volatile ("fsdi $fd31, [%0+0xf8]\n\t"
+			      "fsdi $fd30, [%0+0xf0]\n\t"
+			      "fsdi $fd29, [%0+0xe8]\n\t"
+			      "fsdi $fd28, [%0+0xe0]\n\t"
+			      "fsdi $fd27, [%0+0xd8]\n\t"
+			      "fsdi $fd26, [%0+0xd0]\n\t"
+			      "fsdi $fd25, [%0+0xc8]\n\t"
+			      "fsdi $fd24, [%0+0xc0]\n\t"
+			      "fsdi $fd23, [%0+0xb8]\n\t"
+			      "fsdi $fd22, [%0+0xb0]\n\t"
+			      "fsdi $fd21, [%0+0xa8]\n\t"
+			      "fsdi $fd20, [%0+0xa0]\n\t"
+			      "fsdi $fd19, [%0+0x98]\n\t"
+			      "fsdi $fd18, [%0+0x90]\n\t"
+			      "fsdi $fd17, [%0+0x88]\n\t"
+			      "fsdi $fd16, [%0+0x80]\n\t"
+			      :	/* no output */
+			      : "r" (&tsk->thread.fpu)
+			      : "memory");
+		/* fall through */
+	case SP32_DP16_reg:
+		asm volatile ("fsdi $fd15, [%0+0x78]\n\t"
+			      "fsdi $fd14, [%0+0x70]\n\t"
+			      "fsdi $fd13, [%0+0x68]\n\t"
+			      "fsdi $fd12, [%0+0x60]\n\t"
+			      "fsdi $fd11, [%0+0x58]\n\t"
+			      "fsdi $fd10, [%0+0x50]\n\t"
+			      "fsdi $fd9,  [%0+0x48]\n\t"
+			      "fsdi $fd8,  [%0+0x40]\n\t"
+			      :	/* no output */
+			      : "r" (&tsk->thread.fpu)
+			      : "memory");
+		/* fall through */
+	case SP16_DP8_reg:
+		asm volatile ("fsdi $fd7,  [%0+0x38]\n\t"
+			      "fsdi $fd6,  [%0+0x30]\n\t"
+			      "fsdi $fd5,  [%0+0x28]\n\t"
+			      "fsdi $fd4,  [%0+0x20]\n\t"
+			      :	/* no output */
+			      : "r" (&tsk->thread.fpu)
+			      : "memory");
+		/* fall through */
+	case SP8_DP4_reg:
+		asm volatile ("fsdi $fd3,  [%1+0x18]\n\t"
+			      "fsdi $fd2,  [%1+0x10]\n\t"
+			      "fsdi $fd1,  [%1+0x8]\n\t"
+			      "fsdi $fd0,  [%1+0x0]\n\t"
+			      "fmfcsr	%0\n\t"
+			      "swi  %0, [%1+0x100]\n\t"
+			      : "=&r" (fpcsr)
+			      : "r"(&tsk->thread.fpu)
+			      : "memory");
+	}
+	disable_fpu();
+}
+
+void fpload(const struct fpu_struct *fpregs)
+{
+	unsigned int fpcfg, fpcsr;
+
+	enable_fpu();
+	fpcfg = ((__nds32__fmfcfg() & FPCFG_mskFREG) >> FPCFG_offFREG);
+	switch (fpcfg) {
+	case SP32_DP32_reg:
+		asm volatile ("fldi $fd31, [%0+0xf8]\n\t"
+			      "fldi $fd30, [%0+0xf0]\n\t"
+			      "fldi $fd29, [%0+0xe8]\n\t"
+			      "fldi $fd28, [%0+0xe0]\n\t"
+			      "fldi $fd27, [%0+0xd8]\n\t"
+			      "fldi $fd26, [%0+0xd0]\n\t"
+			      "fldi $fd25, [%0+0xc8]\n\t"
+			      "fldi $fd24, [%0+0xc0]\n\t"
+			      "fldi $fd23, [%0+0xb8]\n\t"
+			      "fldi $fd22, [%0+0xb0]\n\t"
+			      "fldi $fd21, [%0+0xa8]\n\t"
+			      "fldi $fd20, [%0+0xa0]\n\t"
+			      "fldi $fd19, [%0+0x98]\n\t"
+			      "fldi $fd18, [%0+0x90]\n\t"
+			      "fldi $fd17, [%0+0x88]\n\t"
+			      "fldi $fd16, [%0+0x80]\n\t"
+			      :	/* no output */
+			      : "r" (fpregs));
+		/* fall through */
+	case SP32_DP16_reg:
+		asm volatile ("fldi $fd15, [%0+0x78]\n\t"
+			      "fldi $fd14, [%0+0x70]\n\t"
+			      "fldi $fd13, [%0+0x68]\n\t"
+			      "fldi $fd12, [%0+0x60]\n\t"
+			      "fldi $fd11, [%0+0x58]\n\t"
+			      "fldi $fd10, [%0+0x50]\n\t"
+			      "fldi $fd9,  [%0+0x48]\n\t"
+			      "fldi $fd8,  [%0+0x40]\n\t"
+			      :	/* no output */
+			      : "r" (fpregs));
+		/* fall through */
+	case SP16_DP8_reg:
+		asm volatile ("fldi $fd7,  [%0+0x38]\n\t"
+			      "fldi $fd6,  [%0+0x30]\n\t"
+			      "fldi $fd5,  [%0+0x28]\n\t"
+			      "fldi $fd4,  [%0+0x20]\n\t"
+			      :	/* no output */
+			      : "r" (fpregs));
+		/* fall through */
+	case SP8_DP4_reg:
+		asm volatile ("fldi $fd3,  [%1+0x18]\n\t"
+			      "fldi $fd2,  [%1+0x10]\n\t"
+			      "fldi $fd1,  [%1+0x8]\n\t"
+			      "fldi $fd0,  [%1+0x0]\n\t"
+			      "lwi  %0, [%1+0x100]\n\t"
+			      "fmtcsr	%0\n\t":"=&r" (fpcsr)
+			      : "r"(fpregs));
+	}
+	disable_fpu();
+}
+
+inline void do_fpu_context_switch(struct pt_regs *regs)
+{
+	/* Enable to use FPU. */
+
+	if (!user_mode(regs)) {
+		pr_err("BUG: FPU is used in kernel mode.\n");
+		BUG();
+		return;
+	}
+
+	enable_ptreg_fpu(regs);
+#ifndef CONFIG_UNLAZY_FPU	//Lazy FPU is used
+	if (last_task_used_math == current)
+		return;
+	if (last_task_used_math != NULL)
+		/* Other processes fpu state, save away */
+		save_fpu(last_task_used_math);
+	last_task_used_math = current;
+#endif
+	if (used_math()) {
+		fpload(&current->thread.fpu);
+	} else {
+		/* First time FPU user.  */
+		fpload(&init_fpuregs);
+		set_used_math();
+	}
+
+}
+
+inline void fill_sigfpe_signo(unsigned int fpcsr, int *signo)
+{
+	if (fpcsr & FPCSR_mskOVFT)
+		*signo = FPE_FLTOVF;
+	else if (fpcsr & FPCSR_mskUDFT)
+		*signo = FPE_FLTUND;
+	else if (fpcsr & FPCSR_mskIVOT)
+		*signo = FPE_FLTINV;
+	else if (fpcsr & FPCSR_mskDBZT)
+		*signo = FPE_FLTDIV;
+	else if (fpcsr & FPCSR_mskIEXT)
+		*signo = FPE_FLTRES;
+}
+
+inline void handle_fpu_exception(struct pt_regs *regs)
+{
+	unsigned int fpcsr;
+	int si_code = 0, si_signo = SIGFPE;
+
+	lose_fpu();
+	fpcsr = current->thread.fpu.fpcsr;
+
+	if (fpcsr & FPCSR_mskRIT) {
+		if (!user_mode(regs))
+			do_exit(SIGILL);
+		si_signo = SIGILL;
+		show_regs(regs);
+		si_code = ILL_COPROC;
+	} else
+		fill_sigfpe_signo(fpcsr, &si_code);
+	force_sig_fault(si_signo, si_code,
+			(void __user *)instruction_pointer(regs), current);
+}
+
+bool do_fpu_exception(unsigned int subtype, struct pt_regs *regs)
+{
+	int done = true;
+	/* Coprocessor disabled exception */
+	if (subtype == FPU_DISABLE_EXCEPTION) {
+		preempt_disable();
+		do_fpu_context_switch(regs);
+		preempt_enable();
+	}
+	/* Coprocessor exception such as underflow and overflow */
+	else if (subtype == FPU_EXCEPTION)
+		handle_fpu_exception(regs);
+	else
+		done = false;
+	return done;
+}
diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
index 65fda98..4841e32 100644
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -9,15 +9,16 @@
 #include <linux/uaccess.h>
 #include <asm/elf.h>
 #include <asm/proc-fns.h>
+#include <asm/fpu.h>
 #include <linux/ptrace.h>
 #include <linux/reboot.h>
 
-extern void setup_mm_for_reboot(char mode);
-#ifdef CONFIG_PROC_FS
-struct proc_dir_entry *proc_dir_cpu;
-EXPORT_SYMBOL(proc_dir_cpu);
+#if !IS_ENABLED(CONFIG_UNLAZY_FPU)
+struct task_struct *last_task_used_math;
 #endif
 
+extern void setup_mm_for_reboot(char mode);
+
 extern inline void arch_reset(char mode)
 {
 	if (mode == 's') {
@@ -125,15 +126,31 @@ void show_regs(struct pt_regs *regs)
 
 EXPORT_SYMBOL(show_regs);
 
+void exit_thread(struct task_struct *tsk)
+{
+#if defined(CONFIG_FPU) && !defined(CONFIG_UNLAZY_FPU)
+	if (last_task_used_math == tsk)
+		last_task_used_math = NULL;
+#endif
+}
+
 void flush_thread(void)
 {
+#if defined(CONFIG_FPU)
+	clear_fpu(task_pt_regs(current));
+	clear_used_math();
+# ifndef CONFIG_UNLAZY_FPU
+	if (last_task_used_math == current)
+		last_task_used_math = NULL;
+# endif
+#endif
 }
 
 DEFINE_PER_CPU(struct task_struct *, __entry_task);
 
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 int copy_thread(unsigned long clone_flags, unsigned long stack_start,
-	    unsigned long stk_sz, struct task_struct *p)
+		unsigned long stk_sz, struct task_struct *p)
 {
 	struct pt_regs *childregs = task_pt_regs(p);
 
@@ -159,6 +176,22 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	p->thread.cpu_context.pc = (unsigned long)ret_from_fork;
 	p->thread.cpu_context.sp = (unsigned long)childregs;
 
+#if IS_ENABLED(CONFIG_FPU)
+	if (used_math()) {
+# if IS_ENABLED(CONFIG_UNLAZY_FPU)
+		unlazy_fpu(current);
+# else
+		preempt_disable();
+		if (last_task_used_math == current)
+			save_fpu(current);
+		preempt_enable();
+# endif
+		p->thread.fpu = current->thread.fpu;
+		clear_fpu(task_pt_regs(p));
+		set_stopped_child_used_math(p);
+	}
+#endif
+
 #ifdef CONFIG_HWZOL
 	childregs->lb = 0;
 	childregs->le = 0;
@@ -168,12 +201,33 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_FPU)
+struct task_struct *_switch(struct task_struct *prev, struct task_struct *next)
+{
+#if IS_ENABLED(CONFIG_UNLAZY_FPU)
+	unlazy_fpu(prev);
+#endif
+	if (!(next->flags & PF_KTHREAD))
+		clear_fpu(task_pt_regs(next));
+	return prev;
+}
+#endif
+
 /*
  * fill in the fpe structure for a core dump...
  */
 int dump_fpu(struct pt_regs *regs, elf_fpregset_t * fpu)
 {
 	int fpvalid = 0;
+#if IS_ENABLED(CONFIG_FPU)
+	struct task_struct *tsk = current;
+
+	fpvalid = tsk_used_math(tsk);
+	if (fpvalid) {
+		lose_fpu();
+		memcpy(fpu, &tsk->thread.fpu, sizeof(*fpu));
+	}
+#endif
 	return fpvalid;
 }
 
diff --git a/arch/nds32/kernel/setup.c b/arch/nds32/kernel/setup.c
index 63a1a5e..9e97e9a 100644
--- a/arch/nds32/kernel/setup.c
+++ b/arch/nds32/kernel/setup.c
@@ -16,6 +16,7 @@
 #include <asm/proc-fns.h>
 #include <asm/cache_info.h>
 #include <asm/elf.h>
+#include <asm/fpu.h>
 #include <nds32_intrinsic.h>
 
 #define HWCAP_MFUSR_PC		0x000001
@@ -137,6 +138,10 @@ static void __init dump_cpu_info(int cpu)
 		    (aliasing_num - 1) << PAGE_SHIFT;
 	}
 #endif
+#ifdef CONFIG_FPU
+	/* Disable fpu and enable when it is used. */
+	disable_fpu();
+#endif
 }
 
 static void __init setup_cpuinfo(void)
diff --git a/arch/nds32/kernel/signal.c b/arch/nds32/kernel/signal.c
index 5d01f6e..4612645 100644
--- a/arch/nds32/kernel/signal.c
+++ b/arch/nds32/kernel/signal.c
@@ -12,6 +12,7 @@
 #include <asm/cacheflush.h>
 #include <asm/ucontext.h>
 #include <asm/unistd.h>
+#include <asm/fpu.h>
 
 #include <asm/ptrace.h>
 #include <asm/vdso.h>
@@ -20,6 +21,72 @@ struct rt_sigframe {
 	struct siginfo info;
 	struct ucontext uc;
 };
+#if IS_ENABLED(CONFIG_FPU)
+static inline int restore_sigcontext_fpu(struct pt_regs *regs,
+					 struct sigcontext __user *sc)
+{
+	struct task_struct *tsk = current;
+	unsigned long used_math_flag;
+	int ret = 0;
+
+	if (!(__nds32__mfsr(NDS32_SR_FUCOP_EXIST) & FUCOP_EXIST_mskCP0ISFPU))
+		return 0;
+
+	__get_user_error(used_math_flag, &sc->used_math_flag, ret);
+
+	if (!used_math_flag)
+		return 0;
+
+	set_used_math();
+
+#if IS_ENABLED(CONFIG_UNLAZY_FPU)
+	clear_fpu(regs);
+#else
+	preempt_disable();
+	if (current == last_task_used_math) {
+		last_task_used_math = NULL;
+		disable_ptreg_fpu(regs);
+	}
+	preempt_enable();
+#endif
+
+	return __copy_from_user(&tsk->thread.fpu, &sc->fpu,
+				sizeof(struct fpu_struct));
+}
+
+static inline int setup_sigcontext_fpu(struct pt_regs *regs,
+				       struct sigcontext __user *sc)
+{
+	struct task_struct *tsk = current;
+	int ret = 0;
+
+	if (!(__nds32__mfsr(NDS32_SR_FUCOP_EXIST) & FUCOP_EXIST_mskCP0ISFPU))
+		return 0;
+
+	if (!used_math())
+		return 0;
+
+	__put_user_error(used_math(), &sc->used_math_flag, ret);
+
+	preempt_disable();
+#if IS_ENABLED(CONFIG_UNLAZY_FPU)
+	unlazy_fpu(tsk);
+#else
+	if (last_task_used_math != NULL)
+		save_fpu(last_task_used_math);
+#endif
+	ret = __copy_to_user(&sc->fpu, &tsk->thread.fpu,
+			     sizeof(struct fpu_struct));
+
+	enable_ptreg_fpu(task_pt_regs(tsk));
+	fpload(&init_fpuregs);
+#if !IS_ENABLED(CONFIG_UNLAZY_FPU)	//Lazy FPU
+	last_task_used_math = current;
+#endif
+	preempt_enable();
+	return ret;
+}
+#endif
 
 static int restore_sigframe(struct pt_regs *regs,
 			    struct rt_sigframe __user * sf)
@@ -69,7 +136,9 @@ static int restore_sigframe(struct pt_regs *regs,
 	__get_user_error(regs->le, &sf->uc.uc_mcontext.zol.nds32_le, err);
 	__get_user_error(regs->lb, &sf->uc.uc_mcontext.zol.nds32_lb, err);
 #endif
-
+#if IS_ENABLED(CONFIG_FPU)
+	err |= restore_sigcontext_fpu(regs, &sf->uc.uc_mcontext);
+#endif
 	/*
 	 * Avoid sys_rt_sigreturn() restarting.
 	 */
@@ -153,6 +222,9 @@ asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
 	__put_user_error(regs->le, &sf->uc.uc_mcontext.zol.nds32_le, err);
 	__put_user_error(regs->lb, &sf->uc.uc_mcontext.zol.nds32_lb, err);
 #endif
+#if IS_ENABLED(CONFIG_FPU)
+	err |= setup_sigcontext_fpu(regs, &sf->uc.uc_mcontext);
+#endif
 
 	__put_user_error(current->thread.trap_no, &sf->uc.uc_mcontext.trap_no,
 			 err);
diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index 1496aab..5aa7c17 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -12,6 +12,7 @@
 
 #include <asm/proc-fns.h>
 #include <asm/unistd.h>
+#include <asm/fpu.h>
 
 #include <linux/ptrace.h>
 #include <nds32_intrinsic.h>
@@ -357,6 +358,21 @@ void do_dispatch_general(unsigned long entry, unsigned long addr,
 	} else if (type == ETYPE_RESERVED_INSTRUCTION) {
 		/* Reserved instruction */
 		do_revinsn(regs);
+	} else if (type == ETYPE_COPROCESSOR) {
+		/* Coprocessor */
+#if IS_ENABLED(CONFIG_FPU)
+		unsigned int fucop_exist = __nds32__mfsr(NDS32_SR_FUCOP_EXIST);
+		unsigned int cpid = ((itype & ITYPE_mskCPID) >> ITYPE_offCPID);
+
+		if ((cpid == FPU_CPID) &&
+		    (fucop_exist & FUCOP_EXIST_mskCP0ISFPU)) {
+			unsigned int subtype = (itype & ITYPE_mskSTYPE);
+
+			if (true == do_fpu_exception(subtype, regs))
+				return;
+		}
+#endif
+		unhandled_exceptions(entry, addr, type, regs);
 	} else if (type == ETYPE_TRAP && swid == SWID_RAISE_INTERRUPT_LEVEL) {
 		/* trap, used on v3 EDM target debugging workaround */
 		/*
-- 
1.7.1
