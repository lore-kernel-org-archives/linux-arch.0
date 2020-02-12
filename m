From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 8/8] tracing: Remove regular RCU context for _rcuidle
 tracepoints (again)
Date: Wed, 12 Feb 2020 16:12:53 +0100
Message-ID: <20200212151253.GU14897@hirez.programming.kicks-ass.net>
References: <20200212093210.468391728@infradead.org>
 <20200212094108.063885035@infradead.org>
 <20200212092952.7bec74e9@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:43804 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgBLPNN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 10:13:13 -0500
Content-Disposition: inline
In-Reply-To: <20200212092952.7bec74e9@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

On Wed, Feb 12, 2020 at 09:29:52AM -0500, Steven Rostedt wrote:
> On Wed, 12 Feb 2020 10:32:18 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Effectively revert commit 865e63b04e9b2 ("tracing: Add back in
> > rcu_irq_enter/exit_irqson() for rcuidle tracepoints") now that we've
> > taught perf how to deal with not having an RCU context provided.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  include/linux/tracepoint.h |    8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -179,10 +179,8 @@ static inline struct tracepoint *tracepo
> >  		 * For rcuidle callers, use srcu since sched-rcu	\
> >  		 * doesn't work from the idle path.			\
> >  		 */							\
> > -		if (rcuidle) {						\
> > +		if (rcuidle)						\
> >  			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
> > -			rcu_irq_enter_irqsave();			\
> > -		}							\
> >  									\
> >  		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
> >  									\
> > @@ -194,10 +192,8 @@ static inline struct tracepoint *tracepo
> >  			} while ((++it_func_ptr)->func);		\
> >  		}							\
> >  									\
> > -		if (rcuidle) {						\
> > -			rcu_irq_exit_irqsave();				\
> > +		if (rcuidle)						\
> >  			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
> > -		}							\
> >  									\
> >  		preempt_enable_notrace();				\
> >  	} while (0)
> > 
> 
> Which looks basically the same as this patch...
> 
>   https://lore.kernel.org/r/20200211095047.58ddf750@gandalf.local.home

It is a straight revert of 865e63b04e9b2, how different do you want it
to look?

Also it very much isn't that patch, as this one only does the revert and
doesn't mix it in with other stuff.
