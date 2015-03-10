From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH v2 12/18] dt-bindings: Document the STM32 USART bindings
Date: Tue, 10 Mar 2015 16:45:59 +0100
Message-ID: <CALszF6BEYTAF9FiQQB9wF74btVbaMYPgSTRz41-LbhDUnY_37w@mail.gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1424455277-29983-13-git-send-email-mcoquelin.stm32@gmail.com>
	<38153432.AWA0ogMaoK@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:36824 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbbCJPqB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Mar 2015 11:46:01 -0400
In-Reply-To: <38153432.AWA0ogMaoK@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj>

2015-03-10 16:08 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
> On Friday 20 February 2015 19:01:11 Maxime Coquelin wrote:
>> +
>> +Example:
>> +usart1: usart@40011000 {
>> +       compatible = "st,stm32-usart";
>>
>
> Please use generic node names everywhere. The standard name for a serial
> port is "serial".

I already had the remark, and it is already fixed in the next version.

Thanks,
Maxime

>
>         Arnd
