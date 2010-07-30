From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch] Remove the per cpu tick skew
Date: Fri, 30 Jul 2010 17:27:04 +1000
Message-ID: <20100730072704.GA9960@amd>
References: <20100727210210.58d3118c@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100727210210.58d3118c@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 27, 2010 at 09:02:10PM -0700, Arjan van de Ven wrote:
> Hi,
> 
> the following patch is a win for power management on x86....
> ... but since this touches generic code.. are there any 
> other architectures that would be negatively affected by this?
> 
> 
> 
> Subject: [patch] Remove the per cpu tick skew
> 
> Historically, Linux has tried to make the regular timer tick on the various
> CPUs not happen at the same time, to avoid contention on xtime_lock.
> 
> Nowadays, with the tickless kernel, this contention no longer happens
> since time keeping and updating are done differently. In addition,
> this skew is actually hurting power consumption in a measurable
> way on many-core systems.

Question, how much of a win is it? What does it do that tickless
idle does not, can you explain?

> 
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> 
> --- linux.trees.git/kernel/time/tick-sched.c~	2010-07-16 09:40:50.000000000 -0400
> +++ linux.trees.git/kernel/time/tick-sched.c	2010-07-26 11:18:51.138003329 -0400
> @@ -780,7 +780,6 @@
>  {
>  	struct tick_sched *ts = &__get_cpu_var(tick_cpu_sched);
>  	ktime_t now = ktime_get();
> -	u64 offset;
>  
>  	/*
>  	 * Emulate tick processing via per-CPU hrtimers:
> @@ -790,10 +789,6 @@
>  
>  	/* Get the next period (per cpu) */
>  	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());
> -	offset = ktime_to_ns(tick_period) >> 1;
> -	do_div(offset, num_possible_cpus());
> -	offset *= smp_processor_id();
> -	hrtimer_add_expires_ns(&ts->sched_timer, offset);
>  
>  	for (;;) {
>  		hrtimer_forward(&ts->sched_timer, now, tick_period);
> 
> -- 
> Arjan van de Ven 	Intel Open Source Technology Centre
> For development, discussion and tips for power savings, 
> visit http://www.lesswatts.org
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
