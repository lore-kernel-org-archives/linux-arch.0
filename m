From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 18/19] clocksource: add timer-nationalchip.c
Date: Sun, 18 Mar 2018 23:07:12 +0100
Message-ID: <17200f94-9684-2600-a36e-a42a2d53ed70@linaro.org>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <04f5a0702fc14e934e6f5a456cad8682d0b15aa2.1521399976.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <04f5a0702fc14e934e6f5a456cad8682d0b15aa2.1521399976.git.ren_guo@c-sky.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

Hi Guo,


On 18/03/2018 20:51, Guo Ren wrote:

This patch is a new driver. Please add the hardware details of this
timer and optionally a link to the documentation. No need to write a
book, just a quick summary of it.

> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  drivers/clocksource/Makefile             |   1 +
>  drivers/clocksource/timer-nationalchip.c | 149 +++++++++++++++++++++++++++++++
>  2 files changed, 150 insertions(+)
>  create mode 100644 drivers/clocksource/timer-nationalchip.c
> 
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index d6dec44..d091712 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -76,3 +76,4 @@ obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
>  obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
>  obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
>  obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
> +obj-$(CONFIG_CSKY)			+= timer-nationalchip.o
> diff --git a/drivers/clocksource/timer-nationalchip.c b/drivers/clocksource/timer-nationalchip.c
> new file mode 100644
> index 0000000..1279d64
> --- /dev/null
> +++ b/drivers/clocksource/timer-nationalchip.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou NationalChip Science & Technology Co.,Ltd.
> +#include <linux/kernel.h>
> +#include <linux/sched.h>
> +#include <linux/param.h>

sched ? param ?

> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/profile.h>

profile ?

> +#include <linux/irq.h>
> +#include <linux/rtc.h>
> +#include <linux/sizes.h>

rtc ? sizes ?

> +#include <linux/clocksource.h>
> +#include <linux/clockchips.h>
> +#include <asm/irq.h>
> +#include <asm/io.h>
> +#include <asm/delay.h>

Is the delay API defined for this architecture ? I don't see it used below.

> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/sched_clock.h>
> +
> +#define NC_VA_COUNTER_1_STATUS		(void *)(timer_reg + 0x00)
> +#define NC_VA_COUNTER_1_VALUE		(void *)(timer_reg + 0x04)
> +#define NC_VA_COUNTER_1_CONTROL		(void *)(timer_reg + 0x10)
> +#define NC_VA_COUNTER_1_CONFIG		(void *)(timer_reg + 0x20)
> +#define NC_VA_COUNTER_1_PRE		(void *)(timer_reg + 0x24)
> +#define NC_VA_COUNTER_1_INI		(void *)(timer_reg + 0x28)
> +#define NC_VA_COUNTER_2_STATUS		(void *)(timer_reg + 0x40)
> +#define NC_VA_COUNTER_2_VALUE		(void *)(timer_reg + 0x44)
> +#define NC_VA_COUNTER_2_CONTROL		(void *)(timer_reg + 0x50)
> +#define NC_VA_COUNTER_2_CONFIG		(void *)(timer_reg + 0x60)
> +#define NC_VA_COUNTER_2_PRE		(void *)(timer_reg + 0x64)
> +#define NC_VA_COUNTER_2_INI		(void *)(timer_reg + 0x68)
> +#define NC_VA_COUNTER_3_STATUS		(void *)(timer_reg + 0x80)
> +#define NC_VA_COUNTER_3_VALUE		(void *)(timer_reg + 0x84)
> +#define NC_VA_COUNTER_3_CONTROL		(void *)(timer_reg + 0x90)
> +#define NC_VA_COUNTER_3_CONFIG		(void *)(timer_reg + 0xa0)
> +#define NC_VA_COUNTER_3_PRE		(void *)(timer_reg + 0xa4)
> +#define NC_VA_COUNTER_3_INI		(void *)(timer_reg + 0xa8)
> +
> +static unsigned int timer_reg;
> +
> +static inline void timer_reset(void)
> +{
> +	__raw_writel(0x1,	NC_VA_COUNTER_1_CONTROL);
> +	__raw_writel(0x0,	NC_VA_COUNTER_1_CONTROL);
> +	__raw_writel(0x3,	NC_VA_COUNTER_1_CONFIG);
> +	__raw_writel(26,	NC_VA_COUNTER_1_PRE);

Why are you using the __raw_writel instead of writel ?

No values, explicit macros please.

> +}
> +
> +static irqreturn_t timer_interrupt(int irq, void *dev_id)

