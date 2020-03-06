From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 11/27] rcu,tracing: Create trace_rcu_{enter,exit}()
Date: Fri, 6 Mar 2020 13:40:23 +0100
Message-ID: <20200306124023.GA12584@hirez.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.673793889@infradead.org>
 <20200306115042.GG3348@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:51358 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgCFMk7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 07:40:59 -0500
Content-Disposition: inline
In-Reply-To: <20200306115042.GG3348@worktop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

On Fri, Mar 06, 2020 at 12:50:42PM +0100, Peter Zijlstra wrote:
> > +static inline int trace_rcu_enter(void)
> > +{
> > +	int state = !rcu_is_watching();
> > +	if (state)
> > +		rcu_irq_enter_irqsave();
> > +	return state;
> > +}
> > +
> > +static inline void trace_rcu_exit(int state)
> > +{
> > +	if (state)
> > +		rcu_irq_exit_irqsave();
> > +}
> > +
> >  /*
> >   * The init_rcu_head_on_stack() and destroy_rcu_head_on_stack() calls
> >   * are needed for dynamic initialization and destruction of rcu_head

Also, I just noticed these read like tracepoints, so I'm going to rename
them: rcu_trace_{enter,exit}().
