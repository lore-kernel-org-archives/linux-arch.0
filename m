From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V3 11/27] csky: Atomic operations
Date: Mon, 17 Sep 2018 23:05:32 +0800
Message-ID: <20180917150532.GC2612@guoren-Inspiron-7460>
References: <cover.1536757532.git.ren_guo@c-sky.com>
 <93e8b592e429c156ad4d4ca5d85ef48fd0ab8b70.1536757532.git.ren_guo@c-sky.com>
 <20180912155514.GV24082@hirez.programming.kicks-ass.net>
 <20180915145512.GA18355@guoren-Inspiron-7460>
 <20180917081755.GO24124@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180917081755.GO24124@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, devicetree@vger.kernel.org, andrea.parri@amarulasolutions.com, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

On Mon, Sep 17, 2018 at 10:17:55AM +0200, Peter Zijlstra wrote:
> On Sat, Sep 15, 2018 at 10:55:13PM +0800, Guo Ren wrote:
> > > > +#define ATOMIC_OP_RETURN(op, c_op)					\
> 
> > > > +#define ATOMIC_FETCH_OP(op, c_op)					\
> 
> > > For these you could generate _relaxed variants and not provide smp_mb()
> > > inside them.
> > Ok, but I'll modify it in next commit.
> 
> That's fine. Just wanted to let you know about _relaxed() since it will
> benefit your platform.
Thank you.

> > > > +#define ATOMIC_OP(op, c_op)						\
> > > > +static inline void atomic_##op(int i, atomic_t *v)			\
> > > > +{									\
> > > > +	unsigned long tmp, flags;					\
> > > > +									\
> > > > +	raw_local_irq_save(flags);					\
> > > > +									\
> > > > +	asm volatile (							\
> > > > +	"	ldw		%0, (%2) \n"				\
> > > > +	"	" #op "		%0, %1   \n"				\
> > > > +	"	stw		%0, (%2) \n"				\
> > > > +		: "=&r" (tmp)						\
> > > > +		: "r" (i), "r"(&v->counter)				\
> > > > +		: "memory");						\
> > > > +									\
> > > > +	raw_local_irq_restore(flags);					\
> > > > +}
> > > 
> > > Is this really 'better' than the generic UP fallback implementation?
> > There is a lock irq instruction "idly4" with out irq_save. eg:
> > 	asm volatile (							\
> > 	"	idly4			 \n"				\
> > 	"	ldw		%0, (%2) \n"				\
> > 	"	" #op "		%0, %1   \n"				\
> > 	"	stw		%0, (%2) \n"				\
> > I'll change to that after full tested.
> 
> That is pretty nifty, could you explain (or reference me to a arch doc
> that does) the exact semantics of that "idly4" instruction?
The idly4 allows the 4 instructions behind it to not respond to interrupts.
When ldw got exception, it will cause the carry to be 1. So I need
prepare the assemble like this:
1:	cmpne r0, r0
	idly4
	ldw	%0, (%2)
	bt	1b
	" #op " ...
	stw ...

I need more stress test on it and then I'll change to it.

> > > > +static inline void arch_spin_lock(arch_spinlock_t *lock)
> > > > +{
> > > > +	arch_spinlock_t lockval;
> > > > +	u32 ticket_next = 1 << TICKET_NEXT;
> > > > +	u32 *p = &lock->lock;
> > > > +	u32 tmp;
> > > > +
> > > > +	smp_mb();
> > > 
> > > spin_lock() doesn't need smp_mb() before.
> > read_lock and write_lock also needn't smp_mb() before, isn't it?
> 
> Correct. The various *_lock() functions only need imply an ACQUIRE
> barrier, such that the critical section happens after the lock is taken.
> 
> > > > +
> > > > +static inline void arch_spin_unlock(arch_spinlock_t *lock)
> > > > +{
> > > > +	smp_mb();
> > > > +	lock->tickets.owner++;
> > > > +	smp_mb();
> > > 
> > > spin_unlock() doesn't need smp_mb() after.
> > read_unlock and write_unlock also needn't smp_mb() after, isn't it?
> 
> Indeed so, the various *_unlock() functions only need imply a RELEASE
> barrier, such that the critical section happend before the lock is
> released.
> 
> In both cases (lock and unlock) there is a great amount of subtle
> details, but most of that is irrelevant if all you have is smp_mb().
Got it, Thx for the explanation.

> 
> 
> > > > +/*
> > > > + * Test-and-set spin-locking.
> > > > + */
> > > 
> > > Why retain that?
> > > 
> > > same comments; it has far too many smp_mb()s in.
> > I'm not sure about queued_rwlocks and just for 2-cores-smp test-and-set is
> > faster and simpler, isn't it?
> 
> Even on 2 cores I think you can create starvation cases with
> test-and-set spinlocks. And the maintenace overhead of carrying two lock
> implementations is non trivial.
> 
> As to performance; I cannot say, but the ticket lock isn't very
> expensive, you could benchmark of course.
Ticket lock is good.
But How about queued_rwlocks v.s my_test_set_rwlock?
I'm not sure about the queued_rwlocks. I just implement the ticket-spinlock.

Best Regards
 Guo Ren
