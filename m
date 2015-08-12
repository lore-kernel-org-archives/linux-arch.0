From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Wed, 12 Aug 2015 14:44:15 +0100
Message-ID: <20150812134415.GC23540@arm.com>
References: <20150714124540.GC3717@linux.vnet.ibm.com>
 <20150714125146.GJ16213@arm.com>
 <20150714140014.GD3717@linux.vnet.ibm.com>
 <20150714141202.GN16213@arm.com>
 <20150714193144.GP3717@linux.vnet.ibm.com>
 <20150715013820.GA21971@linux.vnet.ibm.com>
 <20150715105135.GE1005@arm.com>
 <20150715131221.GY3717@linux.vnet.ibm.com>
 <20150724113101.GE30410@arm.com>
 <20150724153046.GJ3717@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58462 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752775AbbHLNoT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 12 Aug 2015 09:44:19 -0400
Content-Disposition: inline
In-Reply-To: <20150724153046.GJ3717@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Hello Paul,

On Fri, Jul 24, 2015 at 04:30:46PM +0100, Paul E. McKenney wrote:
> On Fri, Jul 24, 2015 at 12:31:01PM +0100, Will Deacon wrote:
> > On Wed, Jul 15, 2015 at 02:12:21PM +0100, Paul E. McKenney wrote:
> > > > > commit 695c05d4b9666c50b40a1c022678b5f6e2e3e771
> > > > > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > > Date:   Tue Jul 14 18:35:23 2015 -0700
> > > > > 
> > > > >     rcu,locking: Privatize smp_mb__after_unlock_lock()
> > > > >     
> > > > >     RCU is the only thing that uses smp_mb__after_unlock_lock(), and is
> > > > >     likely the only thing that ever will use it, so this commit makes this
> > > > >     macro private to RCU.
> > > > >     
> > > > >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > >     Cc: Will Deacon <will.deacon@arm.com>
> > > > >     Cc: Peter Zijlstra <peterz@infradead.org>
> > > > >     Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > > >     Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
> > 
> > Are you planning to queue this somewhere? I think it makes sense regardless
> > of whether we change PowerPc or not and ideally it would be merged around
> > the same time as my relaxed atomics series.
> 
> I have is in -rcu.  By default, I will push it to the 4.4 merge window.
> Please let me know if you need it sooner.

The generic relaxed atomics are now queued in -tip, so it would be really
good to see this Documentation update land in 4.3 if at all possible. I
appreciate it's late in the cycle, but it's always worth asking.

Thanks,

Will
