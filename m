From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RESEND PATCH v4 1/8] bitops: Introduce the for_each_set_clump
 macro
Date: Tue, 2 Oct 2018 11:21:42 +0300
Message-ID: <20181002082142.GC15943@smile.fi.intel.com>
References: <cover.1538441919.git.vilhelm.gray@gmail.com>
 <f5250b9c78377e476667be1b616c86cf573b57dc.1538441919.git.vilhelm.gray@gmail.com>
 <40ecad49-2797-0d30-b52d-a2e6838dc1ab@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <40ecad49-2797-0d30-b52d-a2e6838dc1ab@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>, linus.walleij@linaro.org, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 02, 2018 at 09:42:48AM +0200, Rasmus Villemoes wrote:
> On 2018-10-02 03:13, William Breathitt Gray wrote:

> The cover letter says
> 
>   The clump_size argument can be an arbitrary number of bits and is not
>   required to be a multiple of 2.
> 
> by which I assume you mean "power of 2", but either way, the above code
> does not seem to take into account the case where bits_offset +
> clump_size straddles a word boundary, so it wouldn't work for a
> clump_size that does not divide BITS_PER_LONG.

E.g. 3 bits in a clump? Hmm...

Why would we need that? I mean some real use case?

> May I suggest another approach:

You may, of course, but see above and my comments below.

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

I would rather go with two prototypes to get()/set() a clump in the bitmap
in a way when it's aligned and BITS_PER_LONG % clump_size == 0.

unsigned long bitmap_get_clump(unsigned long *src, unsigned int start, unsigned int clump_size)
{
	unsigned int index = BIT_WORD(start);
	unsigned int offset = start % BITS_PER_LONG;


	/* These just for spelling the restrictions */
	WARN_ON(BITS_PER_LONG % clump_size);
	WARN_ON(offset % clump_size);

	/* TODO: take care of clump_size == 64 */
	return (bitmap[index] >> offset) & GENMASK(clump_size - 1, 0);
}

Something similar with set with additional parameter unsigned long value
which has MSB cleared till we reach [clump_size - 1 : 0].

-- 
With Best Regards,
Andy Shevchenko
