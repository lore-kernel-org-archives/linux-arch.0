From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Date: Thu, 5 Jul 2018 19:50:59 +0200
Message-ID: <20180705175059.GE2530@hirez.programming.kicks-ass.net>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 02, 2018 at 01:30:14AM +0800, Guo Ren wrote:

> +#include <asm/barrier.h>
> +
> +#define __xchg(new, ptr, size)					\
> +({								\
> +	__typeof__(ptr) __ptr = (ptr);				\
> +	__typeof__(new) __new = (new);				\
> +	__typeof__(*(ptr)) __ret;				\
> +	unsigned long tmp;					\
> +	switch (size) {						\
> +	case 4:							\
> +		asm volatile (					\
> +		"1:	ldex.w		%0, (%3) \n"		\
> +		"	mov		%1, %2   \n"		\
> +		"	stex.w		%1, (%3) \n"		\
> +		"	bez		%1, 1b   \n"		\
> +			: "=&r" (__ret), "=&r" (tmp)		\
> +			: "r" (__new), "r"(__ptr)		\
> +			: "memory");				\
> +		smp_mb();					\
> +		break;						\
> +	default:						\
> +		BUILD_BUG();					\
> +	}							\
> +	__ret;							\
> +})
> +
> +#define xchg(ptr, x)	(__xchg((x), (ptr), sizeof(*(ptr))))
> +
> +#define __cmpxchg(ptr, old, new, size)				\
> +({								\
> +	__typeof__(ptr) __ptr = (ptr);				\
> +	__typeof__(new) __new = (new);				\
> +	__typeof__(new) __tmp;					\
> +	__typeof__(old) __old = (old);				\
> +	__typeof__(*(ptr)) __ret;				\
> +	switch (size) {						\
> +	case 4:							\
> +		asm volatile (					\
> +		"1:	ldex.w		%0, (%3) \n"		\
> +		"	cmpne		%0, %4   \n"		\
> +		"	bt		2f       \n"		\
> +		"	mov		%1, %2   \n"		\
> +		"	stex.w		%1, (%3) \n"		\
> +		"	bez		%1, 1b   \n"		\
> +		"2:				 \n"		\
> +			: "=&r" (__ret), "=&r" (__tmp)		\
> +			: "r" (__new), "r"(__ptr), "r"(__old)	\
> +			: "memory");				\
> +		smp_mb();					\
> +		break;						\
> +	default:						\
> +		BUILD_BUG();					\
> +	}							\
> +	__ret;							\
> +})
> +
> +#define cmpxchg(ptr, o, n) \
> +	(__cmpxchg((ptr), (o), (n), sizeof(*(ptr))))

What's the memory ordering rules for your LDEX/STEX ?

The mandated semantics for xchg() / cmpxchg() is an effective smp_mb()
before _and_ after.

The above implementation suggests LDEX implies a SYNC.IS, is this
correct?
