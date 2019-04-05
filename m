Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfDEEWq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Apr 2019 00:22:46 -0400
From: guoren@kernel.org
Subject: [PATCH V2] csky: Reconstruct signal.c and entry.S
Date: Fri,  5 Apr 2019 12:22:29 +0800
Message-ID: <1554438149-13785-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, linux@roeck-us.net
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ren_guo@c-sky.com
Message-ID: <20190405042229.DbNg46uWdJq7xilUKPsmk6q6QDlod6uByi_XUMcQm-w@z>

From: Guo Ren <ren_guo@c-sky.com>

Linux kernel has provided some apis for arch signal's implementation.
For example:
	restore_saved_sigmask()
	set_current_blocked()
	restore_altstack()

But in last version of csky signal.c didn't use them and some codes are
confusing, so reconstruct signal.c with reference to riscv's code.

Now csky signal.c implementation are very close to riscv and we can
get the following benefits:
 - Clear code structure
 - The signal code of riscv and csky can be reviewed together
 - Promoting the unification of arch's signal implementation

Also modified the related code in entry.S

Changelog:
 - Fixup compile error with verify_area in signal.c

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 arch/csky/abiv1/inc/abi/entry.h  |   7 -
 arch/csky/abiv1/inc/abi/regdef.h |   2 +
 arch/csky/abiv2/inc/abi/entry.h  |   7 -
 arch/csky/abiv2/inc/abi/regdef.h |   2 +
 arch/csky/kernel/atomic.S        |  26 +--
 arch/csky/kernel/entry.S         | 152 ++++++++---------
 arch/csky/kernel/signal.c        | 343 +++++++++++++++------------------------
 7 files changed, 207 insertions(+), 332 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/entry.h b/arch/csky/abiv1/inc/abi/entry.h
index f041299..fa26461 100644
--- a/arch/csky/abiv1/inc/abi/entry.h
+++ b/arch/csky/abiv1/inc/abi/entry.h
@@ -16,9 +16,6 @@
 #define LSAVE_A4	40
 #define LSAVE_A5	44
 
-#define EPC_INCREASE	2
-#define EPC_KEEP	0
-
 .macro USPTOKSP
 	mtcr	sp, ss1
 	mfcr	sp, ss0
@@ -29,10 +26,6 @@
 	mfcr	sp, ss1
 .endm
 
-.macro INCTRAP	rx
-	addi	\rx, EPC_INCREASE
-.endm
-
 .macro	SAVE_ALL epc_inc
 	mtcr    r13, ss2
 	mfcr    r13, epsr
diff --git a/arch/csky/abiv1/inc/abi/regdef.h b/arch/csky/abiv1/inc/abi/regdef.h
index 9e7e692..729b1c3 100644
--- a/arch/csky/abiv1/inc/abi/regdef.h
+++ b/arch/csky/abiv1/inc/abi/regdef.h
@@ -21,4 +21,6 @@
 
 #define SYSTRACE_SAVENUM	2
 
+#define TRAP0_SIZE		2
+
 #endif /* __ASM_CSKY_REGDEF_H */
diff --git a/arch/csky/abiv2/inc/abi/entry.h b/arch/csky/abiv2/inc/abi/entry.h
index b4232c3..31d0aa9 100644
--- a/arch/csky/abiv2/inc/abi/entry.h
+++ b/arch/csky/abiv2/inc/abi/entry.h
@@ -14,18 +14,11 @@
 #define LSAVE_A2	32
 #define LSAVE_A3	36
 
-#define EPC_INCREASE	4
-#define EPC_KEEP	0
-
 #define KSPTOUSP
 #define USPTOKSP
 
 #define usp cr<14, 1>
 
-.macro INCTRAP	rx
-	addi	\rx, EPC_INCREASE
-.endm
-
 .macro SAVE_ALL epc_inc
 	subi    sp, 152
 	stw	tls, (sp, 0)
diff --git a/arch/csky/abiv2/inc/abi/regdef.h b/arch/csky/abiv2/inc/abi/regdef.h
index 652f5ce..77cb178 100644
--- a/arch/csky/abiv2/inc/abi/regdef.h
+++ b/arch/csky/abiv2/inc/abi/regdef.h
@@ -21,4 +21,6 @@
 
 #define SYSTRACE_SAVENUM	5
 
