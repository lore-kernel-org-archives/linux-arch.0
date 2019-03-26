Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:54923 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfCZKHf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Mar 2019 06:07:35 -0400
Date: Tue, 26 Mar 2019 19:08:18 +0900
From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v12 01/11] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190326100743.GA10005@icarus>
References: <cover.1553494625.git.vilhelm.gray@gmail.com>
 <9afc30a574ce3e6a86b51dd522146a1d2156dedd.1553494625.git.vilhelm.gray@gmail.com>
 <20190325093854.jzkkwaksxi7zvtrg@wunner.de>
 <20190326031422.GB3356@icarus>
 <20190326094345.v7l7xjvfs2scbvbv@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190326094345.v7l7xjvfs2scbvbv@wunner.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lukas Wunner <lukas@wunner.de>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, preid@electromag.com.au, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190326100818.OmFCp2g8hlhjcRR9Iu-kBGCAXS1WizMCUE-1hf3g9UA@z>

On Tue, Mar 26, 2019 at 10:43:45AM +0100, Lukas Wunner wrote:
> On Tue, Mar 26, 2019 at 12:14:22PM +0900, William Breathitt Gray wrote:
> > On Mon, Mar 25, 2019 at 10:38:54AM +0100, Lukas Wunner wrote:
> > > On Mon, Mar 25, 2019 at 03:22:23PM +0900, William Breathitt Gray wrote:
> > > > +/**
> > > > + * find_next_clump8 - find next 8-bit clump with set bits in a memory region
> > > > + * @clump: location to store copy of found clump
> > > > + * @addr: address to base the search on
> > > > + * @offset: bit offset at which to start searching
> > > > + * @size: bitmap size in number of bits
> > > > + *
> > > > + * Returns the bit offset for the next set clump; the found clump value is
> > > > + * copied to the location pointed by @clump. If no bits are set, returns @size.
> > > > + */
> > > > +unsigned int find_next_clump8(unsigned long *const clump,
> > > > +			      const unsigned long *const addr,
> > > > +			      unsigned int offset, const unsigned int size)
> > > > +{
> > > > +	for (; offset < size; offset += 8) {
> > > > +		*clump = bitmap_get_value8(addr, size, offset);
> > > > +		if (!*clump)
> > > > +			continue;
> > > > +
> > > > +		return offset;
> > > > +	}
> > > > +
> > > > +	return size;
> > > > +}
> > > > +EXPORT_SYMBOL(find_next_clump8);
> > > 
> > > Just use find_first_bit() / find_next_bit() to use optimized arch-specific
> > > bitops instead of open-coding the iteration over the bitmap.
> > > 
> > > See max3191x_get_multiple() for an example.
> > 
> > Is this the sort of implementation you had in mind:
> > 
> >         offset = find_next_bit(addr, size, offset);
> >         if (offset == size)
> >                 return size;
> > 
> >         offset -= offset % 8;
> >         *clump = bitmap_get_value8(addr, size, offset);
> > 
> >         return offset;
> 
> Almost.  I'd use round_down() instead of "offset -= offset % 8".
> Then it's just a single cheap logical and operation at runtime.

All right I'll try this setup using round_down() then.

> 
> I'd try to avoid copying around the clump value and use a pointer
> to u8 instead.

Although in this case we are handling 8-bit clumps, I anticipate device
drivers in the future which may benefit from larger size clumps (e.g.
GPIO devices with 24-bit ports). It'll be better to define clumps
similar to how we're defining bitmaps now (unsigned long *) so that we
can support these sizes if need be in the future without requiring data
type changes.

> 
> I don't understand the calculations in bitmap_get_value8() at all.
> Why is it so complicated, does it allow passing in a start value
> that's not a multiple of 8?  Do you really need that?  I imagine
> a simplification is possible if that assumption can be made (and
> is spelled out in the kerneldoc).

That's a good point. Originally, I had envisioned the possibility of
calling bitmap_get_value8/bitmap_set_value8 at odd start offsets; this
would open up the possibility of a clump landing as a split between 2
words, thus requiring this complicated case handling code. However, I'm
not sure how often users would need this case; none of the drivers right
now require clumps at odd offsets.

Andy, would you have any objection to restricting the start offset
values for bitmap_get_value8/bitmap_set_value8 to multiples of 8? That
would prevent the split word case, and thus allow the implementation for
those functions to be a lot simpler.

William Breathitt Gray

> 
> 
> > Should the offset and size parameters be redefined as unsigned long to
> > match the find_first_bit/find_next_bit function parameters?
> 
> Yes, probably.  It's just the CPU's native length anyway.
> 
> Thanks,
> 
> Lukas
