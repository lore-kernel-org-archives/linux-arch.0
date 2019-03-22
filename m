From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v10 01/10] bitops: Introduce the for_each_set_clump8 macro
Date: Fri, 22 Mar 2019 20:22:44 +0200
Message-ID: <20190322182244.GZ9224@smile.fi.intel.com>
References: <cover.1552566113.git.vilhelm.gray@gmail.com>
 <0e4d352418252d480dfc7d529604819f8ff88d9c.1552566113.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0e4d352418252d480dfc7d529604819f8ff88d9c.1552566113.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linus.walleij@linaro.org, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, bgolaszewski@baylibre.com, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 14, 2019 at 09:30:02PM +0900, William Breathitt Gray wrote:
> This macro iterates for each 8-bit group of bits (clump) with set bits,
> within a bitmap memory region. For each iteration, "start" is set to the
> bit offset of the found clump, while the respective clump value is
> stored to the location pointed by "clump". Additionally, the
> bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> respectively get and set an 8-bit value in a bitmap memory region.

> +void bitmap_set_value8(unsigned long *const bitmap, const unsigned int size,
> +		       const unsigned long value, const unsigned int start)
> +{
> +	const size_t index = BIT_WORD(start);
> +	const unsigned int offset = start % BITS_PER_LONG;
> +	const unsigned int low_width = (offset + 8 > BITS_PER_LONG) ?
> +				       BITS_PER_LONG - offset : 8;

> +	const unsigned long low_mask = GENMASK(offset + low_width - 1, offset);

I think

	unsigned long low_mask = GENMASK(low_width - 1, 0) << offset;

will generate better code.

> +	const unsigned int high_width = 8 - low_width;
> +	const unsigned long high_mask = GENMASK(high_width - 1, 0);
> +
> +	/* set lower portion */
> +	bitmap[index] &= ~low_mask;
> +	bitmap[index] |= value << offset;
> +
> +	/* set higher portion if space available in bitmap */
> +	if (high_width && start + 8 <= size) {
> +		bitmap[index + 1] &= ~high_mask;
> +		bitmap[index + 1] |= value >> low_width;
> +	}
> +}
> +EXPORT_SYMBOL(bitmap_set_value8);

-- 
With Best Regards,
Andy Shevchenko
