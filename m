Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:45138 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEaIX1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 04:23:27 -0400
Date: Fri, 31 May 2019 10:23:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
Message-ID: <20190531082322.GI2623@hirez.programming.kicks-ass.net>
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
 <20190530185358.GG28207@linux.ibm.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A2520D9C@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A2520D9C@us01wembx1.internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>, Will Deacon <Will.Deacon@arm.com>, arcml <linux-snps-arc@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190531082322.qSfkwatG20Z-kr5R6OYgyHYilOaDAbgWRbeq4cjKC8M@z>

On Thu, May 30, 2019 at 07:16:36PM +0000, Vineet Gupta wrote:
> On 5/30/19 11:55 AM, Paul E. McKenney wrote:
> >
> >> I'm not sure how to interpret "natural alignment" for the case of double
> >> load/stores on 32-bit systems where the hardware and ABI allow for 4 byte
> >> alignment (ARCv2 LDD/STD, ARM LDRD/STRD ....)
> >>
> >> I presume (and the question) that lkmm doesn't expect such 8 byte load/stores to
> >> be atomic unless 8-byte aligned
> > I would not expect 8-byte accesses to be atomic on 32-bit systems unless
> > some special instruction was in use.  But that usually means special
> > intrinsics or assembly code.
> 
> Thx for confirming.
> 
> In cases where we *do* expect the atomicity, it seems there's some existing type
> checking but isn't water tight.
> e.g.
> 
> #define __smp_load_acquire(p)                        \
> ({                                    \
>     typeof(*p) ___p1 = READ_ONCE(*p);                \
>     compiletime_assert_atomic_type(*p);                \
>     __smp_mb();                            \
>     ___p1;                                \
> })
> 
> #define compiletime_assert_atomic_type(t)                \
>     compiletime_assert(__native_word(t),                \
>         "Need native word sized stores/loads for atomicity.")
> 
> #define __native_word(t) \
>     (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
>      sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
> 
> 
> So it won't catch the usage of 4 byte aligned long long which gcc targets to
> single double load instruction.

Yes, we didn't do those because that would result in runtime overhead.

We assume natural alignment for any type the hardware can do.
