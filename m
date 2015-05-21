Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:33203 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbbEUHqg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 May 2015 03:46:36 -0400
MIME-Version: 1.0
In-Reply-To: <555D1C7D.1060205@suse.de>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1431158038-3813-8-git-send-email-mcoquelin.stm32@gmail.com>
	<555D1C7D.1060205@suse.de>
Date: Thu, 21 May 2015 09:46:34 +0200
Message-ID: <CALszF6CrouFF3oS_Qz6+qQRqa4a5PurdYNdvHnZRDb4zwOJ6mQ@mail.gmail.com>
Subject: Re: [PATCH v8 07/16] drivers: reset: Add STM32 reset driver
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>, Peter Meerwald <pmeerw@pmeerw.net>, Paul Bolle <pebolle@tiscali.nl>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Joe Perches <joe@perches.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, Linux-Arch <linux-arch@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Kamil Lulko <rev13@wp.pl>, Antti Palosaari <crope@iki.fi>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rusty Russell <rusty@rustcorp.com.au>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Nicolae Rosia <nicolae.rosia@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Marek <mmarek@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20150521074634.kNTLvHzmoO9V6aVQcx-lxfV0bSnRs41W0EoykqwFw_k@z>

2015-05-21 1:45 GMT+02:00 Andreas Färber <afaerber@suse.de>:
> Am 09.05.2015 um 09:53 schrieb Maxime Coquelin:
>> +static const struct of_device_id stm32_reset_dt_ids[] = {
>> +      { .compatible = "st,stm32-rcc", },
>> +      { /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, sstm32_reset_dt_ids);
>
> Typo.

Indeed, thanks for pointing this out.

>
> IIUC the timer depends on the reset controller, so it must be built in
> anyway, and that's what's enforced in the Makefile above. Drop the line?
>

Agree it must be built-in.
I will fix that in next version.

Thanks for the review,
Maxime
