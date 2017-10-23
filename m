From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH] lib: optimize cpumask_next_and()
Date: Mon, 23 Oct 2017 19:33:56 +0300
Message-ID: <20171023163356.u4h2djpylxxh5glp@yury-thinkpad>
References: <20171023080510.30550-1-courbet@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171023080510.30550-1-courbet@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Clement Courbet <courbet@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <mawilcox@microsoft.com>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Clement,

> diff --git a/lib/find_bit.c b/lib/find_bit.c
> index 6ed74f78380c..83ea8b97ed3e 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -75,6 +75,40 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
>  EXPORT_SYMBOL(find_next_zero_bit);
>  #endif
>  
> +#if !defined(find_next_and_bit)
> +
> +/*
> + * Find the next set bit in a memory region.
> + */
> +unsigned long find_next_and_bit(const unsigned long *addr1,
> +		const unsigned long *addr2, unsigned long nbits,
> +		unsigned long start)
> +{
> +	unsigned long tmp;
> +
> +	if (!nbits || start >= nbits)
> +		return nbits;

It should be:
       if (unlikely(start >= nbits))
                return nbits;

See patch e4afd2e5567f (lib/find_bit.c: micro-optimise find_next_*_bit)
from Matthew Wilcox.

> +
> +	tmp = addr1[start / BITS_PER_LONG] & addr2[start / BITS_PER_LONG];
> +
> +	/* Handle 1st word. */
> +	tmp &= BITMAP_FIRST_WORD_MASK(start);
> +	start = round_down(start, BITS_PER_LONG);
> +
> +	while (!tmp) {
> +		start += BITS_PER_LONG;
> +		if (start >= nbits)
> +			return nbits;
> +
> +		tmp = addr1[start / BITS_PER_LONG] &
> +			addr2[start / BITS_PER_LONG];
> +	}
> +
> +	return min(start + __ffs(tmp), nbits);
> +}
> +EXPORT_SYMBOL(find_next_and_bit);
> +#endif

This function is looking very based on _find_next_bit(). The original
_find_next_bit() implements the invert-trick that allows share the
same code for find_next_bit() and find_next_zero_bit().  Did you consider
to take this approach for new function? If no objections from performance
side, I think it worth to do for sane of completeness.

Yury
