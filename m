From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Date: Fri, 9 Oct 2015 15:06:15 +0200
Message-ID: <20151009130615.GD3816@twins.programming.kicks-ass.net>
References: <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
 <20151008214439.GE3910@linux.vnet.ibm.com>
 <20151009083138.GU3816@twins.programming.kicks-ass.net>
 <20151009094039.GD26278@arm.com>
 <20151009111202.GZ3816@twins.programming.kicks-ass.net>
 <20151009125111.GP26278@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:42935 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbbJINGY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2015 09:06:24 -0400
Content-Disposition: inline
In-Reply-To: <20151009125111.GP26278@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org

On Fri, Oct 09, 2015 at 01:51:11PM +0100, Will Deacon wrote:
> On Fri, Oct 09, 2015 at 01:12:02PM +0200, Peter Zijlstra wrote:
> > On Fri, Oct 09, 2015 at 10:40:39AM +0100, Will Deacon wrote:
> > > > Which leads me to think I would like to suggest alternative rules for
> > > > RELEASE/ACQUIRE (to replace those Will suggested; as I think those are
> > > > partly responsible for my confusion).
> > > 
> > > Yeah, sorry. I originally used the phrase "fully ordered" but changed it
> > > to "full barrier", which has stronger transitivity (newly understood
> > > definition) requirements that I didn't intend.
> > 
> > > Are we explicit about the difference between "fully ordered" and "full
> > > barrier" somewhere else, because this looks like it will confuse people.
> > 
> > I suspect we don't.
> > 
> > > >  - RELEASE -> ACQUIRE can be upgraded to a full barrier (including
> > > >    transitivity) using smp_mb__release_acquire(), either before RELEASE
> > > >    or after ACQUIRE (but consistently [*]).
> > > 
> > > Hmm, but we don't actually need this for RELEASE -> ACQUIRE, afaict. This
> > > is just needed for UNLOCK -> LOCK, and is exactly what RCU is currently
> > > using (for PPC only).
> > 
> > No, we do need that. RELEASE/ACQUIRE is RCpc for TSO as well as PPC.
> > 
> > UNLOCK/LOCK is only RCpc for PPC, the rest of the world has RCsc for
> > UNLOCK/LOCK.
> > 
> > The reason RELEASE/ACQUIRE differ from UNLOCK/LOCK is the fundamental
> > difference between ACQUIRE and LOCK.
> 
> But they don't actually differ in the kernel memory model we have right
> now, thanks to PPC (we can't be stronger than the weakest implementation).
> That's the whole reason we've got this unlock_lock mess!

Correct, which is why I've suggested to separate UNLOCK/LOCK from
RELEASE/ACQUIRE (again).

Even if only PPC is RCpc for locks, this means we need to have different
upgrade barriers (or suffer superfluous full barriers on TSO archs,
which I think we all want to avoid).

> > Where ACQUIRE really is just a LOAD, LOCK ends up fundamentally being a
> > RmW and a control dependency.
> 
> Have you checked that this is true for the recent RELEASE/ACQUIRE
> conversions in things like the qrwlock? In particular, we should annotate
> those control dependencies to make them glaringly obvious if we want to
> rely on sequentially-consistent locks (and also Alpha may need that).

I have not, let me make a note of that.

> > Now, if you want to upgrade your RCpc RELEASE/ACQUIRE to RCsc, you need
> > to do that on the inside (either after ACQUIRE or before RELEASE), this
> > is crucial (as per Paul's argument) for the case where the RELEASE and
> > ACQUIRE happen on different CPUs.
> > 
> > IFF RELEASE and ACQUIRE happen on the _same_ CPU, then it doesn't
> > matter and you can place the barrier in any of the 3 possible locations
> > (before RELEASE, between RELEASE and ACQUIRE, after ACQUIRE).
> 
> Right, but these two need to be different barriers so that we don't
> penalise TSO when UNLOCK -> LOCK ordering is required. That's why I was
> proposing the local variant of smp_mb__after_release_acquire().
> 
> I think we're in agreement about the barriers we need, we just need to
> name them (and then I'll cook a patch and we can GOTO 10).

 smp_mb__after_unlock_lock()
 smp_mb__after_release_acquire()

Would work, unless of course we can convince the PPC people to go RCsc
on their locks -- which per the benchmark result posted is fairly
painful :/

Then again, I do sympathise with them not wanting to find all the bugs
for being the odd duck.
