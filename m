Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cnbjrel02.sonyericsson.com ([219.141.167.166]:9541 "EHLO
	cnbjrel02.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750983AbbBCFmu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Feb 2015 00:42:50 -0500
From: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Date: Tue, 3 Feb 2015 13:42:45 +0800
Subject: RE: [RFC] change non-atomic bitops method
Message-ID: <35FD53F367049845BC99AC72306C23D1044A02027E0C@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
 <20150202152909.13bfd11f192fb0268b2ab4bf@linux-foundation.org>
 <20150203011730.GA15653@node.dhcp.inet.fi>
 <35FD53F367049845BC99AC72306C23D1044A02027E0B@CNBJMBX05.corpusers.net>
In-Reply-To: <35FD53F367049845BC99AC72306C23D1044A02027E0B@CNBJMBX05.corpusers.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "'Kirill A. Shutemov'" <kirill@shutemov.name>, 'Andrew Morton' <akpm@linux-foundation.org>
Cc: "'arnd@arndb.de'" <arnd@arndb.de>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux@arm.linux.org.uk'" <linux@arm.linux.org.uk>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>
Message-ID: <20150203054245.w2ZdcwTBaN-yYEimIWFE8jypIpuv6aYxpkJUumcEzsE@z>

> -----Original Message-----
> From: Wang, Yalin
> Sent: Tuesday, February 03, 2015 10:13 AM
> To: 'Kirill A. Shutemov'; Andrew Morton
> Cc: 'arnd@arndb.de'; 'linux-arch@vger.kernel.org'; 'linux-
> kernel@vger.kernel.org'; 'linux@arm.linux.org.uk'; 'linux-arm-
> kernel@lists.infradead.org'
> Subject: RE: [RFC] change non-atomic bitops method
> 
> > -----Original Message-----
> > From: Kirill A. Shutemov [mailto:kirill@shutemov.name]
> > Sent: Tuesday, February 03, 2015 9:18 AM
> > To: Andrew Morton
> > Cc: Wang, Yalin; 'arnd@arndb.de'; 'linux-arch@vger.kernel.org'; 'linux-
> > kernel@vger.kernel.org'; 'linux@arm.linux.org.uk'; 'linux-arm-
> > kernel@lists.infradead.org'
> > Subject: Re: [RFC] change non-atomic bitops method
> >
> > On Mon, Feb 02, 2015 at 03:29:09PM -0800, Andrew Morton wrote:
> > > On Mon, 2 Feb 2015 11:55:03 +0800 "Wang, Yalin"
> > <Yalin.Wang@sonymobile.com> wrote:
> > >
> > > > This patch change non-atomic bitops,
> > > > add a if() condition to test it, before set/clear the bit.
> > > > so that we don't need dirty the cache line, if this bit
> > > > have been set or clear. On SMP system, dirty cache line will
> > > > need invalidate other processors cache line, this will have
> > > > some impact on SMP systems.
> > > >
> > > > --- a/include/asm-generic/bitops/non-atomic.h
> > > > +++ b/include/asm-generic/bitops/non-atomic.h
> > > > @@ -17,7 +17,9 @@ static inline void __set_bit(int nr, volatile
> > unsigned long *addr)
> > > >  	unsigned long mask = BIT_MASK(nr);
> > > >  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> > > >
> > > > -	*p  |= mask;
> > > > +	if ((*p & mask) == 0)
> > > > +		*p  |= mask;
> > > > +
> > > >  }
> > >
> > > hm, maybe.
> > >
> > > It will speed up set_bit on an already-set bit.  But it will slow down
> > > set_bit on a not-set bit.  And the latter case is presumably much, much
> > > more common.
> > >
> > > How do we know the patch is a net performance gain?
> >
> > Let's try to measure. The micro benchmark:
> >
> > 	#include <stdio.h>
> > 	#include <time.h>
> > 	#include <sys/mman.h>
> >
> > 	#ifdef CACHE_HOT
> > 	#define SIZE (2UL << 20)
> > 	#define TIMES 10000000
> > 	#else
> > 	#define SIZE (1UL << 30)
> > 	#define TIMES 10000
> > 	#endif
> >
> > 	int main(int argc, char **argv)
> > 	{
> > 		struct timespec a, b, diff;
> > 		unsigned long i, *p, times = TIMES;
> >
> > 		p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
> > 				MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1,
> > 0);
> >
> > 		clock_gettime(CLOCK_MONOTONIC, &a);
> > 		while (times--) {
> > 			for (i = 0; i < SIZE/64/sizeof(*p); i++) {
> > 	#ifdef CHECK_BEFORE_SET
> > 				if (p[i] != times)
> > 	#endif
> > 					p[i] = times;
> > 			}
> > 		}
> > 		clock_gettime(CLOCK_MONOTONIC, &b);
> >
> > 		diff.tv_sec = b.tv_sec - a.tv_sec;
> > 		if (a.tv_nsec > b.tv_nsec) {
> > 			diff.tv_sec--;
> > 			diff.tv_nsec = 1000000000 + b.tv_nsec - a.tv_nsec;
> > 		} else
> > 			diff.tv_nsec = b.tv_nsec - a.tv_nsec;
> >
> > 		printf("%lu.%09lu\n", diff.tv_sec, diff.tv_nsec);
> > 		return 0;
> > 	}
> >
> > Results for 10 runs on my laptop -- i5-3427U (IvyBridge 1.8 Ghz, 2.8Ghz
> > Turbo
> > with 3MB LLC):
> >
> > 				Avg		Stddev
> > baseline			21.5351		0.5315
> > -DCHECK_BEFORE_SET		21.9834		0.0789
> > -DCACHE_HOT			14.9987		0.0365
> > -DCACHE_HOT -DCHECK_BEFORE_SET	29.9010		0.0204
> >
> > Difference between -DCACHE_HOT and -DCACHE_HOT -DCHECK_BEFORE_SET appears
> > huge, but if you recalculate it to CPU cycles per inner loop @ 2.8 Ghz,
> > it's 1.02530 and 2.04401 CPU cycles respectively.
> >
> > Basically, the check is free on decent CPU.
> >
> Awesome test, but you only test the one cpu which running this code,
> Have not consider the other CPUs, whose cache line will be invalidate if
> The cache is dirtied by writer CPU,
> So another test should be running 2 thread on two different CPUs(bind to
> CPU),
> One write , one read, to see the impact on the reader CPU.
I make a little change about your test progrom,
Add a new thread to test SMP cache impact.
---
#include <stdio.h>
#include <time.h>
#include <sys/mman.h>
#include <errno.h>
#define _GNU_SOURCE
#define __USE_GNU
#include <sched.h>
#include <pthread.h>

