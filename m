From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/9] RISC-V: Atomic and Locking Code
Date: Fri, 7 Jul 2017 10:08:19 +0200
Message-ID: <20170707080819.krtmzeqlyrl6c35p@hirez.programming.kicks-ass.net>
References: <20170705084321.hqy4qsm45mv772k4@hirez.programming.kicks-ass.net>
 <mhng-c4e3a5d8-59ae-4db5-b6df-2d44fa07e83c@palmer-si-x1c4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <mhng-c4e3a5d8-59ae-4db5-b6df-2d44fa07e83c@palmer-si-x1c4>
Sender: linux-kernel-owner@vger.kernel.org
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com, patches@groups.riscv.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 06, 2017 at 06:04:13PM -0700, Palmer Dabbelt wrote:
> > Also probably not true. I _think_ you want a full barrier here, but
> > given the total lack of documentation on your end and the fact I've not
> > yet read the spinlock (which I suppose is below) I cannot yet state
> > more.
> 
> Ya, sorry about that -- we're waiting on a proper memory model spec.  Is there
> any other documentation I should produce?

Nah, I'll wait for your shiny new document.


>   +/*
>   + * TODO_RISCV_MEMORY_MODEL: I don't think RISC-V is allowed to perform a
>   + * speculative load, but we're going to wait on a formal memory model in order
>   + * to ensure this is safe to elide.
>   + */
>   +#define smp_acquire__after_ctrl_dep()  smp_mb()

So typically a control dependency already provides read->write ordering,
by virtue of speculative writes being BAD.

So a control dependency only needs to provide read->read ordering in
addition to the existing read->write ordering and hence this barrier is
typically a smp_rmb().

See the definition in asm-generic/barrier.h.

Having to use a full barrier here would imply your architecture does not
respect control dependencies, which would be BAD because we actually
rely on them.

So either the normal definition is good and you don't need to do
anything, or you prohibit read speculation in which case you have a
special case like TILE does.



> >> +#define __smp_load_acquire(p)						\
> >> +do {									\
> >> +	union { typeof(*p) __val; char __c[1]; } __u =			\
> >> +		{ .__val = (__force typeof(*p)) (v) };			\
> >> +	compiletime_assert_atomic_type(*p);				\
> >> +	switch (sizeof(*p)) {						\
> >> +	case 1:								\
> >> +	case 2:								\
> >> +		__u.__val = READ_ONCE(*p);				\
> >> +		smb_mb();						\
> >> +		break;							\
> >> +	case 4:								\
> >> +		__asm__ __volatile__ (					\
> >> +			"amoor.w.aq %1, zero, %0"			\
> >> +			: "+A" (*p)					\
> >> +			: "=r" (__u.__val)				\
> >> +			: "memory");					\
> >> +		break;							\
> >> +	case 8:								\
> >> +		__asm__ __volatile__ (					\
> >> +			"amoor.d.aq %1, zero, %0"			\
> >> +			: "+A" (*p)					\
> >> +			: "=r" (__u.__val)				\
> >> +			: "memory");					\
> >> +		break;							\
> >> +	}								\
> >> +	__u.__val;							\
> >> +} while (0)
> >
> > 'creative' use of amoswap and amoor :-)
> >
> > You should really look at a normal load with ordering instruction
> > though, that amoor.aq is a rmw and will promote the cacheline to
> > exclusive (and dirty it).
> 
> The thought here was that implementations could elide the MW by pattern
> matching the "zero" (x0, the architectural zero register) forms of AMOs where
> it's interesting.  I talked to one of our microarchitecture guys, and while he
> agrees that's easy he points out that eliding half the AMO may wreak havoc on
> the consistency model.  Since we're not sure what the memory model is actually
> going to look like, we thought it'd be best to just write the simplest code
> here
> 
>   /*
>    * TODO_RISCV_MEMORY_MODEL: While we could emit AMOs for the W and D sized
>    * accesses here, it's questionable if that actually helps or not: the lack of
>    * offsets in the AMOs means they're usually preceded by an addi, so they
>    * probably won't save code space.  For now we'll just emit the fence.
>    */
>   #define __smp_store_release(p, v)                                       \
>   ({                                                                      \
>           compiletime_assert_atomic_type(*p);                             \
>           smp_mb();                                                       \
>           WRITE_ONCE(*p, v);                                              \
>   })
> 
>   #define __smp_load_acquire(p)                                           \
>   ({                                                                      \
>           union{typeof(*p) __p; long __l;} __u;                           \
>           compiletime_assert_atomic_type(*p);                             \
>           __u.__l = READ_ONCE(*p);                                        \
>           smp_mb();                                                       \
>           __u.__p;                                                        \
>   })

Fair enough, that works.

> > OK, so back to smp_mb__{before,after}_spinlock(), that wants to order
> > things like:
> >
> > 	wakeup:					block:
> >
> > 	COND = 1;				p->state = UNINTERRUPTIBLE;
> > 						smp_mb();
> > 	smp_mb__before_spinlock();
> > 	spin_lock(&lock);			if (!COND)
> > 						  schedule()
> > 	if (p->state & state)
> > 		goto out;
> >
> >
> > And here it is important that the COND store not happen _after_ the
> > p->state load.
> >
> > Now, your spin_lock() only implies the AQ thing, which should only
> > constraint later load/stores but does nothing for the prior load/stores.
> > So our COND store can drop into the lock and even happen after the
> > p->state load.
> >
> > So you very much want your smp_mb__{before,after}_spinlock thingies to
> > be full barriers.
> 
> OK, thanks!  I just had the movement direction backwards.  This makes much more
> sense.
> 
>   diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
>   index a480c0fb85e5..a4e54f4c17eb 100644
>   --- a/arch/riscv/include/asm/barrier.h
>   +++ b/arch/riscv/include/asm/barrier.h
>   @@ -54,12 +54,12 @@
>    #define __smb_mb__after_atomic()       smp_mb()
> 
>    /*
>   - * These barries are meant to prevent memory operations inside a spinlock from
>   - * moving outside of that spinlock.  Since we set the AQ and RL bits when
>   - * entering or leaving spinlocks, no additional fence needs to be performed.
>   + * These barries prevent accesses performed outside a spinlock from being moved
>   + * inside a spinlock.  Since RISC-V sets the aq/rl bits on our spinlock only
>   + * enforce release consistency, we need full fences here.
>     */
>   -#define smb_mb__before_spinlock()      barrier()
>   -#define smb_mb__after_spinlock()       barrier()
>   +#define smb_mb__before_spinlock()      smp_mb()
>   +#define smb_mb__after_spinlock()       smp_mb()
> 

Most excellent. Thanks!
