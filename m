From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Wed, 26 Aug 2015 14:06:11 +1000
Message-ID: <1440561971.20743.2.camel@ellerman.id.au>
References: <20150724153046.GJ3717@linux.vnet.ibm.com>
	 <20150812134415.GC23540@arm.com> <20150812154346.GR3895@linux.vnet.ibm.com>
	 <1439784367.14494.3.camel@ellerman.id.au>
	 <20150817061501.GF11078@linux.vnet.ibm.com> <20150817085759.GB1688@arm.com>
	 <1439862655.1763.2.camel@ellerman.id.au> <20150818083704.GC10301@arm.com>
	 <1440063905.11564.5.camel@ellerman.id.au> <20150820155604.GB24100@arm.com>
	 <20150826002744.GA11078@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:36719 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbbHZEGN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 26 Aug 2015 00:06:13 -0400
In-Reply-To: <20150826002744.GA11078@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Cc: Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Tue, 2015-08-25 at 17:27 -0700, Paul E. McKenney wrote:
> On Thu, Aug 20, 2015 at 04:56:04PM +0100, Will Deacon wrote:
> > On Thu, Aug 20, 2015 at 10:45:05AM +0100, Michael Ellerman wrote:
> > > On Tue, 2015-08-18 at 09:37 +0100, Will Deacon wrote:
> > > > 
> > > > Thanks, that sounds great. FWIW, there are multiple ways of implementing
> > > > the patch (i.e. whether you strengthen lock or unlock). I had a crack at
> > > > something here, but it's not tested:
> > > > 
> > > >   http://marc.info/?l=linux-arch&m=143758379023849&w=2
> > > 
> > > I notice you are not changing PPC_RELEASE_BARRIER, but only the spin unlock
> > > code. But from my reading of the docs we need to make sure any UNLOCK+LOCK is a
> > > full barrier, not just spin unlock/lock?
> > > 
> > > So don't we need to worry about some of the other locks as well? At least
> > > rwlock, and mutex fast path?
> > 
> > Hmm, that's a good question. I notice that you don't do any of the SYNC_IO
> > stuff for any locks other than spinlocks but I don't know whether
> > smp_mb__after_unlock_lock is similarly limited in scope.
> > 
> > Paul?
> 
> I would expect the various locks to have similar ordering characteristics.
> 
> Or am I missing something subtle here?

I don't think so.

The docs just talk about ACQUIRE/RELEASE, so I think it needs to apply to all
lock types. Or at least the list mentioned in the docs which is:

 (*) spin locks
 (*) R/W spin locks
 (*) mutexes
 (*) semaphores
 (*) R/W semaphores
 (*) RCU

cheers
