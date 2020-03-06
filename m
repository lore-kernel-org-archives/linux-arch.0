From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v4 16/27] tracing: Remove regular RCU context for
 _rcuidle tracepoints (again)
Date: Fri, 6 Mar 2020 13:45:38 -0500
Message-ID: <20200306184538.GA92717@google.com>
References: <20200221133416.777099322@infradead.org>
 <20200221134216.051596115@infradead.org>
 <20200306104335.GF3348@worktop.programming.kicks-ass.net>
 <20200306113135.GA8787@worktop.programming.kicks-ass.net>
 <CAADnVQKp=UKg8HAuMOFknhmXtfm_LVu_ynTNJuedHqKdA6zh1g@mail.gmail.com>
 <1896740806.20220.1583510668164.JavaMail.zimbra@efficios.com>
 <20200306125500.6aa75c0d@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46923 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgCFSpk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 13:45:40 -0500
Received: by mail-qk1-f193.google.com with SMTP id u124so3229678qkh.13
        for <linux-arch@vger.kernel.org>; Fri, 06 Mar 2020 10:45:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200306125500.6aa75c0d@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Thomas Gleixner <tglx@linutronix.de>, paulmck <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Andy Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>, Frederic Weisbecker <frederic@kernel.org>, dan carpenter <dan.carpenter@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>

