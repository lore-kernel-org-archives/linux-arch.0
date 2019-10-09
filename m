Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-06.nifty.com ([210.131.2.91]:28439 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731612AbfJIQeG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 12:34:06 -0400
MIME-Version: 1.0
References: <cover.1570633189.git.vilhelm.gray@gmail.com> <271a7735b02b6a8b1f54c018e38ea932d1fd299e.1570633189.git.vilhelm.gray@gmail.com>
In-Reply-To: <271a7735b02b6a8b1f54c018e38ea932d1fd299e.1570633189.git.vilhelm.gray@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 10 Oct 2019 01:33:06 +0900
Message-ID: <CAK7LNAQStJsZ4cYTJyAPvjyngWkKs+5y=yzJb6vz3-cco+2-ug@mail.gmail.com>
Subject: Re: [PATCH v17 09/14] gpio: uniphier: Utilize for_each_set_clump8 macro
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Andrew Morton <akpm@linux-foundation.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, preid@electromag.com.au, Lukas Wunner <lukas@wunner.de>, sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk
Message-ID: <20191009163306.dQscq7x0BqUkAtkkWevipsNe5QrVHm8GCw1SSb6tbf8@z>

On Thu, Oct 10, 2019 at 12:27 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
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
> index 93cdcc41e9fb..3e4b15d0231e 100644
> --- a/drivers/gpio/gpio-uniphier.c
> +++ b/drivers/gpio/gpio-uniphier.c
> @@ -15,9 +15,6 @@
>  #include <linux/spinlock.h>
>  #include <dt-bindings/gpio/uniphier-gpio.h>
>
> -#define UNIPHIER_GPIO_BANK_MASK                \
> -                               GENMASK((UNIPHIER_GPIO_LINES_PER_BANK) - 1, 0)
> -
>  #define UNIPHIER_GPIO_IRQ_MAX_NUM      24
>
>  #define UNIPHIER_GPIO_PORT_DATA                0x0     /* data */
> @@ -147,15 +144,14 @@ static void uniphier_gpio_set(struct gpio_chip *chip,
>  static void uniphier_gpio_set_multiple(struct gpio_chip *chip,
>                                        unsigned long *mask, unsigned long *bits)
>  {
> -       unsigned int bank, shift, bank_mask, bank_bits;
> -       int i;
> +       unsigned long i;
> +       unsigned long bank_mask;
> +       unsigned long bank;
> +       unsigned long bank_bits;


Please do not split it into multiple lines
unless you need to do so.

Thanks.




> -       for (i = 0; i < chip->ngpio; i += UNIPHIER_GPIO_LINES_PER_BANK) {
> +       for_each_set_clump8(i, bank_mask, mask, chip->ngpio) {
>                 bank = i / UNIPHIER_GPIO_LINES_PER_BANK;
> -               shift = i % BITS_PER_LONG;
> -               bank_mask = (mask[BIT_WORD(i)] >> shift) &
> -                                               UNIPHIER_GPIO_BANK_MASK;
> -               bank_bits = bits[BIT_WORD(i)] >> shift;
> +               bank_bits = bitmap_get_value8(bits, i);
>
>                 uniphier_gpio_bank_write(chip, bank, UNIPHIER_GPIO_PORT_DATA,
>                                          bank_mask, bank_bits);
> --
> 2.23.0
>


-- 
Best Regards
Masahiro Yamada
