Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:34534 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756891AbbEVOE0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 May 2015 10:04:26 -0400
MIME-Version: 1.0
In-Reply-To: <555E559F.8040403@suse.de>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1431158038-3813-8-git-send-email-mcoquelin.stm32@gmail.com>
	<555D1C7D.1060205@suse.de>
	<CALszF6CrouFF3oS_Qz6+qQRqa4a5PurdYNdvHnZRDb4zwOJ6mQ@mail.gmail.com>
	<555E1CC4.9090605@suse.de>
	<CALszF6Bhc1MkDaqM3oJ93Rrxxbsss7=FA8WUpbtwmDERUdD0KA@mail.gmail.com>
	<555E559F.8040403@suse.de>
Date: Fri, 22 May 2015 16:04:24 +0200
Message-ID: <CALszF6BFXfjWhRgyejJHXMw+EJZUzT_7FtbKhnjS+DJS=vv11Q@mail.gmail.com>
Subject: Re: [PATCH v8 07/16] drivers: reset: Add STM32 reset driver
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: Kamil Lulko <rev13@wp.pl>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, Stefan Agner <stefan@agner.ch>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Peter Meerwald <pmeerw@pmeerw.net>, Lee Jones <lee.jones@linaro.org>, Linux-Arch <linux-arch@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Jonathan Corbet <corbet@lwn.net>, Jiri Slaby <jslaby@suse.cz>, Daniel Lezcano <daniel.lezcano@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Antti Palosaari <crope@iki.fi>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Rusty Russell <rusty@rustcorp.com.au>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Nicolae Rosia <nicolae.rosia@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Marek <mmarek@suse.cz>, Paul Bolle <pebolle@tiscali.nl>, Peter Hurley <peter@hurleysoftware.com>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <20150522140424.yuq33YlxWWsqzZkOq_5GydJegGF8Rog4G08uS3OllpI@z>

2015-05-22 0:01 GMT+02:00 Andreas Färber <afaerber@suse.de>:
> Am 21.05.2015 um 21:57 schrieb Maxime Coquelin:
>> Note that for now, I still use your bootloader.
>> I have done the changes to reset the timers in the afboot-stm32.
>> That's the reason why I asked you under which licence it is delivered
>> few months ago.
>
> Sorry, too many mails... The stm32 one is GPL-2.0, as parts of it were
> derived from a U-Boot fork. (Personally I prefer GPL-2.0+; fm4 and
> xmc4000 are MIT/X11.)

Not a problem, thanks for providing the licence.

>> I can share you the patch if you want, even if I understand it is more
>> about the concept that you are reluctant.
>>
>> On my side, I plan to move to U-Boot soon, as Kamil Lulko added STM32
>> support in mainline [1].
>
> You're free to use any bootloader you like, but you will find it
> difficult to build in USB etc. drivers given the sheer size of U-Boot.
> That was my motivation for writing the tiny one. ;)

I think the two bootloaders make sense. Indeed, using U-Boot restricts
the size of the Kernel.
I also have the stm32429i-eval board, with 32MB NOR and 32MB SD-Ram.
At least on this one I will use U-Boot, as tftp could be used to load
Kernel since it has Ethernet port.

>> In case of U-Boot, the timer reset should be de-asserted when jumping
>> into the Kernel, as Rob mentionned [0].
>
> Thanks, I've updated the xmc4000 one accordingly and can do the same for
> stm32. But you are right that I consider that an ugly workaround,
> although on the other hand my earlyprintk patches also depend on the
> bootloader setting up GPIOs and UART.

Yes, the Kernel always need to rely on the bootloader to provide a
minimal setup (clock/ddr/muxing...).

Regards,
Maxime