On Fri, Mar 06, 2020 at 12:55:00PM -0500, Steven Rostedt wrote:
> On Fri, 6 Mar 2020 11:04:28 -0500 (EST)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > If we care about not adding those extra branches on the fast-path, there is
> > an alternative way to do things: BPF could provide two distinct probe callbacks,
> > one meant for rcuidle tracepoints (which would have the trace_rcu_enter/exit), and
> > the other for the for 99% of the other callsites which have RCU watching.
> > 
> > I would recommend performing benchmarks justifying the choice of one approach over
> > the other though.
> 
> I just whipped this up (haven't even tried to compile it), but this should
> satisfy everyone. Those that register a callback that needs RCU protection
> simply registers with one of the _rcu versions, and all will be done. And
> since DO_TRACE is a macro, and rcuidle is a constant, the rcu protection
> code will be compiled out for locations that it is not needed.
> 
> With this, perf doesn't even need to do anything extra but register with
> the "_rcu" version.

Looks nice! Some comments below:

> -- Steve
> 
> diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
> index b29950a19205..582dece30170 100644
> --- a/include/linux/tracepoint-defs.h
> +++ b/include/linux/tracepoint-defs.h
> @@ -25,6 +25,7 @@ struct tracepoint_func {
>  	void *func;
>  	void *data;
>  	int prio;
> +	int requires_rcu;
>  };
>  
>  struct tracepoint {
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 1fb11daa5c53..5f4de82ffa0f 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -179,25 +179,28 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		 * For rcuidle callers, use srcu since sched-rcu	\
>  		 * doesn't work from the idle path.			\
>  		 */							\
> -		if (rcuidle) {						\
> +		if (rcuidle)						\
>  			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\

Small addition:
To prevent confusion, we could make more clear that SRCU here is just to
protect the tracepoint function table and not the callbacks themselves.

> -			rcu_irq_enter_irqson();				\
> -		}							\
>  									\
>  		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
>  									\
>  		if (it_func_ptr) {					\
>  			do {						\
> +				int rcu_flags;				\
>  				it_func = (it_func_ptr)->func;		\
> +				if (rcuidle &&				\
> +				    (it_func_ptr)->requires_rcu)	\
> +					rcu_flags = trace_rcu_enter();	\
>  				__data = (it_func_ptr)->data;		\
>  				((void(*)(proto))(it_func))(args);	\
> +				if (rcuidle &&				\
> +				    (it_func_ptr)->requires_rcu)	\
> +					trace_rcu_exit(rcu_flags);	\

Nit: If we have incurred the cost of trace_rcu_enter() once, we can call
it only once and then call trace_rcu_exit() after the do-while loop. That way
we pay the price only once.

thanks,

 - Joel

>  			} while ((++it_func_ptr)->func);		\
>  		}							\
>  									\
> -		if (rcuidle) {						\
> +		if (rcuidle)						\
>  			rcu_irq_exit_irqson();				\
> -			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
> -		}							\
>  									\
>  		preempt_enable_notrace();				\
>  	} while (0)
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 73956eaff8a9..1797e20fd471 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -295,6 +295,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
>   * @probe: probe handler
>   * @data: tracepoint data
>   * @prio: priority of this function over other registered functions
> + * @rcu: set to non zero if the callback requires RCU protection
>   *
>   * Returns 0 if ok, error value on error.
>   * Note: if @tp is within a module, the caller is responsible for
> @@ -302,8 +303,8 @@ static int tracepoint_remove_func(struct tracepoint *tp,
>   * performed either with a tracepoint module going notifier, or from
>   * within module exit functions.
>   */
> -int tracepoint_probe_register_prio(struct tracepoint *tp, void *probe,
> -				   void *data, int prio)
> +int tracepoint_probe_register_prio_rcu(struct tracepoint *tp, void *probe,
> +				       void *data, int prio, int rcu)
>  {
>  	struct tracepoint_func tp_func;
>  	int ret;
> @@ -312,12 +313,52 @@ int tracepoint_probe_register_prio(struct tracepoint *tp, void *probe,
>  	tp_func.func = probe;
>  	tp_func.data = data;
>  	tp_func.prio = prio;
> +	tp_func.requires_rcu = rcu;
>  	ret = tracepoint_add_func(tp, &tp_func, prio);
>  	mutex_unlock(&tracepoints_mutex);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(tracepoint_probe_register_prio_rcu);
> +
> +/**
> + * tracepoint_probe_register_prio -  Connect a probe to a tracepoint with priority
> + * @tp: tracepoint
> + * @probe: probe handler
> + * @data: tracepoint data
> + * @prio: priority of this function over other registered functions
> + *
> + * Returns 0 if ok, error value on error.
> + * Note: if @tp is within a module, the caller is responsible for
> + * unregistering the probe before the module is gone. This can be
> + * performed either with a tracepoint module going notifier, or from
> + * within module exit functions.
> + */
> +int tracepoint_probe_register_prio(struct tracepoint *tp, void *probe,
> +				   void *data, int prio)
> +{
> +	return tracepoint_probe_register_prio_rcu(tp, probe, data, prio, 0);
> +}
>  EXPORT_SYMBOL_GPL(tracepoint_probe_register_prio);
>  
> +/**
> + * tracepoint_probe_register_rcu -  Connect a probe to a tracepoint
> + * @tp: tracepoint
> + * @probe: probe handler
> + * @data: tracepoint data
> + *
> + * Returns 0 if ok, error value on error.
> + * Note: if @tp is within a module, the caller is responsible for
> + * unregistering the probe before the module is gone. This can be
> + * performed either with a tracepoint module going notifier, or from
> + * within module exit functions.
> + */
> +int tracepoint_probe_register_rcu(struct tracepoint *tp, void *probe, void *data)
> +{
> +	return tracepoint_probe_register_prio_rcu(tp, probe, data,
> +						  TRACEPOINT_DEFAULT_PRIO, 1);
> +}
> +EXPORT_SYMBOL_GPL(tracepoint_probe_register_rcu);
> +
>  /**
>   * tracepoint_probe_register -  Connect a probe to a tracepoint
>   * @tp: tracepoint
> @@ -332,7 +373,8 @@ EXPORT_SYMBOL_GPL(tracepoint_probe_register_prio);
>   */
>  int tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data)
>  {
> -	return tracepoint_probe_register_prio(tp, probe, data, TRACEPOINT_DEFAULT_PRIO);
> +	return tracepoint_probe_register_prio_rcu(tp, probe, data,
> +						  TRACEPOINT_DEFAULT_PRIO, 0);
>  }
>  EXPORT_SYMBOL_GPL(tracepoint_probe_register);
>  
