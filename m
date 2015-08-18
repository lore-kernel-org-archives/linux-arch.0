From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Tue, 18 Aug 2015 09:37:04 +0100
Message-ID: <20150818083704.GC10301@arm.com>
References: <20150715105135.GE1005@arm.com>
 <20150715131221.GY3717@linux.vnet.ibm.com>
 <20150724113101.GE30410@arm.com>
 <20150724153046.GJ3717@linux.vnet.ibm.com>
 <20150812134415.GC23540@arm.com>
 <20150812154346.GR3895@linux.vnet.ibm.com>
 <1439784367.14494.3.camel@ellerman.id.au>
 <20150817061501.GF11078@linux.vnet.ibm.com>
 <20150817085759.GB1688@arm.com>
 <1439862655.1763.2.camel@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48178 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790AbbHRIhI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 18 Aug 2015 04:37:08 -0400
Content-Disposition: inline
In-Reply-To: <1439862655.1763.2.camel@ellerman.id.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Tue, Aug 18, 2015 at 02:50:55AM +0100, Michael Ellerman wrote:
> On Mon, 2015-08-17 at 09:57 +0100, Will Deacon wrote:
> > On Mon, Aug 17, 2015 at 07:15:01AM +0100, Paul E. McKenney wrote:
> > > On Mon, Aug 17, 2015 at 02:06:07PM +1000, Michael Ellerman wrote:
> > > > On Wed, 2015-08-12 at 08:43 -0700, Paul E. McKenney wrote:
> > > > I thought the end result of this thread was that we didn't *need* to change the
> > > > powerpc lock semantics? Or did I read it wrong?
> > > > 
> > > > ie. the docs now say that RELEASE+ACQUIRE is not a full barrier, which is
> > > > consistent with our current implementation.
> > > 
> > > That change happened about 1.5 years ago, and I thought that the
> > > current discussion was about reversing it, based in part on the
> > > recent powerpc benchmarks of locking primitives with and without the
> > > sync instruction.  But regardless, I clearly cannot remove either the
> > > smp_mb__after_unlock_lock() or the powerpc definition of it to be smp_mb()
> > > if powerpc unlock/lock is not strengthened.
> > 
> > Yup. Peter and I would really like to get rid of smp_mb__after_unlock_lock
> > entirely, which would mean strengthening the ppc spinlocks. Moving the
> > barrier primitive into RCU is a good step to prevent more widespread usage
> > of the barrier, but we'd really like to go further if the performance impact
> > is deemed acceptable (which is what this thread is about).
> 
> OK, sorry for completely missing the point, too many balls in the air here.

No problem!

> I'll do some benchmarks and see what we come up with.

Thanks, that sounds great. FWIW, there are multiple ways of implementing
the patch (i.e. whether you strengthen lock or unlock). I had a crack at
something here, but it's not tested:

  http://marc.info/?l=linux-arch&m=143758379023849&w=2

Will
