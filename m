Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:35705 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754863AbbESPeS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 May 2015 11:34:18 -0400
MIME-Version: 1.0
In-Reply-To: <20150519145006.GH2067@n2100.arm.linux.org.uk>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
	<555B098A.8030202@linaro.org>
	<CALszF6AJ3Zf598wYeUx=iNWHHKT24xUyfagB=+4GocwZ-Fd-0g@mail.gmail.com>
	<6177628.0ZDPLeVyah@wuerfel>
	<CALszF6BZKD-CPTZ6Hc85wv2Z3Y7JmUv-cMkBtbk2Ga6WeeWU=A@mail.gmail.com>
	<555B3F80.8070605@linaro.org>
	<CALszF6A-De6dvcRNoa9ruL+y6Wt_rc7bi-O-VxHWkFF9NSt5_g@mail.gmail.com>
	<20150519145006.GH2067@n2100.arm.linux.org.uk>
Date: Tue, 19 May 2015 17:34:16 +0200
Message-ID: <CALszF6CRXst-4UwMYeDLxrN_3N4Z9q1dxAR7CzFyngeM6Qeqzw@mail.gmail.com>
Subject: Re: [PATCH v8 09/16] clockevents/drivers: Add STM32 Timer driver
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Stefan Agner <stefan@agner.ch>, Peter Meerwald <pmeerw@pmeerw.net>, Paul Bolle <pebolle@tiscali.nl>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Joe Perches <joe@perches.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, Nicolae Rosia <nicolae.rosia@gmail.com>, Kamil Lulko <rev13@wp.pl>
Message-ID: <20150519153416.YR4cszkUp5Xd5GJC4wzKqNbj-VK-Z_l2_aFcChzeq8w@z>

2015-05-19 16:50 GMT+02:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>
> config CLKSRC_STM32
>         bool "Clocksource for STM32 SoCs" if COMPILE_TEST
>         depends on OF
>         select CLKSRC_MMIO
>
> This permits CLKSRC_STM32 to be selected by STM32 (provided OF is enabled,
> it's always going to be for that case, right?) while allowing the option
> to be visible when both OF!=n and COMPILE_TEST!=n.

Yes OF is always enabled when STM32.

So it fits our needs, as we only want the option to be visible when
both OF!=n and COMPILE_TEST!=n.

>
> Remember,
>
>         bool "string" if <condition-affects-visibility-of-string>
>         depends on <condition-affects-config-symbol-availability>
>
> The former merely hides the option from the user _if_ the condition fails.
> The latter _disables_ the option completely (except if you try and select
> it, at which point you end up with a Kconfig warning about that.)

Thanks for the reminder!
Maxime
