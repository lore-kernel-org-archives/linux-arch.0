From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/4] arch: Introduce smp_load_acquire(),
 smp_store_release()
Date: Tue, 17 Dec 2013 10:07:46 +0100
Message-ID: <20131217090746.GA21999@twins.programming.kicks-ass.net>
References: <20131213145657.265414969@infradead.org>
 <20131213150640.908486364@infradead.org>
 <20131216164002.GF20193@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:36184 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab3LQJI3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Dec 2013 04:08:29 -0500
Content-Disposition: inline
In-Reply-To: <20131216164002.GF20193@mudshark.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kerne.org" <linux-kernel@vger.kerne.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "VICTORK@il.ibm.com" <VICTORK@il.ibm.com>, "oleg@redhat.com" <oleg@redhat.com>, "anton@samba.org" <anton@samba.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "mathieu.desnoyers@polymtl.ca" <mathieu.desnoyers@polymtl.ca>, "michael@ellerman.id.au" <michael@ellerman.id.au>, "mikey@neuling.org" <mikey@neuling.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "tony.luck@intel.com" <tony.luck@intel.com>

On Mon, Dec 16, 2013 at 04:40:04PM +0000, Will Deacon wrote:
> > --- a/arch/ia64/include/asm/barrier.h
> > +++ b/arch/ia64/include/asm/barrier.h
> > @@ -45,14 +45,37 @@
> >  # define smp_rmb()     rmb()
> >  # define smp_wmb()     wmb()
> >  # define smp_read_barrier_depends()    read_barrier_depends()
> > +
> >  #else
> > +
> >  # define smp_mb()      barrier()
> >  # define smp_rmb()     barrier()
> >  # define smp_wmb()     barrier()
> >  # define smp_read_barrier_depends()    do { } while(0)
> > +
> >  #endif
> > 
> >  /*
> > + * IA64 GCC turns volatile stores into st.rel and volatile loads into ld.acq no
> > + * need for asm trickery!
> > + */
> > +
> > +#define smp_store_release(p, v)                                                \
> > +do {                                                                   \
> > +       compiletime_assert_atomic_type(*p);                             \
> > +       barrier();                                                      \
> > +       ACCESS_ONCE(*p) = (v);                                          \
> > +} while (0)
> > +
> > +#define smp_load_acquire(p)                                            \
> > +({                                                                     \
> > +       typeof(*p) ___p1 = ACCESS_ONCE(*p);                             \
> > +       compiletime_assert_atomic_type(*p);                             \
> > +       barrier();                                                      \
> > +       ___p1;                                                          \
> > +})
> > +
> > +/*
> >   * XXX check on this ---I suspect what Linus really wants here is
> >   * acquire vs release semantics but we can't discuss this stuff with
> >   * Linus just yet.  Grrr...
> 
> I guess you can remove this comment now?

I suppose so, but I'll leave that up to the ia64 people.. The comment
relates to set_mb() and that hasn't actually changed.

> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -298,6 +298,11 @@ void ftrace_likely_update(struct ftrace_
> >  # define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
> >  #endif
> > 
> > +/* Is this type a native word size -- useful for atomic operations */
> > +#ifndef __native_word
> > +# define __native_word(t) (sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
> > +#endif
> > +
> >  /* Compile time object size, -1 for unknown */
> >  #ifndef __compiletime_object_size
> >  # define __compiletime_object_size(obj) -1
> > @@ -337,6 +342,10 @@ void ftrace_likely_update(struct ftrace_
> >  #define compiletime_assert(condition, msg) \
> >         _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
> > 
> > +#define compiletime_assert_atomic_type(t)                              \
> > +       compiletime_assert(__native_word(t),                            \
> > +               "Need native word sized stores/loads for atomicity.")
> > +
> 
> At least for ARM, it's not so much the type that cause issues with
> atomicity, but whether or not its naturally aligned, which we don't check
> here...

Yeah I know, but you actually need to do weird things to get unaligned
pointers. Also, I'm fairly sure ARM will fail a 20 byte store-release so
the size check isn't entirely pointless.

I suppose if anybody really cares you can have some DEBUG symbol
dependent alignment check in there, but it will generate extra code.
