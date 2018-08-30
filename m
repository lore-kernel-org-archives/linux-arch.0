Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:33554 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeHaAtW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Aug 2018 20:49:22 -0400
Date: Thu, 30 Aug 2018 22:45:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Message-ID: <20180830204515.GC24124@hirez.programming.kicks-ass.net>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com>
 <1535629996.4465.44.camel@synopsys.com>
 <20180830141713.GN24082@hirez.programming.kicks-ass.net>
 <20180830142354.GB13005@arm.com>
 <20180830142920.GO24082@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075012B090EA4@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B090EA4@us01wembx1.internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Will Deacon <will.deacon@arm.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "mingo@kernel.org" <mingo@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20180830204515.7eAxKXjLModw1QPKDQyIX-3VjrSuYqlHRXreyHDEGyI@z>

On Thu, Aug 30, 2018 at 08:31:59PM +0000, Vineet Gupta wrote:
> On 08/30/2018 07:29 AM, Peter Zijlstra wrote:
> > On Thu, Aug 30, 2018 at 03:23:55PM +0100, Will Deacon wrote:
> >
> >> Yes, that would be worth trying. However, I also just noticed that the
> >> fetch-ops (which are now used to implement test_and_set_bit_lock()) seem
> >> to be missing the backwards branch in the LL/SC case. Yet another diff
> >> below.
> >>
> >> Will
> >>
> >> --->8
> >>
> >> diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
> >> index 4e0072730241..f06c5ed672b3 100644
> >> --- a/arch/arc/include/asm/atomic.h
> >> +++ b/arch/arc/include/asm/atomic.h
> >> @@ -84,7 +84,7 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
> >>  	"1:	llock   %[orig], [%[ctr]]		\n"		\
> >>  	"	" #asm_op " %[val], %[orig], %[i]	\n"		\
> >>  	"	scond   %[val], [%[ctr]]		\n"		\
> >> -	"						\n"		\
> >> +	"	bnz	1b				\n"		\
> >>  	: [val]	"=&r"	(val),						\
> >>  	  [orig] "=&r" (orig)						\
> >>  	: [ctr]	"r"	(&v->counter),					\
> > ACK!! sorry about that, no idea how I messed that up.
> >
> > Also, once it all works, they should look at switching to _relaxed
> > atomics for LL/SC.
> 
> Indeed this is the mother of all issues, I tried and system is clearly hosed with
> and works after.
> What's amazing is the commit 4aef66c8ae9 which introduced it is from 2016 ;-)
> Back then we had a retry branch with backoff stuff which I'd reverted for new
> cores and the merge conflict somehow missed it.
> 
> @PeterZ I'll create a patch with you as author ? do I need any formal sign offs,
> acks etc ?

Well, Will spotted it, give authorship to him, you have my ack per the
above.

> So after this there are 2 other things to be addresses / looked at still while we
> are still here.
> 
> 1. After 84c6591103db __clear_bit_lock() implementation will be broken (or atleast
> not consistent with what we had after), do we need to reinstate it.
> 2. Will's proposed change to remove the underlying issue, but the issue in #1
> remains ?

No, like explained, for spinlock based atomics the issue _should_ not
exist, and if you look at your atomic_set() implementation for that
variant, you'll see it does the right thing by taking the lock.

Basically atomic_set() for spinlock based atomics ends up being
(void)atomic_xchg().

FWIW, also ACK on Will's patch to switch you over to asm-generic bitops
entirely.
