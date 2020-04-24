From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 1/6] bitops: Introduce the the for_each_set_clump macro
Date: Fri, 24 Apr 2020 16:10:37 +0200
Message-ID: <20200424141037.ersebbfe7xls37be@wunner.de>
References: <20200424122521.GA5552@syed>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:57869 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgDXOKk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Apr 2020 10:10:40 -0400
Content-Disposition: inline
In-Reply-To: <20200424122521.GA5552@syed>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Syed Nayyar Waris <syednwaris@gmail.com>
Cc: akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com, arnd@arndb.de, linus.walleij@linaro.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 05:55:21PM +0530, Syed Nayyar Waris wrote:
> +static inline void bitmap_set_value(unsigned long *map,
> +				    unsigned long value,
> +				    unsigned long start, unsigned long nbits)
> +{
> +	const size_t index = BIT_WORD(start);
> +	const unsigned long offset = start % BITS_PER_LONG;
> +	const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
> +	const unsigned long space = ceiling - start;
> +
> +	value &= GENMASK(nbits - 1, 0);
> +
> +	if (space >= nbits) {
> +		map[index] &= ~(GENMASK(nbits + offset - 1, offset));
> +		map[index] |= value << offset;
> +	} else {
> +		map[index] &= ~BITMAP_FIRST_WORD_MASK(start);
> +		map[index] |= value << offset;
> +		map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
> +		map[index + 1] |= (value >> space);
> +	}
> +}

Sorry but what's the advantage of using this complicated function
as a replacement for the much simpler bitmap_set_value8()?

The drivers calling bitmap_set_value8() *know* that 8-bit accesses
are possible and take advantage of that knowledge by using a small,
speed-optimized function.  Replacing that with a more complicated
(potentially less performant) function doesn't seem to be a step
forward.

Thanks,

Lukas
