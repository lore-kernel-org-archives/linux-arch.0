From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v3 08/22] rcu,tracing: Create trace_rcu_{enter,exit}()
Date: Thu, 20 Feb 2020 05:58:00 -0800
Message-ID: <20200220135800.GT2935@paulmck-ThinkPad-P72>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.832297480@infradead.org>
 <20200219104903.46686b81@gandalf.local.home>
 <20200219155828.GF18400@hirez.programming.kicks-ass.net>
 <20200219111532.719c0a6b@gandalf.local.home>
 <20200219163535.GJ18400@hirez.programming.kicks-ass.net>
 <20200219164449.GC2935@paulmck-ThinkPad-P72>
 <20200220103421.GV18400@hirez.programming.kicks-ass.net>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200220103421.GV18400@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Feb 20, 2020 at 11:34:21AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 19, 2020 at 08:44:50AM -0800, Paul E. McKenney wrote:
> > On Wed, Feb 19, 2020 at 05:35:35PM +0100, Peter Zijlstra wrote:
> 
> > > Possibly, and I suppose the current version is less obviously dependent
> > > on the in_nmi() functionality as was the previous, seeing how Paul
> > > frobbed that all the way into the rcu_irq_enter*() implementation.
> > > 
> > > So sure, I can go move it I suppose.
> > 
> > No objections here.
> 
> It now looks like so:
> 
> ---
> Subject: rcu,tracing: Create trace_rcu_{enter,exit}()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed Feb 12 09:18:57 CET 2020
> 
> To facilitate tracers that need RCU, add some helpers to wrap the
> magic required.
> 
> The problem is that we can call into tracers (trace events and
> function tracing) while RCU isn't watching and this can happen from
> any context, including NMI.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/rcupdate.h |   29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -175,6 +175,35 @@ do { \
>  #error "Unknown RCU implementation specified to kernel configuration"
>  #endif
>  
> +/**
> + * trace_rcu_enter - Force RCU to be active, for code that needs RCU readers
> + *
> + * Very similar to RCU_NONIDLE() above.
> + *
> + * Tracing can happen while RCU isn't active yet, for instance in the idle loop
> + * between rcu_idle_enter() and rcu_idle_exit(), or early in exception entry.
> + * RCU will happily ignore any read-side critical sections in this case.
> + *
> + * This function ensures that RCU is aware hereafter and the code can readily
> + * rely on RCU read-side critical sections working as expected.
> + *
> + * This function is NMI safe -- provided in_nmi() is correct and will nest up-to
> + * INT_MAX/2 times.
> + */
> +static inline int trace_rcu_enter(void)
> +{
> +	int state = !rcu_is_watching();
> +	if (state)
> +		rcu_irq_enter_irqsave();
> +	return state;
> +}
> +
> +static inline void trace_rcu_exit(int state)
> +{
> +	if (state)
> +		rcu_irq_exit_irqsave();
> +}
> +
>  /*
>   * The init_rcu_head_on_stack() and destroy_rcu_head_on_stack() calls
>   * are needed for dynamic initialization and destruction of rcu_head