+#define TRAP0_SIZE		4
+
 #endif /* __ASM_CSKY_REGDEF_H */
diff --git a/arch/csky/kernel/atomic.S b/arch/csky/kernel/atomic.S
index d2357c8..5b84f11 100644
--- a/arch/csky/kernel/atomic.S
+++ b/arch/csky/kernel/atomic.S
@@ -12,11 +12,10 @@
  * If *ptr != oldval && return 1,
  * else *ptr = newval return 0.
  */
-#ifdef CONFIG_CPU_HAS_LDSTEX
 ENTRY(csky_cmpxchg)
 	USPTOKSP
 	mfcr	a3, epc
-	INCTRAP	a3
+	addi	a3, TRAP0_SIZE
 
 	subi    sp, 8
 	stw     a3, (sp, 0)
@@ -24,6 +23,7 @@ ENTRY(csky_cmpxchg)
 	stw     a3, (sp, 4)
 
 	psrset	ee
+#ifdef CONFIG_CPU_HAS_LDSTEX
 1:
 	ldex	a3, (a2)
 	cmpne	a0, a3
@@ -33,27 +33,7 @@ ENTRY(csky_cmpxchg)
 	bez	a3, 1b
 2:
 	sync.is
-	mvc	a0
-	ldw	a3, (sp, 0)
-	mtcr	a3, epc
-	ldw     a3, (sp, 4)
-	mtcr	a3, epsr
-	addi	sp, 8
-	KSPTOUSP
-	rte
-END(csky_cmpxchg)
 #else
-ENTRY(csky_cmpxchg)
-	USPTOKSP
-	mfcr	a3, epc
-	INCTRAP	a3
-
-	subi    sp, 8
-	stw     a3, (sp, 0)
-	mfcr    a3, epsr
-	stw     a3, (sp, 4)
-
-	psrset	ee
 1:
 	ldw	a3, (a2)
 	cmpne	a0, a3
@@ -61,6 +41,7 @@ ENTRY(csky_cmpxchg)
 2:
 	stw	a1, (a2)
 3:
+#endif
 	mvc	a0
 	ldw	a3, (sp, 0)
 	mtcr	a3, epc
@@ -71,6 +52,7 @@ ENTRY(csky_cmpxchg)
 	rte
 END(csky_cmpxchg)
 
+#ifndef CONFIG_CPU_HAS_LDSTEX
 /*
  * Called from tlbmodified exception
  */
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index d40fbd5..efcd7a1 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -2,19 +2,19 @@
 // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
 
 #include <linux/linkage.h>
-#include <abi/entry.h>
-#include <abi/pgtable-bits.h>
-#include <asm/errno.h>
-#include <asm/setup.h>
-#include <asm/unistd.h>
-#include <asm/asm-offsets.h>
 #include <linux/threads.h>
-#include <asm/setup.h>
+
+#include <asm/asm-offsets.h>
+#include <asm/errno.h>
 #include <asm/page.h>
+#include <asm/setup.h>
 #include <asm/thread_info.h>
+#include <asm/unistd.h>
 
-.macro tlbop_begin
-	SAVE_ALL EPC_KEEP
+#include <abi/entry.h>
+
+.macro TLBOP_PREPARE
+	SAVE_ALL 0
 #ifdef CONFIG_CPU_HAS_TLBI
 	RD_MEH	a1
 	tlbi.vaas a1
@@ -27,67 +27,66 @@
 #endif
 .endm
 
-.macro tlbop_end
-	mov     a0, sp
+.macro TLBOP_FINISH
+	mov	a0, sp
 	RD_MEH	a1
-	psrset  ee, ie
-	jbsr    do_page_fault
-	jmpi    ret_from_exception
+	psrset	ee, ie
+	jbsr	do_page_fault
+	br	ret_from_exception
 .endm
 
 .text
-
 ENTRY(csky_tlbinvalidl)
