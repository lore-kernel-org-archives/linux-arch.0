From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 2/9] RISC-V: Atomic and Locking Code
Date: Thu, 06 Jul 2017 18:04:13 -0700 (PDT)
Message-ID: <mhng-c4e3a5d8-59ae-4db5-b6df-2d44fa07e83c@palmer-si-x1c4>
References: <20170705084321.hqy4qsm45mv772k4@hirez.programming.kicks-ass.net>
Mime-Version: 1.0 (MHng)
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35819 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753061AbdGGBEP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2017 21:04:15 -0400
Received: by mail-pf0-f196.google.com with SMTP id q85so2365536pfq.2
        for <linux-arch@vger.kernel.org>; Thu, 06 Jul 2017 18:04:15 -0700 (PDT)
In-Reply-To: <20170705084321.hqy4qsm45mv772k4@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org
Cc: mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com, patches@groups.riscv.org

On Wed, 05 Jul 2017 01:43:21 PDT (-0700), peterz@infradead.org wrote:
> On Tue, Jul 04, 2017 at 12:50:55PM -0700, Palmer Dabbelt wrote:
>> +/*
>> + * FIXME: I could only find documentation that atomic_{add,sub,inc,dec} are
>> + * barrier-free.  I'm assuming that and/or/xor have the same constraints as the
>> + * others.
>> + */
>
> Yes.. we have new documentation in the work to which I would post a link
> but for some reason copy/paste stopped working again (Konsole does that
> at times and is #$%#$%#4# annoying).
>
> Ha, found it using google...
>
>   https://marc.info/?l=linux-kernel&m=149727901125801

Thanks.

>> +/*
>> + * atomic_{cmp,}xchg is required to have exactly the same ordering semantics as
>> + * {cmp,}xchg and the operations that return, so they need a barrier.  We just
>> + * use the other implementations directly.
>> + */
>
> cmpxchg triggers an extra rule; all conditional operations only need to
> imply barriers on success. So a cmpxchg that fails, need not imply any
> ordering what so ever.
>
>> +/*
>> + * Our atomic operations set the AQ and RL bits and therefor we don't need to
>> + * fence around atomics.
>> + */
>> +#define __smb_mb__before_atomic()	barrier()
>> +#define __smb_mb__after_atomic()	barrier()
>
> Ah, not quite... you need full barriers here. Because your regular
> atomic ops imply no ordering what so ever.

The new documentation helps here, too.  Thanks!

  diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
  index 82a0092a86d0..a480c0fb85e5 100644
  --- a/arch/riscv/include/asm/barrier.h
  +++ b/arch/riscv/include/asm/barrier.h
  @@ -39,11 +39,19 @@
   #define smp_wmb()      RISCV_FENCE(w,w)

   /*
  - * Our atomic operations set the AQ and RL bits and therefor we don't need to
  - * fence around atomics.
  + * These fences exist to enforce ordering around the relaxed AMOs.  The
  + * documentation defines that
  + * "
  + *     atomic_fetch_add();
  + *   is equivalent to:
  + *     smp_mb__before_atomic();
  + *     atomic_fetch_add_relaxed();
  + *     smp_mb__after_atomic();
  + * "
  + * So we emit full fences on both sides.
    */
  -#define __smb_mb__before_atomic()      barrier()
  -#define __smb_mb__after_atomic()       barrier()
  +#define __smb_mb__before_atomic()      smp_mb()
  +#define __smb_mb__after_atomic()       smp_mb()

   /*
    * These barries are meant to prevent memory operations inside a spinlock from

>> +/*
>> + * These barries are meant to prevent memory operations inside a spinlock from
>> + * moving outside of that spinlock.  Since we set the AQ and RL bits when
>> + * entering or leaving spinlocks, no additional fence needs to be performed.
>> + */
>> +#define smb_mb__before_spinlock()	barrier()
>> +#define smb_mb__after_spinlock()	barrier()
>
> Also probably not true. I _think_ you want a full barrier here, but
> given the total lack of documentation on your end and the fact I've not
> yet read the spinlock (which I suppose is below) I cannot yet state
> more.

Ya, sorry about that -- we're waiting on a proper memory model spec.  Is there
any other documentation I should produce?

More below.

>> +
>> +/* FIXME: I don't think RISC-V is allowed to perform a speculative load. */
>> +#define smp_acquire__after_ctrl_dep()	barrier()
>
> That would be a very weird thing to disallow... speculative loads are
> teh awesome ;-) Note you can get the very same effect from caches when
> your stores are not globally atomic.

