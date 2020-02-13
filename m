From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Date: Thu, 13 Feb 2020 16:19:30 -0500
Message-ID: <20200213211930.GG170680@google.com>
References: <20200212210139.382424693@infradead.org>
 <20200212210749.971717428@infradead.org>
 <20200212232005.GC115917@google.com>
 <20200213082716.GI14897@hirez.programming.kicks-ass.net>
 <20200213135138.GB2935@paulmck-ThinkPad-P72>
 <20200213164031.GH14914@hirez.programming.kicks-ass.net>
 <20200213185612.GG2935@paulmck-ThinkPad-P72>
 <20200213204444.GA94647@google.com>
 <20200213205442.GK2935@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37629 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgBMVTd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 16:19:33 -0500
Received: by mail-qt1-f193.google.com with SMTP id w47so5526480qtk.4
        for <linux-arch@vger.kernel.org>; Thu, 13 Feb 2020 13:19:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200213205442.GK2935@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

On Thu, Feb 13, 2020 at 12:54:42PM -0800, Paul E. McKenney wrote:
> On Thu, Feb 13, 2020 at 03:44:44PM -0500, Joel Fernandes wrote:
> > On Thu, Feb 13, 2020 at 10:56:12AM -0800, Paul E. McKenney wrote:
> > [...] 
> > > > > It might well be that I could make these functions be NMI-safe, but
> > > > > rcu_prepare_for_idle() in particular would be a bit ugly at best.
> > > > > So, before looking into that, I have a question.  Given these proposed
> > > > > changes, will rcu_nmi_exit_common() and rcu_nmi_enter_common() be able
> > > > > to just use in_nmi()?
> > > > 
> > > > That _should_ already be the case today. That is, if we end up in a
> > > > tracer and in_nmi() is unreliable we're already screwed anyway.
> > > 
> > > So something like this, then?  This is untested, probably doesn't even
> > > build, and could use some careful review from both Peter and Steve,
> > > at least.  As in the below is the second version of the patch, the first
> > > having been missing a couple of important "!" characters.
> > 
> > I removed the static from rcu_nmi_enter()/exit() as it is called from
> > outside, that makes it build now. Updated below is Paul's diff. I also added
> > NOKPROBE_SYMBOL() to rcu_nmi_exit() to match rcu_nmi_enter() since it seemed
> > asymmetric.
> 
> My compiler complained about the static and the __always_inline, so I
> fixed those.  But please help me out on adding the NOKPROBE_SYMBOL()
> to rcu_nmi_exit().  What bad thing happens if we leave this on only
> rcu_nmi_enter()?

It seemed odd to me we were not allowing kprobe on the rcu_nmi_enter() but
allowing it on exit (from a code reading standpoint) so my reaction was to
add it to both, but we could probably keep that as a separate
patch/discussion since it is slightly unrelated to the patch.. Sorry to
confuse the topic.

thanks,

 - Joel


> 							Thanx, Paul
> 
> > ---8<-----------------------
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index d91c9156fab2e..bbcc7767f18ee 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -614,16 +614,18 @@ void rcu_user_enter(void)
> >  }
> >  #endif /* CONFIG_NO_HZ_FULL */
> >  
> > -/*
> > +/**
> > + * rcu_nmi_exit - inform RCU of exit from NMI context
> > + *
> >   * If we are returning from the outermost NMI handler that interrupted an
> >   * RCU-idle period, update rdp->dynticks and rdp->dynticks_nmi_nesting
> >   * to let the RCU grace-period handling know that the CPU is back to
> >   * being RCU-idle.
> >   *
> > - * If you add or remove a call to rcu_nmi_exit_common(), be sure to test
> > + * If you add or remove a call to rcu_nmi_exit(), be sure to test
> >   * with CONFIG_RCU_EQS_DEBUG=y.
> >   */
> > -static __always_inline void rcu_nmi_exit_common(bool irq)
> > +__always_inline void rcu_nmi_exit(void)
> >  {
> >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> >  
> > @@ -651,25 +653,15 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
> >  	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
> >  	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
> >  
> > -	if (irq)
> > +	if (!in_nmi())
> >  		rcu_prepare_for_idle();
> >  
> >  	rcu_dynticks_eqs_enter();
> >  
> > -	if (irq)
> > +	if (!in_nmi())
> >  		rcu_dynticks_task_enter();
> >  }
> > -
> > -/**
> > - * rcu_nmi_exit - inform RCU of exit from NMI context
> > - *
> > - * If you add or remove a call to rcu_nmi_exit(), be sure to test
> > - * with CONFIG_RCU_EQS_DEBUG=y.
> > - */
> > -void rcu_nmi_exit(void)
> > -{
> > -	rcu_nmi_exit_common(false);
> > -}
> > +NOKPROBE_SYMBOL(rcu_nmi_exit);
> >  
> >  /**
> >   * rcu_irq_exit - inform RCU that current CPU is exiting irq towards idle
> > @@ -693,7 +685,7 @@ void rcu_nmi_exit(void)
> >  void rcu_irq_exit(void)
> >  {
> >  	lockdep_assert_irqs_disabled();
> > -	rcu_nmi_exit_common(true);
> > +	rcu_nmi_exit();
> >  }
> >  
> >  /*
> > @@ -777,7 +769,7 @@ void rcu_user_exit(void)
> >  #endif /* CONFIG_NO_HZ_FULL */
> >  
> >  /**
> > - * rcu_nmi_enter_common - inform RCU of entry to NMI context
> > + * rcu_nmi_enter - inform RCU of entry to NMI context
> >   * @irq: Is this call from rcu_irq_enter?
> >   *
> >   * If the CPU was idle from RCU's viewpoint, update rdp->dynticks and
> > @@ -786,10 +778,10 @@ void rcu_user_exit(void)
> >   * long as the nesting level does not overflow an int.  (You will probably
> >   * run out of stack space first.)
> >   *
> > - * If you add or remove a call to rcu_nmi_enter_common(), be sure to test
> > + * If you add or remove a call to rcu_nmi_enter(), be sure to test
> >   * with CONFIG_RCU_EQS_DEBUG=y.
> >   */
> > -static __always_inline void rcu_nmi_enter_common(bool irq)
> > +__always_inline void rcu_nmi_enter(void)
> >  {
> >  	long incby = 2;
> >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > @@ -807,12 +799,12 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
> >  	 */
> >  	if (rcu_dynticks_curr_cpu_in_eqs()) {
> >  
> > -		if (irq)
> > +		if (!in_nmi())
> >  			rcu_dynticks_task_exit();
> >  
> >  		rcu_dynticks_eqs_exit();
> >  
> > -		if (irq)
> > +		if (!in_nmi())
> >  			rcu_cleanup_after_idle();
> >  
> >  		incby = 1;
> > @@ -834,14 +826,6 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
> >  		   rdp->dynticks_nmi_nesting + incby);
> >  	barrier();
> >  }
> > -
> > -/**
> > - * rcu_nmi_enter - inform RCU of entry to NMI context
> > - */
> > -void rcu_nmi_enter(void)
> > -{
> > -	rcu_nmi_enter_common(false);
> > -}
> >  NOKPROBE_SYMBOL(rcu_nmi_enter);
> >  
> >  /**
> > @@ -869,7 +853,7 @@ NOKPROBE_SYMBOL(rcu_nmi_enter);
> >  void rcu_irq_enter(void)
> >  {
> >  	lockdep_assert_irqs_disabled();
> > -	rcu_nmi_enter_common(true);
> > +	rcu_nmi_enter();
> >  }
> >  
> >  /*
