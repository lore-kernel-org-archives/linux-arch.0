From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Tue, 14 Jul 2015 12:31:44 -0700
Message-ID: <20150714193144.GP3717@linux.vnet.ibm.com>
References: <20150713155447.GB19282@twins.programming.kicks-ass.net>
 <20150713175029.GO2632@arm.com>
 <20150713202032.GZ3717@linux.vnet.ibm.com>
 <20150713222346.GE19282@twins.programming.kicks-ass.net>
 <20150713230405.GB3717@linux.vnet.ibm.com>
 <20150714100429.GC15448@arm.com>
 <20150714124540.GC3717@linux.vnet.ibm.com>
 <20150714125146.GJ16213@arm.com>
 <20150714140014.GD3717@linux.vnet.ibm.com>
 <20150714141202.GN16213@arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:35069 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627AbbGNTb4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2015 15:31:56 -0400
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 14 Jul 2015 13:31:55 -0600
Content-Disposition: inline
In-Reply-To: <20150714141202.GN16213@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Tue, Jul 14, 2015 at 03:12:16PM +0100, Will Deacon wrote:
> On Tue, Jul 14, 2015 at 03:00:14PM +0100, Paul E. McKenney wrote:
> > On Tue, Jul 14, 2015 at 01:51:46PM +0100, Will Deacon wrote:
> > > On Tue, Jul 14, 2015 at 01:45:40PM +0100, Paul E. McKenney wrote:
> > > > On Tue, Jul 14, 2015 at 11:04:29AM +0100, Will Deacon wrote:
> > > > > Given that RCU is currently the only user of this barrier, how would you
> > > > > feel about making the barrier local to RCU and not part of the general
> > > > > memory-barrier API?
> > > > 
> > > > In theory, no objection.  Your thought is to leave the definitions where
> > > > they are, mark them as being used only by RCU, and removing mention from
> > > > memory-barriers.txt?  Or did you have something else in mind?
> > > 
> > > Actually, I was thinking of defining them in an RCU header file with an
> > > #ifdef CONFIG_POWERPC for the smb_mb() version. Then you could have a big
> > > comment describing the semantics, or put that in an RCU Documentation file
> > > instead of memory-barriers.txt.
> > > 
> > > That *should* then mean we notice anybody else trying to use the barrier,
> > > because they'd need to send patches to either add something equivalent
> > > or move the definition out again.
> > 
> > My concern with this approach is that someone putting together a new
> > architecture might miss this.  That said, this approach certainly would
> > work for the current architectures.
> 
> I don't think they're any more likely to miss it than with the current
> situation where the generic code defines the macro as a NOP unless you
> explicitly override it.

Fair enough...

							Thanx, Paul
