From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Tue, 14 Jul 2015 05:45:40 -0700
Message-ID: <20150714124540.GC3717@linux.vnet.ibm.com>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
 <20150713131143.GY19282@twins.programming.kicks-ass.net>
 <20150713140915.GD2632@arm.com>
 <20150713142109.GE2632@arm.com>
 <20150713155447.GB19282@twins.programming.kicks-ass.net>
 <20150713175029.GO2632@arm.com>
 <20150713202032.GZ3717@linux.vnet.ibm.com>
 <20150713222346.GE19282@twins.programming.kicks-ass.net>
 <20150713230405.GB3717@linux.vnet.ibm.com>
 <20150714100429.GC15448@arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:33812 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbbGNMpu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2015 08:45:50 -0400
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 14 Jul 2015 06:45:50 -0600
Content-Disposition: inline
In-Reply-To: <20150714100429.GC15448@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Tue, Jul 14, 2015 at 11:04:29AM +0100, Will Deacon wrote:
> On Tue, Jul 14, 2015 at 12:04:06AM +0100, Paul E. McKenney wrote:
> > On Tue, Jul 14, 2015 at 12:23:46AM +0200, Peter Zijlstra wrote:
> > > If we look at the inside of the critical section again -- similar
> > > argument as before:
> > > 
> > > 	*A = a
> > > 	smp_mb()
> > > 	store M
> > > 	load N
> > > 	smp_mb()
> > > 	*B = b
> > > 
> > > A and B are fully ordered, and in this case even transitivity is
> > > provided.
> > > 
> > > I'm stating that the order of M and N don't matter, only the
> > > load/stores that are inside the acquire/release are constrained.
> > 
> > No argument here.
> > 
> > > IOW, I think smp_mb__after_unlock_lock() already works as advertised
> > > with all our acquire/release thingies -- as is stated by the
> > > documentation.
> > > 
> > > That said, I'm not aware of anybody but RCU actually using this, so its
> > > not used in that capacity.
> > 
> > OK, I might actually understand what you are getting at.  And, yes, if
> > someone actually comes up with a need to combine smp_mb__after_unlock_lock()
> > with something other than locking, we should worry about it at that point.
> > And probably rename smp_mb__after_unlock_lock() at that point, as well.
> > Until then, why lock ourselves into semantics that no one needs, and
> > that it is quite possible that no one will ever need?
> 
> Given that RCU is currently the only user of this barrier, how would you
> feel about making the barrier local to RCU and not part of the general
> memory-barrier API?

In theory, no objection.  Your thought is to leave the definitions where
they are, mark them as being used only by RCU, and removing mention from
memory-barriers.txt?  Or did you have something else in mind?

> My main reason for proposing its removal is because I don't want to see
> it being used (incorrectly) all over the place to order the new RELEASE
> and ACQUIRE operations I posted separately, at which point we have to try
> fixing up all the callers or retrofitting some semantics. It doesn't help
> that memory-barriers.txt lumps things like LOCK and ACQUIRE together,
> whereas this barrier is currently only intended to be used in conjunction
> with the former.

Heh!  That lumping was considered to be a feature at the time.  ;-)

							Thanx, Paul
