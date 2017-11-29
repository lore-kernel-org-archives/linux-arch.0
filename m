From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH v5] lib: optimize cpumask_next_and()
Date: Wed, 29 Nov 2017 10:16:09 +0300
Message-ID: <20171129071609.lcvcf3iezr2tcn4j@yury-thinkpad>
References: <20171128131334.23491-1-courbet@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam01on0049.outbound.protection.outlook.com ([104.47.34.49]:6512
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751366AbdK2HQZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Nov 2017 02:16:25 -0500
Content-Disposition: inline
In-Reply-To: <20171128131334.23491-1-courbet@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Clement Courbet <courbet@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

NACK. 

I'm sorry, but it seems you have to send v6. See comments inline.

On Tue, Nov 28, 2017 at 02:13:34PM +0100, Clement Courbet wrote:
> We've measured that we spend ~0.6% of sys cpu time in cpumask_next_and().
> It's essentially a joined iteration in search for a non-zero bit, which
> is currently implemented as a lookup join (find a nonzero bit on the
> lhs, lookup the rhs to see if it's set there).
> 
> Implement a direct join (find a nonzero bit on the incrementally built
> join).
> 
> For cpumask_next_and, direct benchmarking shows that it's 1.17x to 14x
> faster with a geometric mean of 2.1 on 32 CPUs [1]. No impact on memory
> usage.
> 
> Also added generic bitmap benchmarks in the new `test_find_bit` module
> for the reference and new implementations (results: see
> `find_next_and_bit` and `find_next_and_bit_ref` in [2] and [3] below).
> Note that on Arm (), the new c implementation still outperforms the
> old one that uses c+ the asm implementation of `find_next_bit` [3].

What is 'c+'? Is it typo?

If you find generic find_bit() on arm faster that asm one, we'd definitely
drop that piece of asm. I have this check it in my long list.

> [1] Approximate benchmark code:
> 
> ```
>   unsigned long src1p[nr_cpumask_longs] = {pattern1};
>   unsigned long src2p[nr_cpumask_longs] = {pattern2};
>   for (/*a bunch of repetitions*/) {
>     for (int n = -1; n <= nr_cpu_ids; ++n) {
>       asm volatile("" : "+rm"(src1p)); // prevent any optimization
>       asm volatile("" : "+rm"(src2p));
>       unsigned long result = cpumask_next_and(n, src1p, src2p);
>       asm volatile("" : "+rm"(result));
>     }
>   }
> ```
> 
> Results:
> pattern1    pattern2     time_before/time_after
> 0x0000ffff  0x0000ffff   1.65
> 0x0000ffff  0x00005555   2.24
> 0x0000ffff  0x00001111   2.94
> 0x0000ffff  0x00000000   14.0
> 0x00005555  0x0000ffff   1.67
> 0x00005555  0x00005555   1.71
> 0x00005555  0x00001111   1.90
> 0x00005555  0x00000000   6.58
> 0x00001111  0x0000ffff   1.46
> 0x00001111  0x00005555   1.49
> 0x00001111  0x00001111   1.45
> 0x00001111  0x00000000   3.10
> 0x00000000  0x0000ffff   1.18
> 0x00000000  0x00005555   1.18
> 0x00000000  0x00001111   1.17
> 0x00000000  0x00000000   1.25
> -----------------------------
>                geo.mean  2.06
> 
> [2] test_find_next_bit, X86 (skylake)
> 
>  [ 3913.477422] Start testing find_bit() with random-filled bitmap
>  [ 3913.477847] find_next_bit: 160868 cycles, 16484 iterations
>  [ 3913.477933] find_next_zero_bit: 169542 cycles, 16285 iterations
>  [ 3913.478036] find_last_bit: 201638 cycles, 16483 iterations
>  [ 3913.480214] find_first_bit: 4353244 cycles, 16484 iterations
>  [ 3913.480216] Start testing find_next_and_bit() with random-filled
>  bitmap
>  [ 3913.481027] find_next_and_bit_ref: 319444 cycles, 8216 iterations
>  [ 3913.481074] find_next_and_bit: 89604 cycles, 8216 iterations
>  [ 3913.481075] Start testing find_bit() with sparse bitmap
>  [ 3913.481078] find_next_bit: 2536 cycles, 66 iterations
>  [ 3913.481252] find_next_zero_bit: 344404 cycles, 32703 iterations
>  [ 3913.481255] find_last_bit: 2006 cycles, 66 iterations
>  [ 3913.481265] find_first_bit: 17488 cycles, 66 iterations
>  [ 3913.481266] Start testing find_next_and_bit() with sparse bitmap
>  [ 3913.481270] find_next_and_bit_ref: 2486 cycles, 1 iterations
>  [ 3913.481272] find_next_and_bit: 764 cycles, 1 iterations
> 
> [3] test_find_next_bit, arm (v7 odroid XU3).
> 
> [  267.206928] Start testing find_bit() with random-filled bitmap
> [  267.214752] find_next_bit: 4474 cycles, 16419 iterations
> [  267.221850] find_next_zero_bit: 5976 cycles, 16350 iterations
> [  267.229294] find_last_bit: 4209 cycles, 16419 iterations
> [  267.279131] find_first_bit: 1032991 cycles, 16420 iterations
> [  267.286265] Start testing find_next_and_bit() with random-filled
> bitmap
> [  267.294895] find_next_and_bit_ref: 7572 cycles, 8140 iterations
> [  267.302386] find_next_and_bit: 2290 cycles, 8140 iterations
> [  267.309422] Start testing find_bit() with sparse bitmap
> [  267.316054] find_next_bit: 191 cycles, 66 iterations
> [  267.322726] find_next_zero_bit: 8758 cycles, 32703 iterations
> [  267.329803] find_last_bit: 84 cycles, 66 iterations
> [  267.336169] find_first_bit: 4118 cycles, 66 iterations
> [  267.342627] Start testing find_next_and_bit() with sparse bitmap
> [  267.349992] find_next_and_bit_ref: 193 cycles, 1 iterations
> [  267.356919] find_next_and_bit: 91 cycles, 1 iterations

This is old version of test based on get_cycles. New one is based on
ktime_get and has other minor changes. I think you'd rerun tests to
not confuse readers. New version is already in linux-next.

> Signed-off-by: Clement Courbet <courbet@google.com>
> ---
> Changes in v2:
>  - Refactored _find_next_common_bit into _find_next_bit., as suggested
>    by Yury Norov. This has no adverse effects on the performance side,
>    as the compiler successfully inlines the code.
> 
> Changes in v3:
>  - Fixes find_next_and_bit() declaration.
>  - Synchronize _find_next_bit_le() with _find_next_bit()
>  - Synchronize the code in tools/lib/find_bit.c
>  - Add find_next_and_bit to guard code
>  - Fix invert value (bad sync with our internal tree on which I'm doing
>    the testing).
> 
> Changes in v4:
>  - Mark _find_next_bit() inline.
> 
> Changes in v5:
>  - Added benchmarks to test_find_bit.cc
>  - Fixed arm compilation: added missing header to arm bitops.h
> 
>  arch/arm/include/asm/bitops.h           |  1 +
>  arch/unicore32/include/asm/bitops.h     |  2 ++
>  include/asm-generic/bitops/find.h       | 20 +++++++++++
>  include/linux/bitmap.h                  |  6 +++-
>  lib/cpumask.c                           |  9 ++---
>  lib/find_bit.c                          | 59 ++++++++++++++++++++++++---------
>  lib/test_find_bit.c                     | 47 +++++++++++++++++++++++++-
>  tools/include/asm-generic/bitops/find.h | 16 +++++++++
>  tools/lib/find_bit.c                    | 40 ++++++++++++++++------
>  9 files changed, 168 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
> index ce5ee762ed66..4cab9bb823fb 100644
> --- a/arch/arm/include/asm/bitops.h
> +++ b/arch/arm/include/asm/bitops.h
> @@ -338,6 +338,7 @@ static inline int find_next_bit_le(const void *p, int size, int offset)
>  
>  #endif
>  
> +#include <asm-generic/bitops/find.h>
>  #include <asm-generic/bitops/le.h>
>  
>  /*
> diff --git a/arch/unicore32/include/asm/bitops.h b/arch/unicore32/include/asm/bitops.h
> index 401f597bc38c..c0cbdbe17168 100644
> --- a/arch/unicore32/include/asm/bitops.h
> +++ b/arch/unicore32/include/asm/bitops.h
> @@ -44,4 +44,6 @@ static inline int fls(int x)
>  #define find_first_bit		find_first_bit
>  #define find_first_zero_bit	find_first_zero_bit
>  
> +#include <asm-generic/bitops/find.h>
> +
>  #endif /* __UNICORE_BITOPS_H__ */
> diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
> index 1ba611e16fa0..8a1ee10014de 100644
> --- a/include/asm-generic/bitops/find.h
> +++ b/include/asm-generic/bitops/find.h
> @@ -16,6 +16,22 @@ extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
>  		size, unsigned long offset);
>  #endif
>  
> +#ifndef find_next_and_bit
> +/**
> + * find_next_and_bit - find the next set bit in both memory regions
> + * @addr1: The first address to base the search on
> + * @addr2: The second address to base the search on
> + * @offset: The bitnumber to start searching at
> + * @size: The bitmap size in bits
> + *
> + * Returns the bit number for the next set bit
> + * If no bits are set, returns @size.
> + */
> +extern unsigned long find_next_and_bit(const unsigned long *addr1,
> +		const unsigned long *addr2, unsigned long size,
> +		unsigned long offset);
> +#endif
> +
>  #ifndef find_next_zero_bit
>  /**
>   * find_next_zero_bit - find the next cleared bit in a memory region
> @@ -55,8 +71,12 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
>  					 unsigned long size);
>  #else /* CONFIG_GENERIC_FIND_FIRST_BIT */
>  
> +#ifndef find_first_bit
>  #define find_first_bit(addr, size) find_next_bit((addr), (size), 0)
> +#endif
> +#ifndef find_first_zero_bit
>  #define find_first_zero_bit(addr, size) find_next_zero_bit((addr), (size), 0)
> +#endif

How this change related to the find_next_and_bit?

Does unguarded version breaks something? Please elaborate.

>  #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
>  
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 3489253e38fc..45a9e169d0fd 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -83,8 +83,12 @@
>   *  test_and_change_bit(bit, addr)      Change bit and return old value
>   *  find_first_zero_bit(addr, nbits)    Position first zero bit in *addr
>   *  find_first_bit(addr, nbits)         Position first set bit in *addr
> - *  find_next_zero_bit(addr, nbits, bit)  Position next zero bit in *addr >= bit
> + *  find_next_zero_bit(addr, nbits, bit)
> + *                                      Position next zero bit in *addr >= bit
>   *  find_next_bit(addr, nbits, bit)     Position next set bit in *addr >= bit
> + *  find_next_and_bit(addr1, addr2, nbits, bit)
> + *                                      Same as find_first_bit, but in
> + *                                      (*addr1 & *addr2)

Nit. Addr1, addr2 - doesn't sound self-explainative. What about
find_next_and_bit(addr1, and_map, nbits, bit), or something like this?

>   *
>   */
>  
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index 35fe142ebb5e..beca6244671a 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -33,10 +33,11 @@ EXPORT_SYMBOL(cpumask_next);
>  int cpumask_next_and(int n, const struct cpumask *src1p,
>  		     const struct cpumask *src2p)
>  {
> -	while ((n = cpumask_next(n, src1p)) < nr_cpu_ids)
> -		if (cpumask_test_cpu(n, src2p))
> -			break;
> -	return n;
> +	/* -1 is a legal arg here. */
> +	if (n != -1)
> +		cpumask_check(n);
> +	return find_next_and_bit(cpumask_bits(src1p), cpumask_bits(src2p),
> +		nr_cpumask_bits, n + 1);
>  }
>  EXPORT_SYMBOL(cpumask_next_and);
>  
> diff --git a/lib/find_bit.c b/lib/find_bit.c
> index 6ed74f78380c..ee3df93ba69a 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -21,22 +21,29 @@
>  #include <linux/export.h>
>  #include <linux/kernel.h>
>  
> -#if !defined(find_next_bit) || !defined(find_next_zero_bit)
> +#if !defined(find_next_bit) || !defined(find_next_zero_bit) || \
> +		!defined(find_next_and_bit)
>  
>  /*
> - * This is a common helper function for find_next_bit and
> - * find_next_zero_bit.  The difference is the "invert" argument, which
> - * is XORed with each fetched word before searching it for one bits.
> + * This is a common helper function for find_next_bit, find_next_zero_bit, and
> + * find_next_and_bit. The differences are:
> + *  - The "invert" argument, which is XORed with each fetched word before
> + *    searching it for one bits.
> + *  - The optional "addr2", which is anded with "addr1" if present.

The optional "and", which is anded with "addr" if present. - sounds
better, isn't?

>   */
> -static unsigned long _find_next_bit(const unsigned long *addr,
> -		unsigned long nbits, unsigned long start, unsigned long invert)
> +static inline unsigned long _find_next_bit(const unsigned long *addr1,
> +		const unsigned long *addr2, unsigned long nbits,
> +		unsigned long start, unsigned long invert)
>  {
>  	unsigned long tmp;
>  
>  	if (unlikely(start >= nbits))
>  		return nbits;
>  
> -	tmp = addr[start / BITS_PER_LONG] ^ invert;
> +	tmp = addr1[start / BITS_PER_LONG];
> +	if (addr2)
> +		tmp &= addr2[start / BITS_PER_LONG];
> +	tmp ^= invert;
>  
>  	/* Handle 1st word. */
>  	tmp &= BITMAP_FIRST_WORD_MASK(start);
> @@ -47,7 +54,10 @@ static unsigned long _find_next_bit(const unsigned long *addr,
>  		if (start >= nbits)
>  			return nbits;
>  
> -		tmp = addr[start / BITS_PER_LONG] ^ invert;
> +		tmp = addr1[start / BITS_PER_LONG];
> +		if (addr2)
> +			tmp &= addr2[start / BITS_PER_LONG];
> +		tmp ^= invert;
>  	}
>  
>  	return min(start + __ffs(tmp), nbits);
> @@ -61,7 +71,7 @@ static unsigned long _find_next_bit(const unsigned long *addr,
>  unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
>  			    unsigned long offset)
>  {
> -	return _find_next_bit(addr, size, offset, 0UL);
> +	return _find_next_bit(addr, NULL, size, offset, 0UL);
>  }
>  EXPORT_SYMBOL(find_next_bit);
>  #endif
> @@ -70,11 +80,21 @@ EXPORT_SYMBOL(find_next_bit);
>  unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
>  				 unsigned long offset)
>  {
> -	return _find_next_bit(addr, size, offset, ~0UL);
> +	return _find_next_bit(addr, NULL, size, offset, ~0UL);
>  }
>  EXPORT_SYMBOL(find_next_zero_bit);
>  #endif
>  
> +#if !defined(find_next_and_bit)
> +unsigned long find_next_and_bit(const unsigned long *addr1,
> +		const unsigned long *addr2, unsigned long size,
> +		unsigned long offset)
> +{
> +	return _find_next_bit(addr1, addr2, size, offset, 0UL);
> +}
> +EXPORT_SYMBOL(find_next_and_bit);
> +#endif
> +
>  #ifndef find_first_bit
>  /*
>   * Find the first set bit in a memory region.
> @@ -146,15 +166,19 @@ static inline unsigned long ext2_swab(const unsigned long y)
>  }
>  
>  #if !defined(find_next_bit_le) || !defined(find_next_zero_bit_le)
> -static unsigned long _find_next_bit_le(const unsigned long *addr,
> -		unsigned long nbits, unsigned long start, unsigned long invert)
> +static inline unsigned long _find_next_bit_le(const unsigned long *addr1,
> +		const unsigned long *addr2, unsigned long nbits,
> +		unsigned long start, unsigned long invert)
>  {
>  	unsigned long tmp;
>  
>  	if (unlikely(start >= nbits))
>  		return nbits;
>  
> -	tmp = addr[start / BITS_PER_LONG] ^ invert;
> +	tmp = addr1[start / BITS_PER_LONG];
> +	if (addr2)
> +		tmp &= addr2[start / BITS_PER_LONG];
> +	tmp ^= invert;
>  
>  	/* Handle 1st word. */
>  	tmp &= ext2_swab(BITMAP_FIRST_WORD_MASK(start));
> @@ -165,7 +189,10 @@ static unsigned long _find_next_bit_le(const unsigned long *addr,
>  		if (start >= nbits)
>  			return nbits;
>  
> -		tmp = addr[start / BITS_PER_LONG] ^ invert;
> +		tmp = addr1[start / BITS_PER_LONG];
> +		if (addr2)
> +			tmp &= addr2[start / BITS_PER_LONG];
> +		tmp ^= invert;
>  	}
>  
>  	return min(start + __ffs(ext2_swab(tmp)), nbits);
> @@ -176,7 +203,7 @@ static unsigned long _find_next_bit_le(const unsigned long *addr,
>  unsigned long find_next_zero_bit_le(const void *addr, unsigned
>  		long size, unsigned long offset)
>  {
> -	return _find_next_bit_le(addr, size, offset, ~0UL);
> +	return _find_next_bit_le(addr, NULL, size, offset, ~0UL);
>  }
>  EXPORT_SYMBOL(find_next_zero_bit_le);
>  #endif
> @@ -185,7 +212,7 @@ EXPORT_SYMBOL(find_next_zero_bit_le);
>  unsigned long find_next_bit_le(const void *addr, unsigned
>  		long size, unsigned long offset)
>  {
> -	return _find_next_bit_le(addr, size, offset, 0UL);
> +	return _find_next_bit_le(addr, NULL, size, offset, 0UL);
>  }
>  EXPORT_SYMBOL(find_next_bit_le);
>  #endif
> diff --git a/lib/test_find_bit.c b/lib/test_find_bit.c
> index f4394a36f9aa..90773efa4694 100644
> --- a/lib/test_find_bit.c
> +++ b/lib/test_find_bit.c
> @@ -35,6 +35,7 @@
>  #define SPARSE		500
>  
>  static DECLARE_BITMAP(bitmap, BITMAP_LEN) __initdata;
> +static DECLARE_BITMAP(bitmap2, BITMAP_LEN) __initdata;
>  
>  /*
>   * This is Schlemiel the Painter's algorithm. It should be called after
> @@ -107,6 +108,42 @@ static int __init test_find_last_bit(const void *bitmap, unsigned long len)
>  	return 0;
>  }
>  
> +static int __init test_find_next_and_bit(const void *bitmap,
> +		const void *bitmap2, unsigned long len)
> +{
> +	unsigned long i, cnt;
> +	cycles_t cycles;
> +
> +	cycles = get_cycles();

Please switch to ktime_get, as other tests do.

> +	for (cnt = i = 0; i < BITMAP_LEN; cnt++)
> +		i = find_next_and_bit(bitmap, bitmap2, BITMAP_LEN, i+1);
> +	cycles = get_cycles() - cycles;
> +	pr_err("find_next_and_bit: %ld cycles, %ld iterations\n", (long)cycles,
> +		cnt);

Use pretty formatting here to align with others tests output.

> +
> +	return 0;
> +}
> +
> +static int __init test_find_next_and_bit_ref(const void *bitmap,
> +		const void *bitmap2, unsigned long len)

> +{
> +	unsigned long i, cnt;
> +	cycles_t cycles;
> +
> +	cycles = get_cycles();
> +	for (cnt = i = 0; i < BITMAP_LEN; cnt++)
> +		while ((i = find_next_bit(bitmap, BITMAP_LEN, i + 1))
> +			< BITMAP_LEN)

Nit:		while (i < BITMAP_LEN) {
                        i = find_next_bit(bitmap, BITMAP_LEN, i + 1);

> +			if (test_bit(i, bitmap2))
> +				break;

                }

> +
> +	cycles = get_cycles() - cycles;
> +	pr_err("find_next_and_bit_ref: %ld cycles, %ld iterations\n",
> +		(long)cycles, cnt);
> +
> +	return 0;
> +}

I don't understand the purpose of this. It's obviously clear that
test_find_next_and_bit cannot be slower than test_find_next_and_bit_ref

We don't have 'reference' implementations for other functions here.
If you still think that you need it, please introduce
find_next_and_bit_ref() to make the purpose of test clear. (I spent
more that a minute to understand what happens here, and my first
suggestion was wrong.)

>  static int __init find_bit_test(void)
>  {
>  	unsigned long nbits = BITMAP_LEN / SPARSE;
> @@ -114,23 +151,31 @@ static int __init find_bit_test(void)
>  	pr_err("\nStart testing find_bit() with random-filled bitmap\n");
>  
>  	get_random_bytes(bitmap, sizeof(bitmap));
> +	get_random_bytes(bitmap2, sizeof(bitmap2));
>  
>  	test_find_next_bit(bitmap, BITMAP_LEN);
>  	test_find_next_zero_bit(bitmap, BITMAP_LEN);
>  	test_find_last_bit(bitmap, BITMAP_LEN);
>  	test_find_first_bit(bitmap, BITMAP_LEN);
> +	test_find_next_and_bit_ref(bitmap, bitmap2, BITMAP_LEN);
> +	test_find_next_and_bit(bitmap, bitmap2, BITMAP_LEN);
>  
>  	pr_err("\nStart testing find_bit() with sparse bitmap\n");
>  
>  	bitmap_zero(bitmap, BITMAP_LEN);
> +	bitmap_zero(bitmap2, BITMAP_LEN);
>  
> -	while (nbits--)
> +	while (nbits--) {
>  		__set_bit(prandom_u32() % BITMAP_LEN, bitmap);
> +		__set_bit(prandom_u32() % BITMAP_LEN, bitmap2);
> +	}
>  
>  	test_find_next_bit(bitmap, BITMAP_LEN);
>  	test_find_next_zero_bit(bitmap, BITMAP_LEN);
>  	test_find_last_bit(bitmap, BITMAP_LEN);
>  	test_find_first_bit(bitmap, BITMAP_LEN);
> +	test_find_next_and_bit_ref(bitmap, bitmap2, BITMAP_LEN);
> +	test_find_next_and_bit(bitmap, bitmap2, BITMAP_LEN);

For sparse bitmaps it will be like traversing zero-bitmaps. I doubt
this numbers will be representative. Do we need this test at all?

>  	return 0;
>  }

Yury
