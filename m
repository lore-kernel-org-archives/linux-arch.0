From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 4/4] arch: Introduce smp_load_acquire(),
 smp_store_release()
Date: Mon, 16 Dec 2013 16:40:04 +0000
Message-ID: <20131216164002.GF20193@mudshark.cambridge.arm.com>
References: <20131213145657.265414969@infradead.org>
 <20131213150640.908486364@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:63591 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754819Ab3LPQkH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 16 Dec 2013 11:40:07 -0500
Content-Disposition: inline
In-Reply-To: <20131213150640.908486364@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kerne.org" <linux-kernel@vger.kerne.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "VICTORK@il.ibm.com" <VICTORK@il.ibm.com>, "oleg@redhat.com" <oleg@redhat.com>, "anton@samba.org" <anton@samba.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "mathieu.desnoyers@polymtl.ca" <mathieu.desnoyers@polymtl.ca>, "michael@ellerman.id.au" <michael@ellerman.id.au>, "mikey@neuling.org" <mikey@neuling.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "tony.luck@intel.com" <tony.luck@intel.com>

Hi Peter,

On Fri, Dec 13, 2013 at 02:57:01PM +0000, Peter Zijlstra wrote:
> A number of situations currently require the heavyweight smp_mb(),
> even though there is no need to order prior stores against later
> loads.  Many architectures have much cheaper ways to handle these
> situations, but the Linux kernel currently has no portable way
> to make use of them.
> 
> This commit therefore supplies smp_load_acquire() and
> smp_store_release() to remedy this situation.  The new
> smp_load_acquire() primitive orders the specified load against
> any subsequent reads or writes, while the new smp_store_release()
> primitive orders the specifed store against any prior reads or
> writes.  These primitives allow array-based circular FIFOs to be
> implemented without an smp_mb(), and also allow a theoretical
> hole in rcu_assign_pointer() to be closed at no additional
> expense on most architectures.
> 
> In addition, the RCU experience transitioning from explicit
> smp_read_barrier_depends() and smp_wmb() to rcu_dereference()
> and rcu_assign_pointer(), respectively resulted in substantial
> improvements in readability.  It therefore seems likely that
> replacing other explicit barriers with smp_load_acquire() and
> smp_store_release() will provide similar benefits.  It appears
> that roughly half of the explicit barriers in core kernel code
> might be so replaced.

[...]

For arm/arm64:

  Acked-by: Will Deacon <will.deacon@arm.com>

A couple of other comments:

> --- a/arch/ia64/include/asm/barrier.h
> +++ b/arch/ia64/include/asm/barrier.h
> @@ -45,14 +45,37 @@
>  # define smp_rmb()     rmb()
>  # define smp_wmb()     wmb()
>  # define smp_read_barrier_depends()    read_barrier_depends()
> +
>  #else
> +
>  # define smp_mb()      barrier()
>  # define smp_rmb()     barrier()
>  # define smp_wmb()     barrier()
>  # define smp_read_barrier_depends()    do { } while(0)
> +
>  #endif
> 
>  /*
> + * IA64 GCC turns volatile stores into st.rel and volatile loads into ld.acq no
> + * need for asm trickery!
> + */
> +
> +#define smp_store_release(p, v)                                                \
> +do {                                                                   \
> +       compiletime_assert_atomic_type(*p);                             \
> +       barrier();                                                      \
> +       ACCESS_ONCE(*p) = (v);                                          \
> +} while (0)
> +
> +#define smp_load_acquire(p)                                            \
> +({                                                                     \
> +       typeof(*p) ___p1 = ACCESS_ONCE(*p);                             \
> +       compiletime_assert_atomic_type(*p);                             \
> +       barrier();                                                      \
> +       ___p1;                                                          \
> +})
> +
> +/*
>   * XXX check on this ---I suspect what Linus really wants here is
>   * acquire vs release semantics but we can't discuss this stuff with
>   * Linus just yet.  Grrr...

I guess you can remove this comment now?

> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -298,6 +298,11 @@ void ftrace_likely_update(struct ftrace_
>  # define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>  #endif
> 
> +/* Is this type a native word size -- useful for atomic operations */
> +#ifndef __native_word
> +# define __native_word(t) (sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
> +#endif
> +
>  /* Compile time object size, -1 for unknown */
>  #ifndef __compiletime_object_size
>  # define __compiletime_object_size(obj) -1
> @@ -337,6 +342,10 @@ void ftrace_likely_update(struct ftrace_
>  #define compiletime_assert(condition, msg) \
>         _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
> 
> +#define compiletime_assert_atomic_type(t)                              \
> +       compiletime_assert(__native_word(t),                            \
> +               "Need native word sized stores/loads for atomicity.")
> +

At least for ARM, it's not so much the type that cause issues with
atomicity, but whether or not its naturally aligned, which we don't check
here...

Will
