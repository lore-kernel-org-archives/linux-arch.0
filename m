Return-Path: <SRS0=bqXs=4A=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgBLO3z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Feb 2020 09:29:55 -0500
Date: Wed, 12 Feb 2020 09:29:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 8/8] tracing: Remove regular RCU context for _rcuidle
 tracepoints (again)
Message-ID: <20200212092952.7bec74e9@gandalf.local.home>
In-Reply-To: <20200212094108.063885035@infradead.org>
References: <20200212093210.468391728@infradead.org>
        <20200212094108.063885035@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Message-ID: <20200212142952.yUaLhe4l8-3E1CLO1xYxqYCLjwvFkatGZi-fISekMtY@z>

On Wed, 12 Feb 2020 10:32:18 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

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

Which looks basically the same as this patch...


  https://lore.kernel.org/r/20200211095047.58ddf750@gandalf.local.home

-- Steve
