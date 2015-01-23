Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:41803 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbbAWOIl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 23 Jan 2015 09:08:41 -0500
Date: Fri, 23 Jan 2015 14:08:32 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: Behaviour of smp_mb__{before,after}_spin* and acquire/release
Message-ID: <20150123140832.GE23058@arm.com>
References: <20150113163353.GE31784@arm.com>
 <20150120093443.GA11596@twins.programming.kicks-ass.net>
 <20150120213545.GT9719@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150120213545.GT9719@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "oleg@redhat.com" <oleg@redhat.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20150123140832.zjNGKg1cTMEQ6z5OBupFtxC4qQPDq47uYU-1U0elyvA@z>

On Tue, Jan 20, 2015 at 09:35:45PM +0000, Paul E. McKenney wrote:
> On Tue, Jan 20, 2015 at 10:34:43AM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 13, 2015 at 04:33:54PM +0000, Will Deacon wrote:
> > > I started dusting off a series I've been working to implement a relaxed
> > > atomic API in Linux (i.e. things like atomic_read(v, ACQUIRE)) but I'm
> > > having trouble making sense of the ordering semantics we have in mainline
> > > today:
> > 
> > >   2. Does smp_mb__after_unlock_lock order smp_store_release against
> > >      smp_load_acquire? Again, Documentation/memory-barriers.txt puts
> > >      these operations into the RELEASE and ACQUIRE classes respectively,
> > >      but since smp_mb__after_unlock_lock is a NOP everywhere other than
> > >      PowerPC, I don't think this is enforced by the current code. 
> > 
> > Yeah, wasn't Paul going to talk to Ben about that? PPC is the only arch
> > that has the weak ACQUIRE/RELEASE for its spinlocks.
> 
> I thought that you guys were going to propose something and we would see
> what the reaction was.  ;-)

Well, ripping it out is quite easy (patch below) :)

I didn't fully grok the comment in the MCS code, since mcs_lock uses an
xchg, which does have full barrier semantics and therefore mcs_unlock +
mcs_lock also has full barrier semantics afaict.

The remaining problem it that this puts PowerPC back into its original state
(before the barrier) where UNLOCK + LOCK doesn't imply a full barrier, so
that would need to be fixed.

Anyway, kicking this out there for comments.

Will

--->8
