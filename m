From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 13/22] tracing: Remove regular RCU context for
 _rcuidle tracepoints (again)
Date: Wed, 19 Feb 2020 18:05:07 +0100
Message-ID: <20200219170507.GH14946@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150745.125119627@infradead.org>
 <20200219164356.GB2935@paulmck-ThinkPad-P72>
 <20200219164736.GL18400@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:37548 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgBSRFa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 12:05:30 -0500
Content-Disposition: inline
In-Reply-To: <20200219164736.GL18400@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

On Wed, Feb 19, 2020 at 05:47:36PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 19, 2020 at 08:43:56AM -0800, Paul E. McKenney wrote:
> > On Wed, Feb 19, 2020 at 03:47:37PM +0100, Peter Zijlstra wrote:
> > > Effectively revert commit 865e63b04e9b2 ("tracing: Add back in
> > > rcu_irq_enter/exit_irqson() for rcuidle tracepoints") now that we've
> > > taught perf how to deal with not having an RCU context provided.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  include/linux/tracepoint.h |    8 ++------
> > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > > 
> > > --- a/include/linux/tracepoint.h
> > > +++ b/include/linux/tracepoint.h
> > > @@ -179,10 +179,8 @@ static inline struct tracepoint *tracepo
> > 
> > Shouldn't we also get rid of this line above?
> > 
> > 		int __maybe_unused __idx = 0;				\
> > 
> 
> Probably makes a lot of sense, lemme fix that!

Oh wait, no! SRCU is the one that remains !
