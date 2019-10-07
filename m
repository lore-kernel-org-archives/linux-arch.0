Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57972 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfJGIpw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Oct 2019 04:45:52 -0400
Date: Mon, 7 Oct 2019 11:45:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v16 14/14] gpio: pca953x: Utilize the for_each_set_clump8
 macro
Message-ID: <20191007084546.GO32742@smile.fi.intel.com>
References: <cover.1570374078.git.vilhelm.gray@gmail.com>
 <e72393325e58778b7ba59c80c6b79c1f93b81d8d.1570374078.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e72393325e58778b7ba59c80c6b79c1f93b81d8d.1570374078.git.vilhelm.gray@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de, sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk
Message-ID: <20191007084546.lQ78OiOpHCmOjqzEVmaTpocDPeAtFRTnVY_gd9fiNRo@z>

On Sun, Oct 06, 2019 at 11:11:11AM -0400, William Breathitt Gray wrote:
> Replace verbose implementation in set_multiple callback with
> for_each_set_clump8 macro to simplify code and improve clarity.

I can test this along with 74x164 at the same time.

> Cc: Phil Reid <preid@electromag.com.au>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/gpio/gpio-pca953x.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index de5d1383f28d..10b669b8f27d 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/bits.h>
> +#include <linux/bitops.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
> @@ -456,7 +457,8 @@ static void pca953x_gpio_set_multiple(struct gpio_chip *gc,
>  				      unsigned long *mask, unsigned long *bits)
>  {
>  	struct pca953x_chip *chip = gpiochip_get_data(gc);
> -	unsigned int bank_mask, bank_val;
> +	unsigned long offset;
> +	unsigned long bank_mask;
>  	int bank;
>  	u8 reg_val[MAX_BANK];
>  	int ret;
> @@ -466,15 +468,10 @@ static void pca953x_gpio_set_multiple(struct gpio_chip *gc,
>  	if (ret)
>  		goto exit;
>  
> -	for (bank = 0; bank < NBANK(chip); bank++) {
> -		bank_mask = mask[bank / sizeof(*mask)] >>
> -			   ((bank % sizeof(*mask)) * 8);
> -		if (bank_mask) {
> -			bank_val = bits[bank / sizeof(*bits)] >>
> -				  ((bank % sizeof(*bits)) * 8);
> -			bank_val &= bank_mask;
> -			reg_val[bank] = (reg_val[bank] & ~bank_mask) | bank_val;
> -		}
> +	for_each_set_clump8(offset, bank_mask, mask, gc->ngpio) {
> +		bank = offset / 8;
> +		reg_val[bank] &= ~bank_mask;
> +		reg_val[bank] |= bitmap_get_value8(bits, offset) & bank_mask;
>  	}
>  
>  	pca953x_write_regs(chip, chip->regs->output, reg_val);
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko
