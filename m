From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 06/27] x86/doublefault: Remove memmove() call
Date: Fri, 21 Feb 2020 14:34:22 +0100
Message-ID: <20200221134215.385886177@infradead.org>
References: <20200221133416.777099322@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org
List-Id: linux-arch.vger.kernel.org

Use of memmove() in #DF is problematic when you consider tracing and
other instrumentation.

Remove the memmove() call and simply write out what need doing; Boris
argues the ranges should not overlap.

Survives selftests/x86, specifically sigreturn_64.

(Andy ?!)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200220121727.GB507@zn.tnic
---
 arch/x86/kernel/traps.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -278,6 +278,7 @@ dotraplinkage void do_double_fault(struc
 		regs->ip == (unsigned long)native_irq_return_iret)
 	{
 		struct pt_regs *gpregs = (struct pt_regs *)this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
+		unsigned long *p = (unsigned long *)regs->sp;
 
 		/*
 		 * regs->sp points to the failing IRET frame on the
@@ -285,7 +286,11 @@ dotraplinkage void do_double_fault(struc
 		 * in gpregs->ss through gpregs->ip.
 		 *
 		 */
-		memmove(&gpregs->ip, (void *)regs->sp, 5*8);
+		gpregs->ip	= p[0];
+		gpregs->cs	= p[1];
+		gpregs->flags	= p[2];
+		gpregs->sp	= p[3];
+		gpregs->ss	= p[4];
 		gpregs->orig_ax = 0;  /* Missing (lost) #GP error code */
 
 		/*
