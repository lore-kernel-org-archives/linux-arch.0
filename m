From: Syed Nayyar Waris <syednwaris@gmail.com>
Subject: Re: [PATCH v8 1/4] bitops: Introduce the for_each_set_clump macro
Date: Sun, 21 Jun 2020 05:11:25 +0530
Message-ID: <CACG_h5qK3KN5xYK=6h+U8u2kLo95979uC4_xfHhD8GqYeVgMLw@mail.gmail.com>
References: <cover.1592224128.git.syednwaris@gmail.com> <fe12eedf3666f4af5138de0e70b67a07c7f40338.1592224129.git.syednwaris@gmail.com>
 <20200616081428.GP2428291@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgFTXli (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Jun 2020 19:41:38 -0400
In-Reply-To: <20200616081428.GP2428291@smile.fi.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Jun 16, 2020 at 1:44 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Jun 15, 2020 at 06:21:18PM +0530, Syed Nayyar Waris wrote:
> > This macro iterates for each group of bits (clump) with set bits,
> > within a bitmap memory region. For each iteration, "start" is set to
> > the bit offset of the found clump, while the respective clump value is
> > stored to the location pointed by "clump". Additionally, the
> > bitmap_get_value and bitmap_set_value functions are introduced to
> > respectively get and set a value of n-bits in a bitmap memory region.
> > The n-bits can have any size less than or equal to BITS_PER_LONG.
> > Moreover, during setting value of n-bit in bitmap, if a situation arise
> > that the width of next n-bit is exceeding the word boundary, then it
> > will divide itself such that some portion of it is stored in that word,
> > while the remaining portion is stored in the next higher word. Similar
> > situation occurs while retrieving value of n-bits from bitmap.
>
> On the second view...
>
> > +static inline unsigned long bitmap_get_value(const unsigned long *map,
> > +                                           unsigned long start,
> > +                                           unsigned long nbits)
> > +{
> > +     const size_t index = BIT_WORD(start);
> > +     const unsigned long offset = start % BITS_PER_LONG;
>
> > +     const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
>
> This perhaps should use round_up()

I checked with 'round_up'. I am getting the same values as I was
getting with 'roundup'.
I have checked with different clump tests.
Moreover, wherever the 'space' was being evaluated as 64, in the case
of 'roundup', it is also getting evaluated to the same value (of 64),
in case of  'round_up' also.

Further below ...

>
> > +     const unsigned long space = ceiling - start;
>
> And I think I see a scenario to complain.
>
> If start == 0, then ceiling will be 64.
> space == 64. Not good.

Yes, you are right, when the 'start' is '0', then 'space' will be 64
(on arch where BITS_PER_LONG is 64).
But actually I want this to happen. I need 'space' to hold value 64
when 'start' is '0'. The reason is as follows:

Taking the example of bitmap_set_value(). If the nbits is 16 (as
example) and 'start' is zero, The 'if' condition will be executed
inside bitmap_set_value() when 'start' is zero because space(64) >=
nbits(16) is true. This 'if' condition is for the case when nbits
falls completely into the first word and the nbits doesn't have to
divide itself into another higher word of the bitmap.

This is what should happen according to me. If space is less than 64,
lets say 63 or 62, then it will not correctly indicate the remaining
space for nbits to fill in (bitmap_set_value) or to extract from
(bitmap_get_value).

Kindly let me know If I have misunderstood something. Thanks !

>
> > +     unsigned long value_low, value_high;
> > +
> > +     if (space >= nbits)
> > +             return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> > +     else {
> > +             value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
> > +             value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
> > +             return (value_low >> offset) | (value_high << space);
> > +     }
> > +}
>
> ...
>
> > +/**
> > + * bitmap_set_value - set n-bit value within a memory region
> > + * @map: address to the bitmap memory region
> > + * @value: value of nbits
> > + * @start: bit offset of the n-bit value
> > + * @nbits: size of value in bits
> > + */
> > +static inline void bitmap_set_value(unsigned long *map,
> > +                                 unsigned long value,
> > +                                 unsigned long start, unsigned long nbits)
> > +{
> > +     const size_t index = BIT_WORD(start);
> > +     const unsigned long offset = start % BITS_PER_LONG;
>
> > +     const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
> > +     const unsigned long space = ceiling - start;
>
> Ditto for both lines.
>
> > +     value &= GENMASK(nbits - 1, 0);
> > +
> > +     if (space >= nbits) {
> > +             map[index] &= ~(GENMASK(nbits + offset - 1, offset));
> > +             map[index] |= value << offset;
> > +     } else {
> > +             map[index] &= ~BITMAP_FIRST_WORD_MASK(start);
> > +             map[index] |= value << offset;
> > +             map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
> > +             map[index + 1] |= (value >> space);
> > +     }
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