OK -- I guess generally the user ISA spec is written disregarding
microarchitecture, so I assumed this would be illegal.  We'll wait for the
memory model spec.

  diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
  index a4e54f4c17eb..c039333d4a5d 100644
  --- a/arch/riscv/include/asm/barrier.h
  +++ b/arch/riscv/include/asm/barrier.h
  @@ -61,8 +61,12 @@
   #define smb_mb__before_spinlock()      smp_mb()
   #define smb_mb__after_spinlock()       smp_mb()

  -/* FIXME: I don't think RISC-V is allowed to perform a speculative load. */
  -#define smp_acquire__after_ctrl_dep()  barrier()
  +/*
  + * TODO_RISCV_MEMORY_MODEL: I don't think RISC-V is allowed to perform a
  + * speculative load, but we're going to wait on a formal memory model in order
  + * to ensure this is safe to elide.
  + */
  +#define smp_acquire__after_ctrl_dep()  smp_mb()

   /*
    * The RISC-V ISA doesn't support byte or half-word AMOs, so we fall back to a
  @@ -137,24 +141,6 @@
          __u.__val;                                                      \
   })

  -/*
  - * The default implementation of this uses READ_ONCE and
  - * smp_acquire__after_ctrl_dep, but since we can directly do an ACQUIRE load we
  - * can avoid the extra barrier.
  - */
  -#define smp_cond_load_acquire(ptr, cond_expr) ({                       \
  -       typeof(ptr) __PTR = (ptr);                                      \
  -       typeof(*ptr) VAL;                                               \
  -       for (;;) {                                                      \
  -               VAL = __smp_load_acquire(__PTR);                        \
  -               if (cond_expr)                                          \
  -                       break;                                          \
  -               cpu_relax();                                            \
  -       }                                                               \
  -       smp_acquire__after_ctrl_dep();                                  \
  -       VAL;                                                            \
  -})
  -
   #include <asm-generic/barrier.h>

   #endif /* __ASSEMBLY__ */

>> +/*
>> + * The RISC-V ISA doesn't support byte or half-word AMOs, so we fall back to a
>> + * regular store and a fence here.  Otherwise we emit an AMO with an AQ or RL
>> + * bit set and allow the microarchitecture to avoid the other half of the AMO.
>> + */
>> +#define __smp_store_release(p, v)					\
>> +do {									\
>> +	union { typeof(*p) __val; char __c[1]; } __u =			\
>> +		{ .__val = (__force typeof(*p)) (v) };			\
>> +	compiletime_assert_atomic_type(*p);				\
>> +	switch (sizeof(*p)) {						\
>> +	case 1:								\
>> +	case 2:								\
>> +		smb_mb();						\
>> +		WRITE_ONCE(*p, __u.__val);				\
>> +		break;							\
>> +	case 4:								\
>> +		__asm__ __volatile__ (					\
>> +			"amoswap.w.rl zero, %1, %0"			\
>> +			: "+A" (*p), "r" (__u.__val)			\
>> +			: 						\
>> +			: "memory");					\
>> +		break;							\
>> +	case 8:								\
>> +		__asm__ __volatile__ (					\
>> +			"amoswap.d.rl zero, %1, %0"			\
>> +			: "+A" (*p), "r" (__u.__val)			\
>> +			: 						\
>> +			: "memory");					\
>> +		break;							\
>> +	}								\
>> +} while (0)
>> +
>> +#define __smp_load_acquire(p)						\
>> +do {									\
>> +	union { typeof(*p) __val; char __c[1]; } __u =			\
>> +		{ .__val = (__force typeof(*p)) (v) };			\
>> +	compiletime_assert_atomic_type(*p);				\
>> +	switch (sizeof(*p)) {						\
>> +	case 1:								\
>> +	case 2:								\
>> +		__u.__val = READ_ONCE(*p);				\
>> +		smb_mb();						\
>> +		break;							\
>> +	case 4:								\
>> +		__asm__ __volatile__ (					\
>> +			"amoor.w.aq %1, zero, %0"			\
>> +			: "+A" (*p)					\
>> +			: "=r" (__u.__val)				\
>> +			: "memory");					\
>> +		break;							\
>> +	case 8:								\
>> +		__asm__ __volatile__ (					\
>> +			"amoor.d.aq %1, zero, %0"			\
>> +			: "+A" (*p)					\
>> +			: "=r" (__u.__val)				\
>> +			: "memory");					\
>> +		break;							\
>> +	}								\
>> +	__u.__val;							\
>> +} while (0)
>
> 'creative' use of amoswap and amoor :-)
>
> You should really look at a normal load with ordering instruction
> though, that amoor.aq is a rmw and will promote the cacheline to
> exclusive (and dirty it).

