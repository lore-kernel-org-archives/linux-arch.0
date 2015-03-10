Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33123 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbbCJVUF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Mar 2015 17:20:05 -0400
MIME-Version: 1.0
In-Reply-To: <2455342.zT71E5iyaL@wuerfel>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
	<2383270.cAJPOxrkvo@wuerfel>
	<CALszF6D3XMkjkMTdS-1xnVMFzgAW53NNOKOsfztsCboTdsBaaw@mail.gmail.com>
	<2455342.zT71E5iyaL@wuerfel>
Date: Tue, 10 Mar 2015 22:20:03 +0100
Message-ID: <CALszF6DENRS2L8mHD_iPsPwbAZndbHoB10oHaJ8-E4ajhog=8w@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] drivers: reset: Add STM32 reset driver
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Message-ID: <20150310212003.uBok1H_QPXC43lOEu253ZS22BIXVXqOuAxBeb7De5sA@z>

2015-03-10 21:21 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 10 March 2015 16:44:24 Maxime Coquelin wrote:
>> 2015-03-10 16:02 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
>> > On Friday 20 February 2015 19:01:06 Maxime Coquelin wrote:
>> >> +/* AHB1 */
>> >> +#define GPIOA_RESET    0
>> >> +#define GPIOB_RESET    1
>> >> +#define GPIOC_RESET    2
>> >> +#define GPIOD_RESET    3
>> >> +#define GPIOE_RESET    4
>> >> +#define GPIOF_RESET    5
>> >> +#define GPIOG_RESET    6
>> >> +#define GPIOH_RESET    7
>> >> +#define GPIOI_RESET    8
>> >> +#define GPIOJ_RESET    9
>> >> +#define GPIOK_RESET    10
>> >>
>> >
>> > As these are just the hardware numbers, it's better to not make them
>> > part of the binding at all. Instead, just document in the binding that
>> > one is supposed to pass the hardware number as the argument.
>>
>> The reset controller is part of the RCC (Reset & Clock Controller) IP.
>> In this version, I only provided the reset registers to the reset
>> controller driver, but as per Andreas Färber remark, I should avec a
>> single DT node for both the resets and clocks.
>>
>> In the next version I am preparing, the defines doesn't look as
>> trivial as in this version, GPIOA_RESET being 128 for instance.
>>
>> Is it fine for you if I keep the defines part of the binding?
>>
>>
>
> It's always better to avoid these files entirely, as they are
> a frequent source of merge dependencies, and they make it less
> obvious what's going on than having binary values in the dtb
> that make sense.

I agree it is always painful to have to have to manage these merge dependencies.
What I will do, if Philipp agrees, is to list all the values in the
binding documentation.

Doing that, the user of a reset won't have to do the calculation, and
no more merge dependencies.

Maxime
>
>         Arnd
