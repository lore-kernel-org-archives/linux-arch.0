From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Mon, 13 Jul 2015 17:54:47 +0200
Message-ID: <20150713155447.GB19282@twins.programming.kicks-ass.net>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
 <20150713131143.GY19282@twins.programming.kicks-ass.net>
 <20150713140915.GD2632@arm.com>
 <20150713142109.GE2632@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56684 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbbGMPy4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2015 11:54:56 -0400
Content-Disposition: inline
In-Reply-To: <20150713142109.GE2632@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>

On Mon, Jul 13, 2015 at 03:21:10PM +0100, Will Deacon wrote:
> On Mon, Jul 13, 2015 at 03:09:15PM +0100, Will Deacon wrote:
> > On Mon, Jul 13, 2015 at 02:11:43PM +0100, Peter Zijlstra wrote:
> > > On Mon, Jul 13, 2015 at 01:15:04PM +0100, Will Deacon wrote:
> > > > smp_mb__after_unlock_lock is used to promote an UNLOCK + LOCK sequence
> > > > into a full memory barrier.
> > > > 
> > > > However:
> > > 
> > > >   - The barrier only applies to UNLOCK + LOCK, not general
> > > >     RELEASE + ACQUIRE operations
> > > 
> > > No it does too; note that on ppc both acquire and release use lwsync and
> > > two lwsyncs do not make a sync.
> > 
> > Really? IIUC, that means smp_mb__after_unlock_lock needs to be a full
> > barrier on all architectures implementing smp_store_release as smp_mb() +
> > STORE, otherwise the following isn't ordered:
> > 
> >   RELEASE X
> >   smp_mb__after_unlock_lock()
> >   ACQUIRE Y
> > 
> > On 32-bit ARM (at least), the ACQUIRE can be observed before the RELEASE.
> 
> I knew we'd had this conversation before ;)
> 
>   http://lkml.kernel.org/r/20150120093443.GA11596@twins.programming.kicks-ass.net

Ha! yes. And I had indeed forgotten about this argument.

However I think we should look at the insides of the critical sections;
for example (from Documentation/memory-barriers.txt):

"       *A = a;
        RELEASE M
        ACQUIRE N
        *B = b;

could occur as:

        ACQUIRE N, STORE *B, STORE *A, RELEASE M"

This could not in fact happen, even though we could flip M and N, A and
B will remain strongly ordered.

That said, I don't think this could even happen on PPC because we have
load_acquire and store_release, this means that:

	*A = a
	lwsync
	store_release M
	load_acquire N
	lwsync
	*B = b

And since the store to M is wrapped inside two lwsync there must be
strong store order, and because the load from N is equally wrapped in
two lwsyncs there must also be strong load order.

In fact, no store/load can cross from before the first lwsync to after
the latter and the other way around.

So in that respect it does provide full load-store ordering. What it
does not provide is order for M and N, nor does it provide transitivity,
but looking at our documentation I'm not at all sure we guarantee that
in any case.
