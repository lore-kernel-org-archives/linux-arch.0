From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V9 11/21] csky: Atomic operations
Date: Sun, 21 Oct 2018 22:55:08 +0200
Message-ID: <20181021205508.GJ4931@worktop.programming.kicks-ass.net>
References: <cover.1539655731.git.ren_guo@c-sky.com>
 <efb6c9bb87f68c6f579ef497096086413effa5c2.1539655732.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <efb6c9bb87f68c6f579ef497096086413effa5c2.1539655732.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, hch@infradead.org, marc.zyngier@arm.com, mark.rutland@arm.com, robh@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, c-sky_gcc_upstream@c-sky.com, Andrea Parri <andrea.parri@amarulasolutions.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 16, 2018 at 10:58:30AM +0800, Guo Ren wrote:

> diff --git a/arch/csky/include/asm/spinlock.h b/arch/csky/include/asm/spinlock.h
> new file mode 100644
> index 0000000..0474603
> --- /dev/null
> +++ b/arch/csky/include/asm/spinlock.h
> @@ -0,0 +1,274 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_CSKY_SPINLOCK_H
> +#define __ASM_CSKY_SPINLOCK_H
> +
> +#include <linux/spinlock_types.h>
> +#include <asm/barrier.h>
> +
> +#ifdef CONFIG_QUEUED_RWLOCKS
> +
> +/*
> + * Ticket-based spin-locking.
> + */
> +static inline void arch_spin_lock(arch_spinlock_t *lock)
> +{
> +	arch_spinlock_t lockval;
> +	u32 ticket_next = 1 << TICKET_NEXT;
> +	u32 *p = &lock->lock;
> +	u32 tmp;
> +
> +	asm volatile (
> +		"1:	ldex.w		%0, (%2) \n"
> +		"	mov		%1, %0	 \n"
> +		"	add		%0, %3	 \n"
> +		"	stex.w		%0, (%2) \n"
> +		"	bez		%0, 1b   \n"
> +		: "=&r" (tmp), "=&r" (lockval)
> +		: "r"(p), "r"(ticket_next)
> +		: "cc");
> +
> +	while (lockval.tickets.next != lockval.tickets.owner)
> +		lockval.tickets.owner = READ_ONCE(lock->tickets.owner);
> +
> +	smp_mb();
> +}
> +
> +static inline int arch_spin_trylock(arch_spinlock_t *lock)
> +{
> +	u32 tmp, contended, res;
> +	u32 ticket_next = 1 << TICKET_NEXT;
> +	u32 *p = &lock->lock;
> +
> +	do {
> +		asm volatile (
> +		"	ldex.w		%0, (%3)   \n"
> +		"	movi		%2, 1	   \n"
> +		"	rotli		%1, %0, 16 \n"
> +		"	cmpne		%1, %0     \n"
> +		"	bt		1f         \n"
> +		"	movi		%2, 0	   \n"
> +		"	add		%0, %0, %4 \n"
> +		"	stex.w		%0, (%3)   \n"
> +		"1:				   \n"
> +		: "=&r" (res), "=&r" (tmp), "=&r" (contended)
> +		: "r"(p), "r"(ticket_next)
> +		: "cc");
> +	} while (!res);
> +
> +	if (!contended)
> +		smp_mb();
> +
> +	return !contended;
> +}
> +
> +static inline void arch_spin_unlock(arch_spinlock_t *lock)
> +{
> +	smp_mb();
> +	lock->tickets.owner++;

	WRITE_ONCE(lock->tickets.owner, lock->tickets.owner + 1);

> +}
> +
> +static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> +{
> +	return lock.tickets.owner == lock.tickets.next;
> +}
> +
> +static inline int arch_spin_is_locked(arch_spinlock_t *lock)
> +{
> +	return !arch_spin_value_unlocked(READ_ONCE(*lock));
> +}
> +
> +static inline int arch_spin_is_contended(arch_spinlock_t *lock)
> +{
> +	struct __raw_tickets tickets = READ_ONCE(lock->tickets);
> +
> +	return (tickets.next - tickets.owner) > 1;
> +}
> +#define arch_spin_is_contended	arch_spin_is_contended
> +
> +#include <asm/qrwlock.h>
> +
> +/* See include/linux/spinlock.h */
> +#define smp_mb__after_spinlock()	smp_mb()
> +
> +#else /* CONFIG_QUEUED_RWLOCKS */
> +
> +/*
> + * Test-and-set spin-locking.
> + */

I'm still not entirely sure why you want to have two spinlock
implementations; to me that is just extra maintenance overhead.

