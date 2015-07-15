From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Wed, 15 Jul 2015 11:51:35 +0100
Message-ID: <20150715105135.GE1005@arm.com>
References: <20150713202032.GZ3717@linux.vnet.ibm.com>
 <20150713222346.GE19282@twins.programming.kicks-ass.net>
 <20150713230405.GB3717@linux.vnet.ibm.com>
 <20150714100429.GC15448@arm.com>
 <20150714124540.GC3717@linux.vnet.ibm.com>
 <20150714125146.GJ16213@arm.com>
 <20150714140014.GD3717@linux.vnet.ibm.com>
 <20150714141202.GN16213@arm.com>
 <20150714193144.GP3717@linux.vnet.ibm.com>
 <20150715013820.GA21971@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150715013820.GA21971@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-arch.vger.kernel.org

Hi Paul,

On Wed, Jul 15, 2015 at 02:38:20AM +0100, Paul E. McKenney wrote:
> On Tue, Jul 14, 2015 at 12:31:44PM -0700, Paul E. McKenney wrote:
> > On Tue, Jul 14, 2015 at 03:12:16PM +0100, Will Deacon wrote:
> > > On Tue, Jul 14, 2015 at 03:00:14PM +0100, Paul E. McKenney wrote:
> > > > On Tue, Jul 14, 2015 at 01:51:46PM +0100, Will Deacon wrote:
> > > > > On Tue, Jul 14, 2015 at 01:45:40PM +0100, Paul E. McKenney wrote:
> > > > > > On Tue, Jul 14, 2015 at 11:04:29AM +0100, Will Deacon wrote:
> > > > > > > Given that RCU is currently the only user of this barrier, how would you
> > > > > > > feel about making the barrier local to RCU and not part of the general
> > > > > > > memory-barrier API?
> > > > > > 
> > > > > > In theory, no objection.  Your thought is to leave the definitions where
> > > > > > they are, mark them as being used only by RCU, and removing mention from
> > > > > > memory-barriers.txt?  Or did you have something else in mind?
> > > > > 
> > > > > Actually, I was thinking of defining them in an RCU header file with an
> > > > > #ifdef CONFIG_POWERPC for the smb_mb() version. Then you could have a big
> > > > > comment describing the semantics, or put that in an RCU Documentation file
> > > > > instead of memory-barriers.txt.
> > > > > 
> > > > > That *should* then mean we notice anybody else trying to use the barrier,
> > > > > because they'd need to send patches to either add something equivalent
> > > > > or move the definition out again.
> > > > 
> > > > My concern with this approach is that someone putting together a new
> > > > architecture might miss this.  That said, this approach certainly would
> > > > work for the current architectures.
> > > 
> > > I don't think they're any more likely to miss it than with the current
> > > situation where the generic code defines the macro as a NOP unless you
> > > explicitly override it.
> > 
> > Fair enough...
> 
> Like this?

Precisely! Thanks for cooking the patch -- this lays all my worries to
rest, so:

  Acked-by: Will Deacon <will.deacon@arm.com>

We should continue the discussion with Ben and Michael about whether or
not the PowerPC locking code can be strengthened, though (making this
barrier a NOP on all currently supported archs).

Will

