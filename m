Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:57931 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145AbbEMQjN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2015 12:39:13 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 14/16] ARM: dts: Introduce STM32F429 MCU
Date: Wed, 13 May 2015 18:37:46 +0200
Message-ID: <2282066.NWoIT9ZyLc@wuerfel>
In-Reply-To: <CALszF6DHazhN6+hGShyrmqtMrPod0hdb8mHAwK-GWfRxXzy7wQ@mail.gmail.com>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com> <11310179.epfRucfQKB@wuerfel> <CALszF6DHazhN6+hGShyrmqtMrPod0hdb8mHAwK-GWfRxXzy7wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Stefan Agner <stefan@agner.ch>, Peter Meerwald <pmeerw@pmeerw.net>, Paul Bolle <pebolle@tiscali.nl>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Joe Perches <joe@perches.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Lee Jones <lee.jones@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, Nicolae Rosia <nicolae.rosia@gmail.com>, Kamil Lulko <rev13@wp.pl>
Message-ID: <20150513163746.VxE_50Ob3dg4B9xWqxYBoBoJxklfIGkaUMFxrNjSkgo@z>

On Wednesday 13 May 2015 18:29:05 Maxime Coquelin wrote:
> 2015-05-13 17:28 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> > On Wednesday 13 May 2015 16:20:34 Daniel Thompson wrote:
> >>
> >> That would suit me very well (although is the 0x20/0x40 not the 8 that
> >> we would need in the middle column).
> >
> > We don't normally use register offsets in DT. The number 8 here instead
> > would indicate block 8, where each block is four bytes wide. Using the
> > same index here for reset and clock would also help readability.
> 
> My view is that it makes the bindings usage very complex.
> Also, it implies we have a specific compatible for stm32f429, whereas
> we didn't need with my earlier proposals.
> Indeed, the reset driver will need to know the offset of every reset
> registers, because:
>   1. The AHB registers start at RCC offset 0x10 (up to 0x18)
>   2. The APB registers start at RCC offset 0x20 (up to 0x24).
> We have a gap between AHB and APB registers, so how do we map the
> index for the block you propose?
> Should the gap be considered as a block, or we should skip it?
>
> I'm afraid it will not be straightforward for a reset user to
> understand how to use this bindings.
> 
> Either my v7 or v8 versions would have made possible to use a single
> compatible for STM32 series.
> If we stick with one of these, we could even think to have a "generic"
> reset driver, as it could be compatible with sunxi driver bindings.

We should definitely try to use the same compatible string for all of
them, and make a binding that is easy to use.

I haven't fully understood the requirements for the various parts that
are involved here. My understanding so far was that the driver could
use the index from the first cell and compute

	void __iomem *reset_reg = rcc_base + 0x10 + 4 * index;
	void __iomem *clock_reg = rcc_base + 0x30 + 4 * index;

Are there parts that need something else? If the 0x10 offset is
different, we probably want a different compatible string, and I'd
consider it a different part at that point. If there are chips
that do not spread the clock from the reset by exactly 256 bits,
we could add a DT property in the rcc node for that.

	Arnd
