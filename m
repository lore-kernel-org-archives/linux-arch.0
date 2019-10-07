Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46340 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfJGPTK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Oct 2019 11:19:10 -0400
Date: Mon, 7 Oct 2019 11:18:51 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v16 01/14] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20191007151851.GA3494@icarus>
References: <cover.1570374078.git.vilhelm.gray@gmail.com>
 <c0830858f19c852f6d124395a32410bc645ecd15.1570374078.git.vilhelm.gray@gmail.com>
 <20191007082156.GL32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191007082156.GL32742@smile.fi.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de, sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20191007151851.0ZHNWO_qxEtPVZP6Vxm7e-DBz61UzyiygzEixF2OMW8@z>

On Mon, Oct 07, 2019 at 11:21:56AM +0300, Andy Shevchenko wrote:
> On Sun, Oct 06, 2019 at 11:10:58AM -0400, William Breathitt Gray wrote:
> > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > within a bitmap memory region. For each iteration, "start" is set to the
> > bit offset of the found clump, while the respective clump value is
> > stored to the location pointed by "clump". Additionally, the
> > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > respectively get and set an 8-bit value in a bitmap memory region.
> 
> Very much thank you for an update!
> I have comments below.
> 
> > +/**
> > + * bitmap_get_value8 - get an 8-bit value within a memory region
> 
> Since it's in find.h I would not collide with bitmap namespace.
> How about
> 
> 	find_and_get_value8()

We modeled the interface for these on the existing bitmap functions, so
perhaps it would be better to move bitmap_get_value8 and
bitmap_set_value8 to include/linux/bitmap.h so that they are with the
rest of the bitmap functions -- afterall, they are operating on bitmaps.

> > + * @addr: address to the bitmap memory region
> > + * @start: bit offset of the 8-bit value; must be a multiple of 8
> > + *
> > + * Returns the 8-bit value located at the @start bit offset within the @addr
> > + * memory region.
> > + */
> > +static inline unsigned long bitmap_get_value8(const unsigned long *addr,
> > +					      unsigned long start)
> > +{
> > +	const size_t index = BIT_WORD(start);
> > +	const unsigned long offset = start % BITS_PER_LONG;
> > +
> > +	return (addr[index] >> offset) & 0xFF;
> > +}
> > +
> > +/**
> > + * bitmap_set_value8 - set an 8-bit value within a memory region
> 
> 	find_and_set_value8()
> 
> ?
> 
> > + * @addr: address to the bitmap memory region
> > + * @value: the 8-bit value; values wider than 8 bits may clobber bitmap
> > + * @start: bit offset of the 8-bit value; must be a multiple of 8
> > + */
> > +static inline void bitmap_set_value8(unsigned long *addr, unsigned long value,
> > +				     unsigned long start)
> > +{
> > +	const size_t index = BIT_WORD(start);
> > +	const unsigned long offset = start % BITS_PER_LONG;
> > +
> > +	addr[index] &= ~(0xFF << offset);
> > +	addr[index] |= value << offset;
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko

The find_next_clump8 function can remain exposed via
include/linux/find.h since it fits in with the rest of the functions
there.

The reason I moved the definition to lib/find_bit.c is due to the
circular dependency that arose from the round_down macro. Should I try
to move the definition back to include/linux/find.h and reimplement it
without the round_down macro; or is it best to keep this simpler
implementation here in lib/find_bit.c?

William Breathitt Gray
