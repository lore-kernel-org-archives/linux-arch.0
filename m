From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 18/19] clocksource: add timer-nationalchip.c
Date: Mon, 19 Mar 2018 04:15:35 +0000
Message-ID: <20180319041522.zyjdjrxtd2va3m2a@salmiak>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <04f5a0702fc14e934e6f5a456cad8682d0b15aa2.1521399976.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <04f5a0702fc14e934e6f5a456cad8682d0b15aa2.1521399976.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

Hi,

On Mon, Mar 19, 2018 at 03:51:40AM +0800, Guo Ren wrote:
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

Please define the offsets alone, e.g.

#define NC_VA_COUNTER_1_STATUS	0x00
#define NC_VA_COUNTER_1_VALUE	0x04

... the base address should be added when calling the io accessor. Please see
below.

> +static unsigned int timer_reg;

This should be a void __iomem *, e.g.

static void __iomem *timer_base;

... though it would be better for this to be associated with the instance of
the clock_event_device, so that there can be multiple instances in a system.

> +
> +static inline void timer_reset(void)
> +{
> +	__raw_writel(0x1,	NC_VA_COUNTER_1_CONTROL);
> +	__raw_writel(0x0,	NC_VA_COUNTER_1_CONTROL);
> +	__raw_writel(0x3,	NC_VA_COUNTER_1_CONFIG);
> +	__raw_writel(26,	NC_VA_COUNTER_1_PRE);

Should this be 26 or 0x26?

It would be nice to have mnemonics for these magic numbers.

Please use writel_relaxed() rather than __raw_writel(). e.g.

	writel_relaxed(0x1, timer_base + NC_VA_COUNTER_1_CONTROL);
	writel_relaxed(0x0, timer_base + NC_VA_COUNTER_1_CONTROL);
	writel_relaxed(0x3, timer_base + NC_VA_COUNTER_1_CONTROL);
	writel_relaxed(26, timer_base + NC_VA_COUNTER_1_PRE);

[...]

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
> +
> +	pr_info("Nationalchip Timer Init, reg: %x, irq: %d, freq: %d.\n",
> +		timer_reg, irq, freq);
> +
> +	/* setup irq */
> +	if (request_irq(irq, timer_interrupt, IRQF_TIMER, np->name, &nc_ced))
> +		panic("%s timer_interrupt error.\n", __func__);
> +
> +	/* register */
> +	clockevents_config_and_register(&nc_ced, freq, 1, ULONG_MAX);
> +
> +	nc_csd_enable();
> +	clocksource_mmio_init(NC_VA_COUNTER_2_VALUE, "nationalchip-clksource", freq, 200, 32, clocksource_mmio_readl_up);
> +
> +	sched_clock_register(nc_sched_clock_read, 32, freq);
> +
> +	return 0;
> +}
> +CLOCKSOURCE_OF_DECLARE(nc_timer, "nationalchip,timer-v1", nc_timer_init);

This needs a devicetree binding document. Please see Documentation/devicetree/bindings/submitting-patches.txt.

Thanks,
Mark
