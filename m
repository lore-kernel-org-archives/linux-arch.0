From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 1/8] bitops: Introduce the for_each_set_clump8 macro
Date: Sat, 12 Jan 2019 10:36:57 +0200
Message-ID: <CAHp75VftRq7ABe_0dABN=XjTSNjMTROgh2n0YNoGOai+C1xOjg@mail.gmail.com>
References: <cover.1547257386.git.vilhelm.gray@gmail.com> <cca4dc59b4eb0a65fca8c6954059b71f305d28c9.1547257386.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cca4dc59b4eb0a65fca8c6954059b71f305d28c9.1547257386.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Sat, Jan 12, 2019 at 3:47 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> This macro iterates for each 8-bit group of bits (clump) with set bits,
> within a bitmap memory region. For each iteration, "start" is set to the
> bit offset of the found clump, while the respective clump value is
> stored to the location pointed by "clump". Additionally, the
> bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> respectively get and set an 8-bit value in a bitmap memory region.

> +unsigned int bitmap_get_value8(const unsigned long *const bitmap,
> +                              const unsigned int start);

Hmm... Shouldn't be returned value of type unsigned long for sake of
consistency?

> +/**
> + * bitmap_set_value8 - set an 8-bit value within a memory region
> + * @bitmap: address to the bitmap memory region

> + * @value: the 8-bit value

Put the same warning here as you did in cover letter

> + * @start: bit offset of the 8-bit value
> + */
> +void bitmap_set_value8(unsigned long *const bitmap,
> +                      const unsigned long value,
> +                      const unsigned int start)
> +{
> +       const size_t index = BIT_WORD(start);
> +       const unsigned int offset = start % BITS_PER_LONG;
> +       const unsigned long mask = GENMASK(7, offset);
> +
> +       bitmap[index] &= ~mask;
> +       bitmap[index] |= value << offset;
> +}


-- 
With Best Regards,
Andy Shevchenko
