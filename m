Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:56489 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486AbbCJPKV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Mar 2015 11:10:21 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 11/18] pinctrl: Add pinctrl driver for STM32 MCUs
Date: Tue, 10 Mar 2015 16:08:26 +0100
Message-ID: <2464742.YZIRrHto62@wuerfel>
In-Reply-To: <1424455277-29983-12-git-send-email-mcoquelin.stm32@gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com> <1424455277-29983-12-git-send-email-mcoquelin.stm32@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, u.kleine-koenig@pengutronix.de, afaerber@suse.de, geert@linux-m68k.org, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150310150826.IMEDZqmacDSiVqp-NKIF3laqp0LmleoARtDHE5q5p0I@z>

On Friday 20 February 2015 19:01:10 Maxime Coquelin wrote:
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/pinctrl-stm32.h
> @@ -0,0 +1,43 @@
> +#ifndef _DT_BINDINGS_PINCTRL_STM32_H
> +#define _DT_BINDINGS_PINCTRL_STM32_H
> +
> +/* Modes */
> +#define IN             0
> +#define OUT            1
> +#define ALT            2
> +#define ANALOG         3

I think it's better to prefix all the names with a
string to identify what they are for, otherwise these
are way too generic.

> +/* Alternate functions */
> +#define ALT0           ((0 << 2) | ALT)
> +#define ALT1           ((1 << 2) | ALT)
> +#define ALT2           ((2 << 2) | ALT)
> +#define ALT3           ((3 << 2) | ALT)
> +#define ALT4           ((4 << 2) | ALT)
> +#define ALT5           ((5 << 2) | ALT)
> +#define ALT6           ((6 << 2) | ALT)
> +#define ALT7           ((7 << 2) | ALT)
> +#define ALT8           ((8 << 2) | ALT)
> +#define ALT9           ((9 << 2) | ALT)
> +#define ALT10          ((10 << 2) | ALT)
> +#define ALT11          ((11 << 2) | ALT)
> +#define ALT12          ((12 << 2) | ALT)
> +#define ALT13          ((13 << 2) | ALT)
> +#define ALT14          ((14 << 2) | ALT)
> +#define ALT15          ((15 << 2) | ALT)

You can have a single macro for these like

#define STM32_PIN_ALT(x) ((x << 2) | ALT)

> +/* Pull-Up/Down */
> +#define NO_PULL                0
> +#define PULL_UP                1
> +#define PULL_DOWN      2
> +
> +/* Type */
> +#define PUSH_PULL      (0 << 2)
> +#define OPEN_DRAIN     (1 << 2)
> +

These should probably not be stm32 specific at all, they sound
rather generic, so maybe put the definitions into a common file.



	Arnd
