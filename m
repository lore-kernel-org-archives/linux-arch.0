Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42432 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728990AbeH3S0G (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Aug 2018 14:26:06 -0400
Date: Thu, 30 Aug 2018 15:23:55 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Message-ID: <20180830142354.GB13005@arm.com>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com>
 <1535629996.4465.44.camel@synopsys.com>
 <20180830141713.GN24082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830141713.GN24082@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "mingo@kernel.org" <mingo@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20180830142355.Wcy19tM8g_P7mcqTJNm5-jPXF5dnBxHUF05T_jNuK30@z>

On Thu, Aug 30, 2018 at 04:17:13PM +0200, Peter Zijlstra wrote:
> On Thu, Aug 30, 2018 at 11:53:17AM +0000, Eugeniy Paltsev wrote:
> > I can see crashes with LLSC enabled in both SMP running on 4 cores
> > and SMP running on 1 core.
> 
> So you're running on LL/SC enabled hardware; that would make Will's
> patch irrelevant (although still a good idea for the hardware that does
> care about that spinlocked atomic crud).

Yeah, that's a good point. I think the !LLSC case is broken without my
patch, so we're looking at two bugs...

> Does something like the below cure things? That would confirm the
> suggestion that the change to __clear_bit_unlock() is the curprit.
> 
> If that doesn't cure things, then we've been looking in entirely the
> wrong place.

Yes, that would be worth trying. However, I also just noticed that the
fetch-ops (which are now used to implement test_and_set_bit_lock()) seem
to be missing the backwards branch in the LL/SC case. Yet another diff
below.

Will

--->8

diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 4e0072730241..f06c5ed672b3 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -84,7 +84,7 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
 	"1:	llock   %[orig], [%[ctr]]		\n"		\
 	"	" #asm_op " %[val], %[orig], %[i]	\n"		\
 	"	scond   %[val], [%[ctr]]		\n"		\
-	"						\n"		\
+	"	bnz	1b				\n"		\
 	: [val]	"=&r"	(val),						\
 	  [orig] "=&r" (orig)						\
 	: [ctr]	"r"	(&v->counter),					\
