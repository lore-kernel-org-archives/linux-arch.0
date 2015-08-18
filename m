From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Tue, 18 Aug 2015 11:50:55 +1000
Message-ID: <1439862655.1763.2.camel@ellerman.id.au>
References: <20150714193144.GP3717@linux.vnet.ibm.com>
	 <20150715013820.GA21971@linux.vnet.ibm.com> <20150715105135.GE1005@arm.com>
	 <20150715131221.GY3717@linux.vnet.ibm.com> <20150724113101.GE30410@arm.com>
	 <20150724153046.GJ3717@linux.vnet.ibm.com> <20150812134415.GC23540@arm.com>
	 <20150812154346.GR3895@linux.vnet.ibm.com>
	 <1439784367.14494.3.camel@ellerman.id.au>
	 <20150817061501.GF11078@linux.vnet.ibm.com> <20150817085759.GB1688@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:52197 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbbHRBu5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 17 Aug 2015 21:50:57 -0400
In-Reply-To: <20150817085759.GB1688@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Mon, 2015-08-17 at 09:57 +0100, Will Deacon wrote:
> On Mon, Aug 17, 2015 at 07:15:01AM +0100, Paul E. McKenney wrote:
> > On Mon, Aug 17, 2015 at 02:06:07PM +1000, Michael Ellerman wrote:
> > > On Wed, 2015-08-12 at 08:43 -0700, Paul E. McKenney wrote:
> > > I thought the end result of this thread was that we didn't *need* to change the
> > > powerpc lock semantics? Or did I read it wrong?
> > > 
> > > ie. the docs now say that RELEASE+ACQUIRE is not a full barrier, which is
> > > consistent with our current implementation.
> > 
> > That change happened about 1.5 years ago, and I thought that the
> > current discussion was about reversing it, based in part on the
> > recent powerpc benchmarks of locking primitives with and without the
> > sync instruction.  But regardless, I clearly cannot remove either the
> > smp_mb__after_unlock_lock() or the powerpc definition of it to be smp_mb()
> > if powerpc unlock/lock is not strengthened.
> 
> Yup. Peter and I would really like to get rid of smp_mb__after_unlock_lock
> entirely, which would mean strengthening the ppc spinlocks. Moving the
> barrier primitive into RCU is a good step to prevent more widespread usage
> of the barrier, but we'd really like to go further if the performance impact
> is deemed acceptable (which is what this thread is about).

OK, sorry for completely missing the point, too many balls in the air here.

I'll do some benchmarks and see what we come up with.

cheers
