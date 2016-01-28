From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3] barriers: introduce smp_mb__release_acquire and
 update documentation
Date: Thu, 28 Jan 2016 15:35:00 +0000
Message-ID: <20160128153500.GJ775@arm.com>
References: <1453918924-27606-1-git-send-email-will.deacon@arm.com>
 <20160127182551.GX6357@twins.programming.kicks-ass.net>
 <20160127183923.GD25545@arm.com>
 <20160127230011.GK4503@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:32881 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966489AbcA1PfD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 28 Jan 2016 10:35:03 -0500
Content-Disposition: inline
In-Reply-To: <20160127230011.GK4503@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>

On Wed, Jan 27, 2016 at 03:00:11PM -0800, Paul E. McKenney wrote:
> On Wed, Jan 27, 2016 at 06:39:23PM +0000, Will Deacon wrote:
> > On Wed, Jan 27, 2016 at 07:25:51PM +0100, Peter Zijlstra wrote:
> > > On Wed, Jan 27, 2016 at 06:22:04PM +0000, Will Deacon wrote:
> > > > As much as we'd like to live in a world where RELEASE -> ACQUIRE is
> > > > always cheaply ordered and can be used to construct UNLOCK -> LOCK
> > > > definitions with similar guarantees, the grim reality is that this isn't
> > > > even possible on x86 (thanks to Paul for bringing us crashing down to
> > > > Earth).
> > > > 
> > > > This patch handles the issue by introducing a new barrier macro,
> > > > smp_mb__after_release_acquire, that can be placed after an ACQUIRE that
> > > > either reads from a RELEASE or is in program-order after a RELEASE. The
> > > > barrier upgrades the RELEASE-ACQUIRE pair to a full memory barrier,
> > > > implying global transitivity. At the moment, it doesn't have any users,
> > > > so its existence serves mainly as a documentation aid and a potential
> > > > stepping stone to the reintroduction of smp_mb__after_unlock_lock() used
> > > > by RCU.
> > > > 
> > > > Documentation/memory-barriers.txt is updated to describe more clearly
> > > > the ACQUIRE and RELEASE ordering in this area and to show some examples
> > > > of the new barrier in action.
> > > 
> > > So the obvious question is: do we have a use-case?
> > 
> > We have a use-case for smp_mb__after_unlock_lock, so I think we should
> > either strengthen our locking guarantees so that smp_mb__after_unlock_lock
> > isn't needed or introduce smp_mb__after_release_acquire to close the gap.
> > As it stands, we've got an inconsistency (despite it being hidden inside
> > RCU).
> > 
> > The main advantage of this patch is a documentation aid, in my opinion
> > (hell, we talk about smp_mb__after_unlock_lock already when reasoning
> > about this stuff).
> 
> But wasn't there an x86 potential use case that required placing the
> strengthening macro after the release and before the acquire?  Or is
> this a case of old age striking again?

The proposal here doesn't order the release/acquire operations with each
other -- it just says that they combine with smp_mb__after_release_acquire()
to make a full barrier, so I don't think it should matter for the
intra-thread case, which is the one that x86 cares out iiuc.

Will
