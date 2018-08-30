Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:51014 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbeH3STl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Aug 2018 14:19:41 -0400
Date: Thu, 30 Aug 2018 16:17:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Message-ID: <20180830141713.GN24082@hirez.programming.kicks-ass.net>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com>
 <1535629996.4465.44.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535629996.4465.44.camel@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: "will.deacon@arm.com" <will.deacon@arm.com>, "mingo@kernel.org" <mingo@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20180830141713.pwwvb0M3p4jOpgtLI7nN4ctXNt7UNu7k0Bxd22p0Ebk@z>

On Thu, Aug 30, 2018 at 11:53:17AM +0000, Eugeniy Paltsev wrote:
> I can see crashes with LLSC enabled in both SMP running on 4 cores
> and SMP running on 1 core.

So you're running on LL/SC enabled hardware; that would make Will's
patch irrelevant (although still a good idea for the hardware that does
care about that spinlocked atomic crud).

Does something like the below cure things? That would confirm the
suggestion that the change to __clear_bit_unlock() is the curprit.

If that doesn't cure things, then we've been looking in entirely the
wrong place.

---
diff --git a/include/asm-generic/bitops/lock.h b/include/asm-generic/bitops/lock.h
index 3ae021368f48..79c6978152f8 100644
--- a/include/asm-generic/bitops/lock.h
+++ b/include/asm-generic/bitops/lock.h
@@ -57,12 +57,7 @@ static inline void clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
 static inline void __clear_bit_unlock(unsigned int nr,
 				      volatile unsigned long *p)
 {
-	unsigned long old;
-
-	p += BIT_WORD(nr);
-	old = READ_ONCE(*p);
-	old &= ~BIT_MASK(nr);
-	atomic_long_set_release((atomic_long_t *)p, old);
+	clear_bit_unlock(nr, p);
 }
 
 /**