-	tlbop_begin
-	tlbop_end
+	TLBOP_PREPARE
+	TLBOP_FINISH
 
 ENTRY(csky_tlbinvalids)
-	tlbop_begin
-	tlbop_end
+	TLBOP_PREPARE
+	TLBOP_FINISH
 
 ENTRY(csky_tlbmodified)
-	tlbop_begin
+	TLBOP_PREPARE
 #ifndef CONFIG_CPU_HAS_LDSTEX
-	jbsr csky_cmpxchg_fixup
+	jbsr	csky_cmpxchg_fixup
 #endif
-	tlbop_end
+	TLBOP_FINISH
 
 ENTRY(csky_systemcall)
-	SAVE_ALL EPC_INCREASE
+	SAVE_ALL TRAP0_SIZE
 
-	psrset  ee, ie
+	psrset	ee, ie
 
-	lrw     r11, __NR_syscalls
-	cmphs   syscallid, r11		/* Check nr of syscall */
-	bt      ret_from_exception
+	lrw	r11, __NR_syscalls
+	cmphs	syscallid, r11		/* Check nr of syscall */
+	bt	ret_from_exception
 
-	lrw     r13, sys_call_table
-	ixw     r13, syscallid
-	ldw     r11, (r13)
-	cmpnei  r11, 0
-	bf      ret_from_exception
+	lrw	r13, sys_call_table
+	ixw	r13, syscallid
+	ldw	r11, (r13)
+	cmpnei	r11, 0
+	bf	ret_from_exception
 
-	mov     r9, sp
-	bmaski  r10, THREAD_SHIFT
-	andn    r9, r10
-	ldw     r8, (r9, TINFO_FLAGS)
+	mov	r9, sp
+	bmaski	r10, THREAD_SHIFT
+	andn	r9, r10
+	ldw	r8, (r9, TINFO_FLAGS)
 	ANDI_R3	r8, (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_AUDIT)
 	cmpnei	r8, 0
-	bt      csky_syscall_trace
+	bt	csky_syscall_trace
 #if defined(__CSKYABIV2__)
-	subi    sp, 8
-	stw  	r5, (sp, 0x4)
-	stw  	r4, (sp, 0x0)
-	jsr     r11                      /* Do system call */
-	addi 	sp, 8
+	subi	sp, 8
+	stw	r5, (sp, 0x4)
+	stw	r4, (sp, 0x0)
+	jsr	r11
+	addi	sp, 8
 #else
-	jsr     r11
+	jsr	r11
 #endif
-	stw     a0, (sp, LSAVE_A0)      /* Save return value */
-	jmpi    ret_from_exception
+	stw	a0, (sp, LSAVE_A0)	/* Save return value */
+	br	ret_from_exception
 
 csky_syscall_trace:
-	mov	a0, sp                  /* sp = pt_regs pointer */
+	mov	a0, sp			/* a0 = pt_regs pointer */
 	jbsr	syscall_trace_enter
 	/* Prepare args before do system call */
 	ldw	a0, (sp, LSAVE_A0)
@@ -102,21 +101,21 @@ csky_syscall_trace:
 	ldw	r6, (sp, LSAVE_A4)
 	ldw	r7, (sp, LSAVE_A5)
 #endif
-	jsr	r11                     /* Do system call */
+	jsr	r11
 #if defined(__CSKYABIV2__)
 	addi	sp, 8
 #endif
 	stw	a0, (sp, LSAVE_A0)	/* Save return value */
 
-	mov     a0, sp                  /* right now, sp --> pt_regs */
-	jbsr    syscall_trace_exit
+	mov	a0, sp			/* a0 = pt_regs pointer */
+	jbsr	syscall_trace_exit
 	br	ret_from_exception
 
 ENTRY(ret_from_kernel_thread)
 	jbsr	schedule_tail
 	mov	a0, r8
 	jsr	r9
-	jbsr	ret_from_exception
+	br	ret_from_exception
 
 ENTRY(ret_from_fork)
 	jbsr	schedule_tail
