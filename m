Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33302 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbbETQRg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 May 2015 12:17:36 -0400
MIME-Version: 1.0
In-Reply-To: <13641152.Yt4ZI3oT6L@wuerfel>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
	<2282066.NWoIT9ZyLc@wuerfel>
	<CALszF6CaO_yuNiSDuDV+4d2NRe_+32j=zcSE1HPhB1UH59cW9w@mail.gmail.com>
	<13641152.Yt4ZI3oT6L@wuerfel>
Date: Wed, 20 May 2015 18:17:34 +0200
Message-ID: <CALszF6CK5ezrO6D=4zr6zEPC7VanzbQjnZJwKOZekEZ5L4D-Dg@mail.gmail.com>
Subject: Re: [PATCH v8 14/16] ARM: dts: Introduce STM32F429 MCU
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Philipp Zabel <p.zabel@pengutronix.de>, Daniel Thompson <daniel.thompson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Stefan Agner <stefan@agner.ch>, Peter Meerwald <pmeerw@pmeerw.net>, Paul Bolle <pebolle@tiscali.nl>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Joe Perches <joe@perches.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Lee Jones <lee.jones@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, Nicolae Rosia <nicolae.rosia@gmail.com>, Kamil Lulko <rev13@wp.pl>
Message-ID: <20150520161734.PMWwxnRs7ejliQ3gAiubzuQ30_e4r5FfA9IcwobvR-c@z>

Hi Arnd, Philipp,

2015-05-13 21:11 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> Ideally the binding should follow closely what is documented
> in the data sheet.
>

Daniel and myself would like your opinion about this binding:

rcc: rcc@40023800 {
    #reset-cells = <1>;
    #clock-cells = <2>;
    compatible = "st,stm32-rcc";
    reg = <0x40023800 0x10>, <0x40023810 0x20>, <0x40023830 0x20>;
    reg-names = "clock-cfg", "reset", "clock-gates";
};

It would solve a problem Daniel is facing due to conflicting mem
region when clock and reset drivers are enabled, as both would reserve
the same region.

Also, it would make the reset driver very generic.
Doing that, we could even create a generic-reset.c driver that would
be used by STM32 and Sunxi (at least).
In the probe function, it would check the number of reg resources.
If a single resource is passed, it would take it, else it would look
the one named "reset".
The driver and bindings would be the same for the two families, and
the bindings would be backward compatible with sunxi ones.

Philip, Arnd, what do you think?

Kind regards,
Maxime
