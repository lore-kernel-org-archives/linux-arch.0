From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [RFC] change non-atomic bitops method
Date: Tue, 3 Feb 2015 03:17:30 +0200
Message-ID: <20150203011730.GA15653@node.dhcp.inet.fi>
References: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
 <20150202152909.13bfd11f192fb0268b2ab4bf@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mta-out1.inet.fi ([62.71.2.227]:53472 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754951AbbBCBUa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Feb 2015 20:20:30 -0500
Content-Disposition: inline
In-Reply-To: <20150202152909.13bfd11f192fb0268b2ab4bf@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Wang, Yalin" <Yalin.Wang@sonymobile.com>, "'arnd@arndb.de'" <arnd@arndb.de>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux@arm.linux.org.uk'" <linux@arm.linux.org.uk>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>

On Mon, Feb 02, 2015 at 03:29:09PM -0800, Andrew Morton wrote:
> On Mon, 2 Feb 2015 11:55:03 +0800 "Wang, Yalin" <Yalin.Wang@sonymobile.com> wrote:
> 
> > This patch change non-atomic bitops,
> > add a if() condition to test it, before set/clear the bit.
> > so that we don't need dirty the cache line, if this bit
> > have been set or clear. On SMP system, dirty cache line will
> > need invalidate other processors cache line, this will have
> > some impact on SMP systems.
> > 
> > --- a/include/asm-generic/bitops/non-atomic.h
> > +++ b/include/asm-generic/bitops/non-atomic.h
> > @@ -17,7 +17,9 @@ static inline void __set_bit(int nr, volatile unsigned long *addr)
> >  	unsigned long mask = BIT_MASK(nr);
> >  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> >  
> > -	*p  |= mask;
> > +	if ((*p & mask) == 0)
> > +		*p  |= mask;
> > +
> >  }
> 
> hm, maybe.
> 
> It will speed up set_bit on an already-set bit.  But it will slow down
> set_bit on a not-set bit.  And the latter case is presumably much, much
> more common.
> 
> How do we know the patch is a net performance gain?

Let's try to measure. The micro benchmark:

	#include <stdio.h>
	#include <time.h>
	#include <sys/mman.h>

	#ifdef CACHE_HOT
	#define SIZE (2UL << 20)
	#define TIMES 10000000
	#else
	#define SIZE (1UL << 30)
	#define TIMES 10000
	#endif

	int main(int argc, char **argv)
	{
		struct timespec a, b, diff;
		unsigned long i, *p, times = TIMES;

		p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
				MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);
		
		clock_gettime(CLOCK_MONOTONIC, &a);
		while (times--) {
			for (i = 0; i < SIZE/64/sizeof(*p); i++) {
	#ifdef CHECK_BEFORE_SET
				if (p[i] != times)
	#endif
					p[i] = times;
			}
		}
		clock_gettime(CLOCK_MONOTONIC, &b);

		diff.tv_sec = b.tv_sec - a.tv_sec;
		if (a.tv_nsec > b.tv_nsec) {
			diff.tv_sec--;
			diff.tv_nsec = 1000000000 + b.tv_nsec - a.tv_nsec;
		} else
			diff.tv_nsec = b.tv_nsec - a.tv_nsec;

		printf("%lu.%09lu\n", diff.tv_sec, diff.tv_nsec);
		return 0;
	}

Results for 10 runs on my laptop -- i5-3427U (IvyBridge 1.8 Ghz, 2.8Ghz Turbo
with 3MB LLC):

				Avg		Stddev
baseline			21.5351		0.5315
-DCHECK_BEFORE_SET		21.9834		0.0789
-DCACHE_HOT			14.9987		0.0365
-DCACHE_HOT -DCHECK_BEFORE_SET	29.9010		0.0204

Difference between -DCACHE_HOT and -DCACHE_HOT -DCHECK_BEFORE_SET appears
huge, but if you recalculate it to CPU cycles per inner loop @ 2.8 Ghz,
it's 1.02530 and 2.04401 CPU cycles respectively.

Basically, the check is free on decent CPU. 

-- 
 Kirill A. Shutemov
