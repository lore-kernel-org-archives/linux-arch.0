Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37562 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160AbbEUT56 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 May 2015 15:57:58 -0400
MIME-Version: 1.0
In-Reply-To: <555E1CC4.9090605@suse.de>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1431158038-3813-8-git-send-email-mcoquelin.stm32@gmail.com>
	<555D1C7D.1060205@suse.de>
	<CALszF6CrouFF3oS_Qz6+qQRqa4a5PurdYNdvHnZRDb4zwOJ6mQ@mail.gmail.com>
	<555E1CC4.9090605@suse.de>
Date: Thu, 21 May 2015 21:57:56 +0200
Message-ID: <CALszF6Bhc1MkDaqM3oJ93Rrxxbsss7=FA8WUpbtwmDERUdD0KA@mail.gmail.com>
Subject: Re: [PATCH v8 07/16] drivers: reset: Add STM32 reset driver
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Kamil Lulko <rev13@wp.pl>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, Stefan Agner <stefan@agner.ch>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Peter Meerwald <pmeerw@pmeerw.net>, Lee Jones <lee.jones@linaro.org>, Linux-Arch <linux-arch@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Jonathan Corbet <corbet@lwn.net>, Jiri Slaby <jslaby@suse.cz>, Daniel Lezcano <daniel.lezcano@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Antti Palosaari <crope@iki.fi>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Rusty Russell <rusty@rustcorp.com.au>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Nicolae Rosia <nicolae.rosia@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Marek <mmarek@suse.cz>, Paul Bolle <pebolle@tiscali.nl>, Peter Hurley <peter@hurleysoftware.com>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <20150521195756.LiH91B39mh3e4YCQpdILw4rzffcIxHqXWAIgmtGKFZ0@z>

2015-05-21 19:58 GMT+02:00 Andreas Färber <afaerber@suse.de>:
> Am 21.05.2015 um 09:46 schrieb Maxime Coquelin:
>> 2015-05-21 1:45 GMT+02:00 Andreas Färber <afaerber@suse.de>:
>>> Am 09.05.2015 um 09:53 schrieb Maxime Coquelin:
>>>> +static const struct of_device_id stm32_reset_dt_ids[] = {
>>>> +      { .compatible = "st,stm32-rcc", },
>>>> +      { /* sentinel */ },
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, sstm32_reset_dt_ids);
>>>
>>> Typo.
>>
>> Indeed, thanks for pointing this out.
>>
>>>
>>> IIUC the timer depends on the reset controller, so it must be built in
>>> anyway, and that's what's enforced in the Makefile above. Drop the line?
>>>
>>
>> Agree it must be built-in.
>> I will fix that in next version.
>
> Actually, I've updated a timer implementation of mine to invoke a reset
> controller similar to how you do in the STM32 clocksource patch, but no
> reset controller is getting returned.
>
> It seems to me, you are working around that by simply ignoring the error
> in the timer code and not doing a reset then, so the STM32 timer does in
> fact _not_ depend on the reset controller? What happened to your efforts
> of making the reset controller usable for the timer? In my case, my
> timer is originally in reset state and needs to be deasserted, so I
> can't just ignore it.

Indeed, I made the reset optionnal in the clocksource patch since v3.
Rob and Arnd said a lot of platform relies on such things are done by
the bootloader [0].
I decided to deassert timers reset at bootloader stage, and make it
optionnal in clocksource driver.
I made it optionnal in case we decide one day to move reset
initialization before timer are initialized.

Note that for now, I still use your bootloader.
I have done the changes to reset the timers in the afboot-stm32.
That's the reason why I asked you under which licence it is delivered
few months ago.
I can share you the patch if you want, even if I understand it is more
about the concept that you are reluctant.

On my side, I plan to move to U-Boot soon, as Kamil Lulko added STM32
support in mainline [1].
In case of U-Boot, the timer reset should be de-asserted when jumping
into the Kernel, as Rob mentionned [0].

Kind regards,
Maxime

[0]: https://lkml.org/lkml/2015/3/10/737
[1]: http://u-boot.10912.n7.nabble.com/PATCH-v2-stm32f4-fix-serial-output-td212812.html
