From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Date: Wed, 7 Oct 2015 08:25:01 -0700
Message-ID: <20151007152501.GI3910@linux.vnet.ibm.com>
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
 <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:36568 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612AbbJGPZF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2015 11:25:05 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 7 Oct 2015 09:25:04 -0600
Content-Disposition: inline
In-Reply-To: <20151007132317.GK16065@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, mpe@ellerman.id.au

On Wed, Oct 07, 2015 at 02:23:17PM +0100, Will Deacon wrote:
> Hi Peter,
> 
> Thanks for the headache ;)
> 
> On Wed, Oct 07, 2015 at 01:19:15PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 07, 2015 at 11:59:28AM +0100, Will Deacon wrote:
> > > As much as we'd like to live in a world where RELEASE -> ACQUIRE is
> > > always cheaply ordered and can be used to construct UNLOCK -> LOCK
> > > definitions with similar guarantees, the grim reality is that this isn't
> > > even possible on x86 (thanks to Paul for bringing us crashing down to
> > > Earth).
> > > 
> > > This patch handles the issue by introducing a new barrier macro,
> > > smp_mb__release_acquire, that can be placed between a RELEASE and a
> > > subsequent ACQUIRE operation in order to upgrade them to a full memory
> > > barrier. At the moment, it doesn't have any users, so its existence
> > > serves mainly as a documentation aid.
> > 
> > Does we want to go revert 12d560f4ea87 ("rcu,locking: Privatize
> > smp_mb__after_unlock_lock()") for that same reason?
> 
> I don't think we want a straight revert. smp_mb__after_unlock_lock could
> largely die if PPC strengthened its locks, whereas smp_mb__release_acquire
> is needed by quite a few architectures.
> 
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

I believe that these three are good.

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

Currently, we do need smp_mb__after_unlock_lock() to be after the
acquisition on PPC -- putting it between the unlock and the lock
of course doesn't cut it for the cross-thread unlock/lock case.

I am with Peter -- we do need the benchmark results for PPC.

							Thanx, Paul
