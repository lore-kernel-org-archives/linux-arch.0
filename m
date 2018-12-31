From: guoren@kernel.org
Subject: [PATCH 05/14] csky: fixup save hi,lo,dspcr regs in switch_stack.
Date: Mon, 31 Dec 2018 23:32:57 +0800
Message-ID: <1546270384-4590-5-git-send-email-guoren@kernel.org>
References: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: guoren@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, oleg@redhat.com, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

HI, LO, DSPCR registers are 807/810 related regs and no need for 610/860.
All of the regs must be saved in pt_regs and switch_stack. This patch
fixup saving dspcr reg in switch_stack and pt_regs.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/abiv1/inc/abi/switch_context.h | 17 ++++++++++++++
 arch/csky/abiv2/inc/abi/entry.h          | 28 ++++++++++++++++++++---
 arch/csky/abiv2/inc/abi/switch_context.h | 32 ++++++++++++++++++++++++++
 arch/csky/include/asm/processor.h        |  3 +--
 arch/csky/include/uapi/asm/ptrace.h      | 39 +-------------------------------
 arch/csky/kernel/asm-offsets.c           |  2 --
 arch/csky/kernel/entry.S                 | 22 ------------------
 arch/csky/kernel/ptrace.c                |  4 +++-
 8 files changed, 79 insertions(+), 68 deletions(-)
 create mode 100644 arch/csky/abiv1/inc/abi/switch_context.h
 create mode 100644 arch/csky/abiv2/inc/abi/switch_context.h

diff --git a/arch/csky/abiv1/inc/abi/switch_context.h b/arch/csky/abiv1/inc/abi/switch_context.h
new file mode 100644
index 0000000..17c8268
--- /dev/null
+++ b/arch/csky/abiv1/inc/abi/switch_context.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ABI_CSKY_PTRACE_H
+#define __ABI_CSKY_PTRACE_H
+
+struct switch_stack {
+	unsigned long r8;
+	unsigned long r9;
+	unsigned long r10;
+	unsigned long r11;
+	unsigned long r12;
+	unsigned long r13;
+	unsigned long r14;
+	unsigned long r15;
+};
+#endif /* __ABI_CSKY_PTRACE_H */
diff --git a/arch/csky/abiv2/inc/abi/entry.h b/arch/csky/abiv2/inc/abi/entry.h
index acd0521..edc5cc0 100644
--- a/arch/csky/abiv2/inc/abi/entry.h
+++ b/arch/csky/abiv2/inc/abi/entry.h
@@ -57,6 +57,8 @@
 	stw	lr, (sp, 60)
 	mflo	lr
 	stw	lr, (sp, 64)
+	mfcr	lr, cr14
+	stw	lr, (sp, 68)
 #endif
 	subi	sp, 80
 .endm
@@ -77,6 +79,8 @@
 	mthi	a0
 	ldw	a0, (sp, 144)
 	mtlo	a0
+	ldw	a0, (sp, 148)
+	mtcr	a0, cr14
 #endif
 
 	ldw     a0, (sp, 24)
@@ -93,9 +97,9 @@
 .endm
 
 .macro SAVE_SWITCH_STACK
-	subi	sp, 64
+	subi    sp, 64
 	stm	r4-r11, (sp)
-	stw	r15, (sp, 32)
+	stw	lr,  (sp, 32)
 	stw	r16, (sp, 36)
 	stw	r17, (sp, 40)
 	stw	r26, (sp, 44)
@@ -103,11 +107,29 @@
 	stw	r28, (sp, 52)
 	stw	r29, (sp, 56)
 	stw	r30, (sp, 60)
+#ifdef CONFIG_CPU_HAS_HILO
+	subi	sp, 16
+	mfhi	lr
+	stw	lr, (sp, 0)
+	mflo	lr
+	stw	lr, (sp, 4)
+	mfcr	lr, cr14
+	stw	lr, (sp, 8)
+#endif
 .endm
 
 .macro RESTORE_SWITCH_STACK
+#ifdef CONFIG_CPU_HAS_HILO
+	ldw	lr, (sp, 0)
+	mthi	lr
+	ldw	lr, (sp, 4)
+	mtlo	lr
+	ldw	lr, (sp, 8)
+	mtcr	lr, cr14
+	addi	sp, 16
+#endif
 	ldm	r4-r11, (sp)
-	ldw	r15, (sp, 32)
+	ldw	lr,  (sp, 32)
 	ldw	r16, (sp, 36)
 	ldw	r17, (sp, 40)
 	ldw	r26, (sp, 44)
diff --git a/arch/csky/abiv2/inc/abi/switch_context.h b/arch/csky/abiv2/inc/abi/switch_context.h
new file mode 100644
index 0000000..73a8124
--- /dev/null
+++ b/arch/csky/abiv2/inc/abi/switch_context.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ABI_CSKY_PTRACE_H
+#define __ABI_CSKY_PTRACE_H
+
+struct switch_stack {
+#ifdef CONFIG_CPU_HAS_HILO
+	unsigned long rhi;
+	unsigned long rlo;
+	unsigned long cr14;
+	unsigned long pad;
+#endif
+	unsigned long r4;
+	unsigned long r5;
+	unsigned long r6;
+	unsigned long r7;
+	unsigned long r8;
+	unsigned long r9;
+	unsigned long r10;
+	unsigned long r11;
+
+	unsigned long r15;
+	unsigned long r16;
+	unsigned long r17;
+	unsigned long r26;
+	unsigned long r27;
+	unsigned long r28;
+	unsigned long r29;
+	unsigned long r30;
+};
+#endif /* __ABI_CSKY_PTRACE_H */
diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/processor.h
index b174865..5ac3f32 100644
--- a/arch/csky/include/asm/processor.h
+++ b/arch/csky/include/asm/processor.h
@@ -11,6 +11,7 @@
 #include <asm/cache.h>
 #include <abi/reg_ops.h>
 #include <abi/regdef.h>
