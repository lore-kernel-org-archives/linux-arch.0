Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:44887 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729608AbfCYJi4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Mar 2019 05:38:56 -0400
Date: Mon, 25 Mar 2019 10:38:54 +0100
From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v12 01/11] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190325093854.jzkkwaksxi7zvtrg@wunner.de>
References: <cover.1553494625.git.vilhelm.gray@gmail.com>
 <9afc30a574ce3e6a86b51dd522146a1d2156dedd.1553494625.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9afc30a574ce3e6a86b51dd522146a1d2156dedd.1553494625.git.vilhelm.gray@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, preid@electromag.com.au, Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190325093854.9b8x84MoKx9hO9DYpp5OS_6U5906SP6ErCx3vRfgipY@z>

On Mon, Mar 25, 2019 at 03:22:23PM +0900, William Breathitt Gray wrote:
> +/**
> + * find_next_clump8 - find next 8-bit clump with set bits in a memory region
> + * @clump: location to store copy of found clump
> + * @addr: address to base the search on
> + * @offset: bit offset at which to start searching
> + * @size: bitmap size in number of bits
> + *
> + * Returns the bit offset for the next set clump; the found clump value is
> + * copied to the location pointed by @clump. If no bits are set, returns @size.
> + */
> +unsigned int find_next_clump8(unsigned long *const clump,
> +			      const unsigned long *const addr,
> +			      unsigned int offset, const unsigned int size)
> +{
> +	for (; offset < size; offset += 8) {
> +		*clump = bitmap_get_value8(addr, size, offset);
> +		if (!*clump)
> +			continue;
> +
> +		return offset;
> +	}
> +
> +	return size;
> +}
> +EXPORT_SYMBOL(find_next_clump8);

Just use find_first_bit() / find_next_bit() to use optimized arch-specific
bitops instead of open-coding the iteration over the bitmap.

See max3191x_get_multiple() for an example.

Thanks,

Lukas
