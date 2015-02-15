Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:11558 "EHLO
	mail1.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646AbbBOHt4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 15 Feb 2015 02:49:56 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v3 03/15] h8300: Exception and Interrupt handling
Date: Sun, 15 Feb 2015 16:49:21 +0900
Message-ID: <1423986573-2329-4-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1423986573-2329-1-git-send-email-ysato@users.sourceforge.jp>
References: <1423986573-2329-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20150215074921.c_trOoRZDQEJtdCahdz9ml470cgl0OSvmDgxLPiwoKA@z>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/kernel/entry.S | 418 ++++++++++++++++++++++++++++++++++++++++++++++
 arch/h8300/kernel/irq.c   | 106 ++++++++++++
 arch/h8300/kernel/traps.c | 166 ++++++++++++++++++
 3 files changed, 690 insertions(+)
 create mode 100644 arch/h8300/kernel/entry.S
 create mode 100644 arch/h8300/kernel/irq.c
 create mode 100644 arch/h8300/kernel/traps.c

diff --git a/arch/h8300/kernel/entry.S b/arch/h8300/kernel/entry.S
new file mode 100644
index 0000000..ba50639
--- /dev/null
+++ b/arch/h8300/kernel/entry.S
@@ -0,0 +1,418 @@
+/*
+ *
+ *  linux/arch/h8300/kernel/entry.S
+ *
+ *  Yoshinori Sato <ysato@users.sourceforge.jp>
+ *  David McCullough <davidm@snapgear.com>
+ *
+ */
+
+/*
+ *  entry.S
+ *  include exception/interrupt gateway
+ *          system call entry
+ */
+
+#include <linux/sys.h>
+#include <asm/unistd.h>
+#include <asm/setup.h>
+#include <asm/segment.h>
+#include <asm/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/thread_info.h>
+#include <asm/errno.h>
+
+#if defined(CONFIG_CPU_H8300H)
+#define USERRET 8
+INTERRUPTS = 64
+	.h8300h
+	.macro	SHLL2 reg
+	shll.l	\reg
+	shll.l	\reg
+	.endm
+	.macro	SHLR2 reg
+	shlr.l	\reg
+	shlr.l	\reg
+	.endm
+	.macro	SAVEREGS
+	mov.l	er0,@-sp
+	mov.l	er1,@-sp
+	mov.l	er2,@-sp
+	mov.l	er3,@-sp
+	.endm
+	.macro	RESTOREREGS
+	mov.l	@sp+,er3
+	mov.l	@sp+,er2
+	.endm
+	.macro	SAVEEXR
+	.endm
+	.macro	RESTOREEXR
+	.endm
+#endif
+#if defined(CONFIG_CPU_H8S)
+#define USERRET 10
+#define USEREXR 8
+INTERRUPTS = 128
+	.h8300s
+	.macro	SHLL2 reg
+	shll.l	#2,\reg
+	.endm
+	.macro	SHLR2 reg
+	shlr.l	#2,\reg
+	.endm
+	.macro	SAVEREGS
+	stm.l	er0-er3,@-sp
+	.endm
+	.macro	RESTOREREGS
+	ldm.l	@sp+,er2-er3
+	.endm
+	.macro	SAVEEXR
+	mov.w	@(USEREXR:16,er0),r1
+	mov.w	r1,@(LEXR-LER3:16,sp)		/* copy EXR */
+	.endm
+	.macro	RESTOREEXR
+	mov.w	@(LEXR-LER1:16,sp),r1		/* restore EXR */
+	mov.b	r1l,r1h
+	mov.w	r1,@(USEREXR:16,er0)
+	.endm
+#endif
+
+
+/* CPU context save/restore macros. */
+
+	.macro	SAVE_ALL
+	mov.l	er0,@-sp
+	stc	ccr,r0l				/* check kernel mode */
+	btst	#4,r0l
+	bne	5f
+
+	/* user mode */
+	mov.l	sp,@_sw_usp
+	mov.l	@sp,er0				/* restore saved er0 */
+	orc	#0x10,ccr			/* switch kernel stack */
+	mov.l	@_sw_ksp,sp
+	sub.l	#(LRET-LORIG),sp		/* allocate LORIG - LRET */
+	SAVEREGS
+	mov.l   @_sw_usp,er0
+	mov.l   @(USERRET:16,er0),er1           /* copy the RET addr */
+	mov.l   er1,@(LRET-LER3:16,sp)
+	SAVEEXR
+
+	mov.l	@(LORIG-LER3:16,sp),er0
+	mov.l	er0,@(LER0-LER3:16,sp)		/* copy ER0 */
+	mov.w	e1,r1				/* e1 highbyte = ccr */
+	and	#0xef,r1h			/* mask mode? flag */
+	bra	6f
+5:
+	/* kernel mode */
+	mov.l	@sp,er0				/* restore saved er0 */
+	subs	#2,sp				/* set dummy ccr */
+	subs	#4,sp				/* set dummp sp */
+	SAVEREGS
+	mov.w	@(LRET-LER3:16,sp),r1		/* copy old ccr */
+6:
+	mov.b	r1h,r1l
+	mov.b	#0,r1h
+	mov.w	r1,@(LCCR-LER3:16,sp)		/* set ccr */
+	mov.l	@_sw_usp,er2
+	mov.l	er2,@(LSP-LER3:16,sp)		/* set usp */
+	mov.l	er6,@-sp			/* syscall arg #6 */
+	mov.l	er5,@-sp			/* syscall arg #5 */
+	mov.l	er4,@-sp			/* syscall arg #4 */
+	.endm					/* r1 = ccr */
+
+	.macro	RESTORE_ALL
+	mov.l	@sp+,er4
+	mov.l	@sp+,er5
+	mov.l	@sp+,er6
+	RESTOREREGS
+	mov.w	@(LCCR-LER1:16,sp),r0		/* check kernel mode */
+	btst	#4,r0l
+	bne	7f
+
+	orc	#0xc0,ccr
+	mov.l	@(LSP-LER1:16,sp),er0
+	mov.l	@(LER0-LER1:16,sp),er1		/* restore ER0 */
+	mov.l	er1,@er0
+	RESTOREEXR
+	mov.w	@(LCCR-LER1:16,sp),r1		/* restore the RET addr */
+	mov.b	r1l,r1h
+	mov.b	@(LRET+1-LER1:16,sp),r1l
+	mov.w	r1,e1
+	mov.w	@(LRET+2-LER1:16,sp),r1
+	mov.l	er1,@(USERRET:16,er0)
+
+	mov.l	@sp+,er1
+	add.l	#(LRET-LER1),sp			/* remove LORIG - LRET */
+	mov.l	sp,@_sw_ksp
+	andc	#0xef,ccr			/* switch to user mode */
+	mov.l	er0,sp
+	bra	8f
+7:
+	mov.l	@sp+,er1
+	add.l	#10,sp
+8:
+	mov.l	@sp+,er0
+	adds	#4,sp				/* remove the sw created LVEC */
+	rte
+	.endm
+
+.globl _system_call
+.globl ret_from_exception
+.globl ret_from_fork
+.globl ret_from_kernel_thread
+.globl ret_from_interrupt
+.globl _interrupt_redirect_table
+.globl _sw_ksp,_sw_usp
+.globl _resume
+.globl _interrupt_entry
+.globl _trace_break
+.globl _nmi
+
+#if defined(CONFIG_ROMKERNEL)
+	.section .int_redirect,"ax"
+_interrupt_redirect_table:
+#if defined(CONFIG_CPU_H8300H)
+	.rept	7
+	.long	0
+	.endr
+#endif
+#if defined(CONFIG_CPU_H8S)
+	.rept	5
+	.long	0
+	.endr
+	jmp	@_trace_break
+	.long	0
+#endif
+
+	jsr	@_interrupt_entry		/* NMI */
+	jmp	@_system_call			/* TRAPA #0 (System call) */
+	.long	0
+	.long	0
+	jmp	@_trace_break			/* TRAPA #3 (breakpoint) */
+	.rept	INTERRUPTS-12
+	jsr	@_interrupt_entry
+	.endr
+#endif
+#if defined(CONFIG_RAMKERNEL)
+.globl _interrupt_redirect_table
+	.section .bss
+_interrupt_redirect_table:
+	.space	4
+#endif
+
+	.section .text
+	.align	2
+_interrupt_entry:
+	SAVE_ALL
+/* r1l is saved ccr */	
+	mov.l	sp,er0
+	add.l	#LVEC,er0
+	btst	#4,r1l
+	bne	1f
+	/* user LVEC */
+	mov.l	@_sw_usp,er0
+	adds	#4,er0
+1:
+	mov.l	@er0,er0			/* LVEC address */
+#if defined(CONFIG_ROMKERNEL)
+	sub.l	#_interrupt_redirect_table,er0
+#endif
+#if defined(CONFIG_RAMKERNEL)
+	mov.l	@_interrupt_redirect_table,er1
+	sub.l	er1,er0
+#endif
+	SHLR2	er0
+	dec.l	#1,er0
+	mov.l	sp,er1
+	subs	#4,er1				/* adjust ret_pc */
+#if defined(CONFIG_CPU_H8S)
+	orc	#7,exr
+#endif
+	jsr	@do_IRQ
+	jmp	@ret_from_interrupt
+
+_system_call:
+	subs	#4,sp				/* dummy LVEC */
+	SAVE_ALL
+	/* er0: syscall nr */
+	andc	#0xbf,ccr
+	mov.l	er0,er4
+
+	/* save top of frame */
+	mov.l	sp,er0
+	jsr	@set_esp0
+	mov.l	sp,er2
+	and.w	#0xe000,r2
+	mov.l	@(TI_FLAGS:16,er2),er2
+	and.w	#_TIF_WORK_SYSCALL_MASK,r2
+	beq	1f
+	mov.l	sp,er0
+	jsr	@do_syscall_trace_enter
+1:
+	cmp.l	#__NR_syscalls,er4
+	bcc	badsys
+	SHLL2	er4
+	mov.l	#_sys_call_table,er0
+	add.l	er4,er0
+	mov.l	@er0,er4
+	beq	ret_from_exception:16
+	mov.l	@(LER1:16,sp),er0
+	mov.l	@(LER2:16,sp),er1
+	mov.l	@(LER3:16,sp),er2
+	jsr	@er4
+	mov.l	er0,@(LER0:16,sp)		/* save the return value */
+	mov.l	sp,er2
+	and.w	#0xe000,r2
+	mov.l	@(TI_FLAGS:16,er2),er2
+	and.w	#_TIF_WORK_SYSCALL_MASK,r2
+	beq	2f
+	mov.l	sp,er0
+	jsr	@do_syscall_trace_leave
+2:
+	orc	#0xc0,ccr
+	bra	resume_userspace
+
+badsys:
+	mov.l	#-ENOSYS,er0
+	mov.l	er0,@(LER0:16,sp)
+	bra	resume_userspace
+
+#if !defined(CONFIG_PREEMPT)
+#define resume_kernel restore_all
+#endif
+
+ret_from_exception:
+#if defined(CONFIG_PREEMPT)
+	orc	#0xc0,ccr
+#endif
+ret_from_interrupt:
+	mov.b	@(LCCR+1:16,sp),r0l
+	btst	#4,r0l
+#if defined(CONFIG_PREEMPT)
+	bne	resume_kernel:16	/* return from kernel */
+#else
+	bne	restore_all:16		/* return from kernel */
+#endif
+resume_userspace:
+	andc	#0xbf,ccr
+	mov.l	sp,er4
+	and.w	#0xe000,r4		/* er4 <- current thread info */
+	mov.l	@(TI_FLAGS:16,er4),er1
+	and.l	#_TIF_WORK_MASK,er1
+	beq	restore_all:8
+work_pending:
+	btst	#TIF_NEED_RESCHED,r1l
+	bne	work_resched:8
+	/* work notifysig */
+	mov.l	sp,er0
+	subs	#4,er0			/* er0: pt_regs */
+	jsr	@do_notify_resume
+	bra	restore_all:8
+work_resched:
+	mov.l	sp,er0
+	jsr	@set_esp0
+	jsr	@schedule
+	bra	resume_userspace:8
+restore_all:
+	RESTORE_ALL			/* Does RTE */
+
+#if defined(CONFIG_PREEMPT)
+resume_kernel:
+	mov.l	@(TI_PRE_COUNT:16,er4),er0
+	bne	restore_all:8
+need_resched:
+	mov.l	@(TI_FLAGS:16,er4),er0
+	btst	#TIF_NEED_RESCHED,r0l
+	beq	restore_all:8
+	mov.b	@(LCCR+1:16,sp),r0l	/* Interrupt Enabled? */
+	bmi	restore_all:8
+	mov.l	sp,er0
+	jsr	@set_esp0
+	jsr	@preempt_schedule_irq
+	bra	need_resched:8
+#endif
+
+ret_from_fork:
+	mov.l	er2,er0
+	jsr	@schedule_tail
+	jmp	@ret_from_exception
+
+ret_from_kernel_thread:
+	mov.l	er2,er0
+	jsr	@schedule_tail
+	mov.l	@(LER4:16,sp),er0
+	mov.l	@(LER5:16,sp),er1
+	jsr	@er1
+	jmp	@ret_from_exception
+
+_resume:
+	/*
+	 * Beware - when entering resume, offset of tss is in d1,
+	 * prev (the current task) is in a0, next (the new task)
+	 * is in a1 and d2.b is non-zero if the mm structure is
+	 * shared between the tasks, so don't change these
+	 * registers until their contents are no longer needed.
+	 */
+
+	/* save sr */
+	sub.w	r3,r3
+	stc	ccr,r3l
+	mov.w	r3,@(THREAD_CCR+2:16,er0)
+
+	/* disable interrupts */
+	orc	#0xc0,ccr
+	mov.l	@_sw_usp,er3
+	mov.l	er3,@(THREAD_USP:16,er0)
+	mov.l	sp,@(THREAD_KSP:16,er0)
+
+	/* Skip address space switching if they are the same. */
+	/* FIXME: what did we hack out of here, this does nothing! */
+
+	mov.l	@(THREAD_USP:16,er1),er0
+	mov.l	er0,@_sw_usp
+	mov.l	@(THREAD_KSP:16,er1),sp
+
+	/* restore status register */
+	mov.w	@(THREAD_CCR+2:16,er1),r3
+
+	ldc	r3l,ccr
+	rts
+
+_trace_break:
+	subs	#4,sp
+	SAVE_ALL
+	sub.l	er1,er1
+	dec.l	#1,er1
+	mov.l	er1,@(LORIG,sp)
+	mov.l	sp,er0
+	jsr	@set_esp0
+	mov.l	@_sw_usp,er0
+	mov.l	@er0,er1
+	mov.w	@(-2:16,er1),r2
+	cmp.w	#0x5730,r2
+	beq	1f
+	subs	#2,er1
+	mov.l	er1,@er0
+1:
+	and.w	#0xff,e1
+	mov.l	er1,er0
+	jsr	@trace_trap
+	jmp	@ret_from_exception
+
+_nmi:
+	subs	#4, sp
+	mov.l	er0, @-sp
+	mov.l	@_interrupt_redirect_table, er0
+	add.l	#8*4, er0
+	mov.l	er0, @(4,sp)
+	mov.l	@sp+, er0
+	jmp	@_interrupt_entry
+
+	.section	.bss
+_sw_ksp:
+	.space	4
+_sw_usp:
+	.space	4
+
+	.end
diff --git a/arch/h8300/kernel/irq.c b/arch/h8300/kernel/irq.c
new file mode 100644
index 0000000..dbff621
--- /dev/null
+++ b/arch/h8300/kernel/irq.c
@@ -0,0 +1,106 @@
+/*
+ * linux/arch/h8300/kernel/irq.c
+ *
+ * Copyright 2014 Yoshinori Sato <ysato@users.sourceforge.jp>
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <asm/traps.h>
+
+#ifdef CONFIG_RAMKERNEL
+#define CPU_VECTOR ((unsigned long *)0x000000)
+#define ADDR_MASK (0xffffff)
+
+extern unsigned long *_interrupt_redirect_table;
+void _interrupt_entry(void);
+
+typedef void (*h8300_vector)(void);
+
+static const h8300_vector __initconst trap_table[] = {
+	0, 0, 0, 0,
+	_trace_break,
+	0, 0,
+	_nmi,
+	_system_call,
+	0, 0,
+	_trace_break,
+};
+
+static unsigned long __init *get_vector_address(void)
+{
+	unsigned long *rom_vector = CPU_VECTOR;
+	unsigned long base, tmp;
+	int vec_no;
+
+	base = rom_vector[EXT_IRQ0] & ADDR_MASK;
+
+	/* check romvector format */
+	for (vec_no = EXT_IRQ0 + 1; vec_no <= EXT_IRQ0+EXT_IRQS; vec_no++) {
+		if ((base+(vec_no - EXT_IRQ0)*4) !=
+		    (rom_vector[vec_no] & ADDR_MASK))
+			return NULL;
+	}
+
+	/* ramvector base address */
+	base -= EXT_IRQ0*4;
+
+	/* writerble? */
+	tmp = ~(*(volatile unsigned long *)base);
+	(*(volatile unsigned long *)base) = tmp;
+	if ((*(volatile unsigned long *)base) != tmp)
+		return NULL;
+	return (unsigned long *)base;
+}
+
+static void __init setup_vector(void)
+{
+	int i;
+	unsigned long *ramvec, *ramvec_p;
+	const h8300_vector *trap_entry;
+
+	ramvec = get_vector_address();
+	if (ramvec == NULL)
+		panic("interrupt vector serup failed.");
+	else
+		pr_debug("virtual vector at 0x%p\n", ramvec);
+
+	/* create redirect table */
+	ramvec_p = ramvec;
+	trap_entry = trap_table;
+	for (i = 0; i < NR_IRQS; i++) {
+		if (i < 12) {
+			if (*trap_entry)
+				*ramvec_p = VECTOR(*trap_entry);
+			ramvec_p++;
+			trap_entry++;
+		} else
+			*ramvec_p++ = REDIRECT(_interrupt_entry);
+	}
+	_interrupt_redirect_table = ramvec;
+}
+#else
+void setup_vector(void)
+{
+	/* noting do */
+}
+#endif
+
+void __init init_IRQ(void)
+{
+	int c;
+
+	setup_vector();
+	h8300_init_ipr();
+
+	for (c = 0; c < NR_IRQS; c++)
+		irq_set_chip_and_handler(c, &IRQ_CHIP, handle_simple_irq);
+}
+
+asmlinkage void do_IRQ(int irq)
+{
+	irq_enter();
+	generic_handle_irq(irq);
+	irq_exit();
+}
diff --git a/arch/h8300/kernel/traps.c b/arch/h8300/kernel/traps.c
new file mode 100644
index 0000000..5a15f42
--- /dev/null
+++ b/arch/h8300/kernel/traps.c
@@ -0,0 +1,166 @@
+/*
+ * linux/arch/h8300/boot/traps.c -- general exception handling code
+ * H8/300 support Yoshinori Sato <ysato@users.sourceforge.jp>
+ *
+ * Cloned from Linux/m68k.
+ *
+ * No original Copyright holder listed,
+ * Probable original (C) Roman Zippel (assigned DJD, 1999)
+ *
+ * Copyright 1999-2000 D. Jeff Dionne, <jeff@rt-control.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/bug.h>
+
+#include <asm/irq.h>
+#include <asm/traps.h>
+#include <asm/page.h>
+
+static DEFINE_SPINLOCK(die_lock);
+
+/*
+ * this must be called very early as the kernel might
+ * use some instruction that are emulated on the 060
+ */
+
+void __init base_trap_init(void)
+{
+}
+
+void __init trap_init(void)
+{
+}
+
+asmlinkage void set_esp0 (unsigned long ssp)
+{
+	current->thread.esp0 = ssp;
+}
+
+/*
+ *	Generic dumping code. Used for panic and debug.
+ */
+
+static void dump(struct pt_regs *fp)
+{
+	unsigned long	*sp;
+	unsigned char	*tp;
+	int		i;
+
+	pr_info("\nCURRENT PROCESS:\n\n");
+	pr_info("COMM=%s PID=%d\n", current->comm, current->pid);
+	if (current->mm) {
+		pr_info("TEXT=%08x-%08x DATA=%08x-%08x BSS=%08x-%08x\n",
+			(int) current->mm->start_code,
+			(int) current->mm->end_code,
+			(int) current->mm->start_data,
+			(int) current->mm->end_data,
+			(int) current->mm->end_data,
+			(int) current->mm->brk);
+		pr_info("USER-STACK=%08x  KERNEL-STACK=%08lx\n\n",
+			(int) current->mm->start_stack,
+			(int) PAGE_SIZE+(unsigned long)current);
+	}
+
+	show_regs(fp);
+	pr_info("\nCODE:");
+	tp = ((unsigned char *) fp->pc) - 0x20;
+	for (sp = (unsigned long *) tp, i = 0; (i < 0x40);  i += 4) {
+		if ((i % 0x10) == 0)
+			pr_info("\n%08x: ", (int) (tp + i));
+		pr_info("%08x ", (int) *sp++);
+	}
+	pr_info("\n");
+
+	pr_info("\nKERNEL STACK:");
+	tp = ((unsigned char *) fp) - 0x40;
+	for (sp = (unsigned long *) tp, i = 0; (i < 0xc0); i += 4) {
+		if ((i % 0x10) == 0)
+			pr_info("\n%08x: ", (int) (tp + i));
+		pr_info("%08x ", (int) *sp++);
+	}
+	pr_info("\n");
+	if (STACK_MAGIC != *(unsigned long *)((unsigned long)current+PAGE_SIZE))
+		pr_info("(Possibly corrupted stack page??)\n");
+
+	pr_info("\n\n");
+}
+
+void die(const char *str, struct pt_regs *fp, unsigned long err)
+{
+	static int diecount;
+
+	oops_enter();
+
+	console_verbose();
+	spin_lock_irq(&die_lock);
+	report_bug(fp->pc, fp);
+	pr_crit("%s: %04lx [#%d] ", str, err & 0xffff, ++diecount);
+	dump(fp);
+
+	spin_unlock_irq(&die_lock);
+	do_exit(SIGSEGV);
+}
+
+extern char _start, _etext;
+#define check_kernel_text(addr) \
+	((addr >= (unsigned long)(&_start)) && \
+	 (addr <  (unsigned long)(&_etext)))
+
+static int kstack_depth_to_print = 24;
+
+void show_stack(struct task_struct *task, unsigned long *esp)
+{
+	unsigned long *stack,  addr;
+	int i;
+
+	if (esp == NULL)
+		esp = (unsigned long *) &esp;
+
+	stack = esp;
+
+	pr_info("Stack from %08lx:", (unsigned long)stack);
+	for (i = 0; i < kstack_depth_to_print; i++) {
+		if (((unsigned long)stack & (THREAD_SIZE - 1)) == 0)
+			break;
+		if (i % 8 == 0)
+			pr_info("\n       ");
+		pr_info(" %08lx", *stack++);
+	}
+
+	pr_info("\nCall Trace:");
+	i = 0;
+	stack = esp;
+	while (((unsigned long)stack & (THREAD_SIZE - 1)) != 0) {
+		addr = *stack++;
+		/*
+		 * If the address is either in the text segment of the
+		 * kernel, or in the region which contains vmalloc'ed
+		 * memory, it *may* be the address of a calling
+		 * routine; if so, print it so that someone tracing
+		 * down the cause of the crash will be able to figure
+		 * out the call path that was taken.
+		 */
+		if (check_kernel_text(addr)) {
+			if (i % 4 == 0)
+				pr_info("\n       ");
+			pr_info(" [<%08lx>]", addr);
+			i++;
+		}
+	}
+	pr_info("\n");
+}
+
+void show_trace_task(struct task_struct *tsk)
+{
+	show_stack(tsk, (unsigned long *)tsk->thread.esp0);
+}
-- 
2.1.4

