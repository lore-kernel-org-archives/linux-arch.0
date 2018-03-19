From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 18/19] clocksource: add timer-nationalchip.c
Date: Mon, 19 Mar 2018 15:03:52 +0800
Message-ID: <20180319070351.GB21923@guoren>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <04f5a0702fc14e934e6f5a456cad8682d0b15aa2.1521399976.git.ren_guo@c-sky.com>
 <20180319041522.zyjdjrxtd2va3m2a@salmiak>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180319041522.zyjdjrxtd2va3m2a@salmiak>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

Hi Mark,

On Mon, Mar 19, 2018 at 04:15:35AM +0000, Mark Rutland wrote:
> > +#define NC_VA_COUNTER_3_CONTROL		(void *)(timer_reg + 0x90)
> > +#define NC_VA_COUNTER_3_CONFIG		(void *)(timer_reg + 0xa0)
> > +#define NC_VA_COUNTER_3_PRE		(void *)(timer_reg + 0xa4)
> > +#define NC_VA_COUNTER_3_INI		(void *)(timer_reg + 0xa8)
> 
> Please define the offsets alone, e.g.
> 
> #define NC_VA_COUNTER_1_STATUS	0x00
> #define NC_VA_COUNTER_1_VALUE	0x04
> 
> ... the base address should be added when calling the io accessor. Please see
> below.
> 
> > +static unsigned int timer_reg;
> 
> This should be a void __iomem *, e.g.
> 
> static void __iomem *timer_base;
> 
> ... though it would be better for this to be associated with the instance of
> the clock_event_device, so that there can be multiple instances in a system.
>
OK

> > +
> > +static inline void timer_reset(void)
> > +{
> > +	__raw_writel(0x1,	NC_VA_COUNTER_1_CONTROL);
> > +	__raw_writel(0x0,	NC_VA_COUNTER_1_CONTROL);
> > +	__raw_writel(0x3,	NC_VA_COUNTER_1_CONFIG);
> > +	__raw_writel(26,	NC_VA_COUNTER_1_PRE);
> 
> Should this be 26 or 0x26?
No

> 
> It would be nice to have mnemonics for these magic numbers.
>
Yes, you are right.

> Please use writel_relaxed() rather than __raw_writel(). e.g.
> 
> 	writel_relaxed(0x1, timer_base + NC_VA_COUNTER_1_CONTROL);
> 	writel_relaxed(0x0, timer_base + NC_VA_COUNTER_1_CONTROL);
> 	writel_relaxed(0x3, timer_base + NC_VA_COUNTER_1_CONTROL);
> 	writel_relaxed(26, timer_base + NC_VA_COUNTER_1_PRE);
>
OK

> > +CLOCKSOURCE_OF_DECLARE(nc_timer, "nationalchip,timer-v1", nc_timer_init);
> 
> This needs a devicetree binding document. Please see Documentation/devicetree/bindings/submitting-patches.txt.
>
OK

Best Regards
  Guo Ren
