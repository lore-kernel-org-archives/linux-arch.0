From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 08/22] rcu,tracing: Create trace_rcu_{enter,exit}()
Date: Wed, 19 Feb 2020 16:58:28 +0100
Message-ID: <20200219155828.GF18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.832297480@infradead.org>
 <20200219104903.46686b81@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:44750 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSP6t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 10:58:49 -0500
Content-Disposition: inline
In-Reply-To: <20200219104903.46686b81@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

On Wed, Feb 19, 2020 at 10:49:03AM -0500, Steven Rostedt wrote:
> On Wed, 19 Feb 2020 15:47:32 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:

> > These helpers are macros because of header-hell; they're placed here
> > because of the proximity to nmi_{enter,exit{().

^^^^

> > +#define trace_rcu_enter()					\
> > +({								\
> > +	unsigned long state = 0;				\
> > +	if (!rcu_is_watching())	{				\
> > +		rcu_irq_enter_irqsave();			\
> > +		state = 1;					\
> > +	}							\
> > +	state;							\
> > +})
> > +
> > +#define trace_rcu_exit(state)					\
> > +do {								\
> > +	if (state)						\
> > +		rcu_irq_exit_irqsave();				\
> > +} while (0)
> > +
> 
> Is there a reason that these can't be static __always_inline functions?

It can be done, but then we need fwd declarations of those RCU functions
somewhere outside of rcupdate.h. It's all a bit of a mess.
