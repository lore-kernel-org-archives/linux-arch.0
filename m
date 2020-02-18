Return-Path: <SRS0=ZivQ=4G=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:33422 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbgBRT65 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Feb 2020 14:58:57 -0500
Date: Tue, 18 Feb 2020 20:58:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200218195831.GD11457@worktop.programming.kicks-ass.net>
References: <20200212210139.382424693@infradead.org>
 <20200212210749.971717428@infradead.org>
 <20200212232005.GC115917@google.com>
 <20200213082716.GI14897@hirez.programming.kicks-ass.net>
 <20200213135138.GB2935@paulmck-ThinkPad-P72>
 <20200213164031.GH14914@hirez.programming.kicks-ass.net>
 <20200213185612.GG2935@paulmck-ThinkPad-P72>
 <20200213204444.GA94647@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213204444.GA94647@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Message-ID: <20200218195831.uv31Q-L70Zx6xlCzMZxXD92f2Saus2RKuIkx0mzNls0@z>

On Thu, Feb 13, 2020 at 03:44:44PM -0500, Joel Fernandes wrote:

> > > That _should_ already be the case today. That is, if we end up in a
> > > tracer and in_nmi() is unreliable we're already screwed anyway.

> I removed the static from rcu_nmi_enter()/exit() as it is called from
> outside, that makes it build now. Updated below is Paul's diff. I also added
> NOKPROBE_SYMBOL() to rcu_nmi_exit() to match rcu_nmi_enter() since it seemed
> asymmetric.

> +__always_inline void rcu_nmi_exit(void)
>  {
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  
> @@ -651,25 +653,15 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
>  	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
>  	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
>  
> -	if (irq)
> +	if (!in_nmi())
>  		rcu_prepare_for_idle();
>  
>  	rcu_dynticks_eqs_enter();
>  
> -	if (irq)
> +	if (!in_nmi())
>  		rcu_dynticks_task_enter();
>  }

Boris and me have been going over the #MC code (and finding loads of
'interesting' code) and ran into ist_enter(), whish has the following
code:

                /*
                 * We might have interrupted pretty much anything.  In
                 * fact, if we're a machine check, we can even interrupt
                 * NMI processing.  We don't want in_nmi() to return true,
                 * but we need to notify RCU.
                 */
                rcu_nmi_enter();


Which, to me, sounds all sorts of broken. The IST (be it #DB or #MC) can
happen while we're holding all sorts of locks. This must be an NMI-like
context.
