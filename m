Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262124AbUKVPbD@vger.kernel.org>
Received: from canuck.infradead.org ([205.233.218.70]:17168 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261387AbUKVPaY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Nov 2004 10:30:24 -0500
Subject: Re: [PATCH 9/11] - UML - fix signal mask on delivery error
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1100507760.8015.54.camel@localhost.localdomain>
References: <200411130201.iAD210pT005889@ccure.user-mode-linux.org>
	 <20041112163442.45fc966f.akpm@osdl.org>
	 <200411142213.iAEMDHbV013050@ccure.user-mode-linux.org>
	 <1100507760.8015.54.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1101137404.8191.7494.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Mon, 22 Nov 2004 15:30:05 +0000
Content-Transfer-Encoding: 7bit
To: Jeff Dike <jdike@addtoit.com>
Cc: paulus@samba.org, Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, cagney@redhat.com
List-ID: <linux-arch.vger.kernel.org>


On Mon, 2004-11-15 at 08:35 +0000, David Woodhouse wrote:
> On Sun, 2004-11-14 at 17:13 -0500, Jeff Dike wrote:
> > 	step_sighdlr.c - PTRACE_SINGLESTEPs into a signal handler, if I'm
> > reading the code right, fails on i386
> 
> I haven't looked at this particular test but given the description I
> think it'll fail on ppc64 too. This ought to fix it for 2.6, along with
> single-stepping over syscalls and single-stepping over sigreturn (which
> is a special case). 

I fixed it too hard -- we don't need to stop _twice_ at the same
instruction on entry to a signal handler; once will suffice...

--- linux-2.6.9/arch/ppc64/kernel/entry.S.sstep	2004-10-18 22:53:06.000000000 +0100
+++ linux-2.6.9/arch/ppc64/kernel/entry.S	2004-11-09 18:32:30.000000000 +0000
@@ -162,7 +162,7 @@ syscall_error_cont:
 
 	/* check for syscall tracing or audit */
 	ld	r9,TI_FLAGS(r12)
-	andi.	r0,r9,_TIF_SYSCALL_T_OR_A
+	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP)
 	bne-	syscall_exit_trace
 syscall_exit_trace_cont:
 
@@ -317,7 +317,7 @@ _GLOBAL(ppc64_rt_sigreturn)
 	blt	syscall_exit
 	clrrdi	r4,r1,THREAD_SHIFT
 	ld	r4,TI_FLAGS(r4)
-	andi.	r4,r4,_TIF_SYSCALL_T_OR_A
+	andi.	r4,r4,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP)
 	beq+	81f
 	bl	.do_syscall_trace_leave
 81:	b	.ret_from_except
--- linux-2.6.9/arch/ppc64/kernel/ptrace.c.sstep	2004-10-18 22:54:55.000000000 +0100
+++ linux-2.6.9/arch/ppc64/kernel/ptrace.c	2004-11-09 18:17:29.000000000 +0000
@@ -318,7 +318,8 @@ void do_syscall_trace_leave(void)
 	if (unlikely(current->audit_context))
 		audit_syscall_exit(current, 0);	/* FIXME: pass pt_regs */
 
-	if (test_thread_flag(TIF_SYSCALL_TRACE)
+	if ((test_thread_flag(TIF_SYSCALL_TRACE)
+	     || test_thread_flag(TIF_SINGLESTEP))
 	    && (current->ptrace & PT_PTRACED))
 		do_syscall_trace();
 }
--- linux-2.6.9/include/asm-ppc64/ptrace-common.h.sstep	2004-10-18 22:54:37.000000000 +0100
+++ linux-2.6.9/include/asm-ppc64/ptrace-common.h	2004-11-09 18:45:29.000000000 +0000
@@ -58,6 +58,7 @@ static inline void set_single_step(struc
 	struct pt_regs *regs = task->thread.regs;
 	if (regs != NULL)
 		regs->msr |= MSR_SE;
+	set_ti_thread_flag(task->thread_info, TIF_SINGLESTEP);
 }
 
 static inline void clear_single_step(struct task_struct *task)
@@ -65,6 +66,7 @@ static inline void clear_single_step(str
 	struct pt_regs *regs = task->thread.regs;
 	if (regs != NULL)
 		regs->msr &= ~MSR_SE;
+	clear_ti_thread_flag(task->thread_info, TIF_SINGLESTEP);
 }
 
 #endif /* _PPC64_PTRACE_COMMON_H */
--- linux-2.6.9/include/asm-ppc64/thread_info.h.sstep	2004-10-18 22:53:21.000000000 +0100
+++ linux-2.6.9/include/asm-ppc64/thread_info.h	2004-11-09 18:25:59.000000000 +0000
@@ -97,6 +97,7 @@ static inline struct thread_info *curren
 #define TIF_RUN_LIGHT		6	/* iSeries run light */
 #define TIF_ABI_PENDING		7	/* 32/64 bit switch needed */
 #define TIF_SYSCALL_AUDIT	8	/* syscall auditing active */
+#define TIF_SINGLESTEP		9	/* singlestepping active */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -108,6 +109,7 @@ static inline struct thread_info *curren
 #define _TIF_RUN_LIGHT		(1<<TIF_RUN_LIGHT)
 #define _TIF_ABI_PENDING	(1<<TIF_ABI_PENDING)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
+#define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_SYSCALL_T_OR_A	(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
 
 #define _TIF_USER_WORK_MASK	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | \




-- 
dwmw2
