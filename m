From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Date: Wed, 12 Feb 2020 18:27:02 -0500
Message-ID: <20200212232702.GA170680@google.com>
References: <20200212210139.382424693@infradead.org>
 <20200212210749.971717428@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200212210749.971717428@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 12, 2020 at 10:01:42PM +0100, Peter Zijlstra wrote:
> To facilitate tracers that need RCU, add some helpers to wrap the
> magic required.
> 
> The problem is that we can call into tracers (trace events and
> function tracing) while RCU isn't watching and this can happen from
> any context, including NMI.
> 
> It is this latter that is causing most of the trouble; we must make
> sure in_nmi() returns true before we land in anything tracing,
> otherwise we cannot recover.
> 
> These helpers are macros because of header-hell; they're placed here
> because of the proximity to nmi_{enter,exit{().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/hardirq.h |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> --- a/include/linux/hardirq.h
> +++ b/include/linux/hardirq.h
> @@ -89,4 +89,52 @@ extern void irq_exit(void);
>  		arch_nmi_exit();				\
>  	} while (0)
>  
> +/*
> + * Tracing vs RCU
> + * --------------
> + *
> + * tracepoints and function-tracing can happen when RCU isn't watching (idle,
> + * or early IRQ/NMI entry).
> + *
> + * When it happens during idle or early during IRQ entry, tracing will have
> + * to inform RCU that it ought to pay attention, this is done by calling
> + * rcu_irq_enter_irqsave().
> + *
> + * On NMI entry, we must be very careful that tracing only happens after we've
> + * incremented preempt_count(), otherwise we cannot tell we're in NMI and take
> + * the special path.
> + */
> +
> +#define __TR_IRQ	1
> +#define __TR_NMI	2
> +
> +#define trace_rcu_enter()					\
> +({								\
> +	unsigned long state = 0;				\
> +	if (!rcu_is_watching())	{				\
> +		if (in_nmi()) {					\
> +			state = __TR_NMI;			\
> +			rcu_nmi_enter();			\
> +		} else {					\
> +			state = __TR_IRQ;			\
> +			rcu_irq_enter_irqsave();		\

Since rcu_irq_enter_irqsave can be called from a tracer context, should those
be marked with notrace as well? AFAICS, there's no notrace marking on them.

thanks,

 - Joel


> +		}						\
> +	}							\
> +	state;							\
> +})
> +
> +#define trace_rcu_exit(state)					\
> +do {								\
> +	switch (state) {					\
> +	case __TR_IRQ:						\
> +		rcu_irq_exit_irqsave();				\
> +		break;						\
> +	case __TR_NMI:						\
> +		rcu_nmi_exit();					\
> +		break;						\
> +	default:						\
> +		break;						\
> +	}							\
> +} while (0)
> +
>  #endif /* LINUX_HARDIRQ_H */
> 
> 