@@ -126,16 +125,14 @@ ENTRY(ret_from_fork)
 	ldw	r8, (r9, TINFO_FLAGS)
 	ANDI_R3	r8, (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_AUDIT)
 	cmpnei	r8, 0
-	bf	3f
-	mov	a0, sp			/* sp = pt_regs pointer */
+	bf	ret_from_exception
+	mov	a0, sp			/* a0 = pt_regs pointer */
 	jbsr	syscall_trace_exit
-3:
-	jbsr	ret_from_exception
 
 ret_from_exception:
 	ld	syscallid, (sp, LSAVE_PSR)
 	btsti	syscallid, 31
-	bt	1f
+	bt	1f			/* return to kernel */
 
 	/*
 	 * Load address of current->thread_info, Then get address of task_struct
@@ -145,38 +142,33 @@ ret_from_exception:
 	bmaski	r10, THREAD_SHIFT
 	andn	r9, r10
 
-resume_userspace:
 	ldw	r8, (r9, TINFO_FLAGS)
 	andi	r8, (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED)
 	cmpnei	r8, 0
 	bt	exit_work
-1:  RESTORE_ALL
+1:
+	RESTORE_ALL
 
 exit_work:
+	lrw	syscallid, ret_from_exception
+	mov	lr, syscallid		/* Return address in link */
+
 	btsti	r8, TIF_NEED_RESCHED
 	bt	work_resched
-	/* If thread_info->flag is empty, RESTORE_ALL */
-	cmpnei	r8, 0
-	bf	1b
-	mov	a0, r8
-	mov	a1, sp
-	jbsr	do_notify_resume	/* do signals */
-	br	resume_userspace
+
+	mov	a0, sp
+	mov	a1, r8
+	jmpi	do_notify_resume
 
 work_resched:
-	lrw	syscallid, ret_from_exception
-	mov	r15, syscallid		/* Return address in link */
 	jmpi	schedule
 
-ENTRY(sys_rt_sigreturn)
-	jmpi	do_rt_sigreturn
-
 ENTRY(csky_trap)
-	SAVE_ALL EPC_KEEP
+	SAVE_ALL 0
 	psrset	ee
-	mov	a0, sp                 /* Push Stack pointer arg */
-	jbsr	trap_c                 /* Call C-level trap handler */
-	jmpi	ret_from_exception
+	mov	a0, sp
+	jbsr	trap_c
+	br	ret_from_exception
 
 /*
  * Prototype from libc for abiv1:
@@ -188,7 +180,7 @@ ENTRY(csky_get_tls)
 
 	/* increase epc for continue */
 	mfcr	a0, epc
-	INCTRAP	a0
+	addi	a0, TRAP0_SIZE
 	mtcr	a0, epc
 
 	/* get current task thread_info with kernel 8K stack */
@@ -205,7 +197,7 @@ ENTRY(csky_get_tls)
 	rte
 
 ENTRY(csky_irq)
-	SAVE_ALL EPC_KEEP
+	SAVE_ALL 0
 	psrset	ee
 
 #ifdef CONFIG_PREEMPT
@@ -240,12 +232,12 @@ ENTRY(csky_irq)
 	bt	1b			/* go again */
 #endif
 2:
-	jmpi	ret_from_exception
+	br	ret_from_exception
 
 /*
- * a0 =  prev task_struct *
- * a1 =  next task_struct *
- * a0 =  return next
+ * a0 = prev task_struct *
+ * a1 = next task_struct *
+ * a0 = return next
  */
 ENTRY(__switch_to)
 	lrw	a3, TASK_THREAD
@@ -269,7 +261,7 @@ ENTRY(__switch_to)
 	ldw	a2, (a3, THREAD_SR)	/* Set next PSR */
 	mtcr	a2, psr
 
-#if  defined(__CSKYABIV2__)
+#if defined(__CSKYABIV2__)
 	addi	r7, a1, TASK_THREAD_INFO
 	ldw	tls, (r7, TINFO_TP_VALUE)
 #endif
diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
index 5a18940..04a43cf 100644
--- a/arch/csky/kernel/signal.c
+++ b/arch/csky/kernel/signal.c
@@ -1,26 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
 
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <linux/kernel.h>
 #include <linux/signal.h>