#ifdef CACHE_HOT
#define SIZE (2UL << 20)
#define TIMES 100000
#else
#define SIZE (1UL << 20)
#define TIMES 10000
#endif
static void *reader_thread(void *arg)
{

	struct timespec a, b, diff;
	unsigned long *p = arg;
	volatile unsigned long temp;
	unsigned long i, ret, times = TIMES;
	cpu_set_t set;
	CPU_ZERO(&set);
	CPU_SET(1, &set);
	ret = sched_setaffinity(-1, sizeof(cpu_set_t), &set);
	if (ret < 0) {
		printf("sched_setaffinity error:%s", strerror(errno));
	}
	clock_gettime(CLOCK_MONOTONIC, &a);
	while (times--) {
		for (i = 0; i < SIZE/sizeof(*p); i++) {
				temp = p[i];
		}
	}
	clock_gettime(CLOCK_MONOTONIC, &b);

	diff.tv_sec = b.tv_sec - a.tv_sec;
	if (a.tv_nsec > b.tv_nsec) {
		diff.tv_sec--;
		diff.tv_nsec = 1000000000 + b.tv_nsec - a.tv_nsec;

	} else
		diff.tv_nsec = b.tv_nsec - a.tv_nsec;

	printf("reader:%lu.%09lu\n", diff.tv_sec, diff.tv_nsec);
}

int main(int argc, char **argv)
{
	struct timespec a, b, diff;
	unsigned long i, ret, *p, times = TIMES;
	pthread_t thread;
	cpu_set_t set;
	CPU_ZERO(&set);
	CPU_SET(0, &set);
	ret = sched_setaffinity(-1, sizeof(cpu_set_t), &set);
	if (ret < 0) {
		printf("sched_setaffinity error:%s", strerror(errno));
	}
	p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
			MAP_LOCKED | MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);
	pthread_create(&thread, NULL, reader_thread, p);
	clock_gettime(CLOCK_MONOTONIC, &a);
	while (times--) {
		for (i = 0; i < SIZE/sizeof(*p); i++) {
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
----
One run on CPU0, reader thread run on CPU1,
Test result:
sudo ./cache_test
reader:8.426228173
8.672198335

With -DCHECK_BEFORE_SET
sudo ./cache_test_check
reader:7.537036819
10.799746531

You can see reader can save some time if cache not dirtied.
Also we can see that for writer, it will increase some impact
Because it need read the data before change it,

I think if the system have lots of cores, reader performance
Improve is more useful .

My CPU info:

28851195@cnbjlx20570:~/test$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 37
model name      : Intel(R) Core(TM) i5 CPU         660  @ 3.33GHz
stepping        : 5
microcode       : 0x2
cpu MHz         : 1199.000
cache size      : 4096 KB
physical id     : 0
siblings        : 4

Thanks for your test program very much!