> commit 695c05d4b9666c50b40a1c022678b5f6e2e3e771
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Tue Jul 14 18:35:23 2015 -0700
> 
>     rcu,locking: Privatize smp_mb__after_unlock_lock()
>     
>     RCU is the only thing that uses smp_mb__after_unlock_lock(), and is
>     likely the only thing that ever will use it, so this commit makes this
>     macro private to RCU.
>     
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>     Cc: Will Deacon <will.deacon@arm.com>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>     Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 318523872db5..eafa6a53f72c 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1854,16 +1854,10 @@ RELEASE are to the same lock variable, but only from the perspective of
>  another CPU not holding that lock.  In short, a ACQUIRE followed by an
>  RELEASE may -not- be assumed to be a full memory barrier.
>  
> -Similarly, the reverse case of a RELEASE followed by an ACQUIRE does not
> -imply a full memory barrier.  If it is necessary for a RELEASE-ACQUIRE
> -pair to produce a full barrier, the ACQUIRE can be followed by an
> -smp_mb__after_unlock_lock() invocation.  This will produce a full barrier
> -(including transitivity) if either (a) the RELEASE and the ACQUIRE are
> -executed by the same CPU or task, or (b) the RELEASE and ACQUIRE act on
> -the same variable.  The smp_mb__after_unlock_lock() primitive is free
> -on many architectures.  Without smp_mb__after_unlock_lock(), the CPU's
> -execution of the critical sections corresponding to the RELEASE and the
> -ACQUIRE can cross, so that:
> +Similarly, the reverse case of a RELEASE followed by an ACQUIRE does
> +not imply a full memory barrier.  Therefore, the CPU's execution of the
> +critical sections corresponding to the RELEASE and the ACQUIRE can cross,
> +so that:
>  
>  	*A = a;
>  	RELEASE M
> @@ -1901,29 +1895,6 @@ the RELEASE would simply complete, thereby avoiding the deadlock.
>  	a sleep-unlock race, but the locking primitive needs to resolve
>  	such races properly in any case.
>  
> -With smp_mb__after_unlock_lock(), the two critical sections cannot overlap.
> -For example, with the following code, the store to *A will always be
> -seen by other CPUs before the store to *B:
> -
> -	*A = a;
> -	RELEASE M
> -	ACQUIRE N
> -	smp_mb__after_unlock_lock();
> -	*B = b;
> -
> -The operations will always occur in one of the following orders:
> -
> -	STORE *A, RELEASE, ACQUIRE, smp_mb__after_unlock_lock(), STORE *B
> -	STORE *A, ACQUIRE, RELEASE, smp_mb__after_unlock_lock(), STORE *B
> -	ACQUIRE, STORE *A, RELEASE, smp_mb__after_unlock_lock(), STORE *B
> -
> -If the RELEASE and ACQUIRE were instead both operating on the same lock
> -variable, only the first of these alternatives can occur.  In addition,
> -the more strongly ordered systems may rule out some of the above orders.
> -But in any case, as noted earlier, the smp_mb__after_unlock_lock()
> -ensures that the store to *A will always be seen as happening before
> -the store to *B.
> -
>  Locks and semaphores may not provide any guarantee of ordering on UP compiled
>  systems, and so cannot be counted on in such a situation to actually achieve
>  anything at all - especially with respect to I/O accesses - unless combined
> @@ -2154,40 +2125,6 @@ But it won't see any of:
>  	*E, *F or *G following RELEASE Q
>  
>  
> -However, if the following occurs:
> -
> -	CPU 1				CPU 2
> -	===============================	===============================
> -	WRITE_ONCE(*A, a);
> -	ACQUIRE M		     [1]
> -	WRITE_ONCE(*B, b);
> -	WRITE_ONCE(*C, c);
> -	RELEASE M	     [1]
> -	WRITE_ONCE(*D, d);		WRITE_ONCE(*E, e);
> -					ACQUIRE M		     [2]
> -					smp_mb__after_unlock_lock();
> -					WRITE_ONCE(*F, f);
> -					WRITE_ONCE(*G, g);
> -					RELEASE M	     [2]
> -					WRITE_ONCE(*H, h);
> -
> -CPU 3 might see:
> -
> -	*E, ACQUIRE M [1], *C, *B, *A, RELEASE M [1],
> -		ACQUIRE M [2], *H, *F, *G, RELEASE M [2], *D
> -
> -But assuming CPU 1 gets the lock first, CPU 3 won't see any of:
> -
> -	*B, *C, *D, *F, *G or *H preceding ACQUIRE M [1]
> -	*A, *B or *C following RELEASE M [1]
> -	*F, *G or *H preceding ACQUIRE M [2]
> -	*A, *B, *C, *E, *F or *G following RELEASE M [2]
> -
> -Note that the smp_mb__after_unlock_lock() is critically important
> -here: Without it CPU 3 might see some of the above orderings.
> -Without smp_mb__after_unlock_lock(), the accesses are not guaranteed
> -to be seen in order unless CPU 3 holds lock M.
> -
>  
>  ACQUIRES VS I/O ACCESSES
>  ------------------------
> diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
> index 4dbe072eecbe..523673d7583c 100644
> --- a/arch/powerpc/include/asm/spinlock.h
> +++ b/arch/powerpc/include/asm/spinlock.h
> @@ -28,8 +28,6 @@
>  #include <asm/synch.h>
>  #include <asm/ppc-opcode.h>
>  
> -#define smp_mb__after_unlock_lock()	smp_mb()  /* Full ordering for lock. */
> -
>  #ifdef CONFIG_PPC64
>  /* use 0x800000yy when locked, where yy == CPU number */
>  #ifdef __BIG_ENDIAN__
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 80d974df0ea0..a9fea7395ba2 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -645,3 +645,15 @@ static inline void rcu_nocb_q_lengths(struct rcu_data *rdp, long *ql, long *qll)
>  #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
>  }
>  #endif /* #ifdef CONFIG_RCU_TRACE */
> +
> +/*
> + * Place this after a lock-acquisition primitive to guarantee that
> + * an UNLOCK+LOCK pair act as a full barrier.  This guarantee applies
> + * if the UNLOCK and LOCK are executed by the same CPU or if the
> + * UNLOCK and LOCK operate on the same lock variable.
> + */
> +#ifdef CONFIG_PPC
> +#define smp_mb__after_unlock_lock()	smp_mb()  /* Full ordering for lock. */
> +#else /* #ifdef CONFIG_PPC */
> +#define smp_mb__after_unlock_lock()	do { } while (0)
> +#endif /* #else #ifdef CONFIG_PPC */
> 
