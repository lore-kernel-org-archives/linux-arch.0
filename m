Return-Path: <SRS0=ZCnS=4X=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36879 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFTOM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 14:14:12 -0500
Received: by mail-qv1-f68.google.com with SMTP id w16so1029666qvn.4
        for <linux-arch@vger.kernel.org>; Fri, 06 Mar 2020 11:14:11 -0800 (PST)
Date: Fri, 6 Mar 2020 14:14:10 -0500
From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v4 16/27] tracing: Remove regular RCU context for
 _rcuidle tracepoints (again)
Message-ID: <20200306191410.GB60713@google.com>
References: <20200221133416.777099322@infradead.org>
 <20200221134216.051596115@infradead.org>
 <20200306104335.GF3348@worktop.programming.kicks-ass.net>
 <20200306113135.GA8787@worktop.programming.kicks-ass.net>
 <CAADnVQKp=UKg8HAuMOFknhmXtfm_LVu_ynTNJuedHqKdA6zh1g@mail.gmail.com>
 <1896740806.20220.1583510668164.JavaMail.zimbra@efficios.com>
 <20200306125500.6aa75c0d@gandalf.local.home>
 <20200306184538.GA92717@google.com>
 <20200306135925.50c38bec@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306135925.50c38bec@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Thomas Gleixner <tglx@linutronix.de>, paulmck <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Andy Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>, Frederic Weisbecker <frederic@kernel.org>, dan carpenter <dan.carpenter@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>
Message-ID: <20200306191410.2DqPyNmKVFWV1xVxmCluDtmUO6lsgpRj0z8plE_bcW8@z>

On Fri, Mar 06, 2020 at 01:59:25PM -0500, Steven Rostedt wrote:
[snip]
> > > -			rcu_irq_enter_irqson();				\
> > > -		}							\
> > >  									\
> > >  		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
> > >  									\
> > >  		if (it_func_ptr) {					\
> > >  			do {						\
> > > +				int rcu_flags;				\
> > >  				it_func = (it_func_ptr)->func;		\
> > > +				if (rcuidle &&				\
> > > +				    (it_func_ptr)->requires_rcu)	\
> > > +					rcu_flags = trace_rcu_enter();	\
> > >  				__data = (it_func_ptr)->data;		\
> > >  				((void(*)(proto))(it_func))(args);	\
> > > +				if (rcuidle &&				\
> > > +				    (it_func_ptr)->requires_rcu)	\
> > > +					trace_rcu_exit(rcu_flags);	\  
> > 
> > Nit: If we have incurred the cost of trace_rcu_enter() once, we can call
> > it only once and then call trace_rcu_exit() after the do-while loop. That way
> > we pay the price only once.
> >
> 
> I thought about that, but the common case is only one callback attached at
> a time. To make the code complex for the non common case seemed too much
> of an overkill. If we find that it does help, it's best to do that as a
> separate patch because then if something goes wrong we know where it
> happened.
> 
> Currently, this provides the same overhead as if each callback did it
> themselves like we were proposing (but without the added need to do it for
> all instances of the callback).

That's ok, it could be a separate patch.

thanks,

 - Joel
