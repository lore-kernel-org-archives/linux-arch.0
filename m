Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f195.google.com ([209.85.166.195]:54717 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfCLH22 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Mar 2019 03:28:28 -0400
Date: Tue, 12 Mar 2019 16:29:23 +0900
From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v9 9/9] gpio: uniphier: Utilize for_each_set_clump8 macro
Message-ID: <20190312072923.GB2898@icarus>
References: <cover.1551598603.git.vilhelm.gray@gmail.com>
 <0840d55707dacd1121659723246fa9f55737f426.1551598603.git.vilhelm.gray@gmail.com>
 <CAK7LNARRqYb_ovO_ccQ8xTLTzNYyTEK8whT2r0cq_AqpWqeNXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNARRqYb_ovO_ccQ8xTLTzNYyTEK8whT2r0cq_AqpWqeNXg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, bgolaszewski@baylibre.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <20190312072923.5zUppw8W2dFpxVeBqxh2ocF-sHWi706AD7gVxyNXvOU@z>

On Tue, Mar 12, 2019 at 01:36:57PM +0900, Masahiro Yamada wrote:
> On Sun, Mar 3, 2019 at 4:51 PM William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> >
> > Replace verbose implementation in set_multiple callback with
> > for_each_set_clump8 macro to simplify code and improve clarity. An
> > improvement in this case is that banks that are not masked will now be
> > skipped.
> >
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >  drivers/gpio/gpio-uniphier.c | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
> > index 0f662b297a95..df640cb29b9c 100644
> > --- a/drivers/gpio/gpio-uniphier.c
> > +++ b/drivers/gpio/gpio-uniphier.c
> > @@ -15,9 +15,6 @@
> >  #include <linux/spinlock.h>
> >  #include <dt-bindings/gpio/uniphier-gpio.h>
> >
> > -#define UNIPHIER_GPIO_BANK_MASK                \
> > -                               GENMASK((UNIPHIER_GPIO_LINES_PER_BANK) - 1, 0)
> > -
> >  #define UNIPHIER_GPIO_IRQ_MAX_NUM      24
> >
> >  #define UNIPHIER_GPIO_PORT_DATA                0x0     /* data */
> > @@ -147,15 +144,14 @@ static void uniphier_gpio_set(struct gpio_chip *chip,
> >  static void uniphier_gpio_set_multiple(struct gpio_chip *chip,
> >                                        unsigned long *mask, unsigned long *bits)
> >  {
> > -       unsigned int bank, shift, bank_mask, bank_bits;
> > -       int i;
> > +       unsigned int i;
> > +       unsigned long bank_mask;
> > +       unsigned int bank;
> > +       unsigned int bank_bits;
> >
> > -       for (i = 0; i < chip->ngpio; i += UNIPHIER_GPIO_LINES_PER_BANK) {
> > +       for_each_set_clump8(i, bank_mask, mask, chip->ngpio) {
> >                 bank = i / UNIPHIER_GPIO_LINES_PER_BANK;
> > -               shift = i % BITS_PER_LONG;
> > -               bank_mask = (mask[BIT_WORD(i)] >> shift) &
> > -                                               UNIPHIER_GPIO_BANK_MASK;
> > -               bank_bits = bits[BIT_WORD(i)] >> shift;
> > +               bank_bits = bitmap_get_value8(bits, chip->ngpio, i);
> >
> >                 uniphier_gpio_bank_write(chip, bank, UNIPHIER_GPIO_PORT_DATA,
> >                                          bank_mask, bank_bits);
> 
> 
> Please do not do this.
> 
> Nothing in this driver says the GPIO width is 8-bit.
> 
> You are hard-coding '8-bit'.

The for_each_set_clump8 macro is hardcoded to 8-bit clumps because the
current drivers utilizing this functionality are only updating their
GPIO ports 8-bits at a time.

However, if this driver updates more or less GPIO at a time, we can
easily update the macro by replacing the hardcoded '8' value with a
variable, thus giving us the generic for_each_set_clump macro.

How many GPIO can be updated at a time for this device?

William Breathitt Gray

> 
> 
> 
> 
> 
> 
> 
> > --
> > 2.21.0
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
