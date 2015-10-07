From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Date: Wed, 7 Oct 2015 16:53:44 +0200
Message-ID: <20151007145344.GJ3816@twins.programming.kicks-ass.net>
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
 <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:41871 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbbJGOxu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2015 10:53:50 -0400
Content-Disposition: inline
In-Reply-To: <20151007132317.GK16065@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, mpe@ellerman.id.au

On Wed, Oct 07, 2015 at 02:23:17PM +0100, Will Deacon wrote:
> Hi Peter,
> 
> Thanks for the headache ;)

Most welcome :-)

> > Does we want to go revert 12d560f4ea87 ("rcu,locking: Privatize
> > smp_mb__after_unlock_lock()") for that same reason?
> 
> I don't think we want a straight revert. smp_mb__after_unlock_lock could
> largely die if PPC strengthened its locks, whereas smp_mb__release_acquire
> is needed by quite a few architectures.

Fair enough, lets wait for the benchmark results from the PPC people
doing that.

> > > Documentation/memory-barriers.txt is updated to describe more clearly
> > > the ACQUIRE and RELEASE ordering in this area and to show an example of
> > > the new barrier in action.
> > 
> > The only nit I have is that if we revert the above it might be make
> > sense to more clearly call out the distinction between the two.
> 
> Right. Where I think we'd like to get to is:
> 
>  - RELEASE -> ACQUIRE acts as a full barrier if they operate on the same
>    variable and the ACQUIRE reads from the RELEASE
> 
>  - RELEASE -> ACQUIRE acts as a full barrier if they execute on the same
>    CPU and are interleaved with an smp_mb__release_acquire barrier.
> 
>  - RELEASE -> ACQUIRE ordering is transitive
> 
> [only the transitivity part is missing in this patch, because I lost
>  track of that discussion]
> 
> We could then use these same guarantees for UNLOCK -> LOCK in RCU,
> defining smp_mb__after_unlock_lock to be the same as
> smp_mb__release_acquire, but only applying to UNLOCK -> LOCK. That's a
> slight relaxation of how it's defined at the moment (and I guess would
> need some work on PPC?), but it keeps things consistent which is
> especially important as core locking primitives are ported over to the
> ACQUIRE/RELEASE primitives.
> 
> Thoughts?

/me like, although I'm too tired to see how those 3 rules combine to
something weaker than the current after_unlock_lock thing for PPC.
