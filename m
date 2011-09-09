Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53227 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab1IINNS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Sep 2011 09:13:18 -0400
Date: Fri, 9 Sep 2011 15:13:17 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch v3 18/36] Hexagon: Add time and timer functions
In-Reply-To: <20110909010916.422373448@codeaurora.org>
Message-ID: <alpine.LFD.2.02.1109091507160.2723@ionos>
References: <20110909010847.294039464@codeaurora.org> <20110909010916.422373448@codeaurora.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20110909131317.JeuDqtj5Prwa68GmTAIm-Cjl7SD5EJkEaEqy6vJTC4o@z>

On Thu, 8 Sep 2011, Richard Kuo wrote:
> +static cycle_t timer_get_cycles(struct clocksource *cs)
> +{
> +	return (cycle_t) __vmgettime();
> +}
> +
> +static struct clocksource hexagon_clocksource = {
> +	.name		= "pcycles",
> +	.rating		= 250,
> +	.shift		= 16,

clocksource_register_khz() calcs mult and shift.

> +	.read		= timer_get_cycles,
> +	.mask		= CLOCKSOURCE_MASK(64),
> +	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> +};
> +

> +static struct clock_event_device hexagon_clockevent_dev = {
> +	.name		= "clockevent",
> +	.features	= CLOCK_EVT_FEAT_ONESHOT,
> +	.rating		= 400,
> +	.shift		= 32,

You recalc this shift as well

> +	.irq		= RTOS_TIMER_INT,
> +	.set_next_event = set_next_event,
> +	.set_mode	= set_mode,
> +#ifdef CONFIG_SMP
> +	.broadcast	= broadcast,
> +#endif
> +};
> +

> +/*  Called from smp.c for each CPU's timer ipi call  */
> +void ipi_timer(void)
> +{
> +	int cpu = smp_processor_id();
> +	struct clock_event_device *ce_dev = &hexagon_clockevent_dev;

This initialization is pointless

> +	ce_dev = &per_cpu(clock_events, cpu);
> +	ce_dev->event_handler(ce_dev);
> +}
> +#endif /* CONFIG_SMP */
> +
> +static irqreturn_t timer_interrupt(int irq, void *devid)
> +{
> +	struct clock_event_device *ce_dev = &hexagon_clockevent_dev;
> +
> +	rtos_timer->enable = 0;
> +	ce_dev->event_handler(ce_dev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*  This should also be pulled from devtree  */
> +static struct irqaction rtos_timer_intdesc = {
> +	.handler = timer_interrupt,
> +	.flags = IRQF_DISABLED | IRQF_TIMER | IRQF_TRIGGER_RISING,

  IRQF_DISABLED is about to be gone and IRQF_TIMER has it already.

> +	.name = "rtos_timer"
> +};
> +
> +void clocksource_debug(struct clocksource *cs)
> +{
> +	printk(KERN_DEBUG "cs->mult=0x%08x\n", cs->mult);
> +	printk(KERN_DEBUG "cs->shift=%d\n", cs->shift);
> +}
> +
> +void clockevent_debug(struct clock_event_device *ce)
> +{
> +	printk(KERN_DEBUG "ce->mult=0x%08x\n", ce->mult);
> +	printk(KERN_DEBUG "ce->shift=%d\n", ce->shift);
> +}

Important debug leftovers ?

Thanks,

	tglx
