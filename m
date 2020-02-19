From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 08/22] rcu,tracing: Create trace_rcu_{enter,exit}()
Date: Wed, 19 Feb 2020 10:49:03 -0500
Message-ID: <20200219104903.46686b81@gandalf.local.home>
References: <20200219144724.800607165@infradead.org>
        <20200219150744.832297480@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgBSPtG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 10:49:06 -0500
In-Reply-To: <20200219150744.832297480@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

On Wed, 19 Feb 2020 15:47:32 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

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
>  include/linux/hardirq.h |   32 ++++++++++++++++++++++++++++++++
 
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
> +#define trace_rcu_enter()					\
> +({								\
> +	unsigned long state = 0;				\
> +	if (!rcu_is_watching())	{				\
> +		rcu_irq_enter_irqsave();			\
> +		state = 1;					\
> +	}							\
> +	state;							\
> +})
> +
> +#define trace_rcu_exit(state)					\
> +do {								\
> +	if (state)						\
> +		rcu_irq_exit_irqsave();				\
> +} while (0)
> +

Is there a reason that these can't be static __always_inline functions?

-- Steve

>  #endif /* LINUX_HARDIRQ_H */
> 
