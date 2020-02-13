From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Date: Thu, 13 Feb 2020 09:27:16 +0100
Message-ID: <20200213082716.GI14897@hirez.programming.kicks-ass.net>
References: <20200212210139.382424693@infradead.org>
 <20200212210749.971717428@infradead.org>
 <20200212232005.GC115917@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:37828 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbgBMI15 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 03:27:57 -0500
Content-Disposition: inline
In-Reply-To: <20200212232005.GC115917@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

On Wed, Feb 12, 2020 at 06:20:05PM -0500, Joel Fernandes wrote:
> On Wed, Feb 12, 2020 at 10:01:42PM +0100, Peter Zijlstra wrote:

> > +#define trace_rcu_enter()					\
> > +({								\
> > +	unsigned long state = 0;				\
> > +	if (!rcu_is_watching())	{				\
> > +		if (in_nmi()) {					\
> > +			state = __TR_NMI;			\
> > +			rcu_nmi_enter();			\
> > +		} else {					\
> > +			state = __TR_IRQ;			\
> > +			rcu_irq_enter_irqsave();		\
> 
> I think this can be simplified. You don't need to rely on in_nmi() here. I
> believe for NMI's, you can just call rcu_irq_enter_irqsave() and that should
> be sufficient to get RCU watching. Paul can correct me if I'm wrong, but I am
> pretty sure that would work.
> 
> In fact, I think a better naming for rcu_irq_enter_irqsave() pair could be
> (in the first patch):
> 
> rcu_ensure_watching_begin();
> rcu_ensure_watching_end();

So I hadn't looked deeply into rcu_irq_enter(), it seems to call
rcu_nmi_enter_common(), but with @irq=true.

What exactly is the purpose of that @irq argument, and how much will it
hurt to lie there? Will it come apart if we have @irq != !in_nmi()
for example?

There is a comment in there that says ->dynticks_nmi_nesting ought to be
odd only if we're in NMI. The only place that seems to care is
rcu_nmi_exit_common(), and that does indeed do something different for
IRQs vs NMIs.

So I don't think we can blindly unify this. But perhaps Paul sees a way?
