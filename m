From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Mon, 13 Jul 2015 11:23:33 -0700
Message-ID: <20150713182332.GW3717@linux.vnet.ibm.com>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
 <20150713131143.GY19282@twins.programming.kicks-ass.net>
 <20150713140915.GD2632@arm.com>
 <20150713142109.GE2632@arm.com>
 <20150713155447.GB19282@twins.programming.kicks-ass.net>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:51426 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbbGMSXk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2015 14:23:40 -0400
Received: from /spool/local
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 13 Jul 2015 12:23:40 -0600
Content-Disposition: inline
In-Reply-To: <20150713155447.GB19282@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Mon, Jul 13, 2015 at 05:54:47PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 13, 2015 at 03:21:10PM +0100, Will Deacon wrote:
> > On Mon, Jul 13, 2015 at 03:09:15PM +0100, Will Deacon wrote:
> > > On Mon, Jul 13, 2015 at 02:11:43PM +0100, Peter Zijlstra wrote:
> > > > On Mon, Jul 13, 2015 at 01:15:04PM +0100, Will Deacon wrote:
> > > > > smp_mb__after_unlock_lock is used to promote an UNLOCK + LOCK sequence
> > > > > into a full memory barrier.
> > > > > 
> > > > > However:
> > > > 
> > > > >   - The barrier only applies to UNLOCK + LOCK, not general
> > > > >     RELEASE + ACQUIRE operations
> > > > 
> > > > No it does too; note that on ppc both acquire and release use lwsync and
> > > > two lwsyncs do not make a sync.
> > > 
> > > Really? IIUC, that means smp_mb__after_unlock_lock needs to be a full
> > > barrier on all architectures implementing smp_store_release as smp_mb() +
> > > STORE, otherwise the following isn't ordered:
> > > 
> > >   RELEASE X
> > >   smp_mb__after_unlock_lock()
> > >   ACQUIRE Y
> > > 
> > > On 32-bit ARM (at least), the ACQUIRE can be observed before the RELEASE.
> > 
> > I knew we'd had this conversation before ;)
> > 
> >   http://lkml.kernel.org/r/20150120093443.GA11596@twins.programming.kicks-ass.net
> 
> Ha! yes. And I had indeed forgotten about this argument.
> 
> However I think we should look at the insides of the critical sections;
> for example (from Documentation/memory-barriers.txt):
> 
> "       *A = a;
>         RELEASE M
>         ACQUIRE N
>         *B = b;
> 
> could occur as:
> 
>         ACQUIRE N, STORE *B, STORE *A, RELEASE M"
> 
> This could not in fact happen, even though we could flip M and N, A and
> B will remain strongly ordered.
> 
> That said, I don't think this could even happen on PPC because we have
> load_acquire and store_release, this means that:
> 
> 	*A = a
> 	lwsync
> 	store_release M
> 	load_acquire N
> 	lwsync

Presumably the lwsync instructions are part of the store_release and
load_acquire?

> 	*B = b
> 
> And since the store to M is wrapped inside two lwsync there must be
> strong store order, and because the load from N is equally wrapped in
> two lwsyncs there must also be strong load order.
> 
> In fact, no store/load can cross from before the first lwsync to after
> the latter and the other way around.
> 
> So in that respect it does provide full load-store ordering. What it
> does not provide is order for M and N, nor does it provide transitivity,
> but looking at our documentation I'm not at all sure we guarantee that
> in any case.

I have no idea what the other thread is doing, so I put together the
following litmus test, guessing reverse order, inverse operations,
and full ordering:

	PPC peterz.2015.07.13a
	""
	{
	0:r1=1; 0:r2=a; 0:r3=b; 0:r4=m; 0:r5=n;
	1:r1=1; 1:r2=a; 1:r3=b; 1:r4=m; 1:r5=n;
	}
	 P0            | P1            ;
	 stw r1,0(r2)  | lwz r10,0(r3) ;
	 lwsync        | sync          ;
	 stw r1,0(r4)  | stw r1,0(r5)  ;
	 lwz r10,0(r5) | sync          ;
	 lwsync        | lwz r11,0(r4) ;
	 stw r1,0(r3)  | sync          ;
		       | lwz r12,0(r2) ;
	exists
	(0:r10=0 /\ 1:r10=1 /\ 1:r11=1 /\ 1:r12=1)

See http://lwn.net/Articles/608550/ and http://lwn.net/Articles/470681/
for information on tools that operate on these litmus tests.  (Both
the herd and ppcmem tools agree, as is usually the case.)

Of the 16 possible combinations of values loaded, the following seven
can happen:

	0:r10=0; 1:r10=0; 1:r11=0; 1:r12=0;
	0:r10=0; 1:r10=0; 1:r11=0; 1:r12=1;
	0:r10=0; 1:r10=0; 1:r11=1; 1:r12=1;
	0:r10=0; 1:r10=1; 1:r11=1; 1:r12=1;
	0:r10=1; 1:r10=0; 1:r11=0; 1:r12=0;
	0:r10=1; 1:r10=0; 1:r11=0; 1:r12=1;
	0:r10=1; 1:r10=0; 1:r11=1; 1:r12=1;

P0's store to "m" and load from "n" can clearly be misordered, as there
is nothing to order them.  And all four possible outcomes for 0:r10 and
1:r11 are seen, as expected.

Given that smp_store_release() is only guaranteed to order against prior
operations and smp_load_acquire() is only guaranteed to order against
subsequent operations, P0's load from "n" can be misordered with its
store to "a", and as expected, all four possible outcomes for 0:r10 and
1:r12 are observed.

P0's pairs of stores should all be ordered:

o	"a" and "m" -> 1:r11=1 and 1:r12=0 cannot happen, as expected.

o	"a" and "b" -> 1:r10=1 and 1:r12=0 cannot happen, as expected.

o	"m" and "b" -> 1:r10=1 and 1:r11=0 cannot happen, as expected.

So smp_load_acquire() orders against all subsequent operations, but not
necessarily against any prior ones, and smp_store_release() orders against
all prior operations but not necessarily against any subsequent onse.
But additional stray orderings are permitted, as is the case here.
Which is in fact what these operations are defined to do.

Does that answer the question, or am I missing the point?

							Thanx, Paul
