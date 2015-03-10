Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:52114 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461AbbCJUWP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Mar 2015 16:22:15 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 07/18] drivers: reset: Add STM32 reset driver
Date: Tue, 10 Mar 2015 21:21:33 +0100
Message-ID: <2455342.zT71E5iyaL@wuerfel>
In-Reply-To: <CALszF6D3XMkjkMTdS-1xnVMFzgAW53NNOKOsfztsCboTdsBaaw@mail.gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com> <2383270.cAJPOxrkvo@wuerfel> <CALszF6D3XMkjkMTdS-1xnVMFzgAW53NNOKOsfztsCboTdsBaaw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Message-ID: <20150310202133.1112Om9J7uY0yZqDQiajgSYQ3grDwSImnEgolwcaaZg@z>

On Tuesday 10 March 2015 16:44:24 Maxime Coquelin wrote:
> 2015-03-10 16:02 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
> > On Friday 20 February 2015 19:01:06 Maxime Coquelin wrote:
> >> +/* AHB1 */
> >> +#define GPIOA_RESET    0
> >> +#define GPIOB_RESET    1
> >> +#define GPIOC_RESET    2
> >> +#define GPIOD_RESET    3
> >> +#define GPIOE_RESET    4
> >> +#define GPIOF_RESET    5
> >> +#define GPIOG_RESET    6
> >> +#define GPIOH_RESET    7
> >> +#define GPIOI_RESET    8
> >> +#define GPIOJ_RESET    9
> >> +#define GPIOK_RESET    10
> >>
> >
> > As these are just the hardware numbers, it's better to not make them
> > part of the binding at all. Instead, just document in the binding that
> > one is supposed to pass the hardware number as the argument.
> 
> The reset controller is part of the RCC (Reset & Clock Controller) IP.
> In this version, I only provided the reset registers to the reset
> controller driver, but as per Andreas Färber remark, I should avec a
> single DT node for both the resets and clocks.
> 
> In the next version I am preparing, the defines doesn't look as
> trivial as in this version, GPIOA_RESET being 128 for instance.
> 
> Is it fine for you if I keep the defines part of the binding?
> 
> 

It's always better to avoid these files entirely, as they are
a frequent source of merge dependencies, and they make it less
obvious what's going on than having binary values in the dtb
that make sense.

	Arnd
