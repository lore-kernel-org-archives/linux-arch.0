From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 3/4] arch: Introduce smp_load_acquire(),
 smp_store_release()
Date: Fri, 8 Nov 2013 10:29:35 +0000 (UTC)
Message-ID: <79126955.63024.1383906575089.JavaMail.zimbra@efficios.com>
References: <20131108062703.GC2693@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([78.47.125.74]:59584 "EHLO mail.efficios.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757091Ab3KHK3e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Nov 2013 05:29:34 -0500
In-Reply-To: <20131108062703.GC2693@Krystal>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org
Cc: linux-arch@vger.kernel.org, geert@linux-m68k.org, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, VICTORK@il.ibm.com, oleg@redhat.com, anton@samba.org, benh@kernel.crashing.org, fweisbec@gmail.com, michael@ellerman.id.au, mikey@neuling.org, linux@arm.linux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, tony.luck@intel.com, Will Deacon <will.deacon@arm.com>

(forwarded due to SMTP issues)

----- Forwarded Message -----
> From: "Mathieu Desnoyers" <compudj@krystal.dyndns.org>
> To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Sent: Friday, November 8, 2013 1:27:03 AM
> Subject: (forw) [mathieu.desnoyers@polymtl.ca: Re: [PATCH 3/4] arch: Introduce smp_load_acquire(),
> smp_store_release()]
> 
> ----- Forwarded message from Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> -----
> 
> Date: Thu, 7 Nov 2013 16:03:20 -0500
> To: peterz@infradead.org
> Cc: linux-arch@vger.kernel.org, geert@linux-m68k.org,
> paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org,
> VICTORK@il.ibm.com, oleg@redhat.com, anton@samba.org,
> 	benh@kernel.crashing.org, fweisbec@gmail.com, michael@ellerman.id.au,
> 	mikey@neuling.org, linux@arm.linux.org.uk, schwidefsky@de.ibm.com,
> 	heiko.carstens@de.ibm.com, tony.luck@intel.com, Will Deacon
> 	<will.deacon@arm.com>
> User-Agent: Mutt/1.5.21 (2010-09-15)
> From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> Subject: Re: [PATCH 3/4] arch: Introduce smp_load_acquire(),
> smp_store_release()
> 
> * peterz@infradead.org (peterz@infradead.org) wrote:
> > A number of situations currently require the heavyweight smp_mb(),
> > even though there is no need to order prior stores against later
> > loads.  Many architectures have much cheaper ways to handle these
> > situations, but the Linux kernel currently has no portable way
> > to make use of them.
> > 
> > This commit therefore supplies smp_load_acquire() and
> > smp_store_release() to remedy this situation.  The new
> > smp_load_acquire() primitive orders the specified load against
> > any subsequent reads or writes, while the new smp_store_release()
> > primitive orders the specifed store against any prior reads or
> > writes.  These primitives allow array-based circular FIFOs to be
> > implemented without an smp_mb(), and also allow a theoretical
> > hole in rcu_assign_pointer() to be closed at no additional
> > expense on most architectures.
> > 
> > In addition, the RCU experience transitioning from explicit
> > smp_read_barrier_depends() and smp_wmb() to rcu_dereference()
> > and rcu_assign_pointer(), respectively resulted in substantial
> > improvements in readability.  It therefore seems likely that
> > replacing other explicit barriers with smp_load_acquire() and
> > smp_store_release() will provide similar benefits.  It appears
> > that roughly half of the explicit barriers in core kernel code
> > might be so replaced.
> > 
> > [Changelog by PaulMck]
> > 
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Frederic Weisbecker <fweisbec@gmail.com>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> > Cc: Michael Ellerman <michael@ellerman.id.au>
> > Cc: Michael Neuling <mikey@neuling.org>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Cc: Victor Kaplansky <VICTORK@il.ibm.com>
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > Reviewed-by: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> > ---
> >  arch/arm/include/asm/barrier.h      |   15 ++++++++++
> >  arch/arm64/include/asm/barrier.h    |   50
> >  ++++++++++++++++++++++++++++++++++++
> >  arch/ia64/include/asm/barrier.h     |   49
> >  +++++++++++++++++++++++++++++++++++
> >  arch/metag/include/asm/barrier.h    |   15 ++++++++++
> >  arch/mips/include/asm/barrier.h     |   15 ++++++++++
> >  arch/powerpc/include/asm/barrier.h  |   21 ++++++++++++++-
> >  arch/s390/include/asm/barrier.h     |   15 ++++++++++
> >  arch/sparc/include/asm/barrier_64.h |   15 ++++++++++
> >  arch/x86/include/asm/barrier.h      |   15 ++++++++++
> >  include/asm-generic/barrier.h       |   15 ++++++++++
> >  include/linux/compiler.h            |    9 ++++++
> >  11 files changed, 233 insertions(+), 1 deletion(-)
> > 
> > Index: linux-2.6/arch/arm/include/asm/barrier.h
> > ===================================================================
> > --- linux-2.6.orig/arch/arm/include/asm/barrier.h	2013-11-07
> > 17:36:09.105170623 +0100
> > +++ linux-2.6/arch/arm/include/asm/barrier.h	2013-11-07 17:36:09.097170473
> > +0100
> > @@ -59,6 +59,21 @@
> >  #define smp_wmb()	dmb(ishst)
> >  #endif
> >  
> > +#define smp_store_release(p, v)						\
> > +do {									\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	smp_mb();							\
> > +	ACCESS_ONCE(*p) = (v);						\
> > +} while (0)
> > +
> > +#define smp_load_acquire(p)						\
> > +({									\
> > +	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	smp_mb();							\
> > +	___p1;								\
> > +})
> 
> Can you move those "generic" definitions into asm-generic/barrier.h
> under an ifdef guard ?
> 
> The pattern using "smp_mb()" seems to be the right target for a generic
> implementation.
> 
> We should probably document the requirements on sizeof(*p) and
> alignof(*p) directly above the macro definition.
> 
> > +
> >  #define read_barrier_depends()		do { } while(0)
> >  #define smp_read_barrier_depends()	do { } while(0)
> >  
> > Index: linux-2.6/arch/arm64/include/asm/barrier.h
> > ===================================================================
> > --- linux-2.6.orig/arch/arm64/include/asm/barrier.h	2013-11-07
> > 17:36:09.105170623 +0100
> > +++ linux-2.6/arch/arm64/include/asm/barrier.h	2013-11-07
> > 17:36:09.098170492 +0100
> > @@ -35,10 +35,60 @@
> >  #define smp_mb()	barrier()
> >  #define smp_rmb()	barrier()
> >  #define smp_wmb()	barrier()
> > +
> > +#define smp_store_release(p, v)						\
> > +do {									\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	smp_mb();							\
> > +	ACCESS_ONCE(*p) = (v);						\
> > +} while (0)
> > +
> > +#define smp_load_acquire(p)						\
> > +({									\
> > +	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	smp_mb();							\
> > +	___p1;								\
> > +})
> > +
> >  #else
> > +
> >  #define smp_mb()	asm volatile("dmb ish" : : : "memory")
> >  #define smp_rmb()	asm volatile("dmb ishld" : : : "memory")
> >  #define smp_wmb()	asm volatile("dmb ishst" : : : "memory")
> > +
> > +#define smp_store_release(p, v)						\
> > +do {									\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	switch (sizeof(*p)) {						\
> > +	case 4:								\
> > +		asm volatile ("stlr %w1, %0"				\
> > +				: "=Q" (*p) : "r" (v) : "memory");	\
> > +		break;							\
> > +	case 8:								\
> > +		asm volatile ("stlr %1, %0"				\
> > +				: "=Q" (*p) : "r" (v) : "memory");	\
> > +		break;							\
> > +	}								\
> > +} while (0)
> > +
> > +#define smp_load_acquire(p)						\
> > +({									\
> > +	typeof(*p) ___p1;						\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	switch (sizeof(*p)) {						\
> > +	case 4:								\
> > +		asm volatile ("ldar %w0, %1"				\
> > +			: "=r" (___p1) : "Q" (*p) : "memory");		\
> > +		break;							\
> > +	case 8:								\
> > +		asm volatile ("ldar %0, %1"				\
> > +			: "=r" (___p1) : "Q" (*p) : "memory");		\
> > +		break;							\
> > +	}								\
> > +	___p1;								\
> > +})
> > +
> >  #endif
> >  
> >  #define read_barrier_depends()		do { } while(0)
> > Index: linux-2.6/arch/ia64/include/asm/barrier.h
> > ===================================================================
> > --- linux-2.6.orig/arch/ia64/include/asm/barrier.h	2013-11-07
> > 17:36:09.105170623 +0100
> > +++ linux-2.6/arch/ia64/include/asm/barrier.h	2013-11-07 17:36:09.098170492
> > +0100
> > @@ -45,11 +45,60 @@
> >  # define smp_rmb()	rmb()
> >  # define smp_wmb()	wmb()
> >  # define smp_read_barrier_depends()	read_barrier_depends()
> > +
> > +#define smp_store_release(p, v)						\
> > +do {									\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	switch (sizeof(*p)) {						\
> > +	case 4:								\
> > +		asm volatile ("st4.rel [%0]=%1"				\
> > +				: "=r" (p) : "r" (v) : "memory");	\
> > +		break;							\
> > +	case 8:								\
> > +		asm volatile ("st8.rel [%0]=%1"				\
> > +				: "=r" (p) : "r" (v) : "memory");	\
> > +		break;							\
> > +	}								\
> > +} while (0)
> > +
> > +#define smp_load_acquire(p)						\
> > +({									\
> > +	typeof(*p) ___p1;						\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	switch (sizeof(*p)) {						\
> > +	case 4:								\
> > +		asm volatile ("ld4.acq %0=[%1]"				\
> > +				: "=r" (___p1) : "r" (p) : "memory");	\
> > +		break;							\
> > +	case 8:								\
> > +		asm volatile ("ld8.acq %0=[%1]"				\
> > +				: "=r" (___p1) : "r" (p) : "memory");	\
> > +		break;							\
> > +	}								\
> > +	___p1;								\
> > +})
> > +
> >  #else
> > +
> >  # define smp_mb()	barrier()
> >  # define smp_rmb()	barrier()
> >  # define smp_wmb()	barrier()
> >  # define smp_read_barrier_depends()	do { } while(0)
> > +
> > +#define smp_store_release(p, v)						\
> > +do {									\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	smp_mb();							\
> > +	ACCESS_ONCE(*p) = (v);						\
> > +} while (0)
> > +
> > +#define smp_load_acquire(p)						\
> > +({									\
> > +	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	smp_mb();							\
> > +	___p1;								\
> > +})
> >  #endif
> >  
> >  /*
> > Index: linux-2.6/arch/metag/include/asm/barrier.h
> > ===================================================================
> > --- linux-2.6.orig/arch/metag/include/asm/barrier.h	2013-11-07
> > 17:36:09.105170623 +0100
> > +++ linux-2.6/arch/metag/include/asm/barrier.h	2013-11-07
> > 17:36:09.099170511 +0100
> > @@ -82,4 +82,19 @@
> >  #define smp_read_barrier_depends()     do { } while (0)
> >  #define set_mb(var, value) do { var = value; smp_mb(); } while (0)
> >  
> > +#define smp_store_release(p, v)						\
> > +do {									\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	smp_mb();							\
> > +	ACCESS_ONCE(*p) = (v);						\
> > +} while (0)
> > +
> > +#define smp_load_acquire(p)						\
> > +({									\
> > +	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	smp_mb();							\
> > +	___p1;								\
> > +})
> > +
> >  #endif /* _ASM_METAG_BARRIER_H */
> > Index: linux-2.6/arch/mips/include/asm/barrier.h
> > ===================================================================
> > --- linux-2.6.orig/arch/mips/include/asm/barrier.h	2013-11-07
> > 17:36:09.105170623 +0100
> > +++ linux-2.6/arch/mips/include/asm/barrier.h	2013-11-07 17:36:09.099170511
> > +0100
> > @@ -180,4 +180,19 @@
> >  #define nudge_writes() mb()
> >  #endif
> >  
> > +#define smp_store_release(p, v)						\
> > +do {									\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	smp_mb();							\
> > +	ACCESS_ONCE(*p) = (v);						\
> > +} while (0)
> > +
> > +#define smp_load_acquire(p)						\
> > +({									\
> > +	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	smp_mb();							\
> > +	___p1;								\
> > +})
> > +
> >  #endif /* __ASM_BARRIER_H */
> > Index: linux-2.6/arch/powerpc/include/asm/barrier.h
> > ===================================================================
> > --- linux-2.6.orig/arch/powerpc/include/asm/barrier.h	2013-11-07
> > 17:36:09.105170623 +0100
> > +++ linux-2.6/arch/powerpc/include/asm/barrier.h	2013-11-07
> > 17:36:09.100170529 +0100
> > @@ -45,11 +45,15 @@
> >  #    define SMPWMB      eieio
> >  #endif
> >  
> > +#define __lwsync()	__asm__ __volatile__ (stringify_in_c(LWSYNC) : :
> > :"memory")
> > +
> >  #define smp_mb()	mb()
> > -#define smp_rmb()	__asm__ __volatile__ (stringify_in_c(LWSYNC) : :
> > :"memory")
> > +#define smp_rmb()	__lwsync()
> >  #define smp_wmb()	__asm__ __volatile__ (stringify_in_c(SMPWMB) : :
> >  :"memory")
> >  #define smp_read_barrier_depends()	read_barrier_depends()
> >  #else
> > +#define __lwsync()	barrier()
> > +
> >  #define smp_mb()	barrier()
> >  #define smp_rmb()	barrier()
> >  #define smp_wmb()	barrier()
> > @@ -65,4 +69,19 @@
> >  #define data_barrier(x)	\
> >  	asm volatile("twi 0,%0,0; isync" : : "r" (x) : "memory");
> >  
> > +#define smp_store_release(p, v)						\
> > +do {									\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	__lwsync();							\
> 
> Even though this is correct, it appears to bear more overhead than
> necessary. See arch/powerpc/include/asm/synch.h
> 
> PPC_ACQUIRE_BARRIER and PPC_RELEASE_BARRIER
> 
> You'll notice that some variants of powerpc require something more
> heavy-weight than a lwsync instruction. The fallback will be "isync"
> rather than "sync" if you use PPC_ACQUIRE_BARRIER and
> PPC_RELEASE_BARRIER rather than LWSYNC directly.
> 
> > +	ACCESS_ONCE(*p) = (v);						\
> > +} while (0)
> > +
> > +#define smp_load_acquire(p)						\
> > +({									\
> > +	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	__lwsync();							\
> > +	___p1;								\
> > +})
> > +
> >  #endif /* _ASM_POWERPC_BARRIER_H */
> > Index: linux-2.6/arch/s390/include/asm/barrier.h
> > ===================================================================
> > --- linux-2.6.orig/arch/s390/include/asm/barrier.h	2013-11-07
> > 17:36:09.105170623 +0100
> > +++ linux-2.6/arch/s390/include/asm/barrier.h	2013-11-07 17:36:09.100170529
> > +0100
> > @@ -32,4 +32,19 @@
> >  
> >  #define set_mb(var, value)		do { var = value; mb(); } while (0)
> >  
> > +#define smp_store_release(p, v)						\
> > +do {									\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	barrier();							\
> > +	ACCESS_ONCE(*p) = (v);						\
> > +} while (0)
> > +
> > +#define smp_load_acquire(p)						\
> > +({									\
> > +	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	barrier();							\
> > +	___p1;								\
> > +})
> > +
> >  #endif /* __ASM_BARRIER_H */
> > Index: linux-2.6/arch/sparc/include/asm/barrier_64.h
> > ===================================================================
> > --- linux-2.6.orig/arch/sparc/include/asm/barrier_64.h	2013-11-07
> > 17:36:09.105170623 +0100
> > +++ linux-2.6/arch/sparc/include/asm/barrier_64.h	2013-11-07
> > 17:36:09.101170548 +0100
> > @@ -53,4 +53,19 @@
> >  
> >  #define smp_read_barrier_depends()	do { } while(0)
> >  
> > +#define smp_store_release(p, v)						\
> > +do {									\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	barrier();							\
> > +	ACCESS_ONCE(*p) = (v);						\
> > +} while (0)
> > +
> > +#define smp_load_acquire(p)						\
> > +({									\
> > +	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	barrier();							\
> > +	___p1;								\
> > +})
> > +
> >  #endif /* !(__SPARC64_BARRIER_H) */
> > Index: linux-2.6/arch/x86/include/asm/barrier.h
> > ===================================================================
> > --- linux-2.6.orig/arch/x86/include/asm/barrier.h	2013-11-07
> > 17:36:09.105170623 +0100
> > +++ linux-2.6/arch/x86/include/asm/barrier.h	2013-11-07 22:23:46.097491898
> > +0100
> > @@ -92,12 +92,53 @@
> >  #endif
> >  #define smp_read_barrier_depends()	read_barrier_depends()
> >  #define set_mb(var, value) do { (void)xchg(&var, value); } while (0)
> > -#else
> > +#else /* !SMP */
> >  #define smp_mb()	barrier()
> >  #define smp_rmb()	barrier()
> >  #define smp_wmb()	barrier()
> >  #define smp_read_barrier_depends()	do { } while (0)
> >  #define set_mb(var, value) do { var = value; barrier(); } while (0)
> > +#endif /* SMP */
> > +
> > +#if defined(CONFIG_X86_OOSTORE) || defined(CONFIG_X86_PPRO_FENCE)
> > +
> > +/*
> > + * For either of these options x86 doesn't have a strong TSO memory
> > + * model and we should fall back to full barriers.
> > + */
> > +
> > +#define smp_store_release(p, v)						\
> > +do {									\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	smp_mb();							\
> > +	ACCESS_ONCE(*p) = (v);						\
> > +} while (0)
> > +
> > +#define smp_load_acquire(p)						\
> > +({									\
> > +	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	smp_mb();							\
> > +	___p1;								\
> > +})
> > +
> > +#else /* regular x86 TSO memory ordering */
> > +
> > +#define smp_store_release(p, v)						\
> > +do {									\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	barrier();							\
> > +	ACCESS_ONCE(*p) = (v);						\
> > +} while (0)
> > +
> > +#define smp_load_acquire(p)						\
> > +({									\
> > +	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	barrier();							\
> > +	___p1;								\
> > +})
> 
> Hrm, I really don't get the two barrier() above.
> 
> On x86, in a standard lock, we can get away with having surrounding
> memory barriers defined as compiler barrier() because the LOCK prefix of
> the atomic instructions taking and releasing the lock are implicit full
> memory barriers.
> 
> Understandably, TSO allows you to remove write barriers. However, AFAIU,
> the smp_store_release()/smp_load_acquire() semantics provides ordering
> guarantees for both loads and stores with respect to the
> store_release/load_acquire operations. I don't see how the simple
> compiler barrier() here conveys this.
> 
> Unless what you really mean is that the smp_load_acquire() only provides
> ordering guarantees of following loads with respect to the load_acquire,
> and that smp_store_release() only provides ordering guarantees of prior
> writes before the store_release ? If this is the case, then I think the
> names chosen are too short and don't convey that:
> 
> a) those are load and store operations,
> b) those have an acquire/release semantic which scope only targets,
>    respectively, other load and store operations.
> 
> Maybe the following names would be clearer ?
> 
>   smp_store_release_wmb(p, v)
>   smp_load_acquire_rmb(p)
> 
> Or maybe we just need to document really well what's the semantic of a
> store_release and load_acquire.
> 
> Furthermore, I don't see how a simple compiler barrier() can provide the
> acquire semantic within smp_load_acquire on x86 TSO. AFAIU, a smp_rmb()
> might be needed.
> 
> > +
> >  #endif
> >  
> >  /*
> > Index: linux-2.6/include/asm-generic/barrier.h
> > ===================================================================
> > --- linux-2.6.orig/include/asm-generic/barrier.h	2013-11-07
> > 17:36:09.105170623 +0100
> > +++ linux-2.6/include/asm-generic/barrier.h	2013-11-07 17:36:09.102170567
> > +0100
> > @@ -62,5 +62,20 @@
> >  #define set_mb(var, value)  do { (var) = (value); mb(); } while (0)
> >  #endif
> >  
> > +#define smp_store_release(p, v)						\
> > +do {									\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	smp_mb();							\
> > +	ACCESS_ONCE(*p) = (v);						\
> > +} while (0)
> > +
> > +#define smp_load_acquire(p)						\
> > +({									\
> > +	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	smp_mb();							\
> > +	___p1;								\
> > +})
> > +
> >  #endif /* !__ASSEMBLY__ */
> >  #endif /* __ASM_GENERIC_BARRIER_H */
> > Index: linux-2.6/include/linux/compiler.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/compiler.h	2013-11-07 17:36:09.105170623
> > +0100
> > +++ linux-2.6/include/linux/compiler.h	2013-11-07 17:36:09.102170567 +0100
> > @@ -298,6 +298,11 @@
> >  # define __same_type(a, b) __builtin_types_compatible_p(typeof(a),
> >  typeof(b))
> >  #endif
> >  
> > +/* Is this type a native word size -- useful for atomic operations */
> > +#ifndef __native_word
> > +# define __native_word(t) (sizeof(t) == sizeof(int) || sizeof(t) ==
> > sizeof(long))
> > +#endif
> 
> Should we also check the pointer alignment, or that would be going too
> far ?
> 
> Thanks,
> 
> Mathieu
> 
> > +
> >  /* Compile time object size, -1 for unknown */
> >  #ifndef __compiletime_object_size
> >  # define __compiletime_object_size(obj) -1
> > @@ -337,6 +342,10 @@
> >  #define compiletime_assert(condition, msg) \
> >  	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
> >  
> > +#define compiletime_assert_atomic_type(t)				\
> > +	compiletime_assert(__native_word(t),				\
> > +		"Need native word sized stores/loads for atomicity.")
> > +
> >  /*
> >   * Prevent the compiler from merging or refetching accesses.  The compiler
> >   * is also forbidden from reordering successive instances of
> >   ACCESS_ONCE(),
> > 
> > 
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
> ----- End forwarded message -----
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
