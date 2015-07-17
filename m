From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Fri, 17 Jul 2015 05:40:40 -0700
Message-ID: <20150717124040.GB3717@linux.vnet.ibm.com>
References: <1436826689.3948.233.camel@kernel.crashing.org>
 <1436929578.10956.3.camel@ellerman.id.au>
 <20150715104420.GD1005@arm.com>
 <1437012028.28475.2.camel@ellerman.id.au>
 <1437023004.28088.27.camel@kernel.crashing.org>
 <1437023695.28088.29.camel@kernel.crashing.org>
 <20150716151142.GR3717@linux.vnet.ibm.com>
 <1437087265.28088.53.camel@kernel.crashing.org>
 <20150717093221.GB18994@arm.com>
 <20150717101535.GR3644@twins.programming.kicks-ass.net>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:45969 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180AbbGQMkw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2015 08:40:52 -0400
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 17 Jul 2015 06:40:51 -0600
Content-Disposition: inline
In-Reply-To: <20150717101535.GR3644@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jul 17, 2015 at 12:15:35PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 17, 2015 at 10:32:21AM +0100, Will Deacon wrote:
> > @@ -158,9 +140,7 @@ void arch_spin_lock_flags(arch_spinlock_t *lock, unsigned long flags)
> >  
> >  static inline void arch_spin_unlock(arch_spinlock_t *lock)
> >  {
> > -	SYNC_IO;
> > -	__asm__ __volatile__("# arch_spin_unlock\n\t"
> > -				PPC_RELEASE_BARRIER: : :"memory");
> > +	smp_mb();
> >  	lock->slock = 0;
> >  }
> 
> Should we then also make smp_store_release() use sync instead of lwsync
> to keep it consistent?

Unless smp_store_release() needs to interact with MMIO accesses, it
should still be able to be lwsync.  This means that unlock-lock is a full
barrier, but relase-acquire is not necessarily, which should be just fine.

							Thanx, Paul
