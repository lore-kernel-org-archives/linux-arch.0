From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Mon, 20 Jul 2015 14:39:06 +0100
Message-ID: <20150720133906.GG9908@arm.com>
References: <1436826689.3948.233.camel@kernel.crashing.org>
 <1436929578.10956.3.camel@ellerman.id.au>
 <20150715104420.GD1005@arm.com>
 <1437012028.28475.2.camel@ellerman.id.au>
 <1437023004.28088.27.camel@kernel.crashing.org>
 <1437023695.28088.29.camel@kernel.crashing.org>
 <20150716151142.GR3717@linux.vnet.ibm.com>
 <1437087265.28088.53.camel@kernel.crashing.org>
 <20150717093221.GB18994@arm.com>
 <1437171254.28088.87.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55809 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753230AbbGTNjI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 20 Jul 2015 09:39:08 -0400
Content-Disposition: inline
In-Reply-To: <1437171254.28088.87.camel@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

On Fri, Jul 17, 2015 at 11:14:14PM +0100, Benjamin Herrenschmidt wrote:
> On Fri, 2015-07-17 at 10:32 +0100, Will Deacon wrote:
> >  static inline void arch_spin_unlock(arch_spinlock_t *lock)
> >  {
> > -       SYNC_IO;
> > -       __asm__ __volatile__("# arch_spin_unlock\n\t"
> > -                               PPC_RELEASE_BARRIER: : :"memory");
> > +       smp_mb();
> >         lock->slock = 0;
> >  }
> 
> That probably needs to be mb() in case somebody has the expectation that
> it does a barrier vs. DMA on UP.

Hmm, but on !SMP doesn't arch_spin_unlock effectively expand to barrier()
in the core code?

Will
