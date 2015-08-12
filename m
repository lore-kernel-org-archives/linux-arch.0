From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Wed, 12 Aug 2015 08:43:46 -0700
Message-ID: <20150812154346.GR3895@linux.vnet.ibm.com>
References: <20150714125146.GJ16213@arm.com>
 <20150714140014.GD3717@linux.vnet.ibm.com>
 <20150714141202.GN16213@arm.com>
 <20150714193144.GP3717@linux.vnet.ibm.com>
 <20150715013820.GA21971@linux.vnet.ibm.com>
 <20150715105135.GE1005@arm.com>
 <20150715131221.GY3717@linux.vnet.ibm.com>
 <20150724113101.GE30410@arm.com>
 <20150724153046.GJ3717@linux.vnet.ibm.com>
 <20150812134415.GC23540@arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:33488 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493AbbHLPnw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 12 Aug 2015 11:43:52 -0400
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 12 Aug 2015 09:43:51 -0600
Content-Disposition: inline
In-Reply-To: <20150812134415.GC23540@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Wed, Aug 12, 2015 at 02:44:15PM +0100, Will Deacon wrote:
> Hello Paul,
> 
> On Fri, Jul 24, 2015 at 04:30:46PM +0100, Paul E. McKenney wrote:
> > On Fri, Jul 24, 2015 at 12:31:01PM +0100, Will Deacon wrote:
> > > On Wed, Jul 15, 2015 at 02:12:21PM +0100, Paul E. McKenney wrote:
> > > > > > commit 695c05d4b9666c50b40a1c022678b5f6e2e3e771
> > > > > > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > > > Date:   Tue Jul 14 18:35:23 2015 -0700
> > > > > > 
> > > > > >     rcu,locking: Privatize smp_mb__after_unlock_lock()
> > > > > >     
> > > > > >     RCU is the only thing that uses smp_mb__after_unlock_lock(), and is
> > > > > >     likely the only thing that ever will use it, so this commit makes this
> > > > > >     macro private to RCU.
> > > > > >     
> > > > > >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > > >     Cc: Will Deacon <will.deacon@arm.com>
> > > > > >     Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > >     Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > > > >     Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
> > > 
> > > Are you planning to queue this somewhere? I think it makes sense regardless
> > > of whether we change PowerPc or not and ideally it would be merged around
> > > the same time as my relaxed atomics series.
> > 
> > I have is in -rcu.  By default, I will push it to the 4.4 merge window.
> > Please let me know if you need it sooner.
> 
> The generic relaxed atomics are now queued in -tip, so it would be really
> good to see this Documentation update land in 4.3 if at all possible. I
> appreciate it's late in the cycle, but it's always worth asking.

Can't hurt to give it a try.  I have set -rcu's rcu/next branch to this
commit, and if it passes a few day's worth of testing, I will see what
Ingo has to say about a pull request.

This commit also privatizes smp_mb__after_unlock_lock() as well as
updating documentation.  Looks like we need to strengthen powerpc's
locking primitives, then get rid of smp_mb__after_unlock_lock() entirely.
Or did that already happen and I just missed it?

							Thanx, Paul
