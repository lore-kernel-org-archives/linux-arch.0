From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 18/19] clocksource: add C-SKY clocksource drivers
Date: Thu, 5 Jul 2018 11:30:21 +0800
Message-ID: <20180705033020.GA8023@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <aba005fd5005c066a2e3d760c334bb55f902d771.1530465326.git.ren_guo@c-sky.com>
 <bc765809-2d97-5ff8-d2ac-65479ce91ef2@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bc765809-2d97-5ff8-d2ac-65479ce91ef2@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

On Wed, Jul 04, 2018 at 07:05:05PM +0200, Daniel Lezcano wrote:
> >  create mode 100644 drivers/clocksource/timer-csky-v1.c
> >  create mode 100644 drivers/clocksource/timer-nationalchip.c
> 
> Provide two separates patches, one for each timer.
Ok.

> > +obj-$(CONFIG_CSKY)			+= timer-csky-v1.o timer-nationalchip.o
> 
> Split this in two.
> 
> CONFIG_TIMER_CSKY += timer-csky.o
> 
> Note, no v1.
> 
> CONFIG_TIMER_NATCHIP += timer-natchip.o
> 
> 
> And in the Kconfig add the silent timer option.
> 
> config TIMER_CSKY
>  bool
> 
> config TIMER_NATCHIP
>  bool
> 
> (If you want to keep the nationalchip name, I'm fine with that).
Ok, NATCHIP & timer-natchip :)

> > +static int csky_timer_irq;
> > +static int csky_timer_rate;
> 
> You can get the value from the timer-of in all the places it is needed.
Ok, I could remove them.

But in csky_timer_v1_init: ret = timer_of_init(np, to)
We only init 1th cpu's timer_of struct, and others just static inited by:

DEFINE_PER_CPU(struct timer_of, csky_to) = {
	.flags = TIMER_OF_CLOCK | TIMER_OF_IRQ,

	.clkevt = {
		.name = "C-SKY SMP Timer V1",
		.rating = 300,
		.features = CLOCK_EVT_FEAT_PERCPU | CLOCK_EVT_FEAT_ONESHOT,
		.set_state_shutdown		= csky_timer_shutdown,
		.set_state_oneshot		= csky_timer_oneshot,
		.set_state_oneshot_stopped	= csky_timer_oneshot_stopped,
		.set_next_event			= csky_timer_set_next_event,
	},

	.of_irq = {
		.handler = timer_interrupt,
		.flags = IRQF_TIMER,
		.percpu = 1,
	},
};

So I still need "for_each_cpu(cpu, cpu_possible_mask)" to init every
csky_to ...

> > +
> > +	.clkevt = {
> > +		.name = "C-SKY SMP Timer V1",
> 
> If the node name is nice enough, you can discard this. See below
> TIMER_OF_DECLARE comment.
Ok, remove it :)


