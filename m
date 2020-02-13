From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Date: Thu, 13 Feb 2020 08:31:12 -0500
Message-ID: <20200213133112.GD170680@google.com>
References: <20200212210139.382424693@infradead.org>
 <20200212210749.971717428@infradead.org>
 <20200212232005.GC115917@google.com>
 <20200213082716.GI14897@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40558 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbgBMNbO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 08:31:14 -0500
Received: by mail-qt1-f196.google.com with SMTP id v25so4339760qto.7
        for <linux-arch@vger.kernel.org>; Thu, 13 Feb 2020 05:31:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200213082716.GI14897@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

On Thu, Feb 13, 2020 at 09:27:16AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 12, 2020 at 06:20:05PM -0500, Joel Fernandes wrote:
> > On Wed, Feb 12, 2020 at 10:01:42PM +0100, Peter Zijlstra wrote:
> 
> > > +#define trace_rcu_enter()					\
> > > +({								\
> > > +	unsigned long state = 0;				\
> > > +	if (!rcu_is_watching())	{				\
> > > +		if (in_nmi()) {					\
> > > +			state = __TR_NMI;			\
> > > +			rcu_nmi_enter();			\
> > > +		} else {					\
> > > +			state = __TR_IRQ;			\
> > > +			rcu_irq_enter_irqsave();		\
> > 
> > I think this can be simplified. You don't need to rely on in_nmi() here. I
> > believe for NMI's, you can just call rcu_irq_enter_irqsave() and that should
> > be sufficient to get RCU watching. Paul can correct me if I'm wrong, but I am
> > pretty sure that would work.
> > 
> > In fact, I think a better naming for rcu_irq_enter_irqsave() pair could be
> > (in the first patch):
> > 
> > rcu_ensure_watching_begin();
> > rcu_ensure_watching_end();
> 
> So I hadn't looked deeply into rcu_irq_enter(), it seems to call
> rcu_nmi_enter_common(), but with @irq=true.
> 
> What exactly is the purpose of that @irq argument, and how much will it
> hurt to lie there? Will it come apart if we have @irq != !in_nmi()
> for example?

At least rcu_dynticks_task_exit() and rcu_cleanup_after_idle() seem to be
safe regardless of IRQ or NMI. If they are safe either way, we should
probably get look into removing @irq. But I'm not fully sure and looking
forward to Paul's thought on that.. I would love for us to simplify that as
well if possible.

> There is a comment in there that says ->dynticks_nmi_nesting ought to be
> odd only if we're in NMI. The only place that seems to care is
> rcu_nmi_exit_common(), and that does indeed do something different for
> IRQs vs NMIs.

I know a bit about the counters. I had previously unified it and it passed
RCU torture testing etc. (Didn't get merge as Paul wanted it done slightly
done differently) : https://lore.kernel.org/patchwork/patch/1120022/ . I am
planning to get back to finishing that soon.

About the comment on dynticks_nmi_nesting and counters, you mean this comment
right? The odd value of '1' is just to catch the outer most handler. We need
to enter/exit the EQS (extended QS) state only from the outermost handler. I
believe that would work regardless whether it is NMI and IRQ that are
nesting. If IRQs could nest within other IRQs in Linux, then that could also
very well have used the odd/ even trick.

	/*
	 * If idle from RCU viewpoint, atomically increment ->dynticks
	 * to mark non-idle and increment ->dynticks_nmi_nesting by one.
	 * Otherwise, increment ->dynticks_nmi_nesting by two.  This means
	 * if ->dynticks_nmi_nesting is equal to one, we are guaranteed
	 * to be in the outermost NMI handler that interrupted an RCU-idle
	 * period (observation due to Andy Lutomirski).
	 */

thanks,

 - Joel
