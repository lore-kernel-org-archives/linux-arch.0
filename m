From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 27/31] locking: Remove linux/atomic.h:atomic_fetch_or
Date: Fri, 22 Apr 2016 16:21:50 +0200
Message-ID: <20160422142150.GR3430@twins.programming.kicks-ass.net>
References: <20160422090413.393652501@infradead.org>
 <20160422093924.799805337@infradead.org>
 <20160422130256.GG10289@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:41181 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbcDVOWY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Apr 2016 10:22:24 -0400
Content-Disposition: inline
In-Reply-To: <20160422130256.GG10289@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de, fengguang.wu@intel.com

On Fri, Apr 22, 2016 at 02:02:56PM +0100, Will Deacon wrote:
> On Fri, Apr 22, 2016 at 11:04:40AM +0200, Peter Zijlstra wrote:
> > --- a/arch/arm64/include/asm/atomic.h
> > +++ b/arch/arm64/include/asm/atomic.h
> > @@ -128,8 +128,6 @@
> >  #define __atomic_add_unless(v, a, u)	___atomic_add_unless(v, a, u,)
> >  #define atomic_andnot			atomic_andnot
> >  
> > -#define atomic_fetch_or atomic_fetch_or
> 
> For some reason, you added this twice to our atomic.h, so there's still
> one left after this patch.

Ah, yes. One was because of the whole _relaxed generate business, this
one is because of this generic atomic_fetch_or() thing.

I went through the arch/*/include/asm/atomic*.h files pretty much
without thinking to add this one.

The end result after this patch should be good though, we have
atomic_fetch_or_relaxed and do not want to generate atomic_fetch_or()
using smp_mb__{before,after}_atomic() because arm64 is 'special' :-)
