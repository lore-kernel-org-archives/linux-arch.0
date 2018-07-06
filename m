Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:56843 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932348AbeGFLog (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Jul 2018 07:44:36 -0400
Date: Fri, 6 Jul 2018 19:44:03 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180706114402.GB27148@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705175902.GF2530@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705175902.GF2530@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
Message-ID: <20180706114403.UFZaS7H62gIVNVa382VYZ5VwDhGHUrbboGONnZD5l8k@z>

On Thu, Jul 05, 2018 at 07:59:02PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 02, 2018 at 01:30:14AM +0800, Guo Ren wrote:
> 
> > +static inline void arch_spin_lock(arch_spinlock_t *lock)
> > +{
> > +	unsigned int *p = &lock->lock;
> > +	unsigned int tmp;
> > +
> > +	asm volatile (
> > +		"1:	ldex.w		%0, (%1) \n"
> > +		"	bnez		%0, 1b   \n"
> > +		"	movi		%0, 1    \n"
> > +		"	stex.w		%0, (%1) \n"
> > +		"	bez		%0, 1b   \n"
> > +		: "=&r" (tmp)
> > +		: "r"(p)
> > +		: "memory");
> > +	smp_mb();
> > +}
> 
> Test-and-set with MB acting as ACQUIRE, ok.
Em ... Ok, I'll try to use test-and-set function instead of it.

> > +static inline void arch_spin_unlock(arch_spinlock_t *lock)
> > +{
> > +	unsigned int *p = &lock->lock;
> > +	unsigned int tmp;
> > +
> > +	smp_mb();
> > +	asm volatile (
> > +		"1:	ldex.w		%0, (%1) \n"
> > +		"	movi		%0, 0    \n"
> > +		"	stex.w		%0, (%1) \n"
> > +		"	bez		%0, 1b   \n"
> > +		: "=&r" (tmp)
> > +		: "r"(p)
> > +		: "memory");
> > +}
> 
> MB acting for RELEASE, but _why_ are you using a LDEX/STEX to clear the
> lock word? Would not a normal store work?
Normal store is enough, I'll fixup it in next version patch.
 
> Also, the fact that you need MB for release implies your LDEX does not
> in fact imply anything and your xchg/cmpxchg implementation is broken.
xchg/cmxchg broken without 1th smp_mb()? Why we need protect the
instructions flow before the ldex.w?

> > +static inline int arch_spin_trylock(arch_spinlock_t *lock)
> > +{
> > +	unsigned int *p = &lock->lock;
> > +	unsigned int tmp;
> > +
> > +	asm volatile (
> > +		"1:	ldex.w		%0, (%1) \n"
> > +		"	bnez		%0, 2f   \n"
> > +		"	movi		%0, 1    \n"
> > +		"	stex.w		%0, (%1) \n"
> > +		"	bez		%0, 1b   \n"
> > +		"	movi		%0, 0    \n"
> > +		"2:				 \n"
> > +		: "=&r" (tmp)
> > +		: "r"(p)
> > +		: "memory");
> > +	smp_mb();
> > +
> > +	return !tmp;
> > +}
> 
> Strictly speaking you can avoid the MB on failure. You only need to
> provide ACQUIRE semantics on success.
> 
> That said, I would really suggest you implement a ticket lock instead of
> a test-and-set lock. They're not really all that complicated and do
> provide better worst case behaviour.
Ok, I'll try to implement ticket lock in next version patch.

> 
> 
> > +/****** read lock/unlock/trylock ******/
> 
> Please have a look at using qrwlock -- esp. if you implement a ticket
> lock, then the rwlock comes for 'free'.
Ok, I'll try it.

 Guo Ren
