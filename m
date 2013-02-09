Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:56470 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729Ab3BIKKK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 9 Feb 2013 05:10:10 -0500
Received: by mail-wi0-f177.google.com with SMTP id hm14so1680049wib.4
        for <linux-arch@vger.kernel.org>; Sat, 09 Feb 2013 02:10:08 -0800 (PST)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 8/9] gpiolib: use gpio_chips list in gpio_to_desc
In-Reply-To: <1359822572-26009-10-git-send-email-acourbot@nvidia.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com> <1359822572-26009-10-git-send-email-acourbot@nvidia.com>
Date: Sat, 09 Feb 2013 09:58:03 +0000
Message-ID: <20130209095803.61C653E2CF2@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, gnurou@gmail.com
Message-ID: <20130209095803.-eus5UTrh_DM25NRrUQyLB8kBrxZLbe4g8YHrYkHBBM@z>

On Sun,  3 Feb 2013 01:29:31 +0900, Alexandre Courbot <acourbot@nvidia.com> wrote:
> Parse the list of chips to find the descriptor corresponding to a GPIO
> number instead of directly picking the entry of the global gpio_desc[]
> array, which is due to be removed.
> 
> This turns the complexity of converting a GPIO number into a descriptor
> from O(1) to O(n) where n is the number of GPIO chips in the system.
> Since n is ought to be small anyway, there should be no noticeable
> performance impact. Moreover, GPIO users who care for speed already have
> implemented their own gpio_get_value() and gpio_set_value() with a
> fast path for the GPIO numbers that matter and this change does not
> affect such use cases.
> 
> The descriptor-based GPIO API, due to be introduced soon, will make this
> lookup unnecessary.

I'm actually going to NAK this one. This is a hot path. Having a O(1)
lookup from gpio number to gpio desc is important. I know you want to be
rid of the gpio_desc table entirely, but in this case I think it is
warranted. However, you can change the gpio_desc table to be a table of
pointers to gpio_descs instead of a table of gpio_descs. That would save
a lot of memory since unused GPIOs wouldn't have gpio_descs associated
with them. It is also the mechanism used by the IRQ subsystem.

So, it makes sense for the primary gpio_chip lookup to be the list, but
the table needs to stick around as a secondary lookup.

g.

> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpio/gpiolib.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 9599b9a..0247c48 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -122,10 +122,21 @@ static int gpio_chip_hwgpio(const struct gpio_desc *desc)
>   */
>  static struct gpio_desc *gpio_to_desc(unsigned gpio)
>  {
> -	if (WARN(!gpio_is_valid(gpio), "invalid GPIO %d\n", gpio))
> -		return NULL;
> -	else
> -		return &gpio_desc[gpio];
> +	struct gpio_chip *chip;
> +
> +	list_for_each_entry(chip, &gpio_chips, list) {
> +		int gpio_min = chip->base;
> +		int gpio_max = gpio_min + chip->ngpio;
> +		if (gpio >= gpio_min && gpio < gpio_max)
> +			return &chip->desc[gpio - gpio_min];
> +		else if (gpio < gpio_min)
> +			/* gpio_chips are ordered by base, so we won't get any
> +			 * hit if we arrive here... */
> +			break;
> +	}
> +
> +	pr_warn("%s: no registered chip to handle GPIO %d\n", __func__, gpio);
> +	return NULL;
>  }
>  
>  /**
> -- 
> 1.8.1.1
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
