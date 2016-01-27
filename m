From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] barriers: introduce smp_mb__release_acquire and
 update documentation
Date: Wed, 27 Jan 2016 15:00:11 -0800
Message-ID: <20160127230011.GK4503@linux.vnet.ibm.com>
References: <1453918924-27606-1-git-send-email-will.deacon@arm.com>
 <20160127182551.GX6357@twins.programming.kicks-ass.net>
 <20160127183923.GD25545@arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:48612 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964971AbcA0XAf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jan 2016 18:00:35 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 27 Jan 2016 16:00:34 -0700
Content-Disposition: inline
In-Reply-To: <20160127183923.GD25545@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>

On Wed, Jan 27, 2016 at 06:39:23PM +0000, Will Deacon wrote:
> On Wed, Jan 27, 2016 at 07:25:51PM +0100, Peter Zijlstra wrote:
> > On Wed, Jan 27, 2016 at 06:22:04PM +0000, Will Deacon wrote:
> > > As much as we'd like to live in a world where RELEASE -> ACQUIRE is
> > > always cheaply ordered and can be used to construct UNLOCK -> LOCK
> > > definitions with similar guarantees, the grim reality is that this isn't
> > > even possible on x86 (thanks to Paul for bringing us crashing down to
> > > Earth).
> > > 
> > > This patch handles the issue by introducing a new barrier macro,
> > > smp_mb__after_release_acquire, that can be placed after an ACQUIRE that
> > > either reads from a RELEASE or is in program-order after a RELEASE. The
> > > barrier upgrades the RELEASE-ACQUIRE pair to a full memory barrier,
> > > implying global transitivity. At the moment, it doesn't have any users,
> > > so its existence serves mainly as a documentation aid and a potential
> > > stepping stone to the reintroduction of smp_mb__after_unlock_lock() used
> > > by RCU.
> > > 
> > > Documentation/memory-barriers.txt is updated to describe more clearly
> > > the ACQUIRE and RELEASE ordering in this area and to show some examples
> > > of the new barrier in action.
> > 
> > So the obvious question is: do we have a use-case?
> 
> We have a use-case for smp_mb__after_unlock_lock, so I think we should
> either strengthen our locking guarantees so that smp_mb__after_unlock_lock
> isn't needed or introduce smp_mb__after_release_acquire to close the gap.
> As it stands, we've got an inconsistency (despite it being hidden inside
> RCU).
> 
> The main advantage of this patch is a documentation aid, in my opinion
> (hell, we talk about smp_mb__after_unlock_lock already when reasoning
> about this stuff).

But wasn't there an x86 potential use case that required placing the
strengthening macro after the release and before the acquire?  Or is
this a case of old age striking again?

							Thanx, Paul
