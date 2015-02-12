Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63026 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbbBLUhy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Feb 2015 15:37:54 -0500
MIME-Version: 1.0
In-Reply-To: <1423763164-5606-9-git-send-email-mcoquelin.stm32@gmail.com>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1423763164-5606-9-git-send-email-mcoquelin.stm32@gmail.com>
Date: Thu, 12 Feb 2015 21:37:53 +0100
Message-ID: <CAMuHMdXfAENN5EB6nFJdf3bJPJ+=41Po22NKrQWdwkyf5nFXpw@mail.gmail.com>
Subject: Re: [PATCH 08/14] pinctrl: Add pinctrl driver for STM32 MCUs
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Message-ID: <20150212203753.v1dmneMVff3i6nrhYLwaOa3r7dmmDXVW75qprEWiZSo@z>

On Thu, Feb 12, 2015 at 6:45 PM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -125,6 +125,15 @@ config PINCTRL_ST
>         select PINCONF
>         select GPIOLIB_IRQCHIP
>
> +config PINCTRL_STM32
> +       bool "STMicroelectronics STM32 pinctrl driver"
> +       depends on OF

depends on ARCH_STM32 || COMPILE_TEST

> +       select PINMUX
> +       select PINCONF
> +       select GPIOLIB_IRQCHIP
> +       help
> +         This selects the device tree based generic pinctrl driver for STM32.
> +
>  config PINCTRL_TEGRA
>         bool
>         select PINMUX

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
