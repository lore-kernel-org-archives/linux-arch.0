From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] barriers: introduce smp_mb__release_acquire and update
 documentation
Date: Tue, 15 Sep 2015 10:47:24 -0700
Message-ID: <20150915174724.GP4029@linux.vnet.ibm.com>
References: <1442333610-16228-1-git-send-email-will.deacon@arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:36357 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbbIORr2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Sep 2015 13:47:28 -0400
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 15 Sep 2015 11:47:28 -0600
Content-Disposition: inline
In-Reply-To: <1442333610-16228-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>

On Tue, Sep 15, 2015 at 05:13:30PM +0100, Will Deacon wrote:
> As much as we'd like to live in a world where RELEASE -> ACQUIRE is
> always cheaply ordered and can be used to construct UNLOCK -> LOCK
> definitions with similar guarantees, the grim reality is that this isn't
> even possible on x86 (thanks to Paul for bringing us crashing down to
> Earth).

"It is a service that I provide."  ;-)

> This patch handles the issue by introducing a new barrier macro,
> smp_mb__release_acquire, that can be placed between a RELEASE and a
> subsequent ACQUIRE operation in order to upgrade them to a full memory
> barrier. At the moment, it doesn't have any users, so its existence
> serves mainly as a documentation aid.
> 
> Documentation/memory-barriers.txt is updated to describe more clearly
> the ACQUIRE and RELEASE ordering in this area and to show an example of
> the new barrier in action.
> 
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Some questions and comments below.

							Thanx, Paul

> ---
> 
> Following our discussion at [1], I thought I'd try to write something
> down...
> 
> [1] http://lkml.kernel.org/r/20150828104854.GB16853@twins.programming.kicks-ass.net
> 
>  Documentation/memory-barriers.txt  | 23 ++++++++++++++++++++++-
>  arch/powerpc/include/asm/barrier.h |  1 +
>  arch/x86/include/asm/barrier.h     |  2 ++
>  include/asm-generic/barrier.h      |  4 ++++
>  4 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 2ba8461b0631..46a85abb77c6 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -459,11 +459,18 @@ And a couple of implicit varieties:
>       RELEASE on that same variable are guaranteed to be visible.  In other
>       words, within a given variable's critical section, all accesses of all
>       previous critical sections for that variable are guaranteed to have
> -     completed.
> +     completed.  If the RELEASE and ACQUIRE operations act on independent
> +     variables, an smp_mb__release_acquire() barrier can be placed between
> +     them to upgrade the sequence to a full barrier.
> 
>       This means that ACQUIRE acts as a minimal "acquire" operation and
>       RELEASE acts as a minimal "release" operation.
> 
> +A subset of the atomic operations described in atomic_ops.txt have ACQUIRE
> +and RELEASE variants in addition to fully-ordered and relaxed definitions.
> +For compound atomics performing both a load and a store, ACQUIRE semantics
> +apply only to the load and RELEASE semantics only to the store portion of
> +the operation.
> 
>  Memory barriers are only required where there's a possibility of interaction
>  between two CPUs or between a CPU and a device.  If it can be guaranteed that
> @@ -1895,6 +1902,20 @@ the RELEASE would simply complete, thereby avoiding the deadlock.
>  	a sleep-unlock race, but the locking primitive needs to resolve
>  	such races properly in any case.
> 
> +If necessary, ordering can be enforced by use of an
> +smp_mb__release_acquire() barrier:
> +
> +	*A = a;
> +	RELEASE M
> +	smp_mb__release_acquire();
> +	ACQUIRE N
> +	*B = b;
> +
> +in which case, the only permitted sequences are:
> +
> +	STORE *A, RELEASE M, ACQUIRE N, STORE *B
> +	STORE *A, ACQUIRE N, RELEASE M, STORE *B
> +
>  Locks and semaphores may not provide any guarantee of ordering on UP compiled
>  systems, and so cannot be counted on in such a situation to actually achieve
>  anything at all - especially with respect to I/O accesses - unless combined
> diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
> index 0eca6efc0631..919624634d0a 100644
> --- a/arch/powerpc/include/asm/barrier.h
> +++ b/arch/powerpc/include/asm/barrier.h
> @@ -87,6 +87,7 @@ do {									\
>  	___p1;								\
>  })
> 
> +#define smp_mb__release_acquire()   smp_mb()

If we are handling locking the same as atomic acquire and release
operations, this could also be placed between the unlock and the lock.

However, independently of the unlock/lock case, this definition and
use of smp_mb__release_acquire() does not handle full ordering of a
release by one CPU and an acquire of that same variable by another.
In that case, we need roughly the same setup as the much-maligned
smp_mb__after_unlock_lock().  So, do we care about this case?  (RCU does,
though not 100% sure about any other subsystems.)

>  #define smp_mb__before_atomic()     smp_mb()
>  #define smp_mb__after_atomic()      smp_mb()
>  #define smp_mb__before_spinlock()   smp_mb()
> diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
> index 0681d2532527..1c61ad251e0e 100644
> --- a/arch/x86/include/asm/barrier.h
> +++ b/arch/x86/include/asm/barrier.h
> @@ -85,6 +85,8 @@ do {									\
>  	___p1;								\
>  })
> 
> +#define smp_mb__release_acquire()	smp_mb()
> +
>  #endif
> 
>  /* Atomic operations are already serializing on x86 */
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index b42afada1280..61ae95199397 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -119,5 +119,9 @@ do {									\
>  	___p1;								\
>  })
> 
> +#ifndef smp_mb__release_acquire
> +#define smp_mb__release_acquire()	do { } while (0)

Doesn't this need to be barrier() in the case where one variable was
released and another was acquired?

> +#endif
> +
>  #endif /* !__ASSEMBLY__ */
>  #endif /* __ASM_GENERIC_BARRIER_H */
> -- 
> 2.1.4
> 
