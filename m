From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V3 11/27] csky: Atomic operations
Date: Sat, 15 Sep 2018 22:55:13 +0800
Message-ID: <20180915145512.GA18355@guoren-Inspiron-7460>
References: <cover.1536757532.git.ren_guo@c-sky.com>
 <93e8b592e429c156ad4d4ca5d85ef48fd0ab8b70.1536757532.git.ren_guo@c-sky.com>
 <20180912155514.GV24082@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180912155514.GV24082@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, devicetree@vger.kernel.org, andrea.parri@amarulasolutions.com, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

Thx for the review, that's very helpful.

On Wed, Sep 12, 2018 at 05:55:14PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 12, 2018 at 09:24:45PM +0800, Guo Ren wrote:
> 
> > +#define ATOMIC_OP(op, c_op)						\
> > +static inline void atomic_##op(int i, atomic_t *v)			\
> > +{									\
> > +	unsigned long tmp;						\
> > +									\
> > +	smp_mb();							\
> > +	asm volatile (							\
> > +	"1:	ldex.w		%0, (%2) \n"				\
> > +	"	" #op "		%0, %1   \n"				\
> > +	"	stex.w		%0, (%2) \n"				\
> > +	"	bez		%0, 1b   \n"				\
> > +		: "=&r" (tmp)						\
> > +		: "r" (i), "r"(&v->counter)				\
> > +		: "memory");						\
> > +	smp_mb();							\
> > +}
> 
> ATOMIC_OP doesn't need to imply any smp_mb()'s what so ever.
Ok.

> > +#define ATOMIC_OP_RETURN(op, c_op)					\
> > +static inline int atomic_##op##_return(int i, atomic_t *v)		\
> > +{									\
> > +	unsigned long tmp, ret;						\
> > +									\
> > +	smp_mb();							\
> > +	asm volatile (							\
> > +	"1:	ldex.w		%0, (%3) \n"				\
> > +	"	" #op "		%0, %2   \n"				\
> > +	"	mov		%1, %0   \n"				\
> > +	"	stex.w		%0, (%3) \n"				\
> > +	"	bez		%0, 1b   \n"				\
> > +		: "=&r" (tmp), "=&r" (ret)				\
> > +		: "r" (i), "r"(&v->counter)				\
> > +		: "memory");						\
> > +	smp_mb();							\
> > +									\
> > +	return ret;							\
> > +}
> > +
> > +#define ATOMIC_FETCH_OP(op, c_op)					\
> > +static inline int atomic_fetch_##op(int i, atomic_t *v)			\
> > +{									\
> > +	unsigned long tmp, ret;						\
> > +									\
> > +	smp_mb();							\
> > +	asm volatile (							\
> > +	"1:	ldex.w		%0, (%3) \n"				\
> > +	"	mov		%1, %0   \n"				\
> > +	"	" #op "		%0, %2   \n"				\
> > +	"	stex.w		%0, (%3) \n"				\
> > +	"	bez		%0, 1b   \n"				\
> > +		: "=&r" (tmp), "=&r" (ret)				\
> > +		: "r" (i), "r"(&v->counter)				\
> > +		: "memory");						\
> > +	smp_mb();							\
> > +									\
> > +	return ret;							\
> > +}
> 
> For these you could generate _relaxed variants and not provide smp_mb()
> inside them.
Ok, but I'll modify it in next commit.
 
> > +#else /* CONFIG_CPU_HAS_LDSTEX */
> > +
> > +#include <linux/irqflags.h>
> > +
> 
> > +#define ATOMIC_OP(op, c_op)						\
> > +static inline void atomic_##op(int i, atomic_t *v)			\
> > +{									\
> > +	unsigned long tmp, flags;					\
> > +									\
> > +	raw_local_irq_save(flags);					\
> > +									\
> > +	asm volatile (							\
> > +	"	ldw		%0, (%2) \n"				\
> > +	"	" #op "		%0, %1   \n"				\
> > +	"	stw		%0, (%2) \n"				\
> > +		: "=&r" (tmp)						\
> > +		: "r" (i), "r"(&v->counter)				\
> > +		: "memory");						\
> > +									\
> > +	raw_local_irq_restore(flags);					\
> > +}
> 
> Is this really 'better' than the generic UP fallback implementation?
There is a lock irq instruction "idly4" with out irq_save. eg:
	asm volatile (							\
	"	idly4			 \n"				\
	"	ldw		%0, (%2) \n"				\
	"	" #op "		%0, %1   \n"				\
	"	stw		%0, (%2) \n"				\
I'll change to that after full tested.

> > +static inline void arch_spin_lock(arch_spinlock_t *lock)
> > +{
> > +	arch_spinlock_t lockval;
> > +	u32 ticket_next = 1 << TICKET_NEXT;
> > +	u32 *p = &lock->lock;
> > +	u32 tmp;
> > +
> > +	smp_mb();
> 
> spin_lock() doesn't need smp_mb() before.
read_lock and write_lock also needn't smp_mb() before, isn't it?

> > +
> > +static inline void arch_spin_unlock(arch_spinlock_t *lock)
> > +{
> > +	smp_mb();
> > +	lock->tickets.owner++;
> > +	smp_mb();
> 
> spin_unlock() doesn't need smp_mb() after.
read_unlock and write_unlock also needn't smp_mb() after, isn't it?

> > +#else /* CONFIG_QUEUED_RWLOCKS */
> > +
> > +/*
> > + * Test-and-set spin-locking.
> > + */
> 
> Why retain that?
> 
> same comments; it has far too many smp_mb()s in.
I'm not sure about queued_rwlocks and just for 2-cores-smp test-and-set is
faster and simpler, isn't it?

Best Regards
 Guo Ren
