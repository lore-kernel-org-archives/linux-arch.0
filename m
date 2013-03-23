From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch 05/34] idle: Implement generic idle function
Date: Sat, 23 Mar 2013 09:56:47 +0100
Message-ID: <20130323085647.GB3530@osiris>
References: <20130321214930.752934102@linutronix.de>
 <20130321215233.646635455@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp18.uk.ibm.com ([195.75.94.114]:34647 "EHLO
	e06smtp18.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755352Ab3CWI4x (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 23 Mar 2013 04:56:53 -0400
Received: from /spool/local
	by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Sat, 23 Mar 2013 08:53:55 -0000
Content-Disposition: inline
In-Reply-To: <20130321215233.646635455@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Magnus Damm <magnus.damm@gmail.com>

On Thu, Mar 21, 2013 at 09:53:00PM -0000, Thomas Gleixner wrote:
> All idle functions in arch/* are more or less the same, plus minus a
> few bugs and extra instrumentation, tickless support and other
> optional items.
> 
> Implement a generic idle function which resembles the functionality
> found in arch/. Provide weak arch_cpu_idle_* functions which can be
> overridden by the architecture code if needed.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

[...]

> +static void cpu_idle_loop(void)
> +{
> +	while (1) {
> +		tick_nohz_idle_enter();
> +
> +		while (!need_resched()) {
> +			check_pgt_cache();
> +			rmb();
> +
> +			if (cpu_is_offline(smp_processor_id()))
> +				arch_cpu_idle_dead();
> +
> +			local_irq_disable();
> +			arch_cpu_idle_enter();
> +
> +			if (cpu_idle_force_poll) {
> +				cpu_idle_poll();
> +			} else {
> +				current_clr_polling();
> +				if (!need_resched()) {
> +					stop_critical_timings();
> +					rcu_idle_enter();
> +					arch_cpu_idle();
> +					WARN_ON_ONCE(!irqs_disabled());

This should be WARN_ON_ONCE(irqs_disabled()), no?

> +					rcu_idle_exit();
> +					start_critical_timings();
> +				} else {
> +					local_irq_enable();
> +				}
> +				current_set_polling();
> +			}
> +			arch_cpu_idle_exit();
> +		}
> +		tick_nohz_idle_exit();

I was wondering why the scheduler doesn't complain when being called with
irqs disabled. In fact tick_nohz_idle_exit() enables irqs unconditionally
iff CONFIG_NO_HZ is set.

> +		schedule_preempt_disabled();
> +	}
> +}
> +
> +void cpu_startup_entry(enum cpuhp_state state)
> +{
> +	current_set_polling();
> +	arch_cpu_idle_prepare();
> +	cpu_idle_loop();
> +}
> +#endif
