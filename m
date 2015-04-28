Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37499 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965594AbbD1MNS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 28 Apr 2015 08:13:18 -0400
MIME-Version: 1.0
In-Reply-To: <552678E7.4040107@mentor.com>
References: <1428424234-28572-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1428424234-28572-11-git-send-email-mcoquelin.stm32@gmail.com>
	<552678E7.4040107@mentor.com>
Date: Tue, 28 Apr 2015 14:13:16 +0200
Message-ID: <CALszF6CTFgVd4D6Ftkf0jW+Hcp53jqrutOHOagDXT-0705aHHQ@mail.gmail.com>
Subject: Re: [PATCH v6 10/15] serial: stm32-usart: Add STM32 USART Driver
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>, Peter Meerwald <pmeerw@pmeerw.net>, Paul Bolle <pebolle@tiscali.nl>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Message-ID: <20150428121316.I5dzQQiV0zgkQV0wEs21SYKF-lAdffjfj6GCg_Xhq3I@z>

Hi Vladimir,

Thanks for the review, and sorry for the late reply.

2015-04-09 15:04 GMT+02:00 Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>:
> Hi Maxime,
>
> On 07.04.2015 19:30, Maxime Coquelin wrote:
>> This drivers adds support to the STM32 USART controller, which is a
>> standard serial driver.
>>
>> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> ---
>>  drivers/tty/serial/Kconfig       |  17 +
>>  drivers/tty/serial/Makefile      |   1 +
>>  drivers/tty/serial/stm32-usart.c | 735 +++++++++++++++++++++++++++++++++++++++
>>  include/uapi/linux/serial_core.h |   3 +
>>  4 files changed, 756 insertions(+)
>>  create mode 100644 drivers/tty/serial/stm32-usart.c
>
> [snip]
>
>> +static void stm32_console_write(struct console *co, const char *s, unsigned cnt)
>> +{
>> +     struct uart_port *port = &stm32_ports[co->index].port;
>> +     unsigned long flags;
>> +     u32 old_cr1, new_cr1;
>> +     int locked = 1;
>> +
>> +     if (oops_in_progress) {
>> +             locked = spin_trylock_irqsave(&port->lock, flags);
>> +     } else {
>> +             locked = 1;    ID

>
> locked = 1 is done from the declaration.
Right, I will fix this in next version

>
> Also do you want to add "if (port->sysrq) locked = 0;" check?

Yes, that makes sense. It will be also in v7.
>
>> +             spin_lock_irqsave(&port->lock, flags);
>> +     }
>> +


>
> [snip]
>
> Everything else is fine from point of view.
>
> Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

Regards,
Maxime
>
> --
> With best wishes,
> Vladimir
