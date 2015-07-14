From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/5] atomics: add acquire/release/relaxed variants of
 some atomic operations
Date: Tue, 14 Jul 2015 11:32:20 +0100
Message-ID: <20150714103220.GB16213@arm.com>
References: <1436790687-11984-1-git-send-email-will.deacon@arm.com>
 <1436790687-11984-2-git-send-email-will.deacon@arm.com>
 <20150714102511.GI19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33546 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753600AbbGNKcY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Jul 2015 06:32:24 -0400
Content-Disposition: inline
In-Reply-To: <20150714102511.GI19282@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Waiman.Long@hp.com" <Waiman.Long@hp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>

On Tue, Jul 14, 2015 at 11:25:11AM +0100, Peter Zijlstra wrote:
> On Mon, Jul 13, 2015 at 01:31:23PM +0100, Will Deacon wrote:
> > +
> > +/*
> > + * Relaxed variants of xchg, cmpxchg and some atomic operations.
> > + *
> > + * We support four variants:
> > + *
> > + * - Fully ordered: The default implementation, no suffix required.
> > + * - Acquire: Provides ACQUIRE semantics, _acquire suffix.
> > + * - Release: Provides RELEASE semantics, _release suffix.
> > + * - Relaxed: No ordering guarantees, _relaxed suffix.
> > + *
> > + * See Documentation/memory-barriers.txt for ACQUIRE/RELEASE definitions.
> > + */
> > +
> > +#ifndef atomic_read_acquire
> > +#define  atomic_read_acquire(v)		smp_load_acquire(&(v)->counter)
> > +#endif
> > +
> > +#ifndef atomic_set_release
> > +#define  atomic_set_release(v, i)	smp_store_release(&(v)->counter, (i))
> > +#endif
> > +
> > +#ifndef atomic_add_return_relaxed
> > +#define  atomic_add_return_relaxed	atomic_add_return
> > +#endif
> > +#ifndef atomic_add_return_acquire
> > +#define  atomic_add_return_acquire	atomic_add_return
> > +#endif
> > +#ifndef atomic_add_return_release
> > +#define  atomic_add_return_release	atomic_add_return
> > +#endif
> 
> Could we not define _{acquire,release} in terms of _relaxed and
> smp_mb__{after,before}_atomic() ?

I actually started out with that, but it penalises architectures that
don't have _relaxed implementations of some routines.

For example, cmpxchg_acquire would likely expand to:

	cmpxchg_relaxed(); smp_mb__after_atomic();
->	cmpxchg(); smp_mb__after_atomic();
->	smp_mb(); __cmpxchg(); __smp_mb(); smp_mb();

(where __cmpxchg() is some arch-internal cmpxchg implementation)

Will
