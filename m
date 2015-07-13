From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Tue, 14 Jul 2015 00:23:46 +0200
Message-ID: <20150713222346.GE19282@twins.programming.kicks-ass.net>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
 <20150713131143.GY19282@twins.programming.kicks-ass.net>
 <20150713140915.GD2632@arm.com>
 <20150713142109.GE2632@arm.com>
 <20150713155447.GB19282@twins.programming.kicks-ass.net>
 <20150713175029.GO2632@arm.com>
 <20150713202032.GZ3717@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:47551 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbbGMWXx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2015 18:23:53 -0400
Content-Disposition: inline
In-Reply-To: <20150713202032.GZ3717@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Mon, Jul 13, 2015 at 01:20:32PM -0700, Paul E. McKenney wrote:
> On Mon, Jul 13, 2015 at 06:50:29PM +0100, Will Deacon wrote:

> > So if I'm following along, smp_mb__after_unlock_lock *does* provide
> > transitivity when used with UNLOCK + LOCK, which is stronger than your
> > example here.
> 
> Yes, that is indeed the intent.

Maybe good to state this explicitly somewhere.

> > I don't think we want to make the same guarantee for general RELEASE +
> > ACQUIRE, because we'd end up forcing most architectures to implement the
> > expensive macro for a case that currently has no users.
> 
> Agreed, smp_mb__after_unlock_lock() makes a limited guarantee.

I'm still not seeing how the archs that implement load_acquire and
store_release with smp_mb() are a problem.

If we look at the inside of the critical section again -- similar
argument as before:

	*A = a
	smp_mb()
	store M
	load N
	smp_mb()
	*B = b

A and B are fully ordered, and in this case even transitivity is
provided.

I'm stating that the order of M and N don't matter, only the
load/stores that are inside the acquire/release are constrained.

IOW, I think smp_mb__after_unlock_lock() already works as advertised
with all our acquire/release thingies -- as is stated by the
documentation.

That said, I'm not aware of anybody but RCU actually using this, so its
not used in that capacity.

> > In which case, it boils down to the question of how expensive it would
> > be to implement an SC UNLOCK operation on PowerPC and whether that justifies
> > the existence of a complicated barrier macro that isn't used outside of
> > RCU.
> 
> Given that it is either smp_mb() or nothing, I am not seeing the
> "complicated" part...

The 'complicated' part is that we need think about it; that is we need
to realized and remember that UNLOCK+LOCK is a load-store barrier but
fails to provide transitivity.
