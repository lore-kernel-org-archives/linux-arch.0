Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:39556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbeIQNoc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Sep 2018 09:44:32 -0400
Date: Mon, 17 Sep 2018 10:17:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V3 11/27] csky: Atomic operations
Message-ID: <20180917081755.GO24124@hirez.programming.kicks-ass.net>
References: <cover.1536757532.git.ren_guo@c-sky.com>
 <93e8b592e429c156ad4d4ca5d85ef48fd0ab8b70.1536757532.git.ren_guo@c-sky.com>
 <20180912155514.GV24082@hirez.programming.kicks-ass.net>
 <20180915145512.GA18355@guoren-Inspiron-7460>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180915145512.GA18355@guoren-Inspiron-7460>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, devicetree@vger.kernel.org, andrea.parri@amarulasolutions.com, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
Message-ID: <20180917081755.uyLeiSPbhKa0D2qtWage_UIFso211NNv6qWhuiO4u0c@z>

On Sat, Sep 15, 2018 at 10:55:13PM +0800, Guo Ren wrote:
> > > +#define ATOMIC_OP_RETURN(op, c_op)					\

> > > +#define ATOMIC_FETCH_OP(op, c_op)					\

> > For these you could generate _relaxed variants and not provide smp_mb()
> > inside them.
> Ok, but I'll modify it in next commit.

That's fine. Just wanted to let you know about _relaxed() since it will
benefit your platform.

> > > +#define ATOMIC_OP(op, c_op)						\
> > > +static inline void atomic_##op(int i, atomic_t *v)			\
> > > +{									\
> > > +	unsigned long tmp, flags;					\
> > > +									\
> > > +	raw_local_irq_save(flags);					\
> > > +									\
> > > +	asm volatile (							\
> > > +	"	ldw		%0, (%2) \n"				\
> > > +	"	" #op "		%0, %1   \n"				\
> > > +	"	stw		%0, (%2) \n"				\
> > > +		: "=&r" (tmp)						\
> > > +		: "r" (i), "r"(&v->counter)				\
> > > +		: "memory");						\
> > > +									\
> > > +	raw_local_irq_restore(flags);					\
> > > +}
> > 
> > Is this really 'better' than the generic UP fallback implementation?
> There is a lock irq instruction "idly4" with out irq_save. eg:
> 	asm volatile (							\
> 	"	idly4			 \n"				\
> 	"	ldw		%0, (%2) \n"				\
> 	"	" #op "		%0, %1   \n"				\
> 	"	stw		%0, (%2) \n"				\
> I'll change to that after full tested.

That is pretty nifty, could you explain (or reference me to a arch doc
that does) the exact semantics of that "idly4" instruction?

> > > +static inline void arch_spin_lock(arch_spinlock_t *lock)
> > > +{
> > > +	arch_spinlock_t lockval;
> > > +	u32 ticket_next = 1 << TICKET_NEXT;
> > > +	u32 *p = &lock->lock;
> > > +	u32 tmp;
> > > +
> > > +	smp_mb();
> > 
> > spin_lock() doesn't need smp_mb() before.
> read_lock and write_lock also needn't smp_mb() before, isn't it?

Correct. The various *_lock() functions only need imply an ACQUIRE
barrier, such that the critical section happens after the lock is taken.

> > > +
> > > +static inline void arch_spin_unlock(arch_spinlock_t *lock)
> > > +{
> > > +	smp_mb();
> > > +	lock->tickets.owner++;
> > > +	smp_mb();
> > 
> > spin_unlock() doesn't need smp_mb() after.
> read_unlock and write_unlock also needn't smp_mb() after, isn't it?

Indeed so, the various *_unlock() functions only need imply a RELEASE
barrier, such that the critical section happend before the lock is
released.

In both cases (lock and unlock) there is a great amount of subtle
details, but most of that is irrelevant if all you have is smp_mb().


> > > +/*
> > > + * Test-and-set spin-locking.
> > > + */
> > 
> > Why retain that?
> > 
> > same comments; it has far too many smp_mb()s in.
> I'm not sure about queued_rwlocks and just for 2-cores-smp test-and-set is
> faster and simpler, isn't it?

Even on 2 cores I think you can create starvation cases with
test-and-set spinlocks. And the maintenace overhead of carrying two lock
implementations is non trivial.

As to performance; I cannot say, but the ticket lock isn't very
expensive, you could benchmark of course.
