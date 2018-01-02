From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v5 07/39] nds32: Exception handling
Date: Tue,  2 Jan 2018 16:24:39 +0800
Message-ID: <28c2c9da4da4c8b07473e97cd4a6cb953f4b507c.1514874857.git.green.hu@gmail.com>
References: <cover.1514874857.git.green.hu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1514874857.git.green.hu@gmail.com>
In-Reply-To: <cover.1514874857.git.green.hu@gmail.com>
References: <cover.1514874857.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

This patch includes the exception/interrupt entries, pt_reg structure and
related accessors.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/asm/ptrace.h |   66 +++++
 arch/nds32/kernel/ex-entry.S    |  157 ++++++++++
 arch/nds32/kernel/ex-exit.S     |  193 +++++++++++++
 arch/nds32/kernel/stacktrace.c  |   47 +++
 arch/nds32/kernel/traps.c       |  428 +++++++++++++++++++++++++++
 arch/nds32/mm/alignment.c       |  609 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 1500 insertions(+)
 create mode 100644 arch/nds32/include/asm/ptrace.h
 create mode 100644 arch/nds32/kernel/ex-entry.S
 create mode 100644 arch/nds32/kernel/ex-exit.S
 create mode 100644 arch/nds32/kernel/stacktrace.c
 create mode 100644 arch/nds32/kernel/traps.c
 create mode 100644 arch/nds32/mm/alignment.c

