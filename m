From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [patch 05/34] idle: Implement generic idle function
Date: Thu, 28 Mar 2013 21:09:24 +0530
Message-ID: <5154642C.6080709@linux.vnet.ibm.com>
References: <20130321214930.752934102@linutronix.de> <20130321215233.646635455@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:49327 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab3C1PmJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Mar 2013 11:42:09 -0400
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Thu, 28 Mar 2013 21:08:38 +0530
In-Reply-To: <20130321215233.646635455@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Magnus Damm <magnus.damm@gmail.com>

On 03/22/2013 03:23 AM, Thomas Gleixner wrote:
> All idle functions in arch/* are more or less the same, plus minus a
> few bugs and extra instrumentation, tickless support and other
> optional items.
> 
> Implement a generic idle function which resembles the functionality
> found in arch/. Provide weak arch_cpu_idle_* functions which can be
> overridden by the architecture code if needed.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/Kconfig        |    3 +
>  include/linux/cpu.h |    8 +++
>  kernel/cpu/idle.c   |  105 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 116 insertions(+)
[...]
> +
> +/*
> + * Generic idle loop implementation
> + */
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

I understand that you have changed it to WARN_ON_ONCE(irqs_disabled()) in
the v2 hosted in your git tree..

Sometime ago, Deepthi (in CC) had added such a check and Rafael had faced
some weird problems with that, and hence it was removed. Below are some
links to that discussion.

https://lkml.org/lkml/2012/6/22/48
https://lkml.org/lkml/2012/6/24/132
https://lkml.org/lkml/2012/6/25/402

Rafael, do you still see that problem after applying Thomas' patches?

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
> 
> 

Regards,
Srivatsa S. Bhat