+#include <linux/uaccess.h>
 #include <linux/syscalls.h>
-#include <linux/errno.h>
-#include <linux/wait.h>
-#include <linux/ptrace.h>
-#include <linux/unistd.h>
-#include <linux/stddef.h>
-#include <linux/highuid.h>
-#include <linux/personality.h>
-#include <linux/tty.h>
-#include <linux/binfmts.h>
 #include <linux/tracehook.h>
-#include <linux/freezer.h>
-#include <linux/uaccess.h>
 
-#include <asm/setup.h>
-#include <asm/pgtable.h>
 #include <asm/traps.h>
 #include <asm/ucontext.h>
 #include <asm/vdso.h>
@@ -29,110 +13,117 @@
 
 #ifdef CONFIG_CPU_HAS_FPU
 #include <abi/fpu.h>
-
-static int restore_fpu_state(struct sigcontext *sc)
+static int restore_fpu_state(struct sigcontext __user *sc)
 {
 	int err = 0;
 	struct user_fp user_fp;
 
-	err = copy_from_user(&user_fp, &sc->sc_user_fp, sizeof(user_fp));
+	err = __copy_from_user(&user_fp, &sc->sc_user_fp, sizeof(user_fp));
 
 	restore_from_user_fp(&user_fp);
 
 	return err;
 }
 
-static int save_fpu_state(struct sigcontext *sc)
+static int save_fpu_state(struct sigcontext __user *sc)
 {
 	struct user_fp user_fp;
 
 	save_to_user_fp(&user_fp);
 
-	return copy_to_user(&sc->sc_user_fp, &user_fp, sizeof(user_fp));
+	return __copy_to_user(&sc->sc_user_fp, &user_fp, sizeof(user_fp));
 }
 #else
-static inline int restore_fpu_state(struct sigcontext *sc) { return 0; }
-static inline int save_fpu_state(struct sigcontext *sc) { return 0; }
+#define restore_fpu_state(sigcontext)	(0)
+#define save_fpu_state(sigcontext)	(0)
 #endif
 
 struct rt_sigframe {
-	int sig;
-	struct siginfo *pinfo;
-	void *puc;
 	struct siginfo info;
 	struct ucontext uc;
 };
 
-static int
-restore_sigframe(struct pt_regs *regs,
-		 struct sigcontext *sc, int *pr2)
+static long restore_sigcontext(struct pt_regs *regs,
+	struct sigcontext __user *sc)
 {
 	int err = 0;
 
-	/* Always make any pending restarted system calls return -EINTR */
-	current_thread_info()->task->restart_block.fn = do_no_restart_syscall;
-
-	err |= copy_from_user(regs, &sc->sc_pt_regs, sizeof(struct pt_regs));
+	/* sc_pt_regs is structured the same as the start of pt_regs */
+	err |= __copy_from_user(regs, &sc->sc_pt_regs, sizeof(struct pt_regs));
 
+	/* Restore the floating-point state. */
 	err |= restore_fpu_state(sc);
 
-	*pr2 = regs->a0;
 	return err;
 }
 
-asmlinkage int
-do_rt_sigreturn(void)
+SYSCALL_DEFINE0(rt_sigreturn)
 {
-	sigset_t set;
-	int a0;
 	struct pt_regs *regs = current_pt_regs();
-	struct rt_sigframe *frame = (struct rt_sigframe *)(regs->usp);
+	struct rt_sigframe __user *frame;
+	struct task_struct *task;
+	sigset_t set;
+
+	/* Always make any pending restarted system calls return -EINTR */
+	current->restart_block.fn = do_no_restart_syscall;
+
+	frame = (struct rt_sigframe __user *)regs->usp;
 
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
+
 	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
 		goto badframe;
 
-	sigdelsetmask(&set, (sigmask(SIGKILL) | sigmask(SIGSTOP)));
-	spin_lock_irq(&current->sighand->siglock);
-	current->blocked = set;
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	set_current_blocked(&set);
+
+	if (restore_sigcontext(regs, &frame->uc.uc_mcontext))
+		goto badframe;
 
-	if (restore_sigframe(regs, &frame->uc.uc_mcontext, &a0))
+	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
-	return a0;
+	return regs->a0;
 
 badframe:
-	force_sig(SIGSEGV, current);
+	task = current;
+	force_sig(SIGSEGV, task);
 	return 0;
 }
 