+#include <abi/switch_context.h>
 #ifdef CONFIG_CPU_HAS_FPU
 #include <abi/fpu.h>
 #endif
@@ -50,8 +51,6 @@ struct thread_struct {
 	unsigned long  ksp;       /* kernel stack pointer */
 	unsigned long  sr;        /* saved status register */
 	unsigned long  esp0;      /* points to SR of stack frame */
-	unsigned long  hi;
-	unsigned long  lo;
 
 	/* Other stuff associated with the thread. */
 	unsigned long address;      /* Last user fault */
diff --git a/arch/csky/include/uapi/asm/ptrace.h b/arch/csky/include/uapi/asm/ptrace.h
index f10d02c..a4eaa8d 100644
--- a/arch/csky/include/uapi/asm/ptrace.h
+++ b/arch/csky/include/uapi/asm/ptrace.h
@@ -36,7 +36,7 @@ struct pt_regs {
 
 	unsigned long	rhi;
 	unsigned long	rlo;
-	unsigned long	pad; /* reserved */
+	unsigned long	dcsr;
 #endif
 };
 
@@ -48,43 +48,6 @@ struct user_fp {
 	unsigned long	reserved;
 };
 
-/*
- * Switch stack for switch_to after push pt_regs.
- *
- * ABI_CSKYV2: r4 ~ r11, r15 ~ r17, r26 ~ r30;
- * ABI_CSKYV1: r8 ~ r14, r15;
- */
-struct  switch_stack {
-#if defined(__CSKYABIV2__)
-	unsigned long   r4;
-	unsigned long   r5;
-	unsigned long   r6;
-	unsigned long   r7;
-	unsigned long   r8;
-	unsigned long   r9;
-	unsigned long   r10;
-	unsigned long   r11;
-#else
-	unsigned long   r8;
-	unsigned long   r9;
-	unsigned long   r10;
-	unsigned long   r11;
-	unsigned long   r12;
-	unsigned long   r13;
-	unsigned long   r14;
-#endif
-	unsigned long   r15;
-#if defined(__CSKYABIV2__)
-	unsigned long   r16;
-	unsigned long   r17;
-	unsigned long   r26;
-	unsigned long   r27;
-	unsigned long   r28;
-	unsigned long   r29;
-	unsigned long   r30;
-#endif
-};
-
 #ifdef __KERNEL__
 
 #define PS_S	0x80000000 /* Supervisor Mode */
diff --git a/arch/csky/kernel/asm-offsets.c b/arch/csky/kernel/asm-offsets.c
index 8d3ed81..2f07670 100644
--- a/arch/csky/kernel/asm-offsets.c
+++ b/arch/csky/kernel/asm-offsets.c
@@ -24,8 +24,6 @@ int main(void)
 	DEFINE(THREAD_FESR,       offsetof(struct thread_struct, user_fp.fesr));
 	DEFINE(THREAD_FCR,        offsetof(struct thread_struct, user_fp.fcr));
 	DEFINE(THREAD_FPREG,      offsetof(struct thread_struct, user_fp.vr));
-	DEFINE(THREAD_DSPHI,      offsetof(struct thread_struct, hi));
-	DEFINE(THREAD_DSPLO,      offsetof(struct thread_struct, lo));
 
 	/* offsets into the thread_info struct */
 	DEFINE(TINFO_FLAGS,       offsetof(struct thread_info, flags));
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 2b4a851..de378e4 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -346,34 +346,12 @@ ENTRY(__switch_to)
 
 	stw	sp, (a3, THREAD_KSP)
 
-#ifdef CONFIG_CPU_HAS_HILO
-	lrw	r10, THREAD_DSPHI
-	add	r10, a3
-	mfhi	r6
-	mflo	r7
-	stw	r6, (r10, 0)		/* THREAD_DSPHI */
-	stw	r7, (r10, 4)		/* THREAD_DSPLO */
-	mfcr	r6, cr14
-	stw	r6, (r10, 8)		/* THREAD_DSPCSR */
-#endif
-
 	/* Set up next process to run */
 	lrw	a3, TASK_THREAD
 	addu	a3, a1
 
 	ldw	sp, (a3, THREAD_KSP)	/* Set next kernel sp */
 
-#ifdef CONFIG_CPU_HAS_HILO
-	lrw	r10, THREAD_DSPHI
-	add	r10, a3
-	ldw	r6, (r10, 8)		/* THREAD_DSPCSR */
-	mtcr	r6, cr14
-	ldw	r6, (r10, 0)		/* THREAD_DSPHI */
-	ldw	r7, (r10, 4)		/* THREAD_DSPLO */
-	mthi	r6
-	mtlo	r7
-#endif
-
 	ldw	a2, (a3, THREAD_SR)	/* Set next PSR */
 	mtcr	a2, psr
 
diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index 34b3025..a76d466 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -95,7 +95,9 @@ static int gpr_set(struct task_struct *target,
 		return ret;
 
 	regs.sr = task_pt_regs(target)->sr;
-
+#ifdef CONFIG_CPU_HAS_HILO
+	regs.dcsr = task_pt_regs(target)->dcsr;
+#endif
 	task_thread_info(target)->tp_value = regs.tls;
 
 	*task_pt_regs(target) = regs;
-- 
2.7.4
