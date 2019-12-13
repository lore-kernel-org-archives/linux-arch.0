Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f42.google.com ([209.85.128.42]:36828 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMO2w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Dec 2019 09:28:52 -0500
Date: Fri, 13 Dec 2019 15:28:46 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Message-ID: <20191213142846.ki2t2fwljnql66lt@ltop.local>
References: <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck>
 <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck>
 <20191212202157.GD11457@worktop.programming.kicks-ass.net>
 <20191212205338.GB11802@worktop.programming.kicks-ass.net>
 <20191213104706.xnpqaehmtean3mkd@ltop.local>
 <20191213125618.GD2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213125618.GD2844@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch <linux-arch@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Segher Boessenkool <segher@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20191213142846.CCgH3L8uPAsu6GuKvU3CqIcqx0aMK3oP5I5DCm_EAT4@z>

On Fri, Dec 13, 2019 at 01:56:18PM +0100, Peter Zijlstra wrote:
> 
> Excellent! I had to change it to something like:
> 
> #define unqual_typeof(x)    typeof(({_Atomic typeof(x) ___x __maybe_unused; ___x; }))
> 
> but that does indeed work!
> 
> Now I suppose we should wrap that in a symbol that indicates our
> compiler does indeed support _Atomic, otherwise things will come apart.
> 
> That is, my gcc-4.6 doesn't seem to have it, while gcc-4.8 does, which
> is exactly the range that needs the daft READ_ONCE() construct, how
> convenient :/
> 
> Something a little like this perhaps?

Yes, this looks good to me.
Just a small nit here below.

> ---
> 
> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index 7d9cc5ec4971..c389af602da8 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -75,9 +75,9 @@ static inline unsigned long array_index_mask_nospec(unsigned long idx,
>  
>  #define __smp_store_release(p, v)					\
>  do {									\
> -	typeof(p) __p = (p);						\
> -	union { typeof(*p) __val; char __c[1]; } __u =			\
> -		{ .__val = (__force typeof(*p)) (v) };			\
> +	unqual_typeof(p) __p = (p);					\
> +	union { unqual_typeof(*p) __val; char __c[1]; } __u =	\
> +		{ .__val = (__force unqual_typeof(*p)) (v) };	\

The 2 two trailing backslashes are now off by one tab.

-- Luc 
