From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 18/19] clocksource: add timer-nationalchip.c
Date: Mon, 19 Mar 2018 14:59:52 +0800
Message-ID: <20180319065951.GA21923@guoren>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <04f5a0702fc14e934e6f5a456cad8682d0b15aa2.1521399976.git.ren_guo@c-sky.com>
 <17200f94-9684-2600-a36e-a42a2d53ed70@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <17200f94-9684-2600-a36e-a42a2d53ed70@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

Hi Daniel,

On Sun, Mar 18, 2018 at 11:07:12PM +0100, Daniel Lezcano wrote:
> 
> This patch is a new driver. Please add the hardware details of this
> timer and optionally a link to the documentation. No need to write a
> book, just a quick summary of it.
>
OK

> > +#include <linux/kernel.h>
> > +#include <linux/sched.h>
> > +#include <linux/param.h>
> 
> sched ? param ?
>
I'll cleanup the headers.

> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/profile.h>
> 
> profile ?
> 
I'll cleanup the headers.

> > +#include <linux/irq.h>
> > +#include <linux/rtc.h>
> > +#include <linux/sizes.h>
> 
> rtc ? sizes ?
> 
I'll cleanup the headers.

> > +#include <linux/clocksource.h>
> > +#include <linux/clockchips.h>
> > +#include <asm/irq.h>
> > +#include <asm/io.h>
> > +#include <asm/delay.h>
> 
> Is the delay API defined for this architecture ? I don't see it used below.
> 
I'll cleanup the headers.

> > +#define NC_VA_COUNTER_3_CONFIG		(void *)(timer_reg + 0xa0)
> > +#define NC_VA_COUNTER_3_PRE		(void *)(timer_reg + 0xa4)
> > +#define NC_VA_COUNTER_3_INI		(void *)(timer_reg + 0xa8)
> > +
> > +static unsigned int timer_reg;
> > +
> > +static inline void timer_reset(void)
> > +{
> > +	__raw_writel(0x1,	NC_VA_COUNTER_1_CONTROL);
> > +	__raw_writel(0x0,	NC_VA_COUNTER_1_CONTROL);
> > +	__raw_writel(0x3,	NC_VA_COUNTER_1_CONFIG);
> > +	__raw_writel(26,	NC_VA_COUNTER_1_PRE);
> 
> Why are you using the __raw_writel instead of writel ?
> 
> No values, explicit macros please.
>
OK

> > +}
> > +
> > +static irqreturn_t timer_interrupt(int irq, void *dev_id)
> 
> timer_interrupt is a too generic name, at least nc_timer_interrupt would
> be more accurate.
>
OK

> > +static u64 notrace nc_sched_clock_read(void)
> > +{
> > +	return (u64) __raw_readl(NC_VA_COUNTER_2_VALUE);
> > +}
> > +
> > +static void nc_csd_enable(void)
> 
> Can you choose a more explicit name than 'csd'?
>
OK, change to nc_clocksource_dev_enable

> > +	/* setup irq */
> > +	if (request_irq(irq, timer_interrupt, IRQF_TIMER, np->name, &nc_ced))
> > +		panic("%s timer_interrupt error.\n", __func__);
> 
> Replace the "clock-frequency" property to a clock phandle and use the
> timer-of API.
> 
> That will result on something like that:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clocksource/timer-sprd.c#n124
> 
> No panic in init function.
>
OK

> > +	/* register */
> > +	clockevents_config_and_register(&nc_ced, freq, 1, ULONG_MAX);
> > +
> > +	nc_csd_enable();
> > +	clocksource_mmio_init(NC_VA_COUNTER_2_VALUE, "nationalchip-clksource", freq, 200, 32, clocksource_mmio_readl_up);
> 
> s/nationalchip-clksource/nationalchip/
> 
> line wrap
>
OK

> > +	sched_clock_register(nc_sched_clock_read, 32, freq);
> > +
> > +	return 0;
> > +}
> > +CLOCKSOURCE_OF_DECLARE(nc_timer, "nationalchip,timer-v1", nc_timer_init);
> 
> s/CLOCKSOURCE_OF_DECLARE/TIMER_OF_DECLARE/
>
OK

Best Regards
 Guo Ren
