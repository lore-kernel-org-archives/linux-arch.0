From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [RESEND PATCH v4 1/8] bitops: Introduce the for_each_set_clump
 macro
Date: Thu, 4 Oct 2018 19:03:27 +0900
Message-ID: <20181004100327.GA4079@icarus>
References: <cover.1538441919.git.vilhelm.gray@gmail.com>
 <f5250b9c78377e476667be1b616c86cf573b57dc.1538441919.git.vilhelm.gray@gmail.com>
 <40ecad49-2797-0d30-b52d-a2e6838dc1ab@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <40ecad49-2797-0d30-b52d-a2e6838dc1ab@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linus.walleij@linaro.org, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 02, 2018 at 09:42:48AM +0200, Rasmus Villemoes wrote:
> On 2018-10-02 03:13, William Breathitt Gray wrote:
> > This macro iterates for each group of bits (clump) with set bits, within
> > a bitmap memory region. For each iteration, "clump" is set to the found
> > clump index, "index" is set to the word index of the bitmap containing
> > the found clump, and "offset" is set to the bit offset of the found
> > clump within the respective bitmap word.
> 
> I can't say I'm a fan. It seems rather clumsy and ad-hoc - though I do
> see how it matches the code you replace in drivers/gpio/. When I
> initially read the cover letter, I assumed that one would get a sequence
> of 4-bit values, but one has to dig the actual value out of the bitmap
> afterwards using all of index, offset and a mask computed from clump_size.

Yes, that is because this macro is as you noted primarily a replacement
for the repetitive code used in the GPIO drivers; the GPIO drivers
require the index and offset in order to modify and store the requested
bit values and perform port I/O.

I put this macro up in the bitops code, but perhaps I should have left
it local to the GPIO subsystem since its so specific. This is one aspect
I want to determine: whether to keep this macro here or move it.

> > +
> > +/**
> > + * find_next_clump - find next clump with set bits in a memory region
> > + * @index: location to store bitmap word index of found clump
> > + * @offset: bits offset of the found clump within the respective bitmap word
> > + * @bits: address to base the search on
> > + * @size: bitmap size in number of clumps
> 
> That's a rather inconvenient unit, no? And rather easy to get wrong, I
> can easily see people passing nbits instead.
> 
> I think you could reduce the number of arguments to this helper and the
> macro, while getting rid of some confusion: Drop index and offset, let
> clump_index be start_index and measured in bit positions (like
> find_next_bit et al), and let the return value also be a bit position.
> And instead of index and offset, have another unsigned long* output
> parameter that gives the actual value at [return value:return
> value+clump_size]. IOW, I think the prototype should be close to
> find_next_bit, except that in case of "clumps", there's an extra piece
> of information to return.

There may be benefit to develop a different macro more aligned with the
rest of the bitops code -- one where we do in fact return the direct
4-bit value for example. Essentially all the GPIO drivers need are the
index for the hardware I/O port and the index for the bitmap to store
the bits.

So we may be able to reimplement the for_each_set_clump to utilize a
simplier macro that returns the clump value, and then determine index
and offset up in the for_each_set_clump macro; that way we can keep the
generic clump value return code isolated from the code needed by the
GPIO drivers.
 
> > + * @clump_index: clump index at which to start searching
> > + * @clump_size: clump size in bits
> > + *
> > + * Returns the clump index for the next clump with set bits; the respective
> > + * bitmap word index is stored at the location pointed by @index, and the bits
> > + * offset of the found clump within the respective bitmap word is stored at the
> > + * location pointed by @offset. If no bits are set, returns @size.
> > + */
> > +size_t find_next_clump(size_t *const index, unsigned int *const offset,
> > +		       const unsigned long *const bits, const size_t size,
> > +		       const size_t clump_index, const unsigned int clump_size)
> > +{
> > +	size_t i;
> > +	unsigned int bits_offset;
> > +	unsigned long word_mask;
> > +	const unsigned long clump_mask = GENMASK(clump_size - 1, 0);
> > +
> > +	for (i = clump_index; i < size; i++) {
> > +		bits_offset = i * clump_size;
> > +
> > +		*index = BIT_WORD(bits_offset);
> > +		*offset = bits_offset % BITS_PER_LONG;
> > +
> > +		word_mask = bits[*index] & (clump_mask << *offset);
> > +		if (!word_mask)
> > +			continue;
> 
> The cover letter says
> 
>   The clump_size argument can be an arbitrary number of bits and is not
>   required to be a multiple of 2.
> 
> by which I assume you mean "power of 2", but either way, the above code
> does not seem to take into account the case where bits_offset +
> clump_size straddles a word boundary, so it wouldn't work for a
> clump_size that does not divide BITS_PER_LONG.

Ah, you are correct, if clump_size does not divide evenly into
BITS_PER_LONG then the macro skips the portion of bits that reside
across the boundary. This is an unintentional behavior that will need to
be fixed. I didn't notice this since the GPIO drivers utilizing the
macro so far have all used a clump_size that divides cleanly.

> 
> May I suggest another approach:
> 
> unsigned long bitmap_get_value(const unsigned long *bitmap, unsigned
> start, unsigned width): Get the value of bitmap[start:start+width] for
> 1<=width<=BITS_PER_LONG (it's up to the caller to ensure this is within
> the defined region). That can almost be an inline
> 
> bitmap_get_value(const unsigned long *bitmap, unsigned start, unsigned
> width)
> {
>   unsigned idx = BIT_WORD(start);
>   unsigned offset = start % BITS_PER_LONG;
>   unsigned long lower = bitmap[idx] >> offset;
>   unsigned long upper = offset <= BITS_PER_LONG - width ? 0 :
> bitmap[idx+1] << (BITS_PER_LONG - offset);
>   return (lower | upper) & GENMASK(width-1, 0)
> }
> 
> Then you can implement the for_each_set_clump by a (IMO) more readable
> 
>   for (i = 0, start = 0; i < num_ports; i++, start += gpio_reg_size) {
>     word_mask = bitmap_get_value(mask, start, gpio_reg_size);
>     if (!word_mask)
>       continue;
>     ...
>   }
> 
> Or, if you do want find_next_clump/for_each_set_clump, that can be
> implemented in terms of this.
> 
> Rasmus

This might work. All that would need to change to support the GPIO
drivers is to return BIT_WORD(start) as index and offset as (start %
BITS_PER_LONG). These sets can be performed outside of bitmap_get_value,
thus allowing it to have a simplier interface for code that does not
require index/offset.

William Breathitt Gray
