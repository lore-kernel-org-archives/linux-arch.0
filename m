From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 18/28] ARC: add smp barriers around atomics per
 memory-barrriers.txt
Date: Wed, 10 Jun 2015 12:53:23 +0200
Message-ID: <20150610105323.GF3644@twins.programming.kicks-ass.net>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
 <1433850508-26317-19-git-send-email-vgupta@synopsys.com>
 <20150609123024.GX3644@twins.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075665A4FEA@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:58302 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbbFJKx2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jun 2015 06:53:28 -0400
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075665A4FEA@IN01WEMBXB.internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Wed, Jun 10, 2015 at 09:17:16AM +0000, Vineet Gupta wrote:
> >> --- a/arch/arc/include/asm/spinlock.h
> >> +++ b/arch/arc/include/asm/spinlock.h
> >> @@ -22,24 +22,32 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
> >>  {
> >>  	unsigned int tmp = __ARCH_SPIN_LOCK_LOCKED__;
> >>  
> >> +	smp_mb();
> >> +
> >>  	__asm__ __volatile__(
> >>  	"1:	ex  %0, [%1]		\n"
> >>  	"	breq  %0, %2, 1b	\n"
> >>  	: "+&r" (tmp)
> >>  	: "r"(&(lock->slock)), "ir"(__ARCH_SPIN_LOCK_LOCKED__)
> >>  	: "memory");
> >> +
> >> +	smp_mb();
> >>  }

> > Both these are only required to provide an ACQUIRE barrier, if all you
> > have is smp_mb(), the second is sufficient.
> 
> Essentially ARCv2 is weakly ordered with explicit ordering provided by DMB
> instructions with semantics load/load, store/store, all/all.
> 
> I wanted to clarify a couple of things
> (1) ACQUIRE barrier implies store/{store,load} while RELEASE implies
> {load,store}/store and given what DMB provides for ARCv2, smp_mb() is the only fit ?

Please see Documentation/memory-barriers.txt, but a quick recap:

 - ACQUIRE: both loads and stores before to the barrier are allowed to
   be observed after it.  Neither loads nor stores after the barrier are
   allowed to be observed before it.

 - RELEASE: both loads and stores before it must be observed before the
   barrier. However, any load or store after it may be observed before
   it.

Therefore:

 X = Y = 0;

	[S] X = 1
	    ACQUIRE

	    RELEASE
	[S] Y = 1

is in fact fully unordered, because both stores are allowed to cross in,
and could cross one another on the inside, like:

	    ACQUIRE
	[S] Y = 1
	[S] X = 1
	    RELEASE

> (2) Do we need smp_mb() on both sides of spin lock/unlock - doesn't ACQUIRE imply
> we have a smp_mb() after lock but before any subsequent critical section - so the
> top hunk is not necessarily needed. Similarly RELEASE requires a smp_mb() before
> the memory operation for lock, but not after.

You do not need an smp_mb() on both sides, as you say, after lock and
before unlock is sufficient. The main point being that things can not
escape out of the critical section. Its fine for them to leak in.
