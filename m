Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:43748 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753611AbeGFL46 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Jul 2018 07:56:58 -0400
Date: Fri, 6 Jul 2018 13:56:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180706115614.GV2476@hirez.programming.kicks-ass.net>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705175059.GE2530@hirez.programming.kicks-ass.net>
 <20180706110129.GC8707@guoren>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706110129.GC8707@guoren>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com, Will Deacon <will.deacon@arm.com>
Message-ID: <20180706115614.NIh65x7vUVdMcsSQ_EUYnvz8D9xXCLqdgEKdnNYMKt8@z>

On Fri, Jul 06, 2018 at 07:01:31PM +0800, Guo Ren wrote:
> On Thu, Jul 05, 2018 at 07:50:59PM +0200, Peter Zijlstra wrote:

> > What's the memory ordering rules for your LDEX/STEX ?
> Every CPU has a local exclusive monitor.
> 
> "Ldex rz, (rx, #off)" will add an entry into the local monitor, and the 
> entry is composed of a address tag and a exclusive flag (inited with 1). 
> Any stores (include other cores') will break the exclusive flag to 0 in
> the entry which could be indexed by the address tag.
> 
> "Stex rz, (rx, #off)" has two condition:
> 1. Store Success: When the entry's exclusive flag is 1, it will store rz
> to the [rx + off] address and the rz will be set to 1.
> 2. Store Failure: When the entry's exclusive flag is 0, just rz will be
> set to 0.

That's how LL/SC works. What I was asking is if they have any effect on
memory ordering. Some architectures have LL/SC imply memory ordering,
most do not.

Going by your spinlock implementation they don't imply any memory
ordering.

> > The mandated semantics for xchg() / cmpxchg() is an effective smp_mb()
> > before _and_ after.
> 
> 	switch (size) {						\
> 	case 4:							\
> 		smp_mb();					\
> 		asm volatile (					\
> 		"1:	ldex.w		%0, (%3) \n"		\
> 		"	mov		%1, %2   \n"		\
> 		"	stex.w		%1, (%3) \n"		\
> 		"	bez		%1, 1b   \n"		\
> 			: "=&r" (__ret), "=&r" (tmp)		\
> 			: "r" (__new), "r"(__ptr)		\
> 			: "memory");				\
> 		smp_mb();					\
> 		break;						\
> Hmm?
> But I couldn't undertand what's wrong without the 1th smp_mb()?
> 1th smp_mb will make all ld/st finish before ldex.w. Is it necessary?

Yes.

	CPU0			CPU1

	r1 = READ_ONCE(x);	WRITE_ONCE(y, 1);
	r2 = xchg(&y, 2);	smp_store_release(&x, 1);

must not allow: r1==1 && r2==0

> > The above implementation suggests LDEX implies a SYNC.IS, is this
> > correct?
> No, ldex doesn't imply a sync.is.

Right, as per the spinlock emails, then your proposed primitives are
incorrect.
