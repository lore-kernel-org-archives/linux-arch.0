Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37726 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbbERM5L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 18 May 2015 08:57:11 -0400
MIME-Version: 1.0
In-Reply-To: <5559DFD6.3050603@linaro.org>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1431158038-3813-5-git-send-email-mcoquelin.stm32@gmail.com>
	<CALszF6BiKwDKejfpVgs6ojTxC4LSRfLSEaszXTGVy7xfbHLHZg@mail.gmail.com>
	<5559DFD6.3050603@linaro.org>
Date: Mon, 18 May 2015 14:57:08 +0200
Message-ID: <CALszF6A5Z0wDpBOFveVjL19sMPAuqfnQJ+CwSgfXygmx46s7tQ@mail.gmail.com>
Subject: Re: [PATCH v8 04/16] clocksource/drivers: Add ARM System timer driver
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>, Peter Meerwald <pmeerw@pmeerw.net>, Paul Bolle <pebolle@tiscali.nl>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Russell King <linux@arm.linux.org.uk>, Joe Perches <joe@perches.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, Nicolae Rosia <nicolae.rosia@gmail.com>, Kamil Lulko <rev13@wp.pl>
Message-ID: <20150518125708.IN3ZLReZ1wBUdE_gRAElcXyky5U8ZAMbIce5kY9dUlo@z>

2015-05-18 14:49 GMT+02:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
> On 05/18/2015 01:55 PM, Maxime Coquelin wrote:
>>
>> Hi Daniel,
>>
>> 2015-05-09 9:53 GMT+02:00 Maxime Coquelin <mcoquelin.stm32@gmail.com>:
>>>
>>> This patch adds clocksource support for ARMv7-M's System timer,
>>> also known as SysTick.
>>>
>>> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>>> ---
>>>   drivers/clocksource/Kconfig          |  7 ++++
>>>   drivers/clocksource/Makefile         |  1 +
>>>   drivers/clocksource/armv7m_systick.c | 79
>>> ++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 87 insertions(+)
>>>   create mode 100644 drivers/clocksource/armv7m_systick.c
>>>
>>
>> Could you consider applying this patch and its dt-bindings
>> documentation (patch 3/16) on your tree for v4.2?
>
>
> Patches applied for 4.2.

Thanks Daniel!

>
> Thanks
>
>   -- Daniel
>
> --
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
