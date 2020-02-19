From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v3 13/22] tracing: Remove regular RCU context for
 _rcuidle tracepoints (again)
Date: Wed, 19 Feb 2020 08:43:56 -0800
Message-ID: <20200219164356.GB2935@paulmck-ThinkPad-P72>
References: <20200219144724.800607165@infradead.org>
 <20200219150745.125119627@infradead.org>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200219150745.125119627@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 19, 2020 at 03:47:37PM +0100, Peter Zijlstra wrote:
> Effectively revert commit 865e63b04e9b2 ("tracing: Add back in
> rcu_irq_enter/exit_irqson() for rcuidle tracepoints") now that we've
> taught perf how to deal with not having an RCU context provided.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/tracepoint.h |    8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -179,10 +179,8 @@ static inline struct tracepoint *tracepo

Shouldn't we also get rid of this line above?

		int __maybe_unused __idx = 0;				\

							Thanx, Paul

>  		 * For rcuidle callers, use srcu since sched-rcu	\
>  		 * doesn't work from the idle path.			\
>  		 */							\
> -		if (rcuidle) {						\
> +		if (rcuidle)						\
>  			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
> -			rcu_irq_enter_irqsave();			\
> -		}							\
>  									\
>  		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
>  									\
> @@ -194,10 +192,8 @@ static inline struct tracepoint *tracepo
>  			} while ((++it_func_ptr)->func);		\
>  		}							\
>  									\
> -		if (rcuidle) {						\
> -			rcu_irq_exit_irqsave();				\
> +		if (rcuidle)						\
>  			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
> -		}							\
>  									\
>  		preempt_enable_notrace();				\
>  	} while (0)
> 
> 
