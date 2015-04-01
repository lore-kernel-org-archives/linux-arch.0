Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53157 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbbDAJNG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Apr 2015 05:13:06 -0400
Message-ID: <1427879123.3638.1.camel@pengutronix.de>
Subject: Re: [PATCH v4 05/15] dt-bindings: Document the STM32 reset bindings
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 01 Apr 2015 11:05:23 +0200
In-Reply-To: <1427819096-31109-6-git-send-email-mcoquelin.stm32@gmail.com>
References: <1427819096-31109-1-git-send-email-mcoquelin.stm32@gmail.com>
	 <1427819096-31109-6-git-send-email-mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: u.kleine-koenig@pengutronix.de, afaerber@suse.de, geert@linux-m68k.org, Rob Herring <robh+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, stefan@agner.ch, pmeerw@pmeerw.net, pebolle@tiscali.nl, peter@hurleysoftware.com, andy.shevchenko@gmail.com, cw00.choi@samsung.com, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150401090523.Old24OihQkTimH4SO38eoaLx32RQsvYkhlhAB0V1mP0@z>

Am Dienstag, den 31.03.2015, 18:24 +0200 schrieb Maxime Coquelin:
> This adds documentation of device tree bindings for the
> STM32 reset controller.
> 
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>  .../devicetree/bindings/reset/st,stm32-rcc.txt     | 107 +++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/st,stm32-rcc.txt
> 
> diff --git a/Documentation/devicetree/bindings/reset/st,stm32-rcc.txt b/Documentation/devicetree/bindings/reset/st,stm32-rcc.txt
> new file mode 100644
> index 0000000..e2e2f25
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/st,stm32-rcc.txt
> @@ -0,0 +1,107 @@
> +STMicroelectronics STM32 Peripheral Reset Controller
> +====================================================
> +
> +The RCC IP is both a reset and a clock controller. This documentation only
> +document the reset part.

documents?

Otherwise,
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

