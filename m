From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2 18/19] clocksource: add C-SKY clocksource drivers
Date: Tue, 3 Jul 2018 11:39:05 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1807031130050.1601@nanos.tec.linutronix.de>
References: <cover.1530465325.git.ren_guo@c-sky.com> <aba005fd5005c066a2e3d760c334bb55f902d771.1530465326.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <aba005fd5005c066a2e3d760c334bb55f902d771.1530465326.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

On Mon, 2 Jul 2018, Guo Ren wrote:

-EEMPTYCHANGELOG

> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> --- /dev/null
> +++ b/drivers/clocksource/timer-csky-v1.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou NationalChip Science & Technology Co.,Ltd.

newline please

> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/sched_clock.h>
> +#include <linux/cpu.h>
> +#include <asm/reg_ops.h>
> +
> +#include "timer-of.h"
> +
> +#define PTIM_CTLR	"cr<0, 14>"
> +#define PTIM_TSR	"cr<1, 14>"
> +#define PTIM_CCVR_HI	"cr<2, 14>"
> +#define PTIM_CCVR_LO	"cr<3, 14>"
> +#define PTIM_LVR	"cr<6, 14>"
> +
> +#define BITS_CSKY_TIMER	56
> +
> +DECLARE_PER_CPU(struct timer_of, csky_to);

static?

> +
> +static int csky_timer_irq;
> +static int csky_timer_rate;
> +
> +static inline u64 get_ccvr(void)
> +{
> +	u32 lo, hi, t;
> +
> +	do {
> +		hi = mfcr(PTIM_CCVR_HI);
> +		lo = mfcr(PTIM_CCVR_LO);
> +		t  = mfcr(PTIM_CCVR_HI);
> +	} while(t != hi);

No idea which frequency this timer ticks at, but if the 32 bit wrap does
not come too fast, then you really should avoid that loop. That function is
called very frequently.

> +	return ((u64)hi << 32) | lo;
> +}
> +

> +DEFINE_PER_CPU(struct timer_of, csky_to) = {

static

> +	.flags = TIMER_OF_CLOCK | TIMER_OF_IRQ,
> +
> +	.clkevt = {
> +		.name = "C-SKY SMP Timer V1",
> +		.rating = 300,
> +		.features = CLOCK_EVT_FEAT_PERCPU | CLOCK_EVT_FEAT_ONESHOT,
> +		.set_state_shutdown		= csky_timer_shutdown,
> +		.set_state_oneshot		= csky_timer_oneshot,
> +		.set_state_oneshot_stopped	= csky_timer_oneshot_stopped,
> +		.set_next_event			= csky_timer_set_next_event,
> +	},
> +
> +	.of_irq = {
> +		.handler = timer_interrupt,
> +		.flags = IRQF_TIMER,
> +		.percpu = 1,

This is inconsistent. You made it half tabular and half not. Please use
tabular style consistently.

> +	},
> +};
> +
> +/*** clock event for percpu ***/

Please refrain from inventing new horrible comment styles.

> +static int csky_timer_starting_cpu(unsigned int cpu)
> +{
> +	struct timer_of *to = this_cpu_ptr(&csky_to);
> +
> +	to->clkevt.cpumask = cpumask_of(smp_processor_id());
> +
> +	clockevents_config_and_register(&to->clkevt, csky_timer_rate, 0, ULONG_MAX);
> +
> +	enable_percpu_irq(csky_timer_irq, 0);
> +
> +	return 0;
> +}
> +
> +static int csky_timer_dying_cpu(unsigned int cpu)
> +{
> +	disable_percpu_irq(csky_timer_irq);
> +
> +	return 0;
> +}
> +
> +/*** clock source ***/
> +static u64 sched_clock_read(void)
> +{
> +	return get_ccvr();
> +}
> +
> +static u64 clksrc_read(struct clocksource *c)
> +{
> +	return get_ccvr();
> +}
> +
> +struct clocksource csky_clocksource = {
> +	.name = "csky_timer_v1_clksrc",
> +	.rating = 400,
> +	.mask = CLOCKSOURCE_MASK(BITS_CSKY_TIMER),
> +	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
> +	.read = clksrc_read,

tabular style please

> +};
> +
> +static void csky_clksrc_init(void)
> +{
> +	clocksource_register_hz(&csky_clocksource, csky_timer_rate);
> +
> +	sched_clock_register(sched_clock_read, BITS_CSKY_TIMER, csky_timer_rate);
> +}
> +
> +static int __init csky_timer_v1_init(struct device_node *np)
> +{
> +	int ret;
> +	struct timer_of *to = this_cpu_ptr(&csky_to);
> +
> +	ret = timer_of_init(np, to);
> +	if (ret)
> +		return ret;
> +
> +	csky_timer_irq = to->of_irq.irq;
> +	csky_timer_rate = timer_of_rate(to);
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_DUMMY_TIMER_STARTING,
> +				"clockevents/csky/timer:starting",
> +				csky_timer_starting_cpu,
> +				csky_timer_dying_cpu);

Oh no. Just picking a random hotplug event is not how it works. Add your
own please and make sure it's at the proper place.

> +++ b/drivers/clocksource/timer-nationalchip.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou NationalChip Science & Technology Co.,Ltd.

...

> +#include <linux/init.h>

> +static irqreturn_t timer_interrupt(int irq, void *dev)
> +{
> +	struct clock_event_device *ce = (struct clock_event_device *) dev;

Pointless type cast.

> +	void __iomem *base = timer_of_base(to_timer_of(ce));
> +
> +	writel_relaxed(STATUS_clr, base + TIMER_STATUS);
> +
> +	ce->event_handler(ce);
> +
> +	return IRQ_HANDLED;
> +}

> +static struct timer_of to = {
> +	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
> +
> +	.clkevt = {
> +		.name = TIMER_NAME,
> +		.rating = 300,
> +		.features = CLOCK_EVT_FEAT_DYNIRQ | CLOCK_EVT_FEAT_PERIODIC |
> +			CLOCK_EVT_FEAT_ONESHOT,
> +		.set_state_shutdown	= nc_timer_shutdown,
> +		.set_state_periodic	= nc_timer_set_periodic,
> +		.set_next_event		= nc_timer_set_next_event,
> +		.cpumask = cpu_possible_mask,
> +	},
> +
> +	.of_irq = {
> +		.handler = timer_interrupt,
> +		.flags = IRQF_TIMER | IRQF_IRQPOLL,
> +	},

See above

> +};

Thanks,

	tglx
