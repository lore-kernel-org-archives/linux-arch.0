Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38820 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752545AbXGYVb1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Jul 2007 17:31:27 -0400
Subject: Re: [patch 7/7] powerpc: optimised lock bitops
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20070725114138.GM29011@wotan.suse.de>
References: <20070725113407.GG29011@wotan.suse.de>
	 <20070725114138.GM29011@wotan.suse.de>
Content-Type: text/plain
Date: Thu, 26 Jul 2007 07:31:16 +1000
Message-Id: <1185399077.5439.344.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2007-07-25 at 13:41 +0200, Nick Piggin wrote:
> Add powerpc optimised lock bitops.
> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  include/asm-powerpc/bitops.h |   46 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/include/asm-powerpc/bitops.h
> ===================================================================
> --- linux-2.6.orig/include/asm-powerpc/bitops.h
> +++ linux-2.6/include/asm-powerpc/bitops.h
> @@ -86,6 +86,24 @@ static __inline__ void clear_bit(int nr,
>  	: "cc" );
>  }
>  
> +static __inline__ void clear_bit_unlock(int nr, volatile unsigned long *addr)
> +{
> +	unsigned long old;
> +	unsigned long mask = BITOP_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
> +
> +	__asm__ __volatile__(
> +	LWSYNC_ON_SMP
> +"1:"	PPC_LLARX "%0,0,%3	# clear_bit_unlock\n"
> +	"andc	%0,%0,%2\n"
> +	PPC405_ERR77(0,%3)
> +	PPC_STLCX "%0,0,%3\n"
> +	"bne-	1b"
> +	: "=&r" (old), "+m" (*p)
> +	: "r" (mask), "r" (p)
> +	: "cc", "memory");
> +}
> +
>  static __inline__ void change_bit(int nr, volatile unsigned long *addr)
>  {
>  	unsigned long old;
> @@ -125,6 +143,27 @@ static __inline__ int test_and_set_bit(u
>  	return (old & mask) != 0;
>  }
>  
> +static __inline__ int test_and_set_bit_lock(unsigned long nr,
> +				       volatile unsigned long *addr)
> +{
> +	unsigned long old, t;
> +	unsigned long mask = BITOP_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
> +
> +	__asm__ __volatile__(
> +"1:"	PPC_LLARX "%0,0,%3		# test_and_set_bit_lock\n"
> +	"or	%1,%0,%2 \n"
> +	PPC405_ERR77(0,%3)
> +	PPC_STLCX "%1,0,%3 \n"
> +	"bne-	1b"
> +	ISYNC_ON_SMP
> +	: "=&r" (old), "=&r" (t)
> +	: "r" (mask), "r" (p)
> +	: "cc", "memory");
> +
> +	return (old & mask) != 0;
> +}
> +
>  static __inline__ int test_and_clear_bit(unsigned long nr,
>  					 volatile unsigned long *addr)
>  {
> @@ -185,6 +224,12 @@ static __inline__ void set_bits(unsigned
>  
>  #include <asm-generic/bitops/non-atomic.h>
>  
> +static __inline__ void __clear_bit_unlock(int nr, volatile unsigned long *addr)
> +{
> +	__asm__ __volatile__(LWSYNC_ON_SMP ::: "memory");
> +	__clear_bit(nr, addr);
> +}
> +
>  /*
>   * Return the zero-based bit position (LE, not IBM bit numbering) of
>   * the most significant 1-bit in a double word.
> @@ -266,7 +311,6 @@ static __inline__ int fls(unsigned int x
>  #include <asm-generic/bitops/fls64.h>
>  
>  #include <asm-generic/bitops/hweight.h>
> -#include <asm-generic/bitops/lock.h>
>  
>  #define find_first_zero_bit(addr, size) find_next_zero_bit((addr), (size), 0)
>  unsigned long find_next_zero_bit(const unsigned long *addr,
> -
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

