From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 18/19] clocksource: add C-SKY clocksource drivers
Date: Wed, 4 Jul 2018 19:05:05 +0200
Message-ID: <bc765809-2d97-5ff8-d2ac-65479ce91ef2@linaro.org>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <aba005fd5005c066a2e3d760c334bb55f902d771.1530465326.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <aba005fd5005c066a2e3d760c334bb55f902d771.1530465326.git.ren_guo@c-sky.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org


Hi Guo,

as you are introducing a new drivers, add a detailed changelog
describing in details the timers.

On 01/07/2018 19:34, Guo Ren wrote:
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  drivers/clocksource/Makefile             |   1 +
>  drivers/clocksource/timer-csky-v1.c      | 169 +++++++++++++++++++++++++++++++
>  drivers/clocksource/timer-nationalchip.c | 165 ++++++++++++++++++++++++++++++
>  3 files changed, 335 insertions(+)
>  create mode 100644 drivers/clocksource/timer-csky-v1.c
>  create mode 100644 drivers/clocksource/timer-nationalchip.c

Provide two separates patches, one for each timer.

> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index d6dec44..bbc567b 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -76,3 +76,4 @@ obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
>  obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
>  obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
>  obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
> +obj-$(CONFIG_CSKY)			+= timer-csky-v1.o timer-nationalchip.o

Split this in two.

CONFIG_TIMER_CSKY += timer-csky.o

Note, no v1.

CONFIG_TIMER_NATCHIP += timer-natchip.o


And in the Kconfig add the silent timer option.

config TIMER_CSKY
 bool

config TIMER_NATCHIP
 bool

