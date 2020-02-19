From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 08/22] rcu,tracing: Create trace_rcu_{enter,exit}()
Date: Wed, 19 Feb 2020 17:35:35 +0100
Message-ID: <20200219163535.GJ18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.832297480@infradead.org>
 <20200219104903.46686b81@gandalf.local.home>
 <20200219155828.GF18400@hirez.programming.kicks-ass.net>
 <20200219111532.719c0a6b@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200219111532.719c0a6b@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 19, 2020 at 11:15:32AM -0500, Steven Rostedt wrote:
> On Wed, 19 Feb 2020 16:58:28 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Feb 19, 2020 at 10:49:03AM -0500, Steven Rostedt wrote:
> > > On Wed, 19 Feb 2020 15:47:32 +0100
> > > Peter Zijlstra <peterz@infradead.org> wrote:  
> > 
> > > > These helpers are macros because of header-hell; they're placed here
> > > > because of the proximity to nmi_{enter,exit{().  
> > 
> > ^^^^
> 
> Bah I can't read, because I even went looking for this!
> 
> > 
> > > > +#define trace_rcu_enter()					\
> > > > +({								\
> > > > +	unsigned long state = 0;				\
> > > > +	if (!rcu_is_watching())	{				\
> > > > +		rcu_irq_enter_irqsave();			\
> > > > +		state = 1;					\
> > > > +	}							\
> > > > +	state;							\
> > > > +})
> > > > +
> > > > +#define trace_rcu_exit(state)					\
> > > > +do {								\
> > > > +	if (state)						\
> > > > +		rcu_irq_exit_irqsave();				\
> > > > +} while (0)
> > > > +  
> > > 
> > > Is there a reason that these can't be static __always_inline functions?  
> > 
> > It can be done, but then we need fwd declarations of those RCU functions
> > somewhere outside of rcupdate.h. It's all a bit of a mess.
> 
> Maybe this belongs in the rcupdate.h file then?

Possibly, and I suppose the current version is less obviously dependent
on the in_nmi() functionality as was the previous, seeing how Paul
frobbed that all the way into the rcu_irq_enter*() implementation.

So sure, I can go move it I suppose.