> > +static int csky_timer_starting_cpu(unsigned int cpu)
> > +{
> > +	struct timer_of *to = this_cpu_ptr(&csky_to);
> 
> per_cpu_ptr(&csky_to, cpu);
Ok, thx for the tip.
 
> > +	to->clkevt.cpumask = cpumask_of(smp_processor_id());
> 
> cpumask_of(cpu);  ?
Yes.

> > +	clockevents_config_and_register(&to->clkevt, csky_timer_rate, 0, ULONG_MAX);
> 
> I suggest to choose something different than zero for the min_delta.
Agree, I'll use 1 :)
clockevents_config_and_register(&to->clkevt, csky_timer_rate, 1, ULONG_MAX);

> > +struct clocksource csky_clocksource = {
> > +	.name = "csky_timer_v1_clksrc",
> 
> "csky"
struct clocksource csky_clocksource = {
	.name = "csky,mptimer",
Hmm?

> > +	csky_clksrc_init();
> 
> inline the function here. It is not worth to add a function for a couple
> of lines which is called one time.
Ok

> > +TIMER_OF_DECLARE(csky_timer_v1, "csky,timer-v1", csky_timer_v1_init);
> 
> Stick to the hardware name.
> 
> eg.
> 
> TIMER_OF_DECLARE(csky_610, "csky,ck610-timer", csky_timer_init);
> TIMER_OF_DECLARE(csky_807, "csky,ck807-timer", csky_timer_init);
> 
> (Beside /proc/interrupts will show the node name which states clearly
> what timer it is).
> 
> ...
> 
> v1, v2, etc ... has no sense here.
TIMER_OF_DECLARE(csky_610, "nationachip,ck610-timer", natchip_timer_init);
TIMER_OF_DECLARE(csky_807, "csky,ck807-timer", csky_timer_init);
TIMER_OF_DECLARE(csky_810, "csky,ck810-timer", csky_timer_init);
TIMER_OF_DECLARE(csky_860, "csky,ck860-timer", csky_timer_init);
TIMER_OF_DECLARE(csky_860mp, "csky,ck860-mptimer", csky_mptimer_init);

Hmm?

> > +#define STATUS_clr	BIT(0)
> > +
> > +#define CONTRL_rst	BIT(0)
> > +#define CONTRL_start	BIT(1)
> > +
> > +#define CONFIG_en	BIT(0)
> > +#define CONFIG_irq_en	BIT(1)
> 
> Prefix the macros with a shortened timer name and don't mix lower case
> and uppercase.
Ok.

#define STATUS_CLR	BIT(0)

#define CONTRL_RST	BIT(0)
#define CONTRL_START	BIT(1)

#define CONFIG_EN	BIT(0)
#define CONFIG_IRQ_EN	BIT(1)

> NC_ is too short, something like NATCHIP may be better.
Ok, good name.

> > +static irqreturn_t timer_interrupt(int irq, void *dev)
> 
> Fix the function name.
static irqreturn_t natchip_timer_interrupt(int irq, void *dev)
Hmm?

> > +static struct timer_of to = {
> > +	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
> > +
> > +	.clkevt = {
> > +		.name = TIMER_NAME,
> 
> Let the node name.
Ok, remove it.
 
> > +		.rating = 300,
> > +		.features = CLOCK_EVT_FEAT_DYNIRQ | CLOCK_EVT_FEAT_PERIODIC |
> > +			CLOCK_EVT_FEAT_ONESHOT,
> > +		.set_state_shutdown	= nc_timer_shutdown,
> > +		.set_state_periodic	= nc_timer_set_periodic,
> > +		.set_next_event		= nc_timer_set_next_event,
> 
> set_oneshot ?
Yes oneshort, but also could support periodic. But in fact, it only
works with oneshort.

> > +		.cpumask = cpu_possible_mask,
> > +	},
> > +
> > +	.of_irq = {
> > +		.handler = timer_interrupt,
> > +		.flags = IRQF_TIMER | IRQF_IRQPOLL,
> > +	},
> > +};
> > +
> > +static u64 notrace nc_sched_clock_read(void)
> > +{
> > +	void __iomem *base;
> > +
> > +	base = timer_of_base(&to) + CLKSRC_OFFSET; 
> > +
> > +	return (u64) readl_relaxed(base + TIMER_VALUE);
> > +}
> > +
> > +static void nc_timer_set_div(void __iomem *base)
> > +{
> > +	unsigned int div;
> > +
> > +	div = timer_of_rate(&to)/TIMER_FREQ - 1;
> 
> space ' / '
> 
> Is it
>   (timer_of_rate(&to) / TIMER_FREQ) - 1
> or
>   timer_of_rate(&to) / (TIMER_FREQ - 1)
> 
> ?
Thx, I'll modify it like this:
div = (timer_of_rate(&to) / TIMER_FREQ) - 1;

> > +	clocksource_mmio_init(base + TIMER_VALUE, "nationalchip", TIMER_FREQ, 200, 32,
> > +			      clocksource_mmio_readl_up);
> 
> return code check ?
Ok, add return code check.

> > +TIMER_OF_DECLARE(nc_timer, "nationalchip,timer-v1", nc_timer_init);
> 
> same comment than cksy timer.
Ok.

 Guo Ren
