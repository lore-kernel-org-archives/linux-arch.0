From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/9] RISC-V: Atomic and Locking Code
Date: Wed, 5 Jul 2017 10:43:21 +0200
Message-ID: <20170705084321.hqy4qsm45mv772k4@hirez.programming.kicks-ass.net>
References: <20170704195102.3974-1-palmer@dabbelt.com>
 <20170704195102.3974-3-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:36951 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbdGEIn5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2017 04:43:57 -0400
Content-Disposition: inline
In-Reply-To: <20170704195102.3974-3-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com, patches@groups.riscv.org

On Tue, Jul 04, 2017 at 12:50:55PM -0700, Palmer Dabbelt wrote:
> +/*
> + * FIXME: I could only find documentation that atomic_{add,sub,inc,dec} are
> + * barrier-free.  I'm assuming that and/or/xor have the same constraints as the
> + * others.
> + */

Yes.. we have new documentation in the work to which I would post a link
but for some reason copy/paste stopped working again (Konsole does that
at times and is #$%#$%#4# annoying).

Ha, found it using google...

  https://marc.info/?l=linux-kernel&m=14972790112580


> +

> +/*
> + * atomic_{cmp,}xchg is required to have exactly the same ordering semantics as
> + * {cmp,}xchg and the operations that return, so they need a barrier.  We just
> + * use the other implementations directly.
> + */

cmpxchg triggers an extra rule; all conditional operations only need to
imply barriers on success. So a cmpxchg that fails, need not imply any
ordering what so ever.

> +/*
> + * Our atomic operations set the AQ and RL bits and therefor we don't need to
> + * fence around atomics.
> + */
> +#define __smb_mb__before_atomic()	barrier()
> +#define __smb_mb__after_atomic()	barrier()

Ah, not quite... you need full barriers here. Because your regular
atomic ops imply no ordering what so ever.

> +/*
> + * These barries are meant to prevent memory operations inside a spinlock from
> + * moving outside of that spinlock.  Since we set the AQ and RL bits when
> + * entering or leaving spinlocks, no additional fence needs to be performed.
> + */
> +#define smb_mb__before_spinlock()	barrier()
> +#define smb_mb__after_spinlock()	barrier()

Also probably not true. I _think_ you want a full barrier here, but
given the total lack of documentation on your end and the fact I've not
yet read the spinlock (which I suppose is below) I cannot yet state
more.


> +
> +/* FIXME: I don't think RISC-V is allowed to perform a speculative load. */
> +#define smp_acquire__after_ctrl_dep()	barrier()

That would be a very weird thing to disallow... speculative loads are
teh awesome ;-) Note you can get the very same effect from caches when
your stores are not globally atomic.

> +/*
> + * The RISC-V ISA doesn't support byte or half-word AMOs, so we fall back to a
> + * regular store and a fence here.  Otherwise we emit an AMO with an AQ or RL
> + * bit set and allow the microarchitecture to avoid the other half of the AMO.
> + */
> +#define __smp_store_release(p, v)					\
> +do {									\
> +	union { typeof(*p) __val; char __c[1]; } __u =			\
> +		{ .__val = (__force typeof(*p)) (v) };			\
> +	compiletime_assert_atomic_type(*p);				\
> +	switch (sizeof(*p)) {						\
> +	case 1:								\
> +	case 2:								\
> +		smb_mb();						\
> +		WRITE_ONCE(*p, __u.__val);				\
> +		break;							\
> +	case 4:								\
> +		__asm__ __volatile__ (					\
> +			"amoswap.w.rl zero, %1, %0"			\
> +			: "+A" (*p), "r" (__u.__val)			\
> +			: 						\
> +			: "memory");					\
> +		break;							\
> +	case 8:								\
> +		__asm__ __volatile__ (					\
> +			"amoswap.d.rl zero, %1, %0"			\
> +			: "+A" (*p), "r" (__u.__val)			\
> +			: 						\
> +			: "memory");					\
> +		break;							\
> +	}								\
> +} while (0)
> +
> +#define __smp_load_acquire(p)						\
> +do {									\
> +	union { typeof(*p) __val; char __c[1]; } __u =			\
> +		{ .__val = (__force typeof(*p)) (v) };			\
> +	compiletime_assert_atomic_type(*p);				\
> +	switch (sizeof(*p)) {						\
> +	case 1:								\
> +	case 2:								\
> +		__u.__val = READ_ONCE(*p);				\
> +		smb_mb();						\
> +		break;							\
> +	case 4:								\
> +		__asm__ __volatile__ (					\
> +			"amoor.w.aq %1, zero, %0"			\
> +			: "+A" (*p)					\
> +			: "=r" (__u.__val)				\
> +			: "memory");					\
> +		break;							\
> +	case 8:								\
> +		__asm__ __volatile__ (					\
> +			"amoor.d.aq %1, zero, %0"			\
> +			: "+A" (*p)					\
> +			: "=r" (__u.__val)				\
> +			: "memory");					\
> +		break;							\
> +	}								\
> +	__u.__val;							\
> +} while (0)

'creative' use of amoswap and amoor :-)

You should really look at a normal load with ordering instruction
though, that amoor.aq is a rmw and will promote the cacheline to
exclusive (and dirty it).

> +/*
> + * Simple spin lock operations.  These provide no fairness guarantees.
> + */
> +
> +/* FIXME: Replace this with a ticket lock, like MIPS. */
> +
> +#define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
> +#define arch_spin_is_locked(x)	((x)->lock != 0)
> +#define arch_spin_unlock_wait(x) \
> +		do { cpu_relax(); } while ((x)->lock)
> +
> +static inline void arch_spin_unlock(arch_spinlock_t *lock)
> +{
> +	__asm__ __volatile__ (
> +		"amoswap.w.rl x0, x0, %0"
> +		: "=A" (lock->lock)
> +		:: "memory");
> +}
> +
> +static inline int arch_spin_trylock(arch_spinlock_t *lock)
> +{
> +	int tmp = 1, busy;
> +
> +	__asm__ __volatile__ (
> +		"amoswap.w.aq %0, %2, %1"
> +		: "=r" (busy), "+A" (lock->lock)
> +		: "r" (tmp)
> +		: "memory");
> +
> +	return !busy;
> +}
> +
> +static inline void arch_spin_lock(arch_spinlock_t *lock)
> +{
> +	while (1) {
> +		if (arch_spin_is_locked(lock))
> +			continue;
> +
> +		if (arch_spin_trylock(lock))
> +			break;
> +	}
> +}

OK, so back to smp_mb__{before,after}_spinlock(), that wants to order
things like:

	wakeup:					block:

	COND = 1;				p->state = UNINTERRUPTIBLE;
						smp_mb();
	smp_mb__before_spinlock();
	spin_lock(&lock);			if (!COND)
						  schedule()
	if (p->state & state)
		goto out;


And here it is important that the COND store not happen _after_ the
p->state load.

Now, your spin_lock() only implies the AQ thing, which should only
constraint later load/stores but does nothing for the prior load/stores.
So our COND store can drop into the lock and even happen after the
p->state load.

So you very much want your smp_mb__{before,after}_spinlock thingies to
be full barriers.
