Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41756 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755552AbbEUR6s (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 21 May 2015 13:58:48 -0400
Message-ID: <555E1CC4.9090605@suse.de>
Date: Thu, 21 May 2015 19:58:28 +0200
From: =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>
MIME-Version: 1.0
Subject: Re: [PATCH v8 07/16] drivers: reset: Add STM32 reset driver
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com> <1431158038-3813-8-git-send-email-mcoquelin.stm32@gmail.com> <555D1C7D.1060205@suse.de> <CALszF6CrouFF3oS_Qz6+qQRqa4a5PurdYNdvHnZRDb4zwOJ6mQ@mail.gmail.com>
In-Reply-To: <CALszF6CrouFF3oS_Qz6+qQRqa4a5PurdYNdvHnZRDb4zwOJ6mQ@mail.gmail.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, Stefan Agner <stefan@agner.ch>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Peter Meerwald <pmeerw@pmeerw.net>, Lee Jones <lee.jones@linaro.org>, Linux-Arch <linux-arch@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Jonathan Corbet <corbet@lwn.net>, Jiri Slaby <jslaby@suse.cz>, Daniel Lezcano <daniel.lezcano@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Antti Palosaari <crope@iki.fi>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Kamil Lulko <rev13@wp.pl>, Rusty Russell <rusty@rustcorp.com.au>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Nicolae Rosia <nicolae.rosia@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Marek <mmarek@suse.cz>, Paul Bolle <pebolle@tiscali.nl>, Peter Hurley <peter@hurleysoftware.com>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <20150521175828.05aycRMR8TM6SzoMuYXiAkDuB6p90ywkfKFr47x_ISU@z>

Am 21.05.2015 um 09:46 schrieb Maxime Coquelin:
> 2015-05-21 1:45 GMT+02:00 Andreas Färber <afaerber@suse.de>:
>> Am 09.05.2015 um 09:53 schrieb Maxime Coquelin:
>>> +static const struct of_device_id stm32_reset_dt_ids[] = {
>>> +      { .compatible = "st,stm32-rcc", },
>>> +      { /* sentinel */ },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, sstm32_reset_dt_ids);
>>
>> Typo.
> 
> Indeed, thanks for pointing this out.
> 
>>
>> IIUC the timer depends on the reset controller, so it must be built in
>> anyway, and that's what's enforced in the Makefile above. Drop the line?
>>
> 
> Agree it must be built-in.
> I will fix that in next version.

Actually, I've updated a timer implementation of mine to invoke a reset
controller similar to how you do in the STM32 clocksource patch, but no
reset controller is getting returned.

It seems to me, you are working around that by simply ignoring the error
in the timer code and not doing a reset then, so the STM32 timer does in
fact _not_ depend on the reset controller? What happened to your efforts
of making the reset controller usable for the timer? In my case, my
timer is originally in reset state and needs to be deasserted, so I
can't just ignore it.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Dilip Upmanyu, Graham Norton; HRB
21284 (AG Nürnberg)