-static int setup_sigframe(struct sigcontext *sc, struct pt_regs *regs)
+static int setup_sigcontext(struct rt_sigframe __user *frame,
+	struct pt_regs *regs)
 {
+	struct sigcontext __user *sc = &frame->uc.uc_mcontext;
 	int err = 0;
 
-	err |= copy_to_user(&sc->sc_pt_regs, regs, sizeof(struct pt_regs));
+	err |= __copy_to_user(&sc->sc_pt_regs, regs, sizeof(struct pt_regs));
 	err |= save_fpu_state(sc);
 
 	return err;
 }
 
-static inline void *
-get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size)
+static inline void __user *get_sigframe(struct ksignal *ksig,
+	struct pt_regs *regs, size_t framesize)
 {
-	unsigned long usp;
+	unsigned long sp;
+	/* Default to using normal stack */
+	sp = regs->usp;
 
-	/* Default to using normal stack.  */
-	usp = regs->usp;
+	/*
+	 * If we are on the alternate signal stack and would overflow it, don't.
+	 * Return an always-bogus address instead so we will die with SIGSEGV.
+	 */
+	if (on_sig_stack(sp) && !likely(on_sig_stack(sp - framesize)))
+		return (void __user __force *)(-1UL);
 
-	/* This is the X/Open sanctioned signal stack switching.  */
-	if ((ka->sa.sa_flags & SA_ONSTACK) && !sas_ss_flags(usp)) {
-		if (!on_sig_stack(usp))
-			usp = current->sas_ss_sp + current->sas_ss_size;
-	}
-	return (void *)((usp - frame_size) & -8UL);
+	/* This is the X/Open sanctioned signal stack switching. */
+	sp = sigsp(sp, ksig) - framesize;
+
+	/* Align the stack frame. */
+	sp &= -8UL;
+
+	return (void __user *)sp;
 }
 
 static int
@@ -140,208 +131,128 @@ setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 {
 	struct rt_sigframe *frame;
 	int err = 0;
-
 	struct csky_vdso *vdso = current->mm->context.vdso;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
-	if (!frame)
-		return 1;
+	frame = get_sigframe(ksig, regs, sizeof(*frame));
+	if (!access_ok(frame, sizeof(*frame)))
+		return -EFAULT;
 
-	err |= __put_user(ksig->sig, &frame->sig);
-	err |= __put_user(&frame->info, &frame->pinfo);
-	err |= __put_user(&frame->uc, &frame->puc);
 	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 
-	/* Create the ucontext.  */
+	/* Create the ucontext. */
 	err |= __put_user(0, &frame->uc.uc_flags);
-	err |= __put_user(0, &frame->uc.uc_link);
-	err |= __put_user((void *)current->sas_ss_sp,
-			&frame->uc.uc_stack.ss_sp);
-	err |= __put_user(sas_ss_flags(regs->usp),
-			&frame->uc.uc_stack.ss_flags);
-	err |= __put_user(current->sas_ss_size, &frame->uc.uc_stack.ss_size);
-	err |= setup_sigframe(&frame->uc.uc_mcontext, regs);
-	err |= copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
-
+	err |= __put_user(NULL, &frame->uc.uc_link);
+	err |= __save_altstack(&frame->uc.uc_stack, regs->usp);
+	err |= setup_sigcontext(frame, regs);
+	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
-	/* Set up registers for signal handler */
-	regs->usp = (unsigned long)frame;
-	regs->pc = (unsigned long)ksig->ka.sa.sa_handler;
-	regs->lr = (unsigned long)vdso->rt_signal_retcode;
+	/* Set up to return from userspace. */
+	regs->lr = (unsigned long)(vdso->rt_signal_retcode);
 
-adjust_stack:
-	regs->a0 = ksig->sig; /* first arg is signo */
-	regs->a1 = (unsigned long)(&(frame->info));
-	regs->a2 = (unsigned long)(&(frame->uc));
-	return err;
+	/*
+	 * Set up registers for signal handler.
+	 * Registers that we don't modify keep the value they had from
+	 * user-space at the time we took the signal.
+	 * We always pass siginfo and mcontext, regardless of SA_SIGINFO,
+	 * since some things rely on this (e.g. glibc's debug/segfault.c).
+	 */
+	regs->pc  = (unsigned long)ksig->ka.sa.sa_handler;
+	regs->usp = (unsigned long)frame;
+	regs->a0  = ksig->sig;				/* a0: signal number */
+	regs->a1  = (unsigned long)(&(frame->info));	/* a1: siginfo pointer */
+	regs->a2  = (unsigned long)(&(frame->uc));	/* a2: ucontext pointer */
 
-give_sigsegv:
-	if (ksig->sig == SIGSEGV)
-		ksig->ka.sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
-	goto adjust_stack;
+	return 0;
 }
 
