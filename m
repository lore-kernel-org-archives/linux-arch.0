From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Date: Thu, 13 Feb 2020 05:51:38 -0800
Message-ID: <20200213135138.GB2935@paulmck-ThinkPad-P72>
References: <20200212210139.382424693@infradead.org>
 <20200212210749.971717428@infradead.org>
 <20200212232005.GC115917@google.com>
 <20200213082716.GI14897@hirez.programming.kicks-ass.net>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730122AbgBMNvk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Feb 2020 08:51:40 -0500
Content-Disposition: inline
In-Reply-To: <20200213082716.GI14897@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

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
> 
> There is a comment in there that says ->dynticks_nmi_nesting ought to be
> odd only if we're in NMI. The only place that seems to care is
> rcu_nmi_exit_common(), and that does indeed do something different for
> IRQs vs NMIs.
> 
> So I don't think we can blindly unify this. But perhaps Paul sees a way?

The reason for the irq argument is to avoid invoking
rcu_prepare_for_idle() and rcu_dynticks_task_enter() from NMI context
from rcu_nmi_exit_common().  Similarly, we need to avoid invoking
rcu_dynticks_task_exit() and rcu_cleanup_after_idle() from NMI context
from rcu_nmi_enter_common().

It might well be that I could make these functions be NMI-safe, but
rcu_prepare_for_idle() in particular would be a bit ugly at best.
So, before looking into that, I have a question.  Given these proposed
changes, will rcu_nmi_exit_common() and rcu_nmi_enter_common() be able
to just use in_nmi()?

							Thanx, Paul
