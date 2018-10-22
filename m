From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V9 11/21] csky: Atomic operations
Date: Mon, 22 Oct 2018 09:52:58 +0800
Message-ID: <20181022015258.GA3649@guoren-Inspiron-7460>
References: <cover.1539655731.git.ren_guo@c-sky.com>
 <efb6c9bb87f68c6f579ef497096086413effa5c2.1539655732.git.ren_guo@c-sky.com>
 <20181021205508.GJ4931@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181021205508.GJ4931@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, hch@infradead.org, marc.zyngier@arm.com, mark.rutland@arm.com, robh@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, c-sky_gcc_upstream@c-sky.com, Andrea Parri <andrea.parri@amarulasolutions.com>
List-Id: linux-arch.vger.kernel.org

Thx Peter, 

Your review has been a great help.

On Sun, Oct 21, 2018 at 10:55:08PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 16, 2018 at 10:58:30AM +0800, Guo Ren wrote:
> > +	smp_mb();
> > +	lock->tickets.owner++;
> 
> 	WRITE_ONCE(lock->tickets.owner, lock->tickets.owner + 1);
Yes, approve! I should use WRITE_ONCE/READ_ONCE as necessary.

> > +/*
> > + * Test-and-set spin-locking.
> > + */
> 
> I'm still not entirely sure why you want to have two spinlock
> implementations; to me that is just extra maintenance overhead.
Test and set (spinlock & rwlock) is easier for debug :P, and I don't
know the details of queue-rwlock (maybe I should learn it).

From education's view, we could teach students both of them in
arch/csky :)

Anyway, I just want to keep both of them.

Thx

> > +	asm volatile (
> > +		"	movi		%0, 0    \n"
> > +		"	stw		%0, (%1) \n"
> > +		: "=&r" (tmp)
> > +		: "r"(p)
> > +		: "cc");
> 
> 	WRITE_ONCE(lock->lock, 0);
> ?
Cool ... I like WRITE_ONCE style. 

> > +
> > +#define arch_spin_is_locked(x)	(READ_ONCE((x)->lock) != 0)
> > +
> > +/*
> > + * read lock/unlock/trylock
> > + */
> 
> Idem, why do you want a second rwlock_t implementation?
The same as above of spinlock.

> > +	asm volatile (
> > +		"1:	ldex.w		%0, (%1) \n"
> > +		"	movi		%0, 0    \n"
> > +		"	stex.w		%0, (%1) \n"
> > +		"	bez		%0, 1b   \n"
> > +		: "=&r" (tmp)
> > +		: "r"(p)
> > +		: "cc");
> 
> Isn't that:
> 
> 	WRITE_ONCE(lock->lock, 0);
Yes, no need ldex/stex and you've mentioned in spinlock before :P

> > diff --git a/arch/csky/kernel/atomic.S b/arch/csky/kernel/atomic.S
> > new file mode 100644
> > index 0000000..d2357c8
> > --- /dev/null
> > +++ b/arch/csky/kernel/atomic.S
> > @@ -0,0 +1,87 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> > +
> > +#include <linux/linkage.h>
> > +#include <abi/entry.h>
> > +
> > +.text
> > +
> > +/*
> > + * int csky_cmpxchg(int oldval, int newval, int *ptr)
> > + *
> > + * If *ptr != oldval && return 1,
> > + * else *ptr = newval return 0.
> > + */
> > +#ifdef CONFIG_CPU_HAS_LDSTEX
> > +ENTRY(csky_cmpxchg)
> > +	USPTOKSP
> > +	mfcr	a3, epc
> > +	INCTRAP	a3
> > +
> > +	subi    sp, 8
> > +	stw     a3, (sp, 0)
> > +	mfcr    a3, epsr
> > +	stw     a3, (sp, 4)
> > + 
> > +	psrset	ee
> > +1:
> > +	ldex	a3, (a2)
> > +	cmpne	a0, a3
> > +	bt16	2f
> > +	mov	a3, a1
> > +	stex	a3, (a2)
> > +	bez	a3, 1b
> > +2:
> > +	sync.is
> > +	mvc	a0
> > +	ldw	a3, (sp, 0)
> > +	mtcr	a3, epc
> > +	ldw     a3, (sp, 4)
> > +	mtcr	a3, epsr
> > +	addi	sp, 8
> > +	KSPTOUSP
> > +	rte
> > +END(csky_cmpxchg)
> 
> I don't understand why you have this; if the CPU has ll/sc, why do you
> need syscall support?
I've really considered your advice before, but from abi view 610/807/810
all have csky_cmpxchg trap and we want to make them the same. Some apps
use the trap directly and not use libc api. Maybe we could delete the
trap in future version of kernel.

> 
> In any case, nothing terminally broken; so I suppose that's good enough
> for starters. I just really don't understand some decisions (like having
> two lock implementations and having that cmpxchg syscall when you have
> hardware ll/sc).
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Thx peter and the two questions which I've clarified in above.

Best Regards
 Guo Ren