-/*
- * OK, we're invoking a handler
- */
-static int
-handle_signal(struct ksignal *ksig, struct pt_regs *regs)
+static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
-	int ret;
 	sigset_t *oldset = sigmask_to_save();
+	int ret;
 
-	/*
-	 * set up the stack frame, regardless of SA_SIGINFO,
-	 * and pass info anyway.
-	 */
-	ret = setup_rt_frame(ksig, oldset, regs);
+	/* Are we from a system call? */
+	if (in_syscall(regs)) {
+		/* Avoid additional syscall restarting via ret_from_exception */
+		forget_syscall(regs);
+
+		/* If so, check system call restarting.. */
+		switch (regs->a0) {
+		case -ERESTART_RESTARTBLOCK:
+		case -ERESTARTNOHAND:
+			regs->a0 = -EINTR;
+			break;
 
-	if (ret != 0) {
-		force_sigsegv(ksig->sig, current);
-		return ret;
+		case -ERESTARTSYS:
+			if (!(ksig->ka.sa.sa_flags & SA_RESTART)) {
+				regs->a0 = -EINTR;
+				break;
+			}
+			/* fallthrough */
+		case -ERESTARTNOINTR:
+			regs->a0 = regs->orig_a0;
+			regs->pc -= TRAP0_SIZE;
+			break;
+		}
 	}
 
-	/* Block the signal if we were successful. */
-	spin_lock_irq(&current->sighand->siglock);
-	sigorsets(&current->blocked, &current->blocked, &ksig->ka.sa.sa_mask);
-	if (!(ksig->ka.sa.sa_flags & SA_NODEFER))
-		sigaddset(&current->blocked, ksig->sig);
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	/* Set up the stack frame */
+	ret = setup_rt_frame(ksig, oldset, regs);
 
-	return 0;
+	signal_setup_done(ret, ksig, 0);
 }
 
