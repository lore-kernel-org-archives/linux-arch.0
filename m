From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v12 10/21] h8300: Low level entry
Date: Mon, 11 May 2015 15:26:29 +0900
Message-ID: <1431325600-12333-11-git-send-email-ysato@users.sourceforge.jp>
References: <1431325600-12333-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431325600-12333-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/kernel/entry.S    | 414 +++++++++++++++++++++++++++++++++++++++++++
 arch/h8300/kernel/head_ram.S |  60 +++++++
 arch/h8300/kernel/head_rom.S | 110 ++++++++++++
 3 files changed, 584 insertions(+)
 create mode 100644 arch/h8300/kernel/entry.S
 create mode 100644 arch/h8300/kernel/head_ram.S
 create mode 100644 arch/h8300/kernel/head_rom.S

diff --git a/arch/h8300/kernel/entry.S b/arch/h8300/kernel/entry.S
new file mode 100644
index 0000000..797dfa8
--- /dev/null
+++ b/arch/h8300/kernel/entry.S
@@ -0,0 +1,414 @@
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
+	bne	resume_kernel:16	/* return from kernel */
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
+	bra	resume_userspace:8
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
diff --git a/arch/h8300/kernel/head_ram.S b/arch/h8300/kernel/head_ram.S
new file mode 100644
index 0000000..84ac5c3
--- /dev/null
+++ b/arch/h8300/kernel/head_ram.S
@@ -0,0 +1,60 @@
+
+#include <linux/sys.h>
+#include <linux/init.h>
+#include <asm/unistd.h>
+#include <asm/setup.h>
+#include <asm/segment.h>
+#include <asm/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/thread_info.h>
+#include <asm/errno.h>
+
+#if defined(CONFIG_CPU_H8300H)
+	.h8300h
+#define SYSCR 0xfee012
+#define IRAMTOP 0xffff20
+#endif
+#if defined(CONFIG_CPU_H8S)
+	.h8300s
+#define INTCR 0xffff31
+#define IRAMTOP 0xffc000
+#endif
+
+	__HEAD
+	.global	_start
+_start:
+	mov.l	#IRAMTOP,sp
+	/* .bss clear */
+	mov.l	#_sbss,er5
+	mov.l	#_ebss,er4
+	sub.l	er5,er4
+	shlr	er4
+	shlr	er4
+	sub.l	er2,er2
+1:
+	mov.l	er2,@er5
+	adds	#4,er5
+	dec.l	#1,er4
+	bne	1b
+	jsr	@h8300_fdt_init
+
+	/* linux kernel start */
+#if defined(CONFIG_CPU_H8300H)
+	ldc	#0xd0,ccr	/* running kernel */
+	mov.l	#SYSCR,er0
+	bclr	#3,@er0
+#endif
+#if defined(CONFIG_CPU_H8S)
+	ldc	#0x07,exr
+	bclr	#4,@INTCR:8
+	bset	#5,@INTCR:8	/* Interrupt mode 2 */
+	ldc	#0x90,ccr	/* running kernel */
+#endif
+	mov.l	#init_thread_union,sp
+	add.l	#0x2000,sp
+	jsr	@start_kernel
+
+1:
+	bra	1b
+
+	.end
diff --git a/arch/h8300/kernel/head_rom.S b/arch/h8300/kernel/head_rom.S
new file mode 100644
index 0000000..9868a41
--- /dev/null
+++ b/arch/h8300/kernel/head_rom.S
@@ -0,0 +1,110 @@
+#include <linux/init.h>
+#include <asm/thread_info.h>
+
+#if defined(CONFIG_CPU_H8300H)
+	.h8300h
+#define SYSCR 0xfee012
+#define IRAMTOP 0xffff20
+#define NR_INT 64
+#endif
+#if defined(CONFIG_CPU_H8S)
+	.h8300s
+#define INTCR 0xffff31
+#define IRAMTOP 0xffc000
+#define NR_INT 128
+#endif
+
+	__HEAD
+	.global	_start
+_start:
+	mov.l	#IRAMTOP,sp
+#if !defined(CONFIG_H8300H_SIM) && \
+    !defined(CONFIG_H8S_SIM)
+	jsr	@lowlevel_init
+
+	/* copy .data */
+	mov.l	#_begin_data,er5
+	mov.l	#_sdata,er6
+	mov.l	#_edata,er4
+	sub.l	er6,er4
+	shlr.l	er4
+	shlr.l	er4
+1:
+	mov.l	@er5+,er0
+	mov.l	er0,@er6
+	adds	#4,er6
+	dec.l	#1,er4
+	bne	1b
+	/* .bss clear */
+	mov.l	#_sbss,er5
+	mov.l	#_ebss,er4
+	sub.l	er5,er4
+	shlr	er4
+	shlr	er4
+	sub.l	er0,er0
+1:
+	mov.l	er0,@er5
+	adds	#4,er5
+	dec.l	#1,er4
+	bne	1b
+#else
+	/* get cmdline from gdb */
+	jsr	@0xcc
+	;; er0 - argc
+	;; er1 - argv
+	mov.l	#command_line,er3
+	adds	#4,er1
+	dec.l	#1,er0
+	beq	4f
+1:
+	mov.l	@er1+,er2
+2:
+	mov.b	@er2+,r4l
+	beq	3f
+	mov.b	r4l,@er3
+	adds	#1,er3
+	bra	2b
+3:
+	mov.b	#' ',r4l
+	mov.b	r4l,@er3
+	adds	#1,er3
+	dec.l	#1,er0
+	bne	1b
+	subs	#1,er3
+	mov.b	#0,r4l
+	mov.b	r4l,@er3
+4:
+#endif
+	sub.l	er0,er0
+	jsr	@h8300_fdt_init
+	/* linux kernel start */
+#if defined(CONFIG_CPU_H8300H)
+	ldc	#0xd0,ccr	/* running kernel */
+	mov.l	#SYSCR,er0
+	bclr	#3,@er0
+#endif
+#if defined(CONFIG_CPU_H8S)
+	ldc	#0x07,exr
+	bclr	#4,@INTCR:8
+	bset	#5,@INTCR:8	/* Interrupt mode 2 */
+	ldc	#0x90,ccr	/* running kernel */
+#endif
+	mov.l	#init_thread_union,sp
+	add.l	#0x2000,sp
+	jsr	@start_kernel
+
+1:
+	bra	1b
+
+#if defined(CONFIG_ROMKERNEL)
+	/* interrupt vector */
+	.section .vectors,"ax"
+	.long	_start
+	.long	_start
+vector	=	2
+	.rept	NR_INT - 2
+	.long	_interrupt_redirect_table+vector*4
+vector	=	vector + 1
+	.endr
+#endif
+	.end
-- 
2.1.4
