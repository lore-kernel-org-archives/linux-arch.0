From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Tue, 14 Jul 2015 00:15:03 +0200
Message-ID: <20150713221503.GD19282@twins.programming.kicks-ass.net>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
 <20150713131143.GY19282@twins.programming.kicks-ass.net>
 <20150713140915.GD2632@arm.com>
 <20150713142109.GE2632@arm.com>
 <20150713155447.GB19282@twins.programming.kicks-ass.net>
 <20150713182332.GW3717@linux.vnet.ibm.com>
 <55A41481.7000702@hurleysoftware.com>
 <20150713201642.GY3717@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:47310 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbbGMWPN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2015 18:15:13 -0400
Content-Disposition: inline
In-Reply-To: <20150713201642.GY3717@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Will Deacon <will.deacon@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Mon, Jul 13, 2015 at 01:16:42PM -0700, Paul E. McKenney wrote:
> On Mon, Jul 13, 2015 at 03:41:53PM -0400, Peter Hurley wrote:
> > > Does that answer the question, or am I missing the point?
> > 
> > Yes, it shows that smp_mb__after_unlock_lock() has no purpose, since it
> > is defined only for PowerPC and your test above just showed that for
> > the sequence

The only purpose is to provide transitivity, but the documentation fails
to explicitly call that out.

> > 
> >   store a
> >   UNLOCK M
> >   LOCK N
> >   store b
> > 
> > a and b is always observed as an ordered pair {a,b}.
> 
> Not quite.
> 
> This is instead the sequence that is of concern:
> 
> 	store a
> 	unlock M
> 	lock N
> 	load b

So its late and that table didn't parse, but that should be ordered too.
The load of b should not be able to escape the lock N.

If only because LWSYNC is a valid RMB and any LOCK implementation must
load the lock state to observe it unlocked.

> > Additionally, the assertion in Documentation/memory_barriers.txt that
> > the sequence above can be reordered as
> > 
> >   LOCK N
> >   store b
> >   store a
> >   UNLOCK M
> > 
> > is not true on any existing arch in Linux.
> 
> It was at one time and might be again.

What would be required to make this true? I'm having a hard time seeing
how things can get reordered like that.
