Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:52400 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932343AbeGFMDt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Jul 2018 08:03:49 -0400
Date: Fri, 6 Jul 2018 14:03:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180706120323.GW2476@hirez.programming.kicks-ass.net>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705175902.GF2530@hirez.programming.kicks-ass.net>
 <20180706114402.GB27148@guoren>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706114402.GB27148@guoren>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
Message-ID: <20180706120323.Zous8nckfPSZpbdB6ZqGrDx7P0f1NVL0o22liS3Rpis@z>

On Fri, Jul 06, 2018 at 07:44:03PM +0800, Guo Ren wrote:
> On Thu, Jul 05, 2018 at 07:59:02PM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 02, 2018 at 01:30:14AM +0800, Guo Ren wrote:
> > 
> > > +static inline void arch_spin_lock(arch_spinlock_t *lock)
> > > +{
> > > +	unsigned int *p = &lock->lock;
> > > +	unsigned int tmp;
> > > +
> > > +	asm volatile (
> > > +		"1:	ldex.w		%0, (%1) \n"
> > > +		"	bnez		%0, 1b   \n"
> > > +		"	movi		%0, 1    \n"
> > > +		"	stex.w		%0, (%1) \n"
> > > +		"	bez		%0, 1b   \n"
> > > +		: "=&r" (tmp)
> > > +		: "r"(p)
> > > +		: "memory");
> > > +	smp_mb();
> > > +}
> > 
> > Test-and-set with MB acting as ACQUIRE, ok.
> Em ... Ok, I'll try to use test-and-set function instead of it.

"test-and-set" is just the name of this type of spinlock implementation.

You _could_ use the linux test_and_set bitop, but those are defined on
unsigned long and spinlock_t is generally assumed to be of unsigned int
size.

Go with the ticket locks as per below.

> > Also, the fact that you need MB for release implies your LDEX does not
> > in fact imply anything and your xchg/cmpxchg implementation is broken.
> xchg/cmxchg broken without 1th smp_mb()? Why we need protect the
> instructions flow before the ldex.w?

See the email I send earlier in that thread.

> Ok, I'll try to implement ticket lock in next version patch.

If you need inspiration, look at:

  git show 81bb5c6420635dfd058c210bd342c29c95ccd145^1:arch/arm64/include/asm/spinlock.h

Or look at the current version of that file and ignore the LSE version.

Note that unlock is a store half-word (u16), not having seen your arch
manual yet I don't know if you even have that.
