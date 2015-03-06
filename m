Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:36932 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244AbbCFJY0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2015 04:24:26 -0500
Received: by obcwp4 with SMTP id wp4so12593299obc.4
        for <linux-arch@vger.kernel.org>; Fri, 06 Mar 2015 01:24:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1424455277-29983-12-git-send-email-mcoquelin.stm32@gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1424455277-29983-12-git-send-email-mcoquelin.stm32@gmail.com>
Date: Fri, 6 Mar 2015 10:24:25 +0100
Message-ID: <CACRpkdbuJ5B_GwvRXax2Y4V37ihh5e6H7=2no0fYTMZPXwDdCw@mail.gmail.com>
Subject: Re: [PATCH v2 11/18] pinctrl: Add pinctrl driver for STM32 MCUs
From: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-api@vger.kernel.org
Message-ID: <20150306092425.Ux9c6Wk2dOzF_-B4VSDMo27j6pFsRo-xXLRRebIHdGI@z>

On Fri, Feb 20, 2015 at 7:01 PM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:

> This driver adds pinctrl and GPIO support to STMicrolectronic's
> STM32 family of MCUs.
>
> Pin muxing and GPIO handling have been tested on STM32F429
> based Discovery board.
>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

(...)
> +config PINCTRL_STM32
> +       bool "STMicroelectronics STM32 pinctrl driver"
> +       depends on OF
> +       depends on ARCH_STM32 || COMPILE_TEST
> +       select PINMUX
> +       select PINCONF
> +       select GPIOLIB_IRQCHIP
> +       help
> +         This selects the device tree based generic pinctrl driver for STM32.

Good start! Especially that you use GPIOLIB_IRQCHIP.

But this (as discussed earlier) should select GENERIC_PINCONF

Stopping review here so you can reengineer it a bit using GENERIC_PINCONF
for next submission.

Also think about pinmux in single registers, whether you want to do this
with a single value for a register or using strings to identify groups
and functions.

Yours,
Linus Walleij