The thought here was that implementations could elide the MW by pattern
matching the "zero" (x0, the architectural zero register) forms of AMOs where
it's interesting.  I talked to one of our microarchitecture guys, and while he
agrees that's easy he points out that eliding half the AMO may wreak havoc on
the consistency model.  Since we're not sure what the memory model is actually
going to look like, we thought it'd be best to just write the simplest code
here

  /*
   * TODO_RISCV_MEMORY_MODEL: While we could emit AMOs for the W and D sized
   * accesses here, it's questionable if that actually helps or not: the lack of
   * offsets in the AMOs means they're usually preceded by an addi, so they
   * probably won't save code space.  For now we'll just emit the fence.
   */
  #define __smp_store_release(p, v)                                       \
  ({                                                                      \
          compiletime_assert_atomic_type(*p);                             \
          smp_mb();                                                       \
          WRITE_ONCE(*p, v);                                              \
  })

  #define __smp_load_acquire(p)                                           \
  ({                                                                      \
          union{typeof(*p) __p; long __l;} __u;                           \
          compiletime_assert_atomic_type(*p);                             \
          __u.__l = READ_ONCE(*p);                                        \
          smp_mb();                                                       \
          __u.__p;                                                        \
  })

>> +/*
>> + * Simple spin lock operations.  These provide no fairness guarantees.
>> + */
>> +
>> +/* FIXME: Replace this with a ticket lock, like MIPS. */
>> +
>> +#define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
>> +#define arch_spin_is_locked(x)	((x)->lock != 0)
>> +#define arch_spin_unlock_wait(x) \
>> +		do { cpu_relax(); } while ((x)->lock)
>> +
>> +static inline void arch_spin_unlock(arch_spinlock_t *lock)
>> +{
>> +	__asm__ __volatile__ (
>> +		"amoswap.w.rl x0, x0, %0"
>> +		: "=A" (lock->lock)
>> +		:: "memory");
>> +}
>> +
>> +static inline int arch_spin_trylock(arch_spinlock_t *lock)
>> +{
>> +	int tmp = 1, busy;
>> +
>> +	__asm__ __volatile__ (
>> +		"amoswap.w.aq %0, %2, %1"
>> +		: "=r" (busy), "+A" (lock->lock)
>> +		: "r" (tmp)
>> +		: "memory");
>> +
>> +	return !busy;
>> +}
>> +
>> +static inline void arch_spin_lock(arch_spinlock_t *lock)
>> +{
>> +	while (1) {
>> +		if (arch_spin_is_locked(lock))
>> +			continue;
>> +
>> +		if (arch_spin_trylock(lock))
>> +			break;
>> +	}
>> +}
>
> OK, so back to smp_mb__{before,after}_spinlock(), that wants to order
> things like:
>
> 	wakeup:					block:
>
> 	COND = 1;				p->state = UNINTERRUPTIBLE;
> 						smp_mb();
> 	smp_mb__before_spinlock();
> 	spin_lock(&lock);			if (!COND)
> 						  schedule()
> 	if (p->state & state)
> 		goto out;
>
>
> And here it is important that the COND store not happen _after_ the
> p->state load.
>
> Now, your spin_lock() only implies the AQ thing, which should only
> constraint later load/stores but does nothing for the prior load/stores.
> So our COND store can drop into the lock and even happen after the
> p->state load.
>
> So you very much want your smp_mb__{before,after}_spinlock thingies to
> be full barriers.

OK, thanks!  I just had the movement direction backwards.  This makes much more
sense.

  diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
  index a480c0fb85e5..a4e54f4c17eb 100644
  --- a/arch/riscv/include/asm/barrier.h
  +++ b/arch/riscv/include/asm/barrier.h
  @@ -54,12 +54,12 @@
   #define __smb_mb__after_atomic()       smp_mb()

   /*
  - * These barries are meant to prevent memory operations inside a spinlock from
  - * moving outside of that spinlock.  Since we set the AQ and RL bits when
  - * entering or leaving spinlocks, no additional fence needs to be performed.
  + * These barries prevent accesses performed outside a spinlock from being moved
  + * inside a spinlock.  Since RISC-V sets the aq/rl bits on our spinlock only
  + * enforce release consistency, we need full fences here.
    */
  -#define smb_mb__before_spinlock()      barrier()
  -#define smb_mb__after_spinlock()       barrier()
  +#define smb_mb__before_spinlock()      smp_mb()
  +#define smb_mb__after_spinlock()       smp_mb()

   /* FIXME: I don't think RISC-V is allowed to perform a speculative load. */
   #define smp_acquire__after_ctrl_dep()  barrier()

Thanks for all the help!
