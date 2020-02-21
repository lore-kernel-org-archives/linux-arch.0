From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 09/27] rcu: Rename rcu_irq_{enter,exit}_irqson()
Date: Fri, 21 Feb 2020 15:21:53 -0500
Message-ID: <20200221152153.15b3cf36@gandalf.local.home>
References: <20200221133416.777099322@infradead.org>
        <20200221134215.559644596@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgBUUV5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Feb 2020 15:21:57 -0500
In-Reply-To: <20200221134215.559644596@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

On Fri, 21 Feb 2020 14:34:25 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -699,10 +699,10 @@ void rcu_irq_exit(void)
>  /*
>   * Wrapper for rcu_irq_exit() where interrupts are enabled.

			where interrupts may be enabled.

>   *
> - * If you add or remove a call to rcu_irq_exit_irqson(), be sure to test
> + * If you add or remove a call to rcu_irq_exit_irqsave(), be sure to test
>   * with CONFIG_RCU_EQS_DEBUG=y.
>   */
> -void rcu_irq_exit_irqson(void)
> +void rcu_irq_exit_irqsave(void)
>  {
>  	unsigned long flags;
>  
> @@ -875,10 +875,10 @@ void rcu_irq_enter(void)
>  /*
>   * Wrapper for rcu_irq_enter() where interrupts are enabled.

			where interrupts may be enabled.

-- Steve

>   *
> - * If you add or remove a call to rcu_irq_enter_irqson(), be sure to test
> + * If you add or remove a call to rcu_irq_enter_irqsave(), be sure to test
>   * with CONFIG_RCU_EQS_DEBUG=y.
>   */
> -void rcu_irq_enter_irqson(void)
> +void rcu_irq_enter_irqsave(void)
>  {
>  	unsigned long flags;
>  
