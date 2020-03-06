From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 03/12] task_isolation: userspace hard isolation from
 kernel
Date: Fri, 6 Mar 2020 17:00:36 +0100
Message-ID: <20200306160035.GD8590@lenoir>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
 <36d84b8dd168a38e6a56549dedc15dd6ebf8c09e.camel@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgCFQAj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Mar 2020 11:00:39 -0500
Content-Disposition: inline
In-Reply-To: <36d84b8dd168a38e6a56549dedc15dd6ebf8c09e.camel@marvell.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Belits <abelits@marvell.com>
Cc: "rostedt@goodmis.org" <rostedt@goodmis.org>, "mingo@kernel.org" <mingo@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prasun Kapoor <pkapoor@marvell.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Wed, Mar 04, 2020 at 04:07:12PM +0000, Alex Belits wrote:
> +#ifdef CONFIG_TASK_ISOLATION
> +int try_stop_full_tick(void)
> +{
> +	int cpu = smp_processor_id();
> +	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
> +
> +	/* For an unstable clock, we should return a permanent error code. */
> +	if (atomic_read(&tick_dep_mask) & TICK_DEP_MASK_CLOCK_UNSTABLE)
> +		return -EINVAL;
> +
> +	if (!can_stop_full_tick(cpu, ts))
> +		return -EAGAIN;

Note that the stop_tick naming in nohz can be misleading. It means
we actually leave the periodic mode and we enter in dynamic tick mode.

In practice it means that the tick is delayed until the next event, which
in the worst case may well be in 1 ms and in the best case never. So what
you probably want to check instead is whether the tick has been entirely
stopped (ie: we called hrtimer_cancel(&ts->sched_timer)).

Thanks.

> +
> +	tick_nohz_stop_sched_tick(ts, cpu);
> +	return 0;
> +}
> +#endif
> +
>  static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
>  {
>  	/*
> -- 
> 2.20.1
> 
