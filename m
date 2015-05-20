Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57807 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753997AbbETXpM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 May 2015 19:45:12 -0400
Message-ID: <555D1C7D.1060205@suse.de>
Date: Thu, 21 May 2015 01:45:01 +0200
From: =?windows-1252?Q?Andreas_F=E4rber?= <afaerber@suse.de>
MIME-Version: 1.0
Subject: Re: [PATCH v8 07/16] drivers: reset: Add STM32 reset driver
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com> <1431158038-3813-8-git-send-email-mcoquelin.stm32@gmail.com>
In-Reply-To: <1431158038-3813-8-git-send-email-mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: u.kleine-koenig@pengutronix.de, geert@linux-m68k.org, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, stefan@agner.ch, pmeerw@pmeerw.net, pebolle@tiscali.nl, peter@hurleysoftware.com, andy.shevchenko@gmail.com, cw00.choi@samsung.com, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, joe@perches.com, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, lee.jones@linaro.org, Daniel Thompson <daniel.thompson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, linux-api@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Kamil Lulko <rev13@wp.pl>, Antti Palosaari <crope@iki.fi>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Kees Cook <keescook@chromium.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rusty Russell <rusty@rustcorp.com.au>, linux-gpio@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Nicolae Rosia <nicolae.rosia@gmail.com>, linux-arm-kernel@lists.infradead.org, Michal Marek <mmarek@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20150520234501._nrN76ZPZVETlOZVHRxAjxO5vxEkiabBUxryuVvhmjg@z>

Am 09.05.2015 um 09:53 schrieb Maxime Coquelin:
> The STM32 MCUs family IPs can be reset by accessing some registers
> from the RCC block.
> 
> The list of available reset lines is documented in the DT bindings.
> 
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>  drivers/reset/Makefile      |   1 +
>  drivers/reset/reset-stm32.c | 124 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 125 insertions(+)
>  create mode 100644 drivers/reset/reset-stm32.c
> 
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 157d421..aed12d1 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -1,5 +1,6 @@
>  obj-$(CONFIG_RESET_CONTROLLER) += core.o
>  obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
>  obj-$(CONFIG_ARCH_BERLIN) += reset-berlin.o
> +obj-$(CONFIG_ARCH_STM32) += reset-stm32.o
>  obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
>  obj-$(CONFIG_ARCH_STI) += sti/
> diff --git a/drivers/reset/reset-stm32.c b/drivers/reset/reset-stm32.c
> new file mode 100644
> index 0000000..2c41858
> --- /dev/null
> +++ b/drivers/reset/reset-stm32.c
[...]
> +static const struct of_device_id stm32_reset_dt_ids[] = {
> +	 { .compatible = "st,stm32-rcc", },
> +	 { /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, sstm32_reset_dt_ids);

Typo.

IIUC the timer depends on the reset controller, so it must be built in
anyway, and that's what's enforced in the Makefile above. Drop the line?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Dilip Upmanyu, Graham Norton; HRB
21284 (AG Nürnberg)