timer_interrupt is a too generic name, at least nc_timer_interrupt would
be more accurate.

> +{
> +	struct clock_event_device *dev = (struct clock_event_device *) dev_id;
> +
> +	__raw_writel(1, NC_VA_COUNTER_1_STATUS);
> +
> +	dev->event_handler(dev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int nc_timer_set_periodic(struct clock_event_device *dev)
> +{
> +	timer_reset();
> +
> +	__raw_writel(0xFFFFD8EF, NC_VA_COUNTER_1_INI);
> +	__raw_writel(0x2, NC_VA_COUNTER_1_CONTROL);
> +
> +	return 0;
> +}
> +
> +static int nc_timer_set_next_event(unsigned long delta, struct clock_event_device *evt)
> +{
> +	__raw_writel(0x1,		NC_VA_COUNTER_1_CONTROL);
> +	__raw_writel(ULONG_MAX - delta, NC_VA_COUNTER_1_INI);
> +	__raw_writel(0x2,		NC_VA_COUNTER_1_CONTROL);
> +	return 0;
> +}
> +
> +static int nc_timer_shutdown(struct clock_event_device *dev)
> +{
> +	__raw_writel(0x0, NC_VA_COUNTER_1_CONTROL);
> +	__raw_writel(0x0, NC_VA_COUNTER_1_CONFIG);
> +
> +	return 0;
> +}
> +
> +static struct clock_event_device nc_ced = {
> +	.name			= "nationalchip-clkevent",
> +	.features		= CLOCK_EVT_FEAT_PERIODIC
> +				| CLOCK_EVT_FEAT_ONESHOT,
> +	.rating			= 200,
> +	.set_state_shutdown	= nc_timer_shutdown,
> +	.set_state_periodic	= nc_timer_set_periodic,
> +	.set_next_event		= nc_timer_set_next_event,
> +};
> +
> +static u64 notrace nc_sched_clock_read(void)
> +{
> +	return (u64) __raw_readl(NC_VA_COUNTER_2_VALUE);
> +}
> +
> +static void nc_csd_enable(void)

Can you choose a more explicit name than 'csd'?

> +{
> +	__raw_writel(0x1, NC_VA_COUNTER_2_CONTROL);
> +	__raw_writel(0x0, NC_VA_COUNTER_2_CONTROL);
> +	__raw_writel(0x1, NC_VA_COUNTER_2_CONFIG);
> +
> +	__raw_writel(26,NC_VA_COUNTER_2_PRE);
> +	__raw_writel(0, NC_VA_COUNTER_2_INI);
> +	__raw_writel(0x2, NC_VA_COUNTER_2_CONTROL);
> +}
> +
> +static int __init nc_timer_init(struct device_node *np)
> +{
> +	unsigned int irq;
> +	unsigned int freq;
> +
> +	/* parse from devicetree */
> +	timer_reg = (unsigned int) of_iomap(np, 0);
> +	if (!timer_reg)
> +		panic("%s, of_iomap err.\n", __func__);
> +
> +	irq = irq_of_parse_and_map(np, 0);
> +	if (!irq)
> +		panic("%s, irq_parse err.\n", __func__);
> +
> +	if (of_property_read_u32(np, "clock-frequency", &freq))
> +		panic("%s, clock-frequency error.\n", __func__);
>
> +	pr_info("Nationalchip Timer Init, reg: %x, irq: %d, freq: %d.\n",
> +		timer_reg, irq, freq);
> +
> +	/* setup irq */
> +	if (request_irq(irq, timer_interrupt, IRQF_TIMER, np->name, &nc_ced))
> +		panic("%s timer_interrupt error.\n", __func__);

Replace the "clock-frequency" property to a clock phandle and use the
timer-of API.

That will result on something like that:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clocksource/timer-sprd.c#n124

No panic in init function.

> +	/* register */
> +	clockevents_config_and_register(&nc_ced, freq, 1, ULONG_MAX);
> +
> +	nc_csd_enable();
> +	clocksource_mmio_init(NC_VA_COUNTER_2_VALUE, "nationalchip-clksource", freq, 200, 32, clocksource_mmio_readl_up);

s/nationalchip-clksource/nationalchip/

line wrap

> +	sched_clock_register(nc_sched_clock_read, 32, freq);
> +
> +	return 0;
> +}
> +CLOCKSOURCE_OF_DECLARE(nc_timer, "nationalchip,timer-v1", nc_timer_init);

s/CLOCKSOURCE_OF_DECLARE/TIMER_OF_DECLARE/


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
