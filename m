Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:57320 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbbGMWxw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2015 18:53:52 -0400
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 13 Jul 2015 16:53:51 -0600
Date: Mon, 13 Jul 2015 15:53:43 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Message-ID: <20150713225343.GA3717@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
 <20150713131143.GY19282@twins.programming.kicks-ass.net>
 <20150713140915.GD2632@arm.com>
 <20150713142109.GE2632@arm.com>
 <20150713155447.GB19282@twins.programming.kicks-ass.net>
 <20150713182332.GW3717@linux.vnet.ibm.com>
 <55A41481.7000702@hurleysoftware.com>
 <20150713201642.GY3717@linux.vnet.ibm.com>
 <20150713221503.GD19282@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150713221503.GD19282@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, Will Deacon <will.deacon@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20150713225343.b7DxFztOcIKxd5JEV451SE6pNhQexSflXWT0UDjovKE@z>

On Tue, Jul 14, 2015 at 12:15:03AM +0200, Peter Zijlstra wrote:
> On Mon, Jul 13, 2015 at 01:16:42PM -0700, Paul E. McKenney wrote:
> > On Mon, Jul 13, 2015 at 03:41:53PM -0400, Peter Hurley wrote:
> > > > Does that answer the question, or am I missing the point?
> > > 
> > > Yes, it shows that smp_mb__after_unlock_lock() has no purpose, since it
> > > is defined only for PowerPC and your test above just showed that for
> > > the sequence
> 
> The only purpose is to provide transitivity, but the documentation fails
> to explicitly call that out.

It does say that it is a full barrier, but I added explicit mention of
transitivity.

> > > 
> > >   store a
> > >   UNLOCK M
> > >   LOCK N
> > >   store b
> > > 
> > > a and b is always observed as an ordered pair {a,b}.
> > 
> > Not quite.
> > 
> > This is instead the sequence that is of concern:
> > 
> > 	store a
> > 	unlock M
> > 	lock N
> > 	load b
> 
> So its late and that table didn't parse, but that should be ordered too.
> The load of b should not be able to escape the lock N.
> 
> If only because LWSYNC is a valid RMB and any LOCK implementation must
> load the lock state to observe it unlocked.

If you actually hold a given lock, then yes, you will observe anything
previously done while holding that same lock, even if you don't use
smp_mb__after_unlock_lock().  The smp_mb__after_unlock_lock() comes into
play when code not holding a lock needs to see the ordering.  RCU needs
this because of the strong ordering that grace periods must provide:
regardless of who started or ended the grace period, anything on any
CPU preceding a given grace period is fully ordered before anything on
any CPU following that same grace period.  It is not clear to me that
anything else would need such strong ordering.

> > > Additionally, the assertion in Documentation/memory_barriers.txt that
> > > the sequence above can be reordered as
> > > 
> > >   LOCK N
> > >   store b
> > >   store a
> > >   UNLOCK M
> > > 
> > > is not true on any existing arch in Linux.
> > 
> > It was at one time and might be again.
> 
> What would be required to make this true? I'm having a hard time seeing
> how things can get reordered like that.

You are right, I failed to merge current and past knowledge.  At one time,
Itanium was said to allow things to bleed into lock-based critical sections.
However, we now know that ld,acq and st,rel really do full ordering.

Compilers might one day do this sort of reordering, but I would guess
that Linux kernel builds would disable this sort of thing.  Something
about wanting critical sections to remain small.

							Thanx, Paul

