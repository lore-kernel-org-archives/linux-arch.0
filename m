From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 05/27] x86: Replace ist_enter() with nmi_enter()
Date: Mon, 24 Feb 2020 11:43:46 +0100
Message-ID: <20200224104346.GJ14946@hirez.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.328642621@infradead.org>
 <CALCETrU7nezN7d3GEZ8h8HbRfvZ0+F9+Ahb7fLvZ9FVaHN9x2w@mail.gmail.com>
 <20200221202246.GA14897@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:33670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBXKoQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Feb 2020 05:44:16 -0500
Content-Disposition: inline
In-Reply-To: <20200221202246.GA14897@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com, Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Tony Luck <tony.luck@intel.com>, Frederic Weisbecker <frederic@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>

On Fri, Feb 21, 2020 at 09:22:46PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 21, 2020 at 11:05:36AM -0800, Andy Lutomirski wrote:
> 
> > > -       /*
> > > -        * Use ist_enter despite the fact that we don't use an IST stack.
> > > -        * We can be called from a kprobe in non-CONTEXT_KERNEL kernel
> > > -        * mode or even during context tracking state changes.
> > > -        *
> > > -        * This means that we can't schedule.  That's okay.
> > > -        */
> > > -       ist_enter(regs);
> > > +       nmi_enter();
> > 
> > I agree with the change, but some commentary might be nice.  Maybe
> > copy from here:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/idtentry&id=061eaa900b4f63601ab6381ab431fcef8dfd84be
> 
> Fair enough; I'll add something to #DB and #BP for that.

do_int3() is now like:

@@ -529,19 +497,18 @@ dotraplinkage void do_general_protection
 }
 NOKPROBE_SYMBOL(do_general_protection);
 
-dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
+dotraplinkage notrace void do_int3(struct pt_regs *regs, long error_code)
 {
 	if (poke_int3_handler(regs))
 		return;
 
 	/*
-	 * Use ist_enter despite the fact that we don't use an IST stack.
-	 * We can be called from a kprobe in non-CONTEXT_KERNEL kernel
-	 * mode or even during context tracking state changes.
-	 *
-	 * This means that we can't schedule.  That's okay.
+	 * Unlike any other non-IST entry, we can be called from pretty much
+	 * any location in the kernel through kprobes -- text_poke() will most
+	 * likely be handled by poke_int3_handler() above. This means this
+	 * handler is effectively NMI-like.
 	 */
-	ist_enter(regs);
+	nmi_enter();
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
 	if (kgdb_ll_trap(DIE_INT3, "int3", regs, error_code, X86_TRAP_BP,
@@ -563,7 +530,7 @@ dotraplinkage void notrace do_int3(struc
 	cond_local_irq_disable(regs);
 
 exit:
-	ist_exit(regs);
+	nmi_exit();
 }
 NOKPROBE_SYMBOL(do_int3);
 

And I'm going to have to do another (few) patches for do_debug(),
because that comment it has it patently false and I remember we had a
bunch of crud for that. Let me dig those out.
