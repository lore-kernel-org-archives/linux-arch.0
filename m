Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48121 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbbBMLty (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 13 Feb 2015 06:49:54 -0500
Message-ID: <1423828144.4182.18.camel@pengutronix.de>
Subject: Re: [PATCH 04/14] reset: Add reset_controller_of_init() function
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 13 Feb 2015 12:49:04 +0100
In-Reply-To: <1423763164-5606-5-git-send-email-mcoquelin.stm32@gmail.com>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
	 <1423763164-5606-5-git-send-email-mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150213114904.WAmgu-8tUyp_IxHW34Tio0EBUzDtKXUM8J8kfSoeBko@z>

Hi Maxime,

Am Donnerstag, den 12.02.2015, 18:45 +0100 schrieb Maxime Coquelin:
> Some platforms need to initialize the reset controller before the timers.
> 
> This patch introduces a reset_controller_of_init() function that can be
> called before the timers intialization.
> 
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>  drivers/reset/core.c              | 20 ++++++++++++++++++++
>  include/asm-generic/vmlinux.lds.h |  4 +++-
>  include/linux/reset-controller.h  |  6 ++++++
>  3 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 7955e00..18ee579 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -86,6 +86,26 @@ void reset_controller_unregister(struct reset_controller_dev *rcdev)
>  }
>  EXPORT_SYMBOL_GPL(reset_controller_unregister);
>  
> +extern struct of_device_id __reset_ctrl_of_table[];
> +
> +static const struct of_device_id __reset_ctrl_of_table_sentinel
> +	__used __section(__reset_ctrl_of_table_end);
> +
> +void __init reset_controller_of_init(void)

The patch looks fine to me, but this function is missing a kerneldoc
comment.

> +{
> +	struct device_node *np;
> +	const struct of_device_id *match;
> +	of_init_fn_1 init_func;
> +
> +	for_each_matching_node_and_match(np, __reset_ctrl_of_table, &match) {
> +		if (!of_device_is_available(np))
> +			continue;
> +
> +		init_func = match->data;
> +		init_func(np);
> +	}
> +}
> +
>  /**
>   * reset_control_reset - reset the controlled device
>   * @rstc: reset controller

regards
Philipp

