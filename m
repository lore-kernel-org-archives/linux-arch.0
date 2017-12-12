From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v5 1/3] clocksource/drivers/atcpit100: Add andestech
 atcpit100 timer
Date: Tue, 12 Dec 2017 11:05:48 +0100
Message-ID: <bb7383ba-bb8e-3cbd-4ce0-faaefa8ed114@linaro.org>
References: <1513057621-19084-1-git-send-email-rickchen36@gmail.com>
 <1513057621-19084-2-git-send-email-rickchen36@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:46251 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbdLLKFz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Dec 2017 05:05:55 -0500
Received: by mail-wm0-f67.google.com with SMTP id r78so19641235wme.5
        for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2017 02:05:54 -0800 (PST)
In-Reply-To: <1513057621-19084-2-git-send-email-rickchen36@gmail.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rick Chen <rickchen36@gmail.com>, rick@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linus.walleij@linaro.org, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, linux-serial@vger.kernel.org
Cc: Greentime Hu <green.hu@gmail.com>

On 12/12/2017 06:46, Rick Chen wrote:
> ATCPIT100 is often used on the Andes architecture,
> This timer provide 4 PIT channels. Each PIT channel is a
> multi-function timer, can be configured as 32,16,8 bit timers
> or PWM as well.
> 
> For system timer it will set channel 1 32-bit timer0 as clock
> source and count downwards until underflow and restart again.

[ ... ]

> +config CLKSRC_ATCPIT100
> +	bool "Clocksource for AE3XX platform"
> +	depends on NDS32 || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This option enables support for the Andestech AE3XX platform timers.

Hi Rick,

the general rule for the Kconfig is:

bool "Clocksource for AE3XX platform" if COMPILE_TEST

and no deps on the platform.

It is up to the platform Kconfig to select the option.

We want here a silent option but make it selectable in case of
compilation test coverage.

Also, this driver is not a CLKSRC but a TIMER. Rename CLKSRC_ATCPIT100
to TIMER_ATCPIT100.

> +
>  endmenu
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 72711f1..7d072f5 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -75,3 +75,4 @@ obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
>  obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
>  obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
>  obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
> +obj-$(CONFIG_CLKSRC_ATCPIT100)		+= timer-atcpit100.o

[ ... ]

> +static struct timer_of to = {
> +	.flags = TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE,
> +
> +	.clkevt = {
> +		.name = "atcpit100_tick",
> +		.rating = 300,
> +		.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> +		.set_state_shutdown = atcpit100_clkevt_shutdown,
> +		.set_state_periodic = atcpit100_clkevt_set_periodic,
> +		.set_state_oneshot = atcpit100_clkevt_set_oneshot,
> +		.tick_resume = atcpit100_clkevt_shutdown,
> +		.set_next_event = atcpit100_clkevt_next_event,
> +		.cpumask = cpu_all_mask,

You may consider CLOCK_EVT_DYN_IRQ
https://lwn.net/Articles/540160/

> +	},
> +
> +	.of_irq = {
> +		.handler = atcpit100_timer_interrupt,
> +		.flags = IRQF_TIMER | IRQF_IRQPOLL,
> +	},
> +
> +	/*
> +	 * FIXME: we currently only support clocking using PCLK
> +	 * and using EXTCLK is not supported in the driver.
> +	 */
> +	.of_clk = {
> +		.name = "PCLK",
> +	}

What do you mean ? We can't specify several clock names with timer-of?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
