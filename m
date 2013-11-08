From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/4] arch: Introduce smp_load_acquire(),
 smp_store_release()
Date: Fri, 8 Nov 2013 12:08:18 +0100
Message-ID: <20131108110818.GI19203@twins.programming.kicks-ass.net>
References: <20131108062703.GC2693@Krystal>
 <79126955.63024.1383906575089.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:48161 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab3KHLIm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2013 06:08:42 -0500
Content-Disposition: inline
In-Reply-To: <79126955.63024.1383906575089.JavaMail.zimbra@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-arch@vger.kernel.org, geert@linux-m68k.org, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, VICTORK@il.ibm.com, oleg@redhat.com, anton@samba.org, benh@kernel.crashing.org, fweisbec@gmail.com, michael@ellerman.id.au, mikey@neuling.org, linux@arm.linux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, tony.luck@intel.com, Will Deacon <will.deacon@arm.com>

On Fri, Nov 08, 2013 at 10:29:35AM +0000, Mathieu Desnoyers wrote:
> > > +#define smp_store_release(p, v)						\
> > > +do {									\
> > > +	compiletime_assert_atomic_type(*p);				\
> > > +	smp_mb();							\
> > > +	ACCESS_ONCE(*p) = (v);						\
> > > +} while (0)
> > > +
> > > +#define smp_load_acquire(p)						\
> > > +({									\
> > > +	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
> > > +	compiletime_assert_atomic_type(*p);				\
> > > +	smp_mb();							\
> > > +	___p1;								\
> > > +})
> > 
> > Can you move those "generic" definitions into asm-generic/barrier.h
> > under an ifdef guard ?
> > 
> > The pattern using "smp_mb()" seems to be the right target for a generic
> > implementation.
> > 
> > We should probably document the requirements on sizeof(*p) and
> > alignof(*p) directly above the macro definition.

So that is the one in asm-generic; its just that some archs have a
rather complex barrier.h and I didn't want to include asm-generic header
to make it still worse. Better to then keep everything in a single file
and suffer a little duplication.

> > > +#define smp_store_release(p, v)						\
> > > +do {									\
> > > +	compiletime_assert_atomic_type(*p);				\
> > > +	__lwsync();							\
> > 
> > Even though this is correct, it appears to bear more overhead than
> > necessary. See arch/powerpc/include/asm/synch.h
> > 
> > PPC_ACQUIRE_BARRIER and PPC_RELEASE_BARRIER
> > 
> > You'll notice that some variants of powerpc require something more
> > heavy-weight than a lwsync instruction. The fallback will be "isync"
> > rather than "sync" if you use PPC_ACQUIRE_BARRIER and
> > PPC_RELEASE_BARRIER rather than LWSYNC directly.

I think Paul answered this.

> > > +#else /* regular x86 TSO memory ordering */
> > > +
> > > +#define smp_store_release(p, v)						\
> > > +do {									\
> > > +	compiletime_assert_atomic_type(*p);				\
> > > +	barrier();							\
> > > +	ACCESS_ONCE(*p) = (v);						\
> > > +} while (0)
> > > +
> > > +#define smp_load_acquire(p)						\
> > > +({									\
> > > +	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
> > > +	compiletime_assert_atomic_type(*p);				\
> > > +	barrier();							\
> > > +	___p1;								\
> > > +})
> > 
> > Hrm, I really don't get the two barrier() above.
> > 
> > Or maybe we just need to document really well what's the semantic of a
> > store_release and load_acquire.

Hence the first patch; they provide the full ACQUIRE and RELEASE
semantics.

> > Furthermore, I don't see how a simple compiler barrier() can provide the
> > acquire semantic within smp_load_acquire on x86 TSO. AFAIU, a smp_rmb()
> > might be needed.

I think the other Paul answered this one on how the TSO memory model
provides all the required semantics.

> > > +/* Is this type a native word size -- useful for atomic operations */
> > > +#ifndef __native_word
> > > +# define __native_word(t) (sizeof(t) == sizeof(int) || sizeof(t) ==
> > > sizeof(long))
> > > +#endif
> > 
> > Should we also check the pointer alignment, or that would be going too
> > far ?

I did consider that, but pointer alignment tests turn into code so I
left those out.
