From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Fri, 24 Jul 2015 08:30:46 -0700
Message-ID: <20150724153046.GJ3717@linux.vnet.ibm.com>
References: <20150714100429.GC15448@arm.com>
 <20150714124540.GC3717@linux.vnet.ibm.com>
 <20150714125146.GJ16213@arm.com>
 <20150714140014.GD3717@linux.vnet.ibm.com>
 <20150714141202.GN16213@arm.com>
 <20150714193144.GP3717@linux.vnet.ibm.com>
 <20150715013820.GA21971@linux.vnet.ibm.com>
 <20150715105135.GE1005@arm.com>
 <20150715131221.GY3717@linux.vnet.ibm.com>
 <20150724113101.GE30410@arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:50512 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbbGXPau (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2015 11:30:50 -0400
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 24 Jul 2015 09:30:49 -0600
Content-Disposition: inline
In-Reply-To: <20150724113101.GE30410@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Fri, Jul 24, 2015 at 12:31:01PM +0100, Will Deacon wrote:
> Hi Paul,
> 
> On Wed, Jul 15, 2015 at 02:12:21PM +0100, Paul E. McKenney wrote:
> > On Wed, Jul 15, 2015 at 11:51:35AM +0100, Will Deacon wrote:
> > > On Wed, Jul 15, 2015 at 02:38:20AM +0100, Paul E. McKenney wrote:
> > > > On Tue, Jul 14, 2015 at 12:31:44PM -0700, Paul E. McKenney wrote:
> > > > > On Tue, Jul 14, 2015 at 03:12:16PM +0100, Will Deacon wrote:
> > > > > > On Tue, Jul 14, 2015 at 03:00:14PM +0100, Paul E. McKenney wrote:
> > > > > > > On Tue, Jul 14, 2015 at 01:51:46PM +0100, Will Deacon wrote:
> > > > > > > > On Tue, Jul 14, 2015 at 01:45:40PM +0100, Paul E. McKenney wrote:
> > > > > > > > > On Tue, Jul 14, 2015 at 11:04:29AM +0100, Will Deacon wrote:
> > > > > > > > > > Given that RCU is currently the only user of this barrier, how would you
> > > > > > > > > > feel about making the barrier local to RCU and not part of the general
> > > > > > > > > > memory-barrier API?
> > > > > > > > > 
> > > > > > > > > In theory, no objection.  Your thought is to leave the definitions where
> > > > > > > > > they are, mark them as being used only by RCU, and removing mention from
> > > > > > > > > memory-barriers.txt?  Or did you have something else in mind?
> > > > > > > > 
> > > > > > > > Actually, I was thinking of defining them in an RCU header file with an
> > > > > > > > #ifdef CONFIG_POWERPC for the smb_mb() version. Then you could have a big
> > > > > > > > comment describing the semantics, or put that in an RCU Documentation file
> > > > > > > > instead of memory-barriers.txt.
> > > > > > > > 
> > > > > > > > That *should* then mean we notice anybody else trying to use the barrier,
> > > > > > > > because they'd need to send patches to either add something equivalent
> > > > > > > > or move the definition out again.
> > > > > > > 
> > > > > > > My concern with this approach is that someone putting together a new
> > > > > > > architecture might miss this.  That said, this approach certainly would
> > > > > > > work for the current architectures.
> > > > > > 
> > > > > > I don't think they're any more likely to miss it than with the current
> > > > > > situation where the generic code defines the macro as a NOP unless you
> > > > > > explicitly override it.
> > > > > 
> > > > > Fair enough...
> > > > 
> > > > Like this?
> > > 
> > > Precisely! Thanks for cooking the patch -- this lays all my worries to
> > > rest, so:
> > > 
> > >   Acked-by: Will Deacon <will.deacon@arm.com>
> > 
> > Thank you!
> 
> [...]
> 
> > > > commit 695c05d4b9666c50b40a1c022678b5f6e2e3e771
> > > > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > Date:   Tue Jul 14 18:35:23 2015 -0700
> > > > 
> > > >     rcu,locking: Privatize smp_mb__after_unlock_lock()
> > > >     
> > > >     RCU is the only thing that uses smp_mb__after_unlock_lock(), and is
> > > >     likely the only thing that ever will use it, so this commit makes this
> > > >     macro private to RCU.
> > > >     
> > > >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > >     Cc: Will Deacon <will.deacon@arm.com>
> > > >     Cc: Peter Zijlstra <peterz@infradead.org>
> > > >     Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > >     Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
> 
> Are you planning to queue this somewhere? I think it makes sense regardless
> of whether we change PowerPc or not and ideally it would be merged around
> the same time as my relaxed atomics series.

I have is in -rcu.  By default, I will push it to the 4.4 merge window.
Please let me know if you need it sooner.

							Thanx, Paul
