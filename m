From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH v2] lib: optimize cpumask_next_and()
Date: Wed, 25 Oct 2017 17:59:38 +0300
Message-ID: <20171025145938.wpr7spsujounqudk@yury-thinkpad>
References: <20171024105159.18293-1-courbet@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171024105159.18293-1-courbet@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Clement Courbet <courbet@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <mawilcox@microsoft.com>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 24, 2017 at 12:51:59PM +0200, Clement Courbet wrote:
> We've measured that we spend ~0.6% of sys cpu time in cpumask_next_and().
> It's essentially a joined iteration in search for a non-zero bit, which
> is currently implemented as a lookup join (find a nonzero bit on the
> lhs, lookup the rhs to see if it's set there).
> 
> Implement a direct join (find a nonzero bit on the incrementally built
> join). Direct benchmarking shows that it's 1.17x to 14x faster with a
> geometric mean of 2.1 on 32 CPUs. No impact on memory usage.
> 
> Approximate benchmark code:
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
> Signed-off-by: Clement Courbet <courbet@google.com>
> ---
> Changes in v2:
>  - Refactored _find_next_common_bit into _find_next_bit., as suggested
>    by Yury Norov.

What I actually suggested is make _find_next_and_bit() similar to
_find_next_bit(), not to extend _find_next_bit(). But what you did
looks OK.

> This has no adverse effects on the performance side,
>    as the compiler successfully inlines the code.

I think it's not about inlining, compiler just optimizes out branches known
as false at compile-time.

>  include/asm-generic/bitops/find.h       | 16 ++++++++++++++
>  include/linux/bitmap.h                  |  2 ++
>  lib/cpumask.c                           |  9 ++++----
>  lib/find_bit.c                          | 37 +++++++++++++++++++++++++--------
>  tools/include/asm-generic/bitops/find.h | 16 ++++++++++++++
>  5 files changed, 67 insertions(+), 13 deletions(-)
> 
> diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
> index 998d4d544f18..130962f3a264 100644
> --- a/include/asm-generic/bitops/find.h
> +++ b/include/asm-generic/bitops/find.h
> @@ -15,6 +15,22 @@ extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
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
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 700cf5f67118..b4606bfda52f 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -77,6 +77,8 @@
>   * find_first_bit(addr, nbits)		Position first set bit in *addr
>   * find_next_zero_bit(addr, nbits, bit)	Position next zero bit in *addr >= bit
>   * find_next_bit(addr, nbits, bit)	Position next set bit in *addr >= bit
> + * find_next_and_bit(addr1, addr2, nbits, bit)	Same as find_first_bit, but in
> + *						(*addr1 & *addr2)
>   */
>  
>  /*
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index 8b1a1bd77539..5602223837fa 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -32,10 +32,11 @@ EXPORT_SYMBOL(cpumask_next);
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
> index 6ed74f78380c..ebc08fd9fdf8 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -24,19 +24,25 @@
>  #if !defined(find_next_bit) || !defined(find_next_zero_bit)
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
>   */
> -static unsigned long _find_next_bit(const unsigned long *addr,
> -		unsigned long nbits, unsigned long start, unsigned long invert)
> +static unsigned long _find_next_bit(const unsigned long *addr1,
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
> @@ -47,7 +53,10 @@ static unsigned long _find_next_bit(const unsigned long *addr,
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
> @@ -61,7 +70,7 @@ static unsigned long _find_next_bit(const unsigned long *addr,
>  unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
>  			    unsigned long offset)
>  {
> -	return _find_next_bit(addr, size, offset, 0UL);
> +	return _find_next_bit(addr, NULL, size, offset, 0UL);
>  }
>  EXPORT_SYMBOL(find_next_bit);
>  #endif
> @@ -70,11 +79,21 @@ EXPORT_SYMBOL(find_next_bit);
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
> +		const unsigned long *addr2, unsigned long nbits,
> +		unsigned long start)

It should be:

unsigned long find_next_and_bit(const unsigned long *addr1,
		const unsigned long *addr2, unsigned long size,
		unsigned long offset)

> +{
> +	return _find_next_bit(addr1, addr2, size, offset, ~0UL);
> +}
> +EXPORT_SYMBOL(find_next_and_bit);
> +#endif
> +
>  #ifndef find_first_bit
>  /*
>   * Find the first set bit in a memory region.

If we continue this way, we'll most probably end up like this,
sooner or later:

diff --git a/lib/find_bit.c b/lib/find_bit.c
index ebc08fd9fdf8..1b0b4aedc93a 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -31,8 +31,12 @@
  *  - The optional "addr2", which is anded with "addr1" if present.
  */
 static unsigned long _find_next_bit(const unsigned long *addr1,
-		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert)
+		const unsigned long *and,
+		const unsigned long *or,
+		const unsigned long *xor,
+		unsigned long nbits,
+		unsigned long start,
+		unsigned long invert)
 {
 	unsigned long tmp;
 
@@ -40,8 +44,12 @@ static unsigned long _find_next_bit(const unsigned long *addr1,
 		return nbits;
 
 	tmp = addr1[start / BITS_PER_LONG];
-	if (addr2)
-		tmp &= addr2[start / BITS_PER_LONG];
+	if (and)
+		tmp &= and[start / BITS_PER_LONG];
+	if (or)
+		tmp |= or[start / BITS_PER_LONG];
+	if (xor)
+		tmp ^= xor[start / BITS_PER_LONG];
 	tmp ^= invert;
 
 	/* Handle 1st word. */
@@ -54,8 +62,12 @@ static unsigned long _find_next_bit(const unsigned long *addr1,
 			return nbits;
 
 		tmp = addr1[start / BITS_PER_LONG];
-		if (addr2)
-			tmp &= addr2[start / BITS_PER_LONG];
+		if (and)
+			tmp &= and[start / BITS_PER_LONG];
+		if (or)
+			tmp |= or[start / BITS_PER_LONG];
+		if (xor)
+			tmp ^= xor[start / BITS_PER_LONG];
 		tmp ^= invert;
 	}
 
Just a fantasy of course.

I'm generally fine to proceed this way. It makes _find_next_bit() more
complex, but lets us avoid code duplication, which is better deal for
long-term maintenance.

But I'd like also to keep _find_next_bit() consistent with _find_next_bit_le()

Could you please send v3 with fixed find_next_and_bit() declaration,
and synced LE routines?

Yury
