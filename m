From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 09/27] rcu: Rename rcu_irq_{enter,exit}_irqson()
Date: Mon, 24 Feb 2020 11:24:43 +0100
Message-ID: <20200224102443.GF14897@hirez.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.559644596@infradead.org>
 <20200221152153.15b3cf36@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:50522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBXKZI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Feb 2020 05:25:08 -0500
Content-Disposition: inline
In-Reply-To: <20200221152153.15b3cf36@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

On Fri, Feb 21, 2020 at 03:21:53PM -0500, Steven Rostedt wrote:
> On Fri, 21 Feb 2020 14:34:25 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -699,10 +699,10 @@ void rcu_irq_exit(void)
> >  /*
> >   * Wrapper for rcu_irq_exit() where interrupts are enabled.
> 
> 			where interrupts may be enabled.
> 
> >   *
> > - * If you add or remove a call to rcu_irq_exit_irqson(), be sure to test
> > + * If you add or remove a call to rcu_irq_exit_irqsave(), be sure to test
> >   * with CONFIG_RCU_EQS_DEBUG=y.
> >   */
> > -void rcu_irq_exit_irqson(void)
> > +void rcu_irq_exit_irqsave(void)
> >  {
> >  	unsigned long flags;
> >  
> > @@ -875,10 +875,10 @@ void rcu_irq_enter(void)
> >  /*
> >   * Wrapper for rcu_irq_enter() where interrupts are enabled.
> 
> 			where interrupts may be enabled.
> 

Thanks, done!
