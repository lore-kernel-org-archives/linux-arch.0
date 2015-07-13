From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Mon, 13 Jul 2015 13:20:32 -0700
Message-ID: <20150713202032.GZ3717@linux.vnet.ibm.com>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
 <20150713131143.GY19282@twins.programming.kicks-ass.net>
 <20150713140915.GD2632@arm.com>
 <20150713142109.GE2632@arm.com>
 <20150713155447.GB19282@twins.programming.kicks-ass.net>
 <20150713175029.GO2632@arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:50339 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914AbbGMUUl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2015 16:20:41 -0400
Received: from /spool/local
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 13 Jul 2015 14:20:40 -0600
Content-Disposition: inline
In-Reply-To: <20150713175029.GO2632@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Mon, Jul 13, 2015 at 06:50:29PM +0100, Will Deacon wrote:
> On Mon, Jul 13, 2015 at 04:54:47PM +0100, Peter Zijlstra wrote:
> > However I think we should look at the insides of the critical sections;
> > for example (from Documentation/memory-barriers.txt):
> > 
> > "       *A = a;
> >         RELEASE M
> >         ACQUIRE N
> >         *B = b;
> > 
> > could occur as:
> > 
> >         ACQUIRE N, STORE *B, STORE *A, RELEASE M"
> > 
> > This could not in fact happen, even though we could flip M and N, A and
> > B will remain strongly ordered.
> > 
> > That said, I don't think this could even happen on PPC because we have
> > load_acquire and store_release, this means that:
> > 
> > 	*A = a
> > 	lwsync
> > 	store_release M
> > 	load_acquire N
> > 	lwsync
> > 	*B = b
> > 
> > And since the store to M is wrapped inside two lwsync there must be
> > strong store order, and because the load from N is equally wrapped in
> > two lwsyncs there must also be strong load order.
> > 
> > In fact, no store/load can cross from before the first lwsync to after
> > the latter and the other way around.
> > 
> > So in that respect it does provide full load-store ordering. What it
> > does not provide is order for M and N, nor does it provide transitivity,
> > but looking at our documentation I'm not at all sure we guarantee that
> > in any case.
> 
> So if I'm following along, smp_mb__after_unlock_lock *does* provide
> transitivity when used with UNLOCK + LOCK, which is stronger than your
> example here.

Yes, that is indeed the intent.

> I don't think we want to make the same guarantee for general RELEASE +
> ACQUIRE, because we'd end up forcing most architectures to implement the
> expensive macro for a case that currently has no users.

Agreed, smp_mb__after_unlock_lock() makes a limited guarantee.

> In which case, it boils down to the question of how expensive it would
> be to implement an SC UNLOCK operation on PowerPC and whether that justifies
> the existence of a complicated barrier macro that isn't used outside of
> RCU.

Given that it is either smp_mb() or nothing, I am not seeing the
"complicated" part...

							Thanx, Paul
