Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38691 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbbDAIhA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Apr 2015 04:37:00 -0400
MIME-Version: 1.0
In-Reply-To: <CAHp75VeUzKUEo7NCaXUYKBPpG7JYCykB+76Wu5tBKj750Bi+Qg@mail.gmail.com>
References: <1427819096-31109-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1427819096-31109-11-git-send-email-mcoquelin.stm32@gmail.com>
	<CAHp75VeUzKUEo7NCaXUYKBPpG7JYCykB+76Wu5tBKj750Bi+Qg@mail.gmail.com>
Date: Wed, 1 Apr 2015 10:36:58 +0200
Message-ID: <CALszF6AKw-F1RVc5m2As7upp7ZuS7GpcJSoqixms3Dd4SNU9EQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/15] serial: stm32-usart: Add STM32 USART Driver
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>, Peter Meerwald <pmeerw@pmeerw.net>, Paul Bolle <pebolle@tiscali.nl>, Peter Hurley <peter@hurleysoftware.com>, Chanwoo Choi <cw00.choi@samsung.com>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, Linux Documentation List <linux-doc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Message-ID: <20150401083658.Xee7XcUUpTSju0reV9kddhRFhPr1y8_rDwH2Cjqy_-E@z>

Hello Andy,

2015-03-31 18:45 GMT+02:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
> On Tue, Mar 31, 2015 at 7:24 PM, Maxime Coquelin
> <mcoquelin.stm32@gmail.com> wrote:
>> This drivers adds support to the STM32 USART controller, which is a
>> standard serial driver.
>>
>> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>
> Few minor comments below.

All your comments are valid, I will send a v5 shortly fixing this.

Thanks for the review,
Maxime

>
>> ---
>>  drivers/tty/serial/Kconfig       |  17 +
>>  drivers/tty/serial/Makefile      |   1 +
>>  drivers/tty/serial/stm32-usart.c | 743 +++++++++++++++++++++++++++++++++++++++
>>  include/uapi/linux/serial_core.h |   3 +
>>  4 files changed, 764 insertions(+)
>>  create mode 100644 drivers/tty/serial/stm32-usart.c
>>
