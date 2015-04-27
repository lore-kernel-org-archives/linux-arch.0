From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 06/17] h8300: CPU depend helpers
Date: Mon, 27 Apr 2015 10:54:24 +0200
Message-ID: <6023810.QeChDcReGk@wuerfel>
References: <1430112924-1134-1-git-send-email-ysato@users.sourceforge.jp> <1430112924-1134-7-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:54803 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbbD0Iyg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2015 04:54:36 -0400
In-Reply-To: <1430112924-1134-7-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Monday 27 April 2015 14:35:13 Yoshinori Sato wrote:
> +static struct platform_device sci0_device = {
> +	.name		= "sh-sci",
> +	.id		= 0,
> +	.resource	= sci0_resources,
> +	.num_resources	= ARRAY_SIZE(sci0_resources),
> +	.dev		= {
> +		.platform_data	= &sci0_platform_data,
> +	},
> +};
> +
> +static struct platform_device sci1_device = {
> +	.name		= "sh-sci",
> +	.id		= 1,
> +	.resource	= sci1_resources,
> +	.num_resources	= ARRAY_SIZE(sci1_resources),
> +	.dev		= {
> +		.platform_data	= &sci1_platform_data,
> +	},
> +};

You should generally not define 'platform_device' structure statically.
Generally, all new architectures should pass a dtb blob from the
boot loader that contains the device definitions outside of the
kernel binary.

If you don't expect to use h8300 with a lot of external peripherals,
you can also use platform_device_register_simple() and related functions
to register the platform device here, which lets you remove the
static definition.

> +void __init early_device_init(void)
> +{
> +	early_platform_add_devices(early_devices,
> +				   ARRAY_SIZE(early_devices));
> +}

I would like to eventually remove the early_platform_add_devices()
interface, and use some other mechanism here. Can you try either using
devicetree to probe those devices like ARM does, or just calling into
the drivers manually?

In case of the sci, using the new 'earlycon' framework is probably the
best idea, and for the timer, just call the probe() function directly
instead of going through the whole early_platform_add_devices
and early_platform_driver_probe() dance.

	Arnd
