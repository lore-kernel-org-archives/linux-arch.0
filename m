Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46147 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfCNMwY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Mar 2019 08:52:24 -0400
Date: Thu, 14 Mar 2019 21:53:08 +0900
From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v10 09/10] gpio: uniphier: Utilize for_each_set_clump8
 macro
Message-ID: <20190314125308.GA7400@icarus>
References: <cover.1552566113.git.vilhelm.gray@gmail.com>
 <9487b6bd8f9c2242448729f5f8fc9534f724b221.1552566114.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9487b6bd8f9c2242448729f5f8fc9534f724b221.1552566114.git.vilhelm.gray@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: yamada.masahiro@socionext.com
Cc: akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, linus.walleij@linaro.org, bgolaszewski@baylibre.com, linux-arm-kernel@lists.infradead.org
Message-ID: <20190314125308.K4QviyXznWpW92nvqVr4_C-gcFKuBshwSU63_zQ4AFA@z>

On Thu, Mar 14, 2019 at 09:32:37PM +0900, William Breathitt Gray wrote:
> Replace verbose implementation in set_multiple callback with
> for_each_set_clump8 macro to simplify code and improve clarity. An
> improvement in this case is that banks that are not masked will now be
> skipped.
> 
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/gpio/gpio-uniphier.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
> index 0f662b297a95..df640cb29b9c 100644
> --- a/drivers/gpio/gpio-uniphier.c
> +++ b/drivers/gpio/gpio-uniphier.c
> @@ -15,9 +15,6 @@
>  #include <linux/spinlock.h>
>  #include <dt-bindings/gpio/uniphier-gpio.h>
>  
> -#define UNIPHIER_GPIO_BANK_MASK		\
> -				GENMASK((UNIPHIER_GPIO_LINES_PER_BANK) - 1, 0)
> -
>  #define UNIPHIER_GPIO_IRQ_MAX_NUM	24
>  
>  #define UNIPHIER_GPIO_PORT_DATA		0x0	/* data */
> @@ -147,15 +144,14 @@ static void uniphier_gpio_set(struct gpio_chip *chip,
>  static void uniphier_gpio_set_multiple(struct gpio_chip *chip,
>  				       unsigned long *mask, unsigned long *bits)
>  {
> -	unsigned int bank, shift, bank_mask, bank_bits;
> -	int i;
> +	unsigned int i;
> +	unsigned long bank_mask;
> +	unsigned int bank;
> +	unsigned int bank_bits;
>  
> -	for (i = 0; i < chip->ngpio; i += UNIPHIER_GPIO_LINES_PER_BANK) {
> +	for_each_set_clump8(i, bank_mask, mask, chip->ngpio) {
>  		bank = i / UNIPHIER_GPIO_LINES_PER_BANK;
> -		shift = i % BITS_PER_LONG;
> -		bank_mask = (mask[BIT_WORD(i)] >> shift) &
> -						UNIPHIER_GPIO_BANK_MASK;
> -		bank_bits = bits[BIT_WORD(i)] >> shift;
> +		bank_bits = bitmap_get_value8(bits, chip->ngpio, i);
>  
>  		uniphier_gpio_bank_write(chip, bank, UNIPHIER_GPIO_PORT_DATA,
>  					 bank_mask, bank_bits);
> -- 
> 2.21.0

Masahiro,

I noticed this loops per GPIO bank and uniphier_gpio_bank_write is
called each time to update the respective bank. The
uniphier_gpio_reg_update function however is calling writel to update
the registers; yet only 8 bits (UNIPHIER_GPIO_LINES_PER_BANK) are
updated at a time via the uniphier_gpio_bank_write call in the
uniphier_gpio_set_multiple function.

Can more than one bank be updated at a time via writel (e.g. 4 banks at
8 bits per bank via a single 32-bit writel call)? If so, instead of
using the for_each_set_clump8 macro, it may be more efficient to loop
through 4 banks at a time.

William Breathitt Gray
