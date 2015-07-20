From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Mon, 20 Jul 2015 06:48:49 -0700
Message-ID: <20150720134849.GC3717@linux.vnet.ibm.com>
References: <1436929578.10956.3.camel@ellerman.id.au>
 <20150715104420.GD1005@arm.com>
 <1437012028.28475.2.camel@ellerman.id.au>
 <1437023004.28088.27.camel@kernel.crashing.org>
 <1437023695.28088.29.camel@kernel.crashing.org>
 <20150716151142.GR3717@linux.vnet.ibm.com>
 <1437087265.28088.53.camel@kernel.crashing.org>
 <20150717093221.GB18994@arm.com>
 <1437171254.28088.87.camel@kernel.crashing.org>
 <20150720133906.GG9908@arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e37.co.us.ibm.com ([32.97.110.158]:57279 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024AbbGTNs5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jul 2015 09:48:57 -0400
Received: from /spool/local
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 20 Jul 2015 07:48:56 -0600
Content-Disposition: inline
In-Reply-To: <20150720133906.GG9908@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

On Mon, Jul 20, 2015 at 02:39:06PM +0100, Will Deacon wrote:
> On Fri, Jul 17, 2015 at 11:14:14PM +0100, Benjamin Herrenschmidt wrote:
> > On Fri, 2015-07-17 at 10:32 +0100, Will Deacon wrote:
> > >  static inline void arch_spin_unlock(arch_spinlock_t *lock)
> > >  {
> > > -       SYNC_IO;
> > > -       __asm__ __volatile__("# arch_spin_unlock\n\t"
> > > -                               PPC_RELEASE_BARRIER: : :"memory");
> > > +       smp_mb();
> > >         lock->slock = 0;
> > >  }
> > 
> > That probably needs to be mb() in case somebody has the expectation that
> > it does a barrier vs. DMA on UP.
> 
> Hmm, but on !SMP doesn't arch_spin_unlock effectively expand to barrier()
> in the core code?

Yes, to barrier(), but that doesn't generate any code.  In contrast, the
mb() that Ben is asking for puts out a sync instruction.  Without that
sync instruction, MMIO accesses can be reordered with the spin_unlock(),
even on single-CPU systems.  So the bm() is really needed if unlock is
to order against MMIO (and thus DMA) on UP.

							Thanx, Paul
