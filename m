Return-Path: <SRS0=iE4N=6I=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726753AbgDXOwu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Apr 2020 10:52:50 -0400
MIME-Version: 1.0
References: <20200424122521.GA5552@syed> <20200424141037.ersebbfe7xls37be@wunner.de>
In-Reply-To: <20200424141037.ersebbfe7xls37be@wunner.de>
From: Syed Nayyar Waris <syednwaris@gmail.com>
Date: Fri, 24 Apr 2020 20:22:38 +0530
Message-ID: <CACG_h5prcXVdk6ecn2WoT1jas3K6UF+KCrxAM9u4_ZLSyPKCEA@mail.gmail.com>
Subject: Re: [PATCH 1/6] bitops: Introduce the the for_each_set_clump macro
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com, William Breathitt Gray <vilhelm.gray@gmail.com>, arnd@arndb.de, Linus Walleij <linus.walleij@linaro.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20200424145238.Fd5jiy8-E1KNMw1n8BdyaVGnDIPgs8Cm4e2kdQlOgbI@z>

On Fri, Apr 24, 2020 at 7:40 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Fri, Apr 24, 2020 at 05:55:21PM +0530, Syed Nayyar Waris wrote:
> > +static inline void bitmap_set_value(unsigned long *map,
> > +                                 unsigned long value,
> > +                                 unsigned long start, unsigned long nbits)
> > +{
> > +     const size_t index = BIT_WORD(start);
> > +     const unsigned long offset = start % BITS_PER_LONG;
> > +     const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
> > +     const unsigned long space = ceiling - start;
> > +
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
> Sorry but what's the advantage of using this complicated function
> as a replacement for the much simpler bitmap_set_value8()?
>
> The drivers calling bitmap_set_value8() *know* that 8-bit accesses
> are possible and take advantage of that knowledge by using a small,
> speed-optimized function.  Replacing that with a more complicated
> (potentially less performant) function doesn't seem to be a step
> forward.
>
> Thanks,
>
> Lukas

Actually this generic function can work with n-bits of any size (less
than equal to BITS_PER_LONG), while the earlier bitmap_set_value8
worked with n-bits having size of 8 bits only.

In the case when n-bits is 8-bits, this new bitmap_set_value()
function would behave very similar to the earlier bitmap_set_value8()
function. For example,  in case of n-bits being 8-bits it will always
execute the 'if' condition and not the 'else' condition, hence
offering the same performance (because of encountering similar code
statements) as earlier bitmap_set_value8() function, most probably.

There is an additional advantage (this can happen when n-bits is not 8
bits): during setting value of n-bit in bitmap, if a situation arise
that the width of next n-bit is exceeding the word boundary, then it
will divide itself such that some portion of it is stored in that
word, while the remaining portion is stored in the next higher word.

So, this function preserves the behaviour of earlier
bitmap_set_value8() function and also adds extra functionality to
that.

Thanks
Syed Nayyar Waris
