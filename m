Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:34327 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499AbbCIOjs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2015 10:39:48 -0400
Received: by obcwp18 with SMTP id wp18so22576016obc.1
        for <linux-arch@vger.kernel.org>; Mon, 09 Mar 2015 07:39:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1424455277-29983-17-git-send-email-mcoquelin.stm32@gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1424455277-29983-17-git-send-email-mcoquelin.stm32@gmail.com>
Date: Mon, 9 Mar 2015 15:39:47 +0100
Message-ID: <CACRpkdaW-OMgGfw8+ngia8AsmzRpW8z7922=dPpRGjgv79-gqw@mail.gmail.com>
Subject: Re: [PATCH v2 16/18] ARM: dts: Introduce STM32F429 MCU
From: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-api@vger.kernel.org
Message-ID: <20150309143947.3LkEOi9F4SIDW5f-DYPc_Iv8NK2eURr2PmQhj8W8eoY@z>

On Fri, Feb 20, 2015 at 7:01 PM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:

> The STMicrolectornics's STM32F419 MCU has the following main features:
>  - Cortex-M4 core running up to @180MHz
>  - 2MB internal flash, 256KBytes internal RAM
>  - FMC controller to connect SDRAM, NOR and NAND memories
>  - SD/MMC/SDIO support
>  - Ethernet controller
>  - USB OTFG FS & HS controllers
>  - I2C, SPI, CAN busses support
>  - Several 16 & 32 bits general purpose timers
>  - Serial Audio interface
>  - LCD controller
>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
(...)
> +       soc {
> +               usart1: usart@40011000 {
> +                       status = "okay";
> +               };
> +
> +               leds {
> +                       compatible = "gpio-leds";
> +                       red {
> +                               #gpio-cells = <2>;
> +                               label = "Front Panel LED";
> +                               gpios = <&gpiog 14 0>;
> +                               linux,default-trigger = "heartbeat";
> +                       };
> +                       green {
> +                               #gpio-cells = <2>;
> +                               gpios = <&gpiog 13 0>;
> +                               default-state = "off";
> +                       };
> +               };
> +       };

The LEDs are mounted on the board not the SoC, right?

So move them outside of the soc node, to the top level
of the DTS file.

Yours,
Linus Walleij
