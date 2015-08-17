From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Mon, 17 Aug 2015 14:06:07 +1000
Message-ID: <1439784367.14494.3.camel@ellerman.id.au>
References: <20150714125146.GJ16213@arm.com>
	 <20150714140014.GD3717@linux.vnet.ibm.com> <20150714141202.GN16213@arm.com>
	 <20150714193144.GP3717@linux.vnet.ibm.com>
	 <20150715013820.GA21971@linux.vnet.ibm.com> <20150715105135.GE1005@arm.com>
	 <20150715131221.GY3717@linux.vnet.ibm.com> <20150724113101.GE30410@arm.com>
	 <20150724153046.GJ3717@linux.vnet.ibm.com> <20150812134415.GC23540@arm.com>
	 <20150812154346.GR3895@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:43885 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732AbbHQEGP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 17 Aug 2015 00:06:15 -0400
In-Reply-To: <20150812154346.GR3895@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Cc: Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Wed, 2015-08-12 at 08:43 -0700, Paul E. McKenney wrote:
> On Wed, Aug 12, 2015 at 02:44:15PM +0100, Will Deacon wrote:
> > Hello Paul,
> > 
> > On Fri, Jul 24, 2015 at 04:30:46PM +0100, Paul E. McKenney wrote:
> > > On Fri, Jul 24, 2015 at 12:31:01PM +0100, Will Deacon wrote:
> > > > On Wed, Jul 15, 2015 at 02:12:21PM +0100, Paul E. McKenney wrote:
> > > > > > > commit 695c05d4b9666c50b40a1c022678b5f6e2e3e771
> > > > > > > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > > > > Date:   Tue Jul 14 18:35:23 2015 -0700
> > > > > > > 
> > > > > > >     rcu,locking: Privatize smp_mb__after_unlock_lock()
> > > > > > >     
> > > > > > >     RCU is the only thing that uses smp_mb__after_unlock_lock(), and is
> > > > > > >     likely the only thing that ever will use it, so this commit makes this
> > > > > > >     macro private to RCU.
> > > > > > >     
> > > > > > >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > > > >     Cc: Will Deacon <will.deacon@arm.com>
> > > > > > >     Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > >     Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > > > > >     Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
> > > > 
> > > > Are you planning to queue this somewhere? I think it makes sense regardless
> > > > of whether we change PowerPc or not and ideally it would be merged around
> > > > the same time as my relaxed atomics series.
> > > 
> > > I have is in -rcu.  By default, I will push it to the 4.4 merge window.
> > > Please let me know if you need it sooner.
> > 
> > The generic relaxed atomics are now queued in -tip, so it would be really
> > good to see this Documentation update land in 4.3 if at all possible. I
> > appreciate it's late in the cycle, but it's always worth asking.
> 
> Can't hurt to give it a try.  I have set -rcu's rcu/next branch to this
> commit, and if it passes a few day's worth of testing, I will see what
> Ingo has to say about a pull request.
> 
> This commit also privatizes smp_mb__after_unlock_lock() as well as
> updating documentation.  Looks like we need to strengthen powerpc's
> locking primitives, then get rid of smp_mb__after_unlock_lock() entirely.
> Or did that already happen and I just missed it?

No it didn't.

I thought the end result of this thread was that we didn't *need* to change the
powerpc lock semantics? Or did I read it wrong?

ie. the docs now say that RELEASE+ACQUIRE is not a full barrier, which is
consistent with our current implementation.

cheers
