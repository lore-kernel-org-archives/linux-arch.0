From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Date: Fri, 6 Jul 2018 19:01:31 +0800
Message-ID: <20180706110129.GC8707@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705175059.GE2530@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180705175059.GE2530@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 05, 2018 at 07:50:59PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 02, 2018 at 01:30:14AM +0800, Guo Ren wrote:
> 
> > +#include <asm/barrier.h>
> > +
> > +#define __xchg(new, ptr, size)					\
> > +({								\
> > +	__typeof__(ptr) __ptr = (ptr);				\
> > +	__typeof__(new) __new = (new);				\
> > +	__typeof__(*(ptr)) __ret;				\
> > +	unsigned long tmp;					\
> > +	switch (size) {						\
> > +	case 4:							\
> > +		asm volatile (					\
> > +		"1:	ldex.w		%0, (%3) \n"		\
> > +		"	mov		%1, %2   \n"		\
> > +		"	stex.w		%1, (%3) \n"		\
> > +		"	bez		%1, 1b   \n"		\
> > +			: "=&r" (__ret), "=&r" (tmp)		\
> > +			: "r" (__new), "r"(__ptr)		\
> > +			: "memory");				\
> > +		smp_mb();					\
> > +		break;						\
> > +	default:						\
> > +		BUILD_BUG();					\
> > +	}							\
> > +	__ret;							\
> > +})
> > +
> > +#define xchg(ptr, x)	(__xchg((x), (ptr), sizeof(*(ptr))))
> > +
> > +#define __cmpxchg(ptr, old, new, size)				\
> > +({								\
> > +	__typeof__(ptr) __ptr = (ptr);				\
> > +	__typeof__(new) __new = (new);				\
> > +	__typeof__(new) __tmp;					\
> > +	__typeof__(old) __old = (old);				\
> > +	__typeof__(*(ptr)) __ret;				\
> > +	switch (size) {						\
> > +	case 4:							\
> > +		asm volatile (					\
> > +		"1:	ldex.w		%0, (%3) \n"		\
> > +		"	cmpne		%0, %4   \n"		\
> > +		"	bt		2f       \n"		\
> > +		"	mov		%1, %2   \n"		\
> > +		"	stex.w		%1, (%3) \n"		\
> > +		"	bez		%1, 1b   \n"		\
> > +		"2:				 \n"		\
> > +			: "=&r" (__ret), "=&r" (__tmp)		\
> > +			: "r" (__new), "r"(__ptr), "r"(__old)	\
> > +			: "memory");				\
> > +		smp_mb();					\
> > +		break;						\
> > +	default:						\
> > +		BUILD_BUG();					\
> > +	}							\
> > +	__ret;							\
> > +})
> > +
> > +#define cmpxchg(ptr, o, n) \
> > +	(__cmpxchg((ptr), (o), (n), sizeof(*(ptr))))
> 
> What's the memory ordering rules for your LDEX/STEX ?
Every CPU has a local exclusive monitor.

"Ldex rz, (rx, #off)" will add an entry into the local monitor, and the 
entry is composed of a address tag and a exclusive flag (inited with 1). 
Any stores (include other cores') will break the exclusive flag to 0 in
the entry which could be indexed by the address tag.

"Stex rz, (rx, #off)" has two condition:
1. Store Success: When the entry's exclusive flag is 1, it will store rz
to the [rx + off] address and the rz will be set to 1.
2. Store Failure: When the entry's exclusive flag is 0, just rz will be
set to 0.

> The mandated semantics for xchg() / cmpxchg() is an effective smp_mb()
> before _and_ after.

	switch (size) {						\
	case 4:							\
		smp_mb();					\
		asm volatile (					\
		"1:	ldex.w		%0, (%3) \n"		\
		"	mov		%1, %2   \n"		\
		"	stex.w		%1, (%3) \n"		\
		"	bez		%1, 1b   \n"		\
			: "=&r" (__ret), "=&r" (tmp)		\
			: "r" (__new), "r"(__ptr)		\
			: "memory");				\
		smp_mb();					\
		break;						\
Hmm?
But I couldn't undertand what's wrong without the 1th smp_mb()?
1th smp_mb will make all ld/st finish before ldex.w. Is it necessary?

> The above implementation suggests LDEX implies a SYNC.IS, is this
> correct?
No, ldex doesn't imply a sync.is.

 Guo Ren
