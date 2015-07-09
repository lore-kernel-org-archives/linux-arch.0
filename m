From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH 15/24] powerpc: Provide atomic_{or,xor,and}
Date: Fri, 10 Jul 2015 07:49:20 +1000
Message-ID: <1436478560.3948.137.camel@kernel.crashing.org>
References: <20150709172855.564686637@infradead.org>
	 <20150709175309.375034448@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:51574 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754046AbbGIVva (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 9 Jul 2015 17:51:30 -0400
In-Reply-To: <20150709175309.375034448@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org

On Thu, 2015-07-09 at 19:29 +0200, Peter Zijlstra wrote:
> Implement atomic logic ops -- atomic_{or,xor,and}.
> 
> These will replace the atomic_{set,clear}_mask functions that are
> available on some archs.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/powerpc/include/asm/atomic.h |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- a/arch/powerpc/include/asm/atomic.h
> +++ b/arch/powerpc/include/asm/atomic.h
> @@ -66,6 +66,9 @@ static __inline__ int atomic_##op##_retu
>  
>  ATOMIC_OPS(add, add)
>  ATOMIC_OPS(sub, subf)
> +ATOMIC_OP(and, and)
> +ATOMIC_OP(or, or)
> +ATOMIC_OP(xor, xor)
>  
>  #undef ATOMIC_OPS
>  #undef ATOMIC_OP_RETURN
> @@ -304,6 +307,9 @@ static __inline__ long atomic64_##op##_r
>  
>  ATOMIC64_OPS(add, add)
>  ATOMIC64_OPS(sub, subf)
> +ATOMIC64_OP(and, and)
> +ATOMIC64_OP(or, or)
> +ATOMIC64_OP(xor, xor)

As long as you are ok that they are non-ordered atomics (no barrier in
them), then

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

>  #undef ATOMIC64_OPS
>  #undef ATOMIC64_OP_RETURN
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