(If you want to keep the nationalchip name, I'm fine with that).

> diff --git a/drivers/clocksource/timer-csky-v1.c b/drivers/clocksource/timer-csky-v1.c
> new file mode 100644
> index 0000000..f3a822a
> --- /dev/null
> +++ b/drivers/clocksource/timer-csky-v1.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou NationalChip Science & Technology Co.,Ltd.
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
> +
> +static int csky_timer_irq;
> +static int csky_timer_rate;

You can get the value from the timer-of in all the places it is needed.

> +static inline u64 get_ccvr(void)
> +{
> +	u32 lo, hi, t;
> +
> +	do {
> +		hi = mfcr(PTIM_CCVR_HI);
> +		lo = mfcr(PTIM_CCVR_LO);
> +		t  = mfcr(PTIM_CCVR_HI);
> +	} while(t != hi);
> +
> +	return ((u64)hi << 32) | lo;
> +}
> +
> +static irqreturn_t timer_interrupt(int irq, void *dev)
> +{
> +	struct timer_of *to = this_cpu_ptr(&csky_to);
> +
> +	mtcr(PTIM_TSR, 0);
> +
> +	to->clkevt.event_handler(&to->clkevt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int csky_timer_set_next_event(unsigned long delta, struct clock_event_device *ce)
> +{
> +	mtcr(PTIM_LVR, delta);
> +
> +	return 0;
> +}
> +
> +static int csky_timer_shutdown(struct clock_event_device *ce)
> +{
> +	mtcr(PTIM_CTLR, 0);
> +
> +	return 0;
> +}
> +
> +static int csky_timer_oneshot(struct clock_event_device *ce)
> +{
> +	mtcr(PTIM_CTLR, 1);
> +
> +	return 0;
> +}
> +
> +static int csky_timer_oneshot_stopped(struct clock_event_device *ce)
> +{
> +	mtcr(PTIM_CTLR, 0);
> +
> +	return 0;
> +}
> +
> +DEFINE_PER_CPU(struct timer_of, csky_to) = {
> +	.flags = TIMER_OF_CLOCK | TIMER_OF_IRQ,
> +
> +	.clkevt = {
> +		.name = "C-SKY SMP Timer V1",

If the node name is nice enough, you can discard this. See below
TIMER_OF_DECLARE comment.

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
> +		.flags = IRQF_TIMER> +		.percpu = 1,> +	},
> +};
> +
> +/*** clock event for percpu ***/
> +static int csky_timer_starting_cpu(unsigned int cpu)
> +{
> +	struct timer_of *to = this_cpu_ptr(&csky_to);

per_cpu_ptr(&csky_to, cpu);

> +	to->clkevt.cpumask = cpumask_of(smp_processor_id());

cpumask_of(cpu);  ?

> +
> +	clockevents_config_and_register(&to->clkevt, csky_timer_rate, 0, ULONG_MAX);

I suggest to choose something different than zero for the min_delta.

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

"csky"

> +	.rating = 400,
> +	.mask = CLOCKSOURCE_MASK(BITS_CSKY_TIMER),
> +	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
> +	.read = clksrc_read,
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
> +	if (ret) {
> +		pr_err("%s: Failed to cpuhp_setup_state.\n", __func__);
> +		return ret;
> +	}
> +
> +	csky_clksrc_init();

inline the function here. It is not worth to add a function for a couple
of lines which is called one time.

> +
> +	return ret;

return 0;

> +}
> +TIMER_OF_DECLARE(csky_timer_v1, "csky,timer-v1", csky_timer_v1_init);

Stick to the hardware name.

eg.

TIMER_OF_DECLARE(csky_610, "csky,ck610-timer", csky_timer_init);
TIMER_OF_DECLARE(csky_807, "csky,ck807-timer", csky_timer_init);

(Beside /proc/interrupts will show the node name which states clearly
what timer it is).

...

v1, v2, etc ... has no sense here.

> +
> diff --git a/drivers/clocksource/timer-nationalchip.c b/drivers/clocksource/timer-nationalchip.c
> new file mode 100644
> index 0000000..8f4e1e5
> --- /dev/null
> +++ b/drivers/clocksource/timer-nationalchip.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou NationalChip Science & Technology Co.,Ltd.
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/sched_clock.h>
> +
> +#include "timer-of.h"
> +
> +#define TIMER_NAME	"nc_timer"
> +#define TIMER_FREQ	1000000
> +#define CLKSRC_OFFSET	0x40
> +
> +#define TIMER_STATUS	0x00
> +#define TIMER_VALUE	0x04
> +#define TIMER_CONTRL	0x10
> +#define TIMER_CONFIG	0x20
> +#define TIMER_DIV	0x24
> +#define TIMER_INI	0x28
> +
> +#define STATUS_clr	BIT(0)
> +
> +#define CONTRL_rst	BIT(0)
> +#define CONTRL_start	BIT(1)
> +
> +#define CONFIG_en	BIT(0)
> +#define CONFIG_irq_en	BIT(1)

Prefix the macros with a shortened timer name and don't mix lower case
and uppercase.

NC_ is too short, something like NATCHIP may be better.

> +
> +static irqreturn_t timer_interrupt(int irq, void *dev)

Fix the function name.

> +{
> +	struct clock_event_device *ce = (struct clock_event_device *) dev;
> +	void __iomem *base = timer_of_base(to_timer_of(ce));
> +
> +	writel_relaxed(STATUS_clr, base + TIMER_STATUS);
> +
> +	ce->event_handler(ce);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int nc_timer_set_periodic(struct clock_event_device *ce)
> +{
> +	void __iomem *base = timer_of_base(to_timer_of(ce));
> +
> +	/* reset */
> +	writel_relaxed(CONTRL_rst, base + TIMER_CONTRL);
> +
> +	/* config the timeout value */
> +	writel_relaxed(ULONG_MAX - timer_of_period(to_timer_of(ce)),
> +		       base + TIMER_INI);
> +
> +	/* enable with irq and start */
> +	writel_relaxed(CONFIG_en|CONFIG_irq_en, base + TIMER_CONFIG);
> +	writel_relaxed(CONTRL_start, base + TIMER_CONTRL);
> +
> +	return 0;
> +}
> +
> +static int nc_timer_set_next_event(unsigned long delta, struct clock_event_device *ce)
> +{
> +	void __iomem *base = timer_of_base(to_timer_of(ce));
> +
> +	/* use reset to pause timer */
> +	writel_relaxed(CONTRL_rst, base + TIMER_CONTRL);
> +
> +	/* config next timeout value */
> +	writel_relaxed(ULONG_MAX - delta, base + TIMER_INI);
> +	writel_relaxed(CONTRL_start, base + TIMER_CONTRL);
> +
> +	return 0;
> +}
> +
> +static int nc_timer_shutdown(struct clock_event_device *ce)
> +{
> +	void __iomem *base = timer_of_base(to_timer_of(ce));
> +
> +	writel_relaxed(0, base + TIMER_CONTRL);
> +	writel_relaxed(0, base + TIMER_CONFIG);
> +
> +	return 0;
> +}
> +
> +static struct timer_of to = {
> +	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
> +
> +	.clkevt = {
> +		.name = TIMER_NAME,

Let the node name.

> +		.rating = 300,
> +		.features = CLOCK_EVT_FEAT_DYNIRQ | CLOCK_EVT_FEAT_PERIODIC |
> +			CLOCK_EVT_FEAT_ONESHOT,
> +		.set_state_shutdown	= nc_timer_shutdown,
> +		.set_state_periodic	= nc_timer_set_periodic,
> +		.set_next_event		= nc_timer_set_next_event,

set_oneshot ?

> +		.cpumask = cpu_possible_mask,
> +	},
> +
> +	.of_irq = {
> +		.handler = timer_interrupt,
> +		.flags = IRQF_TIMER | IRQF_IRQPOLL,
> +	},
> +};
> +
> +static u64 notrace nc_sched_clock_read(void)
> +{
> +	void __iomem *base;
> +
> +	base = timer_of_base(&to) + CLKSRC_OFFSET; 
> +
> +	return (u64) readl_relaxed(base + TIMER_VALUE);
> +}
> +
> +static void nc_timer_set_div(void __iomem *base)
> +{
> +	unsigned int div;
> +
> +	div = timer_of_rate(&to)/TIMER_FREQ - 1;

space ' / '

Is it
  (timer_of_rate(&to) / TIMER_FREQ) - 1
or
  timer_of_rate(&to) / (TIMER_FREQ - 1)

?

> +
> +	writel_relaxed(div, base + TIMER_DIV);
> +}
> +
> +static void nc_clkevt_init(void __iomem *base)
> +{
> +	/* reset */
> +	writel_relaxed(CONTRL_rst, base + TIMER_CONTRL);
> +
> +	/* reset config */
> +	writel_relaxed(0, base + TIMER_CONFIG);
> +
> +	nc_timer_set_div(base);
> +
> +	clockevents_config_and_register(&to.clkevt, TIMER_FREQ, 1, ULONG_MAX);
> +}
> +
> +static void nc_clksrc_init(void __iomem *base)
> +{
> +	writel_relaxed(CONTRL_rst, base + TIMER_CONTRL);
> +
> +	writel_relaxed(CONFIG_en, base + TIMER_CONFIG);
> +
> +	nc_timer_set_div(base);
> +
> +	writel_relaxed(0, base + TIMER_INI);
> +	writel_relaxed(CONTRL_start, base + TIMER_CONTRL);
> +
> +	clocksource_mmio_init(base + TIMER_VALUE, "nationalchip", TIMER_FREQ, 200, 32,
> +			      clocksource_mmio_readl_up);

return code check ?

> +	sched_clock_register(nc_sched_clock_read, 32, TIMER_FREQ);
> +}
> +
> +static int __init nc_timer_init(struct device_node *np)
> +{
> +	int ret;
> +
> +	ret = timer_of_init(np, &to);
> +	if (ret)
> +		return ret;
> +
> +	nc_clkevt_init(timer_of_base(&to));
> +
> +	nc_clksrc_init(timer_of_base(&to) + CLKSRC_OFFSET);
> +
> +	return 0;
> +}
> +TIMER_OF_DECLARE(nc_timer, "nationalchip,timer-v1", nc_timer_init);

same comment than cksy timer.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
