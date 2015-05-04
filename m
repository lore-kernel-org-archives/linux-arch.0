Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36371 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbbEDLLu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 May 2015 07:11:50 -0400
MIME-Version: 1.0
In-Reply-To: <1430735320.3722.34.camel@pengutronix.de>
References: <1430410844-16062-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1430410844-16062-6-git-send-email-mcoquelin.stm32@gmail.com>
	<55433467.2010603@linaro.org>
	<CALszF6Bw900E9MtpaVmvkFxsrOODRkNg+RxRXz5V3WghHtsxbw@mail.gmail.com>
	<5544A069.5000808@linaro.org>
	<1430735320.3722.34.camel@pengutronix.de>
Date: Mon, 4 May 2015 13:11:48 +0200
Message-ID: <CALszF6DpwfeaXRnOyyL+EJv2dYoGuUQtXZsiMisuaAj1_jCLFw@mail.gmail.com>
Subject: Re: [PATCH v7 05/15] dt-bindings: Document the STM32 reset bindings
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>, Peter Meerwald <pmeerw@pmeerw.net>, Paul Bolle <pebolle@tiscali.nl>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Joe Perches <joe@perches.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, Nicolae Rosia <nicolae.rosia@gmail.com>, Kamil Lulko <rev13@wp.pl>
Message-ID: <20150504111148.9ZKPrlAIWo0q1MGlcskPGk-JfTj4NZ9dhMXV6xZZhCA@z>

2015-05-04 12:28 GMT+02:00 Philipp Zabel <p.zabel@pengutronix.de>:
> Am Samstag, den 02.05.2015, 11:01 +0100 schrieb Daniel Thompson:
>> On 02/05/15 08:55, Maxime Coquelin wrote:
>> > 2015-05-01 10:08 GMT+02:00 Daniel Thompson <daniel.thompson@linaro.org>:
> [...]
>> >> Do you intend the clock driver to use the same compatible string (given it
>> >> is the same bit of hardware).
>> >>
>> >> If so, is it better to use st,stm32f4-rcc here? It seems unlikey to me that
>> >> the register layout of the PLLs and dividers can be the same on the f7 parts
>> >> (and later).
>> >
>> > I agree we need a compatible dedicate to f4 series for clocks, and
>> > maybe even one for f429 (to be checked).
>> > For the reset part, we don't have this need.
>> >
>> > So either we use only "st,stm32f4" as you suggest, or we can have both
>> > in device tree:
>> >
>> > rcc: reset@40023800 {
>> >      #reset-cells = <1>;
>> >      compatible = "st,stm32f4-rcc", "st,stm32-rcc";
>> >      reg = <0x40023800 0x400>;
>> > };
>> >
>> > What do you think?
>>
>> Having both makes sense. The reset driver probably doesn't care about
>> differences between F4 and F7 (I know very little about F7 but I can't
>> think of any obvious h/ware evolution that would confuse the current
>> reset driver).
>
> Seconded, this is exactly the way compatible string lists are supposed
> to be used.

Ok good, so we all agree.

I propose I keep "st,stm32-rcc" only for this series, as it does not
contain the clock driver.
The series adding the clock driver will add "st,stm32f4-rcc", or
"st,stm32f429-rcc" depending on clock driver needs.

Thanks,
Maxime

>
> [...]
>
> regards
> Philipp
>
