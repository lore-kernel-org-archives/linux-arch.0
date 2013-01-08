From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/4] gpiolib: introduce descriptor-based GPIO interface
Date: Tue, 8 Jan 2013 12:59:29 +0000
Message-ID: <201301081259.29839.arnd@arndb.de>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com> <1357629535-26033-2-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64734 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756239Ab3AHM7p (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Jan 2013 07:59:45 -0500
In-Reply-To: <1357629535-26033-2-git-send-email-acourbot@nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Alexandre Courbot <gnurou@gmail.com>

On Tuesday 08 January 2013, Alexandre Courbot wrote:
> +struct gpio_desc *__must_check devm_gpiod_get(struct device *dev,
> +                                                    const char *con_id)
> +{
> +       struct gpio_desc **dr;
> +       struct gpio_desc *desc;
> +
> +       dr = devres_alloc(devm_gpio_release, sizeof(struct gpio_desc *),
> +                         GFP_KERNEL);
> +       if (!dr)
> +               return ERR_PTR(-ENOMEM);
> +
> +       desc = gpiod_get(dev, con_id);
> +       if (IS_ERR_OR_NULL(desc)) {
> +               devres_free(dr);
> +               return desc;
> +       }

Please avoid the use of IS_ERR_OR_NULL(), especially on interfaces you
introduce yourself. AFAICT, gpiod_get cannot return NULL, so you
should not check for that.

> +       *dr = desc;
> +       devres_add(dev, dr);
> +
> +       return 0;
> +}

I'm pretty sure you meant to write 'return desc;' here.

	Arnd
