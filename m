Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:61457 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754613AbbBTVsc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Feb 2015 16:48:32 -0500
Message-ID: <1424468908.24292.10.camel@x220>
Subject: Re: [PATCH v2 04/18] clocksource: Add ARM System timer driver
From: Paul Bolle <pebolle@tiscali.nl>
Date: Fri, 20 Feb 2015 22:48:28 +0100
In-Reply-To: <20150220195437.GT19388@pengutronix.de>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
	 <1424455277-29983-5-git-send-email-mcoquelin.stm32@gmail.com>
	 <20150220195437.GT19388@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, afaerber@suse.de, geert@linux-m68k.org, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150220214828.RlBItelbSd-asE5fInnEcuTGd4cjglQ9XvoduZvaTec@z>

On Fri, 2015-02-20 at 20:54 +0100, Uwe Kleine-König wrote:
> On Fri, Feb 20, 2015 at 07:01:03PM +0100, Maxime Coquelin wrote:
> > This patch adds clocksource support for ARMv7-M's System timer,
> > also known as SysTick.
> > 
> > Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> > ---
> >  drivers/clocksource/Kconfig          |  7 ++++
> >  drivers/clocksource/Makefile         |  1 +
> >  drivers/clocksource/armv7m_systick.c | 78 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 86 insertions(+)
> >  create mode 100644 drivers/clocksource/armv7m_systick.c
> > 
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index fc01ec2..fb6011e 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -124,6 +124,13 @@ config CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
> >  	help
> >  	 Use ARM global timer clock source as sched_clock
> >  
> > +config ARMV7M_SYSTICK
> > +	bool
> I assume this symbol is enabled later in the series.

Yes, I noticed it was selected in 14/18 ("ARM: Add STM32 family
machine").

> Would it make sense
> to allow enabing the symbol for compile test coverage?
> 
> > +	select CLKSRC_OF if OF
> What happens if ARMV7M_SYSTICK=y but OF=n? Doesn't the driver fail to
> compile?
> 
> > +	select CLKSRC_MMIO
> > +	help
> > +	  This options enables support for the ARMv7M system timer unit
> the right spelling is ARMv7-M.

This Kconfig entry has no prompt, so no one is going to see this text
during make *config. Perhaps this should be made a comment. In that case
the right spelling should still be used.

Thanks,


Paul Bolle