> +static inline void arch_spin_lock(arch_spinlock_t *lock)
> +{
> +	u32 *p = &lock->lock;
> +	u32 tmp;
> +
> +	asm volatile (
> +		"1:	ldex.w		%0, (%1) \n"
> +		"	bnez		%0, 1b   \n"
> +		"	movi		%0, 1    \n"
> +		"	stex.w		%0, (%1) \n"
> +		"	bez		%0, 1b   \n"
> +		: "=&r" (tmp)
> +		: "r"(p)
> +		: "cc");
> +	smp_mb();
> +}
> +
> +static inline void arch_spin_unlock(arch_spinlock_t *lock)
> +{
> +	u32 *p = &lock->lock;
> +	u32 tmp;
> +
> +	smp_mb();
> +	asm volatile (
> +		"	movi		%0, 0    \n"
> +		"	stw		%0, (%1) \n"
> +		: "=&r" (tmp)
> +		: "r"(p)
> +		: "cc");

	WRITE_ONCE(lock->lock, 0);
?

> +}
> +
> +static inline int arch_spin_trylock(arch_spinlock_t *lock)
> +{
> +	u32 *p = &lock->lock;
> +	u32 tmp;
> +
> +	asm volatile (
> +		"1:	ldex.w		%0, (%1) \n"
> +		"	bnez		%0, 2f   \n"
> +		"	movi		%0, 1    \n"
> +		"	stex.w		%0, (%1) \n"
> +		"	bez		%0, 1b   \n"
> +		"	movi		%0, 0    \n"
> +		"2:				 \n"
> +		: "=&r" (tmp)
> +		: "r"(p)
> +		: "cc");
> +
> +	if (!tmp)
> +		smp_mb();
> +
> +	return !tmp;
> +}
> +
> +#define arch_spin_is_locked(x)	(READ_ONCE((x)->lock) != 0)
> +
> +/*
> + * read lock/unlock/trylock
> + */

Idem, why do you want a second rwlock_t implementation?

> +/*
> + * write lock/unlock/trylock
> + */
> +static inline void arch_write_lock(arch_rwlock_t *lock)
> +{
> +	u32 *p = &lock->lock;
> +	u32 tmp;
> +
> +	asm volatile (
> +		"1:	ldex.w		%0, (%1) \n"
> +		"	bnez		%0, 1b   \n"
> +		"	subi		%0, 1    \n"
> +		"	stex.w		%0, (%1) \n"
> +		"	bez		%0, 1b   \n"
> +		: "=&r" (tmp)
> +		: "r"(p)
> +		: "cc");
> +	smp_mb();
> +}
> +
> +static inline void arch_write_unlock(arch_rwlock_t *lock)
> +{
> +	u32 *p = &lock->lock;
> +	u32 tmp;
> +
> +	smp_mb();
> +	asm volatile (
> +		"1:	ldex.w		%0, (%1) \n"
> +		"	movi		%0, 0    \n"
> +		"	stex.w		%0, (%1) \n"
> +		"	bez		%0, 1b   \n"
> +		: "=&r" (tmp)
> +		: "r"(p)
> +		: "cc");

Isn't that:

	WRITE_ONCE(lock->lock, 0);

> +}
> +
> +static inline int arch_write_trylock(arch_rwlock_t *lock)
> +{
> +	u32 *p = &lock->lock;
> +	u32 tmp;
> +
> +	asm volatile (
> +		"1:	ldex.w		%0, (%1) \n"
> +		"	bnez		%0, 2f   \n"
> +		"	subi		%0, 1    \n"
> +		"	stex.w		%0, (%1) \n"
> +		"	bez		%0, 1b   \n"
> +		"	movi		%0, 0    \n"
> +		"2:				 \n"
> +		: "=&r" (tmp)
> +		: "r"(p)
> +		: "cc");
> +
> +	if (!tmp)
> +		smp_mb();
> +
> +	return !tmp;
> +}

> diff --git a/arch/csky/kernel/atomic.S b/arch/csky/kernel/atomic.S
> new file mode 100644
> index 0000000..d2357c8
> --- /dev/null
> +++ b/arch/csky/kernel/atomic.S
> @@ -0,0 +1,87 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +
> +#include <linux/linkage.h>
> +#include <abi/entry.h>
> +
> +.text
> +
> +/*
> + * int csky_cmpxchg(int oldval, int newval, int *ptr)
> + *
> + * If *ptr != oldval && return 1,
> + * else *ptr = newval return 0.
> + */
> +#ifdef CONFIG_CPU_HAS_LDSTEX
> +ENTRY(csky_cmpxchg)
> +	USPTOKSP
> +	mfcr	a3, epc
> +	INCTRAP	a3
> +
> +	subi    sp, 8
> +	stw     a3, (sp, 0)
> +	mfcr    a3, epsr
> +	stw     a3, (sp, 4)
> +
> +	psrset	ee
> +1:
> +	ldex	a3, (a2)
> +	cmpne	a0, a3
> +	bt16	2f
> +	mov	a3, a1
> +	stex	a3, (a2)
> +	bez	a3, 1b
> +2:
> +	sync.is
> +	mvc	a0
> +	ldw	a3, (sp, 0)
> +	mtcr	a3, epc
> +	ldw     a3, (sp, 4)
> +	mtcr	a3, epsr
> +	addi	sp, 8
> +	KSPTOUSP
> +	rte
> +END(csky_cmpxchg)

I don't understand why you have this; if the CPU has ll/sc, why do you
need syscall support?

In any case, nothing terminally broken; so I suppose that's good enough
for starters. I just really don't understand some decisions (like having
two lock implementations and having that cmpxchg syscall when you have
hardware ll/sc).

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
