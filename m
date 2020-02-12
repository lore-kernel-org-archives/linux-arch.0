From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Date: Wed, 12 Feb 2020 18:20:05 -0500
Message-ID: <20200212232005.GC115917@google.com>
References: <20200212210139.382424693@infradead.org>
 <20200212210749.971717428@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33943 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgBLXUH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 18:20:07 -0500
Received: by mail-qk1-f193.google.com with SMTP id c20so3911304qkm.1
        for <linux-arch@vger.kernel.org>; Wed, 12 Feb 2020 15:20:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200212210749.971717428@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

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

I think this can be simplified. You don't need to rely on in_nmi() here. I
believe for NMI's, you can just call rcu_irq_enter_irqsave() and that should
be sufficient to get RCU watching. Paul can correct me if I'm wrong, but I am
pretty sure that would work.

In fact, I think a better naming for rcu_irq_enter_irqsave() pair could be
(in the first patch):

rcu_ensure_watching_begin();
rcu_ensure_watching_end();

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