diff --git a/arch/nds32/include/asm/ptrace.h b/arch/nds32/include/asm/ptrace.h
new file mode 100644
index 0000000..db7856c
--- /dev/null
+++ b/arch/nds32/include/asm/ptrace.h
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __ASM_NDS32_PTRACE_H
+#define __ASM_NDS32_PTRACE_H
+
+#define PTRACE_GETREGS		12
+#define PTRACE_SETREGS		13
+#define PTRACE_GETFPREGS	14
+#define PTRACE_SETFPREGS	15
+
+#include <uapi/asm/ptrace.h>
+
+#ifndef __ASSEMBLY__
+
+struct pt_regs {
+	union {
+		struct user_pt_regs user_regs;
+		struct {
+			long uregs[26];
+			long fp;
+			long gp;
+			long lp;
+			long sp;
+			long ipc;
+#if defined(CONFIG_HWZOL)
+			long lb;
+			long le;
+			long lc;
+#else
+			long dummy[3];
+#endif
+			long syscallno;
+		};
+	};
+	long orig_r0;
+	long ir0;
+	long ipsw;
+	long pipsw;
+	long pipc;
+	long pp0;
+	long pp1;
+	long fucop_ctl;
+	long osp;
+};
+
+#include <asm/bitfield.h>
+extern void show_regs(struct pt_regs *);
+/* Avoid circular header include via sched.h */
+struct task_struct;
+extern void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
+			 int error_code, int si_code);
+
+#define arch_has_single_step()		(1)
+#define user_mode(regs)			(((regs)->ipsw & PSW_mskPOM) == 0)
+#define interrupts_enabled(regs)	(!!((regs)->ipsw & PSW_mskGIE))
+#define valid_user_regs(regs)		(user_mode(regs) && interrupts_enabled(regs))
+#define regs_return_value(regs)		((regs)->uregs[0])
+#define instruction_pointer(regs)	((regs)->ipc)
+#define user_stack_pointer(regs)        ((regs)->sp)
+#define profile_pc(regs) 		instruction_pointer(regs)
+
+#define ARCH_HAS_USER_SINGLE_STEP_INFO
+
+#endif /* __ASSEMBLY__ */
+#endif
diff --git a/arch/nds32/kernel/ex-entry.S b/arch/nds32/kernel/ex-entry.S
new file mode 100644
index 0000000..a72e83d
--- /dev/null
+++ b/arch/nds32/kernel/ex-entry.S
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/linkage.h>
+#include <asm/memory.h>
+#include <asm/nds32.h>
+#include <asm/errno.h>
+#include <asm/asm-offsets.h>
+#include <asm/page.h>
+
+#ifdef CONFIG_HWZOL
+	.macro push_zol
+	mfusr	$r14, $LB
+	mfusr	$r15, $LE
+	mfusr	$r16, $LC
+	.endm
+#endif
+
+	.macro	save_user_regs
+
+	smw.adm $sp, [$sp], $sp, #0x1
+	/* move $SP to the bottom of pt_regs */
+	addi    $sp, $sp, -OSP_OFFSET
+
+	/* push $r0 ~ $r25 */
+	smw.bim $r0, [$sp], $r25
+	/* push $fp, $gp, $lp */
+	smw.bim $sp, [$sp], $sp, #0xe
+
+	mfsr	$r12, $SP_USR
+	mfsr	$r13, $IPC
+#ifdef CONFIG_HWZOL
+	push_zol
+#endif
+	movi	$r17, -1
+	move	$r18, $r0
+	mfsr	$r19, $PSW
+	mfsr	$r20, $IPSW
+	mfsr	$r21, $P_IPSW
+	mfsr	$r22, $P_IPC
+	mfsr	$r23, $P_P0
+	mfsr	$r24, $P_P1
+	smw.bim $r12, [$sp], $r24, #0
+	addi	$sp, $sp, -FUCOP_CTL_OFFSET
+
+	/* Initialize kernel space $fp */
+	andi    $p0, $r20, #PSW_mskPOM
+	movi    $p1, #0x0
+	cmovz   $fp, $p1, $p0
+
+	andi	$r16, $r19, #PSW_mskINTL
+	slti	$r17, $r16, #4
+	bnez	$r17, 1f
+	addi	$r17, $r19, #-2
+	mtsr	$r17, $PSW
+	isb
+1:
+	/* If it was superuser mode, we don't need to update $r25 */
+	bnez	$p0, 2f
+	la	$p0, __entry_task
+	lw	$r25, [$p0]
+2:
+	.endm
+
+	.text
+
+/*
+ * Exception Vector
+ */
+exception_handlers:
+	.long	unhandled_exceptions	!Reset/NMI
+	.long	unhandled_exceptions	!TLB fill
+	.long	do_page_fault		!PTE not present
+	.long	do_dispatch_tlb_misc	!TLB misc
+	.long	unhandled_exceptions	!TLB VLPT
+	.long	unhandled_exceptions	!Machine Error
+	.long	do_debug_trap		!Debug related
+	.long	do_dispatch_general	!General exception
+	.long	eh_syscall		!Syscall
+	.long	asm_do_IRQ		!IRQ
+
+common_exception_handler:
+	save_user_regs
+	mfsr	$p0, $ITYPE
+	andi	$p0, $p0, #ITYPE_mskVECTOR
+	srli	$p0, $p0, #ITYPE_offVECTOR
+	andi	$p1, $p0, #NDS32_VECTOR_mskNONEXCEPTION
+	bnez	$p1, 1f
+	sethi	$lp, hi20(ret_from_exception)
+	ori	$lp, $lp, lo12(ret_from_exception)
+	sethi	$p1, hi20(exception_handlers)
+	ori	$p1, $p1, lo12(exception_handlers)
+	lw	$p1, [$p1+$p0<<2]
+	move	$r0, $p0
+	mfsr	$r1, $EVA
+	mfsr	$r2, $ITYPE
+	move	$r3, $sp
+	mfsr    $r4, $OIPC
+	/* enable gie if it is enabled in IPSW. */
+	mfsr	$r21, $PSW
+	andi	$r20, $r20, #PSW_mskGIE	/* r20 is $IPSW*/
+	or	$r21, $r21, $r20
+	mtsr	$r21, $PSW
+	dsb
+	jr	$p1
+
+	/* syscall */
+1:
+	addi	$p1, $p0, #-NDS32_VECTOR_offEXCEPTION
+	bnez	$p1, 2f
+	sethi	$lp, hi20(ret_from_exception)
+	ori	$lp, $lp, lo12(ret_from_exception)
+	sethi	$p1, hi20(exception_handlers)
+	ori	$p1, $p1, lo12(exception_handlers)
+	lwi	$p1, [$p1+#NDS32_VECTOR_offEXCEPTION<<2]
+	jr	$p1
+
+	/* interrupt */
+2:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	jal     arch_trace_hardirqs_off
+#endif
+	move	$r0, $sp
+	sethi	$lp, hi20(ret_from_intr)
+	ori	$lp, $lp, lo12(ret_from_intr)
+	sethi	$p0, hi20(exception_handlers)
+	ori	$p0, $p0, lo12(exception_handlers)
+	lwi	$p0, [$p0+#NDS32_VECTOR_offINTERRUPT<<2]
+	jr	$p0
+
+	.macro	EXCEPTION_VECTOR_DEBUG
+	.align 4
+	mfsr     $p0, $EDM_CTL
+	andi     $p0, $p0, EDM_CTL_mskV3_EDM_MODE
+	tnez     $p0, SWID_RAISE_INTERRUPT_LEVEL
+	.endm
+
+	.macro	EXCEPTION_VECTOR
+	.align 4
+	sethi	 $p0, hi20(common_exception_handler)
+	ori	 $p0, $p0, lo12(common_exception_handler)
+	jral.ton $p0, $p0
+	.endm
+
+	.section	".text.init", #alloc, #execinstr
+	.global	exception_vector
+exception_vector:
+.rept 6
+	EXCEPTION_VECTOR
+.endr
+	EXCEPTION_VECTOR_DEBUG
+.rept 121
+	EXCEPTION_VECTOR
+.endr
+	.align 4
+	.global	exception_vector_end
+exception_vector_end:
diff --git a/arch/nds32/kernel/ex-exit.S b/arch/nds32/kernel/ex-exit.S
new file mode 100644
index 0000000..98e1e33
--- /dev/null
+++ b/arch/nds32/kernel/ex-exit.S
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/linkage.h>
+#include <asm/unistd.h>
+#include <asm/assembler.h>
+#include <asm/nds32.h>
+#include <asm/asm-offsets.h>
+#include <asm/thread_info.h>
+#include <asm/current.h>
+
+
+
+#ifdef CONFIG_HWZOL
+	.macro pop_zol
+	mtusr	$r14, $LB
+	mtusr	$r15, $LE
+	mtusr	$r16, $LC
+	.endm
+#endif
+
+	.macro	restore_user_regs_first
+	setgie.d
+	isb
+
+	addi	$sp, $sp, FUCOP_CTL_OFFSET
+
+	lmw.adm $r12, [$sp], $r24, #0x0
+	mtsr	$r12, $SP_USR
+	mtsr	$r13, $IPC
+#ifdef CONFIG_HWZOL
+	pop_zol
+#endif
+	mtsr	$r19, $PSW
+	mtsr	$r20, $IPSW
+	mtsr    $r21, $P_IPSW
+	mtsr	$r22, $P_IPC
+	mtsr	$r23, $P_P0
+	mtsr	$r24, $P_P1
+	lmw.adm $sp, [$sp], $sp, #0xe
+	.endm
+
+	.macro	restore_user_regs_last
+	pop	$p0
+	cmovn	$sp, $p0, $p0
+
+	iret
+	nop
+
+	.endm
+
+	.macro	restore_user_regs
+	restore_user_regs_first
+	lmw.adm $r0, [$sp], $r25, #0x0
+	addi	$sp, $sp, OSP_OFFSET
+	restore_user_regs_last
+	.endm
+
+	.macro	fast_restore_user_regs
+	restore_user_regs_first
+	lmw.adm $r1, [$sp], $r25, #0x0
+	addi	$sp, $sp, OSP_OFFSET-4
+	restore_user_regs_last
+	.endm
+
+#ifdef CONFIG_PREEMPT
+	.macro	preempt_stop
+	.endm
+#else
+	.macro	preempt_stop
+	setgie.d
+	isb
+	.endm
+#define	resume_kernel	no_work_pending
+#endif
+
+ENTRY(ret_from_exception)
+	preempt_stop
+ENTRY(ret_from_intr)
+	move	why, #0				! not system call
+
+/*
+ * judge Kernel or user mode
+ *
+ */
+	lwi	$p0, [$sp+(#IPSW_OFFSET)]	! Check if in nested interrupt
+	andi	$p0, $p0, #PSW_mskINTL
+	bnez	$p0, resume_kernel		! done with iret
+	j	resume_userspace
+
+
+/*
+ * This is the fast syscall return path.  We do as little as
+ * possible here, and this includes saving $r0 back into the SVC
+ * stack.
+ * fixed: tsk - $r25, why - $r8, $r7 - syscall #, $r8 - syscall table pointer
+ */
+ENTRY(ret_fast_syscall)
+	gie_disable
+	lwi	$r1, [tsk+#TSK_TI_FLAGS]
+	andi	$p1, $r1, #_TIF_WORK_MASK
+	bnez	$p1, fast_work_pending
+	fast_restore_user_regs			! iret
+
+/*
+ * Ok, we need to do extra processing,
+ * enter the slow path returning from syscall, while pending work.
+ */
+fast_work_pending:
+	swi	$r0, [$sp+(#R0_OFFSET)]		! what is different from ret_from_exception
+work_pending:
+	andi	$p1, $r1, #_TIF_NEED_RESCHED
+	bnez	$p1, work_resched
+
+	andi	$p1, $r1, #_TIF_SIGPENDING|#_TIF_NOTIFY_RESUME
+	beqz	$p1, no_work_pending
+
+	move	$r0, $sp			! 'regs'
+	move	$r2, why
+	gie_enable
+	bal	do_notify_resume
+	beqz	$r0, ret_slow_syscall
+	bgtz	$r0, 1f
+	movi	$r7, #__NR_restart_syscall
+1:
+	lmw.bi  $r0, [sp], $r5
+	b	eh_syscall_phase_2
+work_resched:
+	bal	schedule			! path, return to user mode
+
+/*
+ * "slow" syscall return path.
+ * "why" tells us if this was a real syscall.
+ */
+ENTRY(resume_userspace)
+ENTRY(ret_slow_syscall)
+	gie_disable
+	lwi	$p0, [$sp+(#IPSW_OFFSET)]	! Check if in nested interrupt
+	andi	$p0, $p0, #PSW_mskINTL
+	bnez	$p0, no_work_pending		! done with iret
+	lwi	$r1, [tsk+#TSK_TI_FLAGS]
+	andi	$p1, $r1, #_TIF_WORK_MASK
+	bnez	$p1, work_pending		! handle work_resched, sig_pend
+
+no_work_pending:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	lwi	$p0, [$sp+(#IPSW_OFFSET)]
+	andi	$p0, $p0, #0x1
+	la	$r10, trace_hardirqs_off
+	la	$r9, trace_hardirqs_on
+	cmovz	$r9, $p0, $r10
+	jral	$r9
+#endif
+	restore_user_regs			! return from iret
+
+
+/*
+ * preemptive kernel
+ */
+#ifdef CONFIG_PREEMPT
+resume_kernel:
+	gie_disable
+	lwi	$t0, [tsk+#TSK_TI_PREEMPT]
+	bnez	$t0, no_work_pending
+need_resched:
+	lwi	$t0, [tsk+#TSK_TI_FLAGS]
+	andi	$p1, $t0, #_TIF_NEED_RESCHED
+	beqz	$p1, no_work_pending
+
+	lwi	$t0, [$sp+(#IPSW_OFFSET)]	! Interrupts off?
+	andi	$t0, $t0, #1
+	beqz	$t0, no_work_pending
+
+	jal	preempt_schedule_irq
+	b	need_resched
+#endif
+
+/*
+ * This is how we return from a fork.
+ */
+ENTRY(ret_from_fork)
+	bal	schedule_tail
+	beqz	$r6, 1f				! r6 stores fn for kernel thread
+	move	$r0, $r7			! prepare kernel thread arg
+	jral	$r6
+1:
+	lwi	$r1, [tsk+#TSK_TI_FLAGS]		! check for syscall tracing
+	move	why, #1
+	andi	$p1, $r1, #_TIF_WORK_SYSCALL_LEAVE	! are we tracing syscalls?
+	beqz	$p1, ret_slow_syscall
+	move    $r0, $sp
+	bal	syscall_trace_leave
+	b	ret_slow_syscall
diff --git a/arch/nds32/kernel/stacktrace.c b/arch/nds32/kernel/stacktrace.c
new file mode 100644
index 0000000..bc70113
--- /dev/null
+++ b/arch/nds32/kernel/stacktrace.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/sched/debug.h>
+#include <linux/sched/task_stack.h>
+#include <linux/stacktrace.h>
+
+void save_stack_trace(struct stack_trace *trace)
+{
+	save_stack_trace_tsk(current, trace);
+}
+
+void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
+{
+	unsigned long *fpn;
+	int skip = trace->skip;
+	int savesched;
+
+	if (tsk == current) {
+		__asm__ __volatile__("\tori\t%0, $fp, #0\n":"=r"(fpn));
+		savesched = 1;
+	} else {
+		fpn = (unsigned long *)thread_saved_fp(tsk);
+		savesched = 0;
+	}
+
+	while (!kstack_end(fpn) && !((unsigned long)fpn & 0x3)
+	       && (fpn >= (unsigned long *)TASK_SIZE)) {
+		unsigned long lpp, fpp;
+
+		lpp = fpn[-1];
+		fpp = fpn[FP_OFFSET];
+		if (!__kernel_text_address(lpp))
+			break;
+
+		if (savesched || !in_sched_functions(lpp)) {
+			if (skip) {
+				skip--;
+			} else {
+				trace->entries[trace->nr_entries++] = lpp;
+				if (trace->nr_entries >= trace->max_entries)
+					break;
+			}
+		}
+		fpn = (unsigned long *)fpp;
+	}
+}
diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
new file mode 100644
index 0000000..bb162a9
--- /dev/null
+++ b/arch/nds32/kernel/traps.c
@@ -0,0 +1,428 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/module.h>
+#include <linux/personality.h>
+#include <linux/kallsyms.h>
+#include <linux/hardirq.h>
+#include <linux/kdebug.h>
+#include <linux/sched/task_stack.h>
+#include <linux/uaccess.h>
+
+#include <asm/proc-fns.h>
+#include <asm/unistd.h>
+
+#include <linux/ptrace.h>
+#include <nds32_intrinsic.h>
+
+extern void show_pte(struct mm_struct *mm, unsigned long addr);
+
+/*
+ * Dump out the contents of some memory nicely...
+ */
+void dump_mem(const char *lvl, unsigned long bottom, unsigned long top)
+{
+	unsigned long first;
+	mm_segment_t fs;
+	int i;
+
+	/*
+	 * We need to switch to kernel mode so that we can use __get_user
+	 * to safely read from kernel space.  Note that we now dump the
+	 * code first, just in case the backtrace kills us.
+	 */
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+
+	pr_emerg("%s(0x%08lx to 0x%08lx)\n", lvl, bottom, top);
+
+	for (first = bottom & ~31; first < top; first += 32) {
+		unsigned long p;
+		char str[sizeof(" 12345678") * 8 + 1];
+
+		memset(str, ' ', sizeof(str));
+		str[sizeof(str) - 1] = '\0';
+
+		for (p = first, i = 0; i < 8 && p < top; i++, p += 4) {
+			if (p >= bottom && p < top) {
+				unsigned long val;
+				if (__get_user(val, (unsigned long *)p) == 0)
+					sprintf(str + i * 9, " %08lx", val);
+				else
+					sprintf(str + i * 9, " ????????");
+			}
+		}
+		pr_emerg("%s%04lx:%s\n", lvl, first & 0xffff, str);
+	}
+
+	set_fs(fs);
+}
+
+EXPORT_SYMBOL(dump_mem);
+
+static void dump_instr(struct pt_regs *regs)
+{
+	unsigned long addr = instruction_pointer(regs);
+	mm_segment_t fs;
+	char str[sizeof("00000000 ") * 5 + 2 + 1], *p = str;
+	int i;
+
+	return;
+	/*
+	 * We need to switch to kernel mode so that we can use __get_user
+	 * to safely read from kernel space.  Note that we now dump the
+	 * code first, just in case the backtrace kills us.
+	 */
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+
+	pr_emerg("Code: ");
+	for (i = -4; i < 1; i++) {
+		unsigned int val, bad;
+
+		bad = __get_user(val, &((u32 *) addr)[i]);
+
+		if (!bad) {
+			p += sprintf(p, i == 0 ? "(%08x) " : "%08x ", val);
+		} else {
+			p += sprintf(p, "bad PC value");
+			break;
+		}
+	}
+	pr_emerg("Code: %s\n", str);
+
+	set_fs(fs);
+}
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#include <linux/ftrace.h>
+static void
+get_real_ret_addr(unsigned long *addr, struct task_struct *tsk, int *graph)
+{
+	if (*addr == (unsigned long)return_to_handler) {
+		int index = tsk->curr_ret_stack;
+
+		if (tsk->ret_stack && index >= *graph) {
+			index -= *graph;
+			*addr = tsk->ret_stack[index].ret;
+			(*graph)++;
+		}
+	}
+}
+#else
+static inline void
+get_real_ret_addr(unsigned long *addr, struct task_struct *tsk, int *graph)
+{
+}
+#endif
+
+#define LOOP_TIMES (100)
+static void __dump(struct task_struct *tsk, unsigned long *base_reg)
+{
+	unsigned long ret_addr;
+	int cnt = LOOP_TIMES, graph = 0;
+	pr_emerg("Call Trace:\n");
+	if (!IS_ENABLED(CONFIG_FRAME_POINTER)) {
+		while (!kstack_end(base_reg)) {
+			ret_addr = *base_reg++;
+			if (__kernel_text_address(ret_addr)) {
+				get_real_ret_addr(&ret_addr, tsk, &graph);
+				print_ip_sym(ret_addr);
+			}
+			if (--cnt < 0)
+				break;
+		}
+	} else {
+		while (!kstack_end((void *)base_reg) &&
+		       !((unsigned long)base_reg & 0x3) &&
+		       ((unsigned long)base_reg >= TASK_SIZE)) {
+			unsigned long next_fp;
+#if !defined(NDS32_ABI_2)
+			ret_addr = base_reg[0];
+			next_fp = base_reg[1];
+#else
+			ret_addr = base_reg[-1];
+			next_fp = base_reg[FP_OFFSET];
+#endif
+			if (__kernel_text_address(ret_addr)) {
+				get_real_ret_addr(&ret_addr, tsk, &graph);
+				print_ip_sym(ret_addr);
+			}
+			if (--cnt < 0)
+				break;
+		base_reg = (unsigned long *)next_fp;
+		}
+	}
+	pr_emerg("\n");
+}
+
+void dump_stack(void)
+{
+	unsigned long *base_reg;
+	if (!IS_ENABLED(CONFIG_FRAME_POINTER))
+		__asm__ __volatile__("\tori\t%0, $sp, #0\n":"=r"(base_reg));
+	else
+		__asm__ __volatile__("\tori\t%0, $fp, #0\n":"=r"(base_reg));
+	__dump(NULL, base_reg);
+}
+
+EXPORT_SYMBOL(dump_stack);
+
+void show_stack(struct task_struct *tsk, unsigned long *sp)
+{
+	unsigned long *base_reg;
+
+	if (!tsk)
+		tsk = current;
+	if (!IS_ENABLED(CONFIG_FRAME_POINTER)) {
+		if (tsk != current)
+			base_reg = (unsigned long *)(tsk->thread.cpu_context.sp);
+		else
+			__asm__ __volatile__("\tori\t%0, $sp, #0\n":"=r"(base_reg));
+	} else {
+		if (tsk != current)
+			base_reg = (unsigned long *)(tsk->thread.cpu_context.fp);
+		else
+			__asm__ __volatile__("\tori\t%0, $fp, #0\n":"=r"(base_reg));
+	}
+	__dump(tsk, base_reg);
+	barrier();
+}
+
+DEFINE_SPINLOCK(die_lock);
+
+/*
+ * This function is protected against re-entrancy.
+ */
+void die(const char *str, struct pt_regs *regs, int err)
+{
+	struct task_struct *tsk = current;
+	static int die_counter;
+
+	console_verbose();
+	spin_lock_irq(&die_lock);
+	bust_spinlocks(1);
+
+	pr_emerg("Internal error: %s: %x [#%d]\n", str, err, ++die_counter);
+	print_modules();
+	pr_emerg("CPU: %i\n", smp_processor_id());
+	show_regs(regs);
+	pr_emerg("Process %s (pid: %d, stack limit = 0x%p)\n",
+		 tsk->comm, tsk->pid, task_thread_info(tsk) + 1);
+
+	if (!user_mode(regs) || in_interrupt()) {
+		dump_mem("Stack: ", regs->sp,
+			 THREAD_SIZE + (unsigned long)task_thread_info(tsk));
+		dump_instr(regs);
+		dump_stack();
+	}
+
+	bust_spinlocks(0);
+	spin_unlock_irq(&die_lock);
+	do_exit(SIGSEGV);
+}
+
+EXPORT_SYMBOL(die);
+
+void die_if_kernel(const char *str, struct pt_regs *regs, int err)
+{
+	if (user_mode(regs))
+		return;
+
+	die(str, regs, err);
+}
+
+int bad_syscall(int n, struct pt_regs *regs)
+{
+	siginfo_t info;
+
+	if (current->personality != PER_LINUX) {
+		send_sig(SIGSEGV, current, 1);
+		return regs->uregs[0];
+	}
+
+	info.si_signo = SIGILL;
+	info.si_errno = 0;
+	info.si_code = ILL_ILLTRP;
+	info.si_addr = (void __user *)instruction_pointer(regs) - 4;
+
+	force_sig_info(SIGILL, &info, current);
+	die_if_kernel("Oops - bad syscall", regs, n);
+	return regs->uregs[0];
+}
+
+void __pte_error(const char *file, int line, unsigned long val)
+{
+	pr_emerg("%s:%d: bad pte %08lx.\n", file, line, val);
+}
+
+void __pmd_error(const char *file, int line, unsigned long val)
+{
+	pr_emerg("%s:%d: bad pmd %08lx.\n", file, line, val);
+}
+
+void __pgd_error(const char *file, int line, unsigned long val)
+{
+	pr_emerg("%s:%d: bad pgd %08lx.\n", file, line, val);
+}
+
+extern char *exception_vector, *exception_vector_end;
+void __init trap_init(void)
+{
+	return;
+}
+
+void __init early_trap_init(void)
+{
+	unsigned long ivb = 0;
+	unsigned long base = PAGE_OFFSET;
+
+	memcpy((unsigned long *)base, (unsigned long *)&exception_vector,
+	       ((unsigned long)&exception_vector_end -
+		(unsigned long)&exception_vector));
+	ivb = __nds32__mfsr(NDS32_SR_IVB);
+	/* Check platform support. */
+	if (((ivb & IVB_mskNIVIC) >> IVB_offNIVIC) < 2)
+		panic
+		    ("IVIC mode is not allowed on the platform with interrupt controller\n");
+	__nds32__mtsr((ivb & ~IVB_mskESZ) | (IVB_valESZ16 << IVB_offESZ) |
+		      IVB_BASE, NDS32_SR_IVB);
+	__nds32__mtsr(INT_MASK_INITAIAL_VAL, NDS32_SR_INT_MASK);
+
+	/*
+	 * 0x800 = 128 vectors * 16byte.
+	 * It should be enough to flush a page.
+	 */
+	cpu_cache_wbinval_page(base, true);
+}
+
+void do_debug_trap(unsigned long entry, unsigned long addr,
+		   unsigned long type, struct pt_regs *regs)
+{
+	if (notify_die(DIE_OOPS, "Oops", regs, addr, type, SIGTRAP)
+	    == NOTIFY_STOP)
+		return;
+
+	if (user_mode(regs)) {
+		/* trap_signal */
+		send_sigtrap(current, regs, 0, TRAP_BRKPT);
+	} else {
+		/* kernel_trap */
+		if (!fixup_exception(regs))
+			die("unexpected kernel_trap", regs, 0);
+	}
+}
+
+void unhandled_interruption(struct pt_regs *regs)
+{
+	siginfo_t si;
+	pr_emerg("unhandled_interruption\n");
+	show_regs(regs);
+	if (!user_mode(regs))
+		do_exit(SIGKILL);
+	si.si_signo = SIGKILL;
+	si.si_errno = 0;
+	force_sig_info(SIGKILL, &si, current);
+}
+
+void unhandled_exceptions(unsigned long entry, unsigned long addr,
+			  unsigned long type, struct pt_regs *regs)
+{
+	siginfo_t si;
+	pr_emerg("Unhandled Exception: entry: %lx addr:%lx itype:%lx\n", entry,
+		 addr, type);
+	show_regs(regs);
+	if (!user_mode(regs))
+		do_exit(SIGKILL);
+	si.si_signo = SIGKILL;
+	si.si_errno = 0;
+	si.si_addr = (void *)addr;
+	force_sig_info(SIGKILL, &si, current);
+}
+
+extern int do_page_fault(unsigned long entry, unsigned long addr,
+			 unsigned int error_code, struct pt_regs *regs);
+
+/*
+ * 2:DEF dispatch for TLB MISC exception handler
+*/
+
+void do_dispatch_tlb_misc(unsigned long entry, unsigned long addr,
+			  unsigned long type, struct pt_regs *regs)
+{
+	type = type & (ITYPE_mskINST | ITYPE_mskETYPE);
+	if ((type & ITYPE_mskETYPE) < 5) {
+		/* Permission exceptions */
+		do_page_fault(entry, addr, type, regs);
+	} else
+		unhandled_exceptions(entry, addr, type, regs);
+}
+
+void do_revinsn(struct pt_regs *regs)
+{
+	siginfo_t si;
+	pr_emerg("Reserved Instruction\n");
+	show_regs(regs);
+	if (!user_mode(regs))
+		do_exit(SIGILL);
+	si.si_signo = SIGILL;
+	si.si_errno = 0;
+	force_sig_info(SIGILL, &si, current);
+}
+
+#ifdef CONFIG_ALIGNMENT_TRAP
+extern int unalign_access_mode;
+extern int do_unaligned_access(unsigned long entry, unsigned long addr,
+			unsigned long type, struct pt_regs *regs);
+#endif
+void do_dispatch_general(unsigned long entry, unsigned long addr,
+			 unsigned long itype, struct pt_regs *regs,
+			 unsigned long oipc)
+{
+	unsigned int swid = itype >> ITYPE_offSWID;
+	unsigned long type = itype & (ITYPE_mskINST | ITYPE_mskETYPE);
+	if (type == ETYPE_ALIGNMENT_CHECK) {
+#ifdef CONFIG_ALIGNMENT_TRAP
+		/* Alignment check */
+		if (unalign_access_mode & 0x3) {
+			int ret;
+			ret = do_unaligned_access(entry, addr, type, regs);
+
+			if (ret == 0)
+				return;
+
+			if (ret == -EFAULT)
+				pr_emerg
+				    ("Unhandled unaligned access exception\n");
+		}
+#endif
+		do_page_fault(entry, addr, type, regs);
+	} else if (type == ETYPE_RESERVED_INSTRUCTION) {
+		/* Reserved instruction */
+		do_revinsn(regs);
+	} else if (type == ETYPE_TRAP && swid == SWID_RAISE_INTERRUPT_LEVEL) {
+		/* trap, used on v3 EDM target debugging workaround */
+		/*
+		 * DIPC(OIPC) is passed as parameter before
+		 * interrupt is enabled, so the DIPC will not be corrupted
+		 * even though interrupts are coming in
+		 */
+		/*
+		 * 1. update ipc
+		 * 2. update pt_regs ipc with oipc
+		 * 3. update pt_regs ipsw (clear DEX)
+		 */
+		__asm__ volatile ("mtsr %0, $IPC\n\t"::"r" (oipc));
+		regs->ipc = oipc;
+		if (regs->pipsw & PSW_mskDEX) {
+			pr_emerg
+			    ("Nested Debug exception is possibly happened\n");
+			pr_emerg("ipc:%08x pipc:%08x\n",
+				 (unsigned int)regs->ipc,
+				 (unsigned int)regs->pipc);
+		}
+		do_debug_trap(entry, addr, itype, regs);
+		regs->ipsw &= ~PSW_mskDEX;
+	} else
+		unhandled_exceptions(entry, addr, type, regs);
+}
diff --git a/arch/nds32/mm/alignment.c b/arch/nds32/mm/alignment.c
new file mode 100644
index 0000000..653b89b
--- /dev/null
+++ b/arch/nds32/mm/alignment.c
@@ -0,0 +1,609 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/proc_fs.h>
+#include <linux/uaccess.h>
+#include <linux/sysctl.h>
+#include <asm/unaligned.h>
+
+#define DEBUG(enable, tagged, ...)				\
+	do{							\
+		if (enable) {					\
+			if (tagged)				\
+			pr_warn("[ %30s() ] ", __func__);	\
+			pr_warn(__VA_ARGS__);			\
+		}						\
+	} while (0)
+
+#define RT(inst)	(((inst) >> 20) & 0x1FUL)
+#define RA(inst)	(((inst) >> 15) & 0x1FUL)
+#define RB(inst)	(((inst) >> 10) & 0x1FUL)
+#define SV(inst)	(((inst) >> 8) & 0x3UL)
+#define IMM(inst)	(((inst) >> 0) & 0x3FFFUL)
+
+#define RA3(inst)	(((inst) >> 3) & 0x7UL)
+#define RT3(inst)	(((inst) >> 6) & 0x7UL)
+#define IMM3U(inst)	(((inst) >> 0) & 0x7UL)
+
+#define RA5(inst)	(((inst) >> 0) & 0x1FUL)
+#define RT4(inst)	(((inst) >> 5) & 0xFUL)
+
+#define __get8_data(val,addr,err)	\
+	__asm__(					\
+	"1:	lbi.bi	%1, [%2], #1\n"			\
+	"2:\n"						\
+	"	.pushsection .text.fixup,\"ax\"\n"	\
+	"	.align	2\n"				\
+	"3:	movi	%0, #1\n"			\
+	"	j	2b\n"				\
+	"	.popsection\n"				\
+	"	.pushsection __ex_table,\"a\"\n"	\
+	"	.align	3\n"				\
+	"	.long	1b, 3b\n"			\
+	"	.popsection\n"				\
+	: "=r" (err), "=&r" (val), "=r" (addr)		\
+	: "0" (err), "2" (addr))
+
+#define get16_data(addr, val_ptr)				\
+	do {							\
+		unsigned int err = 0, v, a = addr;		\
+		__get8_data(v,a,err);				\
+		*val_ptr =  v << 0;				\
+		__get8_data(v,a,err);				\
+		*val_ptr |= v << 8;				\
+		if (err)					\
+			goto fault;				\
+		*val_ptr = le16_to_cpu(*val_ptr);		\
+	} while(0)
+
+#define get32_data(addr, val_ptr)				\
+	do {							\
+		unsigned int err = 0, v, a = addr;		\
+		__get8_data(v,a,err);				\
+		*val_ptr =  v << 0;				\
+		__get8_data(v,a,err);				\
+		*val_ptr |= v << 8;				\
+		__get8_data(v,a,err);				\
+		*val_ptr |= v << 16;				\
+		__get8_data(v,a,err);				\
+		*val_ptr |= v << 24;				\
+		if (err)					\
+			goto fault;				\
+		*val_ptr = le32_to_cpu(*val_ptr);		\
+	} while(0)
+
+#define get_data(addr, val_ptr, len)				\
+	if (len == 2)						\
+		get16_data(addr, val_ptr);			\
+	else							\
+		get32_data(addr, val_ptr);
+
+
+#define set16_data(addr, val)					\
+	do {							\
+		unsigned int err = 0, *ptr = addr ;		\
+		val = le32_to_cpu(val);				\
+		__asm__(					\
+                "1:	sbi.bi 	%2, [%1], #1\n"			\
+                "	srli 	%2, %2, #8\n"			\
+                "2:	sbi	%2, [%1]\n"			\
+		"3:\n"						\
+		"	.pushsection .text.fixup,\"ax\"\n"	\
+		"	.align	2\n"				\
+		"4:	movi	%0, #1\n"			\
+		"	j	3b\n"				\
+		"	.popsection\n"				\
+		"	.pushsection __ex_table,\"a\"\n"	\
+		"	.align	3\n"				\
+		"	.long	1b, 4b\n"			\
+		"	.long	2b, 4b\n"			\
+		"	.popsection\n"				\
+		: "=r" (err), "+r" (ptr), "+r" (val)		\
+		: "0" (err)					\
+		);						\
+		if (err)					\
+			goto fault;				\
+	} while(0)
+
+#define set32_data(addr, val)					\
+	do {							\
+		unsigned int err = 0, *ptr = addr ;		\
+		val = le32_to_cpu(val);				\
+		__asm__(					\
+                "1:	sbi.bi 	%2, [%1], #1\n"			\
+                "	srli 	%2, %2, #8\n"			\
+                "2:	sbi.bi 	%2, [%1], #1\n"			\
+                "	srli 	%2, %2, #8\n"			\
+                "3:	sbi.bi 	%2, [%1], #1\n"			\
+                "	srli 	%2, %2, #8\n"			\
+                "4:	sbi 	%2, [%1]\n"			\
+		"5:\n"						\
+		"	.pushsection .text.fixup,\"ax\"\n"	\
+		"	.align	2\n"				\
+		"6:	movi	%0, #1\n"			\
+		"	j	5b\n"				\
+		"	.popsection\n"				\
+		"	.pushsection __ex_table,\"a\"\n"	\
+		"	.align	3\n"				\
+		"	.long	1b, 6b\n"			\
+		"	.long	2b, 6b\n"			\
+		"	.long	3b, 6b\n"			\
+		"	.long	4b, 6b\n"			\
+		"	.popsection\n"				\
+		: "=r" (err), "+r" (ptr), "+r" (val)		\
+		: "0" (err)					\
+		);						\
+		if (err)					\
+			goto fault;				\
+	} while(0)
+#define set_data(addr, val, len)				\
+	if (len == 2)						\
+		set16_data(addr, val);				\
+	else							\
+		set32_data(addr, val);
+extern pte_t va_present(struct mm_struct *mm, unsigned long addr);
+extern pte_t va_kernel_present(unsigned long addr);
+extern int va_readable(struct pt_regs *regs, unsigned long addr);
+extern int va_writable(struct pt_regs *regs, unsigned long addr);
+
+int unalign_access_mode = 0, unalign_access_debug = 0;
+
+static inline unsigned long *idx_to_addr(struct pt_regs *regs, int idx)
+{
+	/* this should be consistent with ptrace.h */
+	if (idx >= 0 && idx <= 25)	/* R0-R25 */
+		return &regs->uregs[0] + idx;
+	else if (idx >= 28 && idx <= 30)	/* FP, GP, LP */
+		return &regs->fp + (idx - 28);
+	else if (idx == 31)	/* SP */
+		return &regs->sp;
+	else
+		return NULL;	/* cause a segfault */
+}
+
+static inline unsigned long get_inst(unsigned long addr)
+{
+	return be32_to_cpu(get_unaligned((u32 *) addr));
+}
+
+
+static inline unsigned long sign_extend(unsigned long val, int len)
+{
+	unsigned long ret = 0;
+	unsigned char *s, *t;
+	int i = 0;
+
+	val = cpu_to_le32(val);
+
+	s = (void *)&val;
+	t = (void *)&ret;
+
+	while (i++ < len)
+		*t++ = *s++;
+
+	if (((*(t - 1)) & 0x80) && (i < 4)) {
+
+		while (i++ <= 4)
+			*t++ = 0xff;
+	}
+
+	return le32_to_cpu(ret);
+}
+
+static inline int do_16(unsigned long inst, struct pt_regs *regs)
+{
+	int imm, regular, load, len, addr_mode, idx_mode;
+	unsigned long unaligned_addr, target_val, source_idx, target_idx,
+	    shift = 0;
+	switch ((inst >> 9) & 0x3F) {
+
+	case 0x12:		/* LHI333    */
+		imm = 1;
+		regular = 1;
+		load = 1;
+		len = 2;
+		addr_mode = 3;
+		idx_mode = 3;
+		break;
+	case 0x10:		/* LWI333    */
+		imm = 1;
+		regular = 1;
+		load = 1;
+		len = 4;
+		addr_mode = 3;
+		idx_mode = 3;
+		break;
+	case 0x11:		/* LWI333.bi */
+		imm = 1;
+		regular = 0;
+		load = 1;
+		len = 4;
+		addr_mode = 3;
+		idx_mode = 3;
+		break;
+	case 0x1A:		/* LWI450    */
+		imm = 0;
+		regular = 1;
+		load = 1;
+		len = 4;
+		addr_mode = 5;
+		idx_mode = 4;
+		break;
+	case 0x16:		/* SHI333    */
+		imm = 1;
+		regular = 1;
+		load = 0;
+		len = 2;
+		addr_mode = 3;
+		idx_mode = 3;
+		break;
+	case 0x14:		/* SWI333    */
+		imm = 1;
+		regular = 1;
+		load = 0;
+		len = 4;
+		addr_mode = 3;
+		idx_mode = 3;
+		break;
+	case 0x15:		/* SWI333.bi */
+		imm = 1;
+		regular = 0;
+		load = 0;
+		len = 4;
+		addr_mode = 3;
+		idx_mode = 3;
+		break;
+	case 0x1B:		/* SWI450    */
+		imm = 0;
+		regular = 1;
+		load = 0;
+		len = 4;
+		addr_mode = 5;
+		idx_mode = 4;
+		break;
+
+	default:
+		return -EFAULT;
+	}
+
+	if (addr_mode == 3) {
+		unaligned_addr = *idx_to_addr(regs, RA3(inst));
+		source_idx = RA3(inst);
+	} else {
+		unaligned_addr = *idx_to_addr(regs, RA5(inst));
+		source_idx = RA5(inst);
+	}
+
+	if (idx_mode == 3)
+		target_idx = RT3(inst);
+	else
+		target_idx = RT4(inst);
+
+	if (imm)
+		shift = IMM3U(inst) * len;
+
+	if (regular)
+		unaligned_addr += shift;
+
+	if (load) {
+		if (!access_ok(VERIFY_READ, (void *)unaligned_addr, len))
+			return -EACCES;
+
+		get_data(unaligned_addr,&target_val,len);
+		*idx_to_addr(regs, target_idx) = target_val;
+	} else {
+		if (!access_ok(VERIFY_WRITE, (void *)unaligned_addr, len))
+			return -EACCES;
+		target_val = *idx_to_addr(regs, target_idx);
+		set_data((void *)unaligned_addr, target_val, len);
+	}
+
+	if(!regular)
+		*idx_to_addr(regs, source_idx) = unaligned_addr + shift;
+	regs->ipc += 2;
+
+	return 0;
+fault:
+	return -EACCES;
+}
+
+static inline int do_32(unsigned long inst, struct pt_regs *regs)
+{
+	int imm, regular, load, len, sign_ext;
+	unsigned long unaligned_addr, target_val, shift;
+
+	unaligned_addr = *idx_to_addr(regs, RA(inst));
+
+	switch ((inst >> 25) << 1) {
+
+	case 0x02:		/* LHI       */
+		imm = 1;
+		regular = 1;
+		load = 1;
+		len = 2;
+		sign_ext = 0;
+		break;
+	case 0x0A:		/* LHI.bi    */
+		imm = 1;
+		regular = 0;
+		load = 1;
+		len = 2;
+		sign_ext = 0;
+		break;
+	case 0x22:		/* LHSI      */
+		imm = 1;
+		regular = 1;
+		load = 1;
+		len = 2;
+		sign_ext = 1;
+		break;
+	case 0x2A:		/* LHSI.bi   */
+		imm = 1;
+		regular = 0;
+		load = 1;
+		len = 2;
+		sign_ext = 1;
+		break;
+	case 0x04:		/* LWI       */
+		imm = 1;
+		regular = 1;
+		load = 1;
+		len = 4;
+		sign_ext = 0;
+		break;
+	case 0x0C:		/* LWI.bi    */
+		imm = 1;
+		regular = 0;
+		load = 1;
+		len = 4;
+		sign_ext = 0;
+		break;
+	case 0x12:		/* SHI       */
+		imm = 1;
+		regular = 1;
+		load = 0;
+		len = 2;
+		sign_ext = 0;
+		break;
+	case 0x1A:		/* SHI.bi    */
+		imm = 1;
+		regular = 0;
+		load = 0;
+		len = 2;
+		sign_ext = 0;
+		break;
+	case 0x14:		/* SWI       */
+		imm = 1;
+		regular = 1;
+		load = 0;
+		len = 4;
+		sign_ext = 0;
+		break;
+	case 0x1C:		/* SWI.bi    */
+		imm = 1;
+		regular = 0;
+		load = 0;
+		len = 4;
+		sign_ext = 0;
+		break;
+
+	default:
+		switch (inst & 0xff) {
+
+		case 0x01:	/* LH        */
+			imm = 0;
+			regular = 1;
+			load = 1;
+			len = 2;
+			sign_ext = 0;
+			break;
+		case 0x05:	/* LH.bi     */
+			imm = 0;
+			regular = 0;
+			load = 1;
+			len = 2;
+			sign_ext = 0;
+			break;
+		case 0x11:	/* LHS       */
+			imm = 0;
+			regular = 1;
+			load = 1;
+			len = 2;
+			sign_ext = 1;
+			break;
+		case 0x15:	/* LHS.bi    */
+			imm = 0;
+			regular = 0;
+			load = 1;
+			len = 2;
+			sign_ext = 1;
+			break;
+		case 0x02:	/* LW        */
+			imm = 0;
+			regular = 1;
+			load = 1;
+			len = 4;
+			sign_ext = 0;
+			break;
+		case 0x06:	/* LW.bi     */
+			imm = 0;
+			regular = 0;
+			load = 1;
+			len = 4;
+			sign_ext = 0;
+			break;
+		case 0x09:	/* SH        */
+			imm = 0;
+			regular = 1;
+			load = 0;
+			len = 2;
+			sign_ext = 0;
+			break;
+		case 0x0D:	/* SH.bi     */
+			imm = 0;
+			regular = 0;
+			load = 0;
+			len = 2;
+			sign_ext = 0;
+			break;
+		case 0x0A:	/* SW        */
+			imm = 0;
+			regular = 1;
+			load = 0;
+			len = 4;
+			sign_ext = 0;
+			break;
+		case 0x0E:	/* SW.bi     */
+			imm = 0;
+			regular = 0;
+			load = 0;
+			len = 4;
+			sign_ext = 0;
+			break;
+
+		default:
+			return -EFAULT;
+		}
+	}
+
+	if (imm)
+		shift = IMM(inst) * len;
+	else
+		shift = *idx_to_addr(regs, RB(inst)) << SV(inst);
+
+
+	if (regular)
+		unaligned_addr += shift;
+
+	if (load) {
+
+		if (!access_ok(VERIFY_READ, (void *)unaligned_addr, len))
+			return -EACCES;
+
+		get_data(unaligned_addr,&target_val,len);
+
+		if (sign_ext)
+			*idx_to_addr(regs, RT(inst)) =
+			    sign_extend(target_val, len);
+		else
+			*idx_to_addr(regs, RT(inst)) = target_val;
+	} else {
+
+		if (!access_ok(VERIFY_WRITE, (void *)unaligned_addr, len))
+			return -EACCES;
+
+		target_val = *idx_to_addr(regs, RT(inst));
+		set_data((void *)unaligned_addr, target_val, len);
+	}
+
+	if(!regular)
+		*idx_to_addr(regs, RA(inst)) = unaligned_addr + shift;
+
+	regs->ipc += 4;
+
+	return 0;
+fault:
+	return -EACCES;
+}
+
+int do_unaligned_access(unsigned long entry, unsigned long addr,
+			unsigned long type, struct pt_regs *regs)
+{
+	unsigned long inst;
+	int ret = -EFAULT;
+
+	inst = get_inst(regs->ipc);
+
+	DEBUG((unalign_access_debug > 0), 1,
+	      "Faulting addr: 0x%08lx, pc: 0x%08lx [inst: 0x%08lx ]\n"
+	      "unalign_access_mode: %x\n"
+		, addr,regs->ipc, inst, unalign_access_mode);
+
+	if ((user_mode(regs) && (unalign_access_mode & 0x01))
+	    || (!user_mode(regs) && (unalign_access_mode & 0x02))) {
+
+		mm_segment_t seg = get_fs();
+
+		user_mode(regs)?set_fs(USER_DS):set_fs(KERNEL_DS);
+
+		if (inst & 0x80000000)
+		{
+			ret = do_16((inst >> 16) & 0xffff, regs);
+		}
+		else
+		{
+			ret = do_32(inst, regs);
+		}
+		set_fs(seg);
+	}
+
+	return ret;
+}
+
+#ifdef CONFIG_PROC_FS
+
+static
+int unalign_access_policy(struct ctl_table *ctl, int write,
+			     void __user * buffer, size_t * lenp, loff_t * ppos)
+{
+	int val = *(int *)(ctl->data);
+	loff_t pos = *ppos;
+	struct ctl_table lctl;
+	int ret;
+
+	lctl = *ctl;
+	lctl.data = &val;
+	ret = proc_dointvec(&lctl, write, buffer, lenp, ppos);
+
+	if (ret)
+		*ppos = pos;
+	else {
+		*(int *)ctl->data = val;
+		if (val > 3)
+			return -EINVAL;
+	}
+
+	return ret;
+}
+
+static struct ctl_table alignment_tbl[3] = {
+	{
+		.procname = "enable_mode",
+		.data = &unalign_access_mode,
+		.maxlen = sizeof(unalign_access_mode),
+		.mode = 0666,
+		.proc_handler = unalign_access_policy,
+	},
+	{
+		.procname	= "debug",
+		.data		= &unalign_access_debug,
+		.maxlen		= sizeof(unalign_access_mode),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec
+	},
+	{}
+};
+
+static struct ctl_table nds32_sysctl_table[2] = {
+	{
+	 .procname = "unaligned_acess",
+	 .mode = 0555,
+	 .child = alignment_tbl},
+	{}
+};
+static struct ctl_path nds32_path[2] = {
+	{.procname = "nds32" },
+	{}
+};
+
+/*
+ * Initialize nds32 alignment-correction interface
+ */
+static int __init nds32_sysctl_init(void)
+{
+	register_sysctl_paths(nds32_path, nds32_sysctl_table);
+	return 0;
+}
+
+__initcall(nds32_sysctl_init);
+#endif /* CONFIG_PROC_FS */
-- 
1.7.9.5
