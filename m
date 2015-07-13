From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Mon, 13 Jul 2015 16:04:06 -0700
Message-ID: <20150713230405.GB3717@linux.vnet.ibm.com>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
 <20150713131143.GY19282@twins.programming.kicks-ass.net>
 <20150713140915.GD2632@arm.com>
 <20150713142109.GE2632@arm.com>
 <20150713155447.GB19282@twins.programming.kicks-ass.net>
 <20150713175029.GO2632@arm.com>
 <20150713202032.GZ3717@linux.vnet.ibm.com>
 <20150713222346.GE19282@twins.programming.kicks-ass.net>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:57073 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbbGMXEO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2015 19:04:14 -0400
Received: from /spool/local
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 13 Jul 2015 17:04:13 -0600
Content-Disposition: inline
In-Reply-To: <20150713222346.GE19282@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Tue, Jul 14, 2015 at 12:23:46AM +0200, Peter Zijlstra wrote:
> On Mon, Jul 13, 2015 at 01:20:32PM -0700, Paul E. McKenney wrote:
> > On Mon, Jul 13, 2015 at 06:50:29PM +0100, Will Deacon wrote:
> 
> > > So if I'm following along, smp_mb__after_unlock_lock *does* provide
> > > transitivity when used with UNLOCK + LOCK, which is stronger than your
> > > example here.
> > 
> > Yes, that is indeed the intent.
> 
> Maybe good to state this explicitly somewhere.

Fair enough!  Please see patch below.

> > > I don't think we want to make the same guarantee for general RELEASE +
> > > ACQUIRE, because we'd end up forcing most architectures to implement the
> > > expensive macro for a case that currently has no users.
> > 
> > Agreed, smp_mb__after_unlock_lock() makes a limited guarantee.
> 
> I'm still not seeing how the archs that implement load_acquire and
> store_release with smp_mb() are a problem.

I don't know that I ever claimed such architectures to be a problem.
Color me confused.

> If we look at the inside of the critical section again -- similar
> argument as before:
> 
> 	*A = a
> 	smp_mb()
> 	store M
> 	load N
> 	smp_mb()
> 	*B = b
> 
> A and B are fully ordered, and in this case even transitivity is
> provided.
> 
> I'm stating that the order of M and N don't matter, only the
> load/stores that are inside the acquire/release are constrained.

No argument here.

> IOW, I think smp_mb__after_unlock_lock() already works as advertised
> with all our acquire/release thingies -- as is stated by the
> documentation.
> 
> That said, I'm not aware of anybody but RCU actually using this, so its
> not used in that capacity.

OK, I might actually understand what you are getting at.  And, yes, if
someone actually comes up with a need to combine smp_mb__after_unlock_lock()
with something other than locking, we should worry about it at that point.
And probably rename smp_mb__after_unlock_lock() at that point, as well.
Until then, why lock ourselves into semantics that no one needs, and
that it is quite possible that no one will ever need?

> > > In which case, it boils down to the question of how expensive it would
> > > be to implement an SC UNLOCK operation on PowerPC and whether that justifies
> > > the existence of a complicated barrier macro that isn't used outside of
> > > RCU.
> > 
> > Given that it is either smp_mb() or nothing, I am not seeing the
> > "complicated" part...
> 
> The 'complicated' part is that we need think about it; that is we need
> to realized and remember that UNLOCK+LOCK is a load-store barrier but
> fails to provide transitivity.

...  unless you are holding the lock.  So in the common case, you do
get transitivity.

							Thanx, Paul

------------------------------------------------------------------------

commit bae5cf1e2973bb1e8f852abb54f8b1948ffd82e4
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Mon Jul 13 15:55:52 2015 -0700

    doc: Call out smp_mb__after_unlock_lock() transitivity
    
    Although "full barrier" should be interpreted as providing transitivity,
    it is worth eliminating any possible confusion.  This commit therefore
    adds "(including transitivity)" to eliminate any possible confusion.
    
    Reported-by: Peter Zijlstra <peterz@infradead.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 470c07c868e4..318523872db5 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1858,11 +1858,12 @@ Similarly, the reverse case of a RELEASE followed by an ACQUIRE does not
 imply a full memory barrier.  If it is necessary for a RELEASE-ACQUIRE
 pair to produce a full barrier, the ACQUIRE can be followed by an
 smp_mb__after_unlock_lock() invocation.  This will produce a full barrier
-if either (a) the RELEASE and the ACQUIRE are executed by the same
-CPU or task, or (b) the RELEASE and ACQUIRE act on the same variable.
-The smp_mb__after_unlock_lock() primitive is free on many architectures.
-Without smp_mb__after_unlock_lock(), the CPU's execution of the critical
-sections corresponding to the RELEASE and the ACQUIRE can cross, so that:
+(including transitivity) if either (a) the RELEASE and the ACQUIRE are
+executed by the same CPU or task, or (b) the RELEASE and ACQUIRE act on
+the same variable.  The smp_mb__after_unlock_lock() primitive is free
+on many architectures.  Without smp_mb__after_unlock_lock(), the CPU's
+execution of the critical sections corresponding to the RELEASE and the
+ACQUIRE can cross, so that:
 
 	*A = a;
 	RELEASE M
