Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:50945 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754429AbbBTVhY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Feb 2015 16:37:24 -0500
Message-ID: <1424468240.24292.5.camel@x220>
Subject: Re: [PATCH v2 14/18] ARM: Add STM32 family machine
From: Paul Bolle <pebolle@tiscali.nl>
Date: Fri, 20 Feb 2015 22:37:20 +0100
In-Reply-To: <20150220200019.GU19388@pengutronix.de>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
	 <1424455277-29983-15-git-send-email-mcoquelin.stm32@gmail.com>
	 <20150220200019.GU19388@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, afaerber@suse.de, geert@linux-m68k.org, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150220213720.W1SV-Np1EniBUtixR7E24fv2jJNVLnLQhifc--639-g@z>

On Fri, 2015-02-20 at 21:00 +0100, Uwe Kleine-König wrote:
> On Fri, Feb 20, 2015 at 07:01:13PM +0100, Maxime Coquelin wrote:
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 97d07ed..cfd9532 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -774,6 +774,28 @@ config ARCH_OMAP1
> >  	help
> >  	  Support for older TI OMAP1 (omap7xx, omap15xx or omap16xx)
> >  
> > +config ARCH_STM32
> > +	bool "STMicrolectronics STM32"
> > +	depends on !MMU
> > +	select ARCH_REQUIRE_GPIOLIB
> > +	select ARM_NVIC
> > +	select AUTO_ZRELADDR
> > +	select ARCH_HAS_RESET_CONTROLLER
> > +	select RESET_CONTROLLER
> > +	select PINCTRL
> > +	select PINCTRL_STM32
> > +	select CLKSRC_OF
> > +	select ARMV7M_SYSTICK
> > +	select COMMON_CLK
> > +	select CPU_V7M
> > +	select GENERIC_CLOCKEVENTS
> > +	select NO_DMA
> > +	select NO_IOPORT_MAP
> > +	select SPARSE_IRQ
> > +	select USE_OF
> Please sort this list alphabetically.

And drop
    select NO_DMA

You copied that from ARCH_EFM32, but it's pointless on arm (as arch/arm/
doesn't provide a NO_DMA Kconfig symbol).

I submitted a patch last year to drop it from ARCH_EFM32, which Uwe
Acked, but then nothing happened. I'm to blame, as I should have sent a
reminder.

> > +	help
> > +	  Support for STMicorelectronics STM32 processors.
> > +
> >  endchoice
> >  
> >  menu "Multiple platform selection"


Paul Bolle