-/*
- * Note that 'init' is a special process: it doesn't get signals it doesn't
- * want to handle. Thus you cannot kill init even with a SIGKILL even by
- * mistake.
- *
- * Note that we go through the signals twice: once to check the signals
- * that the kernel can handle, and then we build all the user-level signal
- * handling stack-frames in one go after that.
- */
 static void do_signal(struct pt_regs *regs)
 {
-	unsigned int retval = 0, continue_addr = 0, restart_addr = 0;
 	struct ksignal ksig;
 
-	/*
-	 * We want the common case to go fast, which
-	 * is why we may in certain cases get here from
-	 * kernel mode. Just return without doing anything
-	 * if so.
-	 */
-	if (!user_mode(regs))
+	if (get_signal(&ksig)) {
+		/* Actually deliver the signal */
+		handle_signal(&ksig, regs);
 		return;
+	}
 
-	/*
-	 * If we were from a system call, check for system call restarting...
-	 */
+	/* Did we come from a system call? */
 	if (in_syscall(regs)) {
+		/* Avoid additional syscall restarting via ret_from_exception */
 		forget_syscall(regs);
 
-		continue_addr = regs->pc;
-#if defined(__CSKYABIV2__)
-		restart_addr = continue_addr - 4;
-#else
-		restart_addr = continue_addr - 2;
-#endif
-		retval = regs->a0;
-		/*
-		 * Prepare for system call restart.  We do this here so that a
-		 * debugger will see the already changed.
-		 */
-		switch (retval) {
+		/* Restart the system call - no handlers present */
+		switch (regs->a0) {
 		case -ERESTARTNOHAND:
 		case -ERESTARTSYS:
 		case -ERESTARTNOINTR:
 			regs->a0 = regs->orig_a0;
-			regs->pc = restart_addr;
+			regs->pc -= TRAP0_SIZE;
 			break;
 		case -ERESTART_RESTARTBLOCK:
-			regs->a0 = -EINTR;
+			regs->a0 = regs->orig_a0;
+			regs_syscallid(regs) = __NR_restart_syscall;
+			regs->pc -= TRAP0_SIZE;
 			break;
 		}
 	}
 
-	if (try_to_freeze())
-		goto no_signal;
-
 	/*
-	 * Get the signal to deliver.  When running under ptrace, at this
-	 * point the debugger may change all our registers ...
+	 * If there is no signal to deliver, we just put the saved
+	 * sigmask back.
 	 */
-	if (get_signal(&ksig)) {
-		/*
-		 * Depending on the signal settings we may need to revert the
-		 * decision to restart the system call.  But skip this if a
-		 * debugger has chosen to restart at a different PC.
-		 */
-		if (regs->pc == restart_addr) {
-			if (retval == -ERESTARTNOHAND ||
-			    (retval == -ERESTARTSYS &&
-			     !(ksig.ka.sa.sa_flags & SA_RESTART))) {
-				regs->a0 = -EINTR;
-				regs->pc = continue_addr;
-			}
-		}
-
-		/* Whee!  Actually deliver the signal.  */
-		if (handle_signal(&ksig, regs) == 0) {
-			/*
-			 * A signal was successfully delivered; the saved
-			 * sigmask will have been stored in the signal frame,
-			 * and will be restored by sigreturn, so we can simply
-			 * clear the TIF_RESTORE_SIGMASK flag.
-			 */
-			if (test_thread_flag(TIF_RESTORE_SIGMASK))
-				clear_thread_flag(TIF_RESTORE_SIGMASK);
-		}
-		return;
-	}
-
-no_signal:
-	if (in_syscall(regs)) {
-		forget_syscall(regs);
-
-		/*
-		 * Handle restarting a different system call.  As above,
-		 * if a debugger has chosen to restart at a different PC,
-		 * ignore the restart.
-		 */
-		if (retval == -ERESTART_RESTARTBLOCK
-				&& regs->pc == continue_addr) {
-#if defined(__CSKYABIV2__)
-			regs->regs[3] = __NR_restart_syscall;
-			regs->pc -= 4;
-#else
-			regs->regs[9] = __NR_restart_syscall;
-			regs->pc -= 2;
-#endif
-		}
-
-		/*
-		 * If there's no signal to deliver, we just put the saved
-		 * sigmask back.
-		 */
-		if (test_thread_flag(TIF_RESTORE_SIGMASK)) {
-			clear_thread_flag(TIF_RESTORE_SIGMASK);
-			sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
-		}
-	}
+	restore_saved_sigmask();
 }
 
-asmlinkage void
-do_notify_resume(unsigned int thread_flags, struct pt_regs *regs)
+/*
+ * notification of userspace execution resumption
+ * - triggered by the _TIF_WORK_MASK flags
+ */
+asmlinkage void do_notify_resume(struct pt_regs *regs,
+	unsigned long thread_info_flags)
 {
-	if (thread_flags & _TIF_SIGPENDING)
+	/* Handle pending signal delivery */
+	if (thread_info_flags & _TIF_SIGPENDING)
 		do_signal(regs);
 
-	if (thread_flags & _TIF_NOTIFY_RESUME) {
+	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
 		clear_thread_flag(TIF_NOTIFY_RESUME);
 		tracehook_notify_resume(regs);
 	}
-- 
2.7.4
