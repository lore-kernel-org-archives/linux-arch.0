Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35878 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbbDCWOH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Apr 2015 18:14:07 -0400
MIME-Version: 1.0
In-Reply-To: <CAHp75VfPn_+sg_1iR_CdR2KuTyWcR+SKFsuHCbCkCKB0Oeqgfg@mail.gmail.com>
References: <1428080481-18591-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1428080481-18591-9-git-send-email-mcoquelin.stm32@gmail.com>
	<CAHp75VfPn_+sg_1iR_CdR2KuTyWcR+SKFsuHCbCkCKB0Oeqgfg@mail.gmail.com>
Date: Sat, 4 Apr 2015 01:14:04 +0300
Message-ID: <CAHp75Ve+2UUyPAM6ZnYLXaLNOaEA4DGnY6y=VCQxZpdo+cYBfw@mail.gmail.com>
Subject: Re: [PATCH v5 08/15] clockevents/drivers: Add STM32 Timer driver
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>, Peter Meerwald <pmeerw@pmeerw.net>, Paul Bolle <pebolle@tiscali.nl>, Peter Hurley <peter@hurleysoftware.com>, cw00.choi@samsung.com, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, Linux Documentation List <linux-doc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Message-ID: <20150403221404.GAXmOME2SzXgcJ8rNHT_ARSOEuLlaQEpFp7K0wYUEII@z>

On Sat, Apr 4, 2015 at 1:09 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Apr 3, 2015 at 8:01 PM, Maxime Coquelin
> <mcoquelin.stm32@gmail.com> wrote:
>> STM32 MCUs feature 16 and 32 bits general purpose timers with prescalers.
>> The drivers detects whether the time is 16 or 32 bits, and applies a
>> 1024 prescaler value if it is 16 bits.

[]

>> +               pr_err("failed to get clock for clockevent (%d)\n", ret);
>
> Why not dev_err(); ?

Understood, because it's device tree with lack of something like of_err();

-- 
With Best Regards,
Andy Shevchenko
