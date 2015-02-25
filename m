Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:62457 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbbBYMEt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2015 07:04:49 -0500
MIME-Version: 1.0
In-Reply-To: <1424468240.24292.5.camel@x220>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1424455277-29983-15-git-send-email-mcoquelin.stm32@gmail.com>
	<20150220200019.GU19388@pengutronix.de>
	<1424468240.24292.5.camel@x220>
Date: Wed, 25 Feb 2015 13:04:47 +0100
Message-ID: <CALszF6CGT35V71QKTrDx+1Ltrctv5F7t8Zq6Tq15zn2bZGQXwQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] ARM: Add STM32 family machine
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Message-ID: <20150225120447._nLdcKY8fNlF1f0ip5FG5qDzH65cPo8QTPM0f2O1w5o@z>

2015-02-20 22:37 GMT+01:00 Paul Bolle <pebolle@tiscali.nl>:
> On Fri, 2015-02-20 at 21:00 +0100, Uwe Kleine-König wrote:
>> On Fri, Feb 20, 2015 at 07:01:13PM +0100, Maxime Coquelin wrote:
>> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> > index 97d07ed..cfd9532 100644
>> > --- a/arch/arm/Kconfig
>> > +++ b/arch/arm/Kconfig
>> > @@ -774,6 +774,28 @@ config ARCH_OMAP1
>> >     help
>> >       Support for older TI OMAP1 (omap7xx, omap15xx or omap16xx)
>> >
>> > +config ARCH_STM32
>> > +   bool "STMicrolectronics STM32"
>> > +   depends on !MMU
>> > +   select ARCH_REQUIRE_GPIOLIB
>> > +   select ARM_NVIC
>> > +   select AUTO_ZRELADDR
>> > +   select ARCH_HAS_RESET_CONTROLLER
>> > +   select RESET_CONTROLLER
>> > +   select PINCTRL
>> > +   select PINCTRL_STM32
>> > +   select CLKSRC_OF
>> > +   select ARMV7M_SYSTICK
>> > +   select COMMON_CLK
>> > +   select CPU_V7M
>> > +   select GENERIC_CLOCKEVENTS
>> > +   select NO_DMA
>> > +   select NO_IOPORT_MAP
>> > +   select SPARSE_IRQ
>> > +   select USE_OF
>> Please sort this list alphabetically.
>
> And drop
>     select NO_DMA
>
> You copied that from ARCH_EFM32, but it's pointless on arm (as arch/arm/
> doesn't provide a NO_DMA Kconfig symbol).

You are right, I will drop NO_DMA in v3.

Thanks,
Maxime

>
> I submitted a patch last year to drop it from ARCH_EFM32, which Uwe
> Acked, but then nothing happened. I'm to blame, as I should have sent a
> reminder.
>
>> > +   help
>> > +     Support for STMicorelectronics STM32 processors.
>> > +
>> >  endchoice
>> >
>> >  menu "Multiple platform selection"
>
>
> Paul Bolle
>
