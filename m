From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Date: Thu, 30 Aug 2018 16:29:20 +0200
Message-ID: <20180830142920.GO24082@hirez.programming.kicks-ass.net>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com>
 <1535629996.4465.44.camel@synopsys.com>
 <20180830141713.GN24082@hirez.programming.kicks-ass.net>
 <20180830142354.GB13005@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180830142354.GB13005@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "mingo@kernel.org" <mingo@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Aug 30, 2018 at 03:23:55PM +0100, Will Deacon wrote:

> Yes, that would be worth trying. However, I also just noticed that the
> fetch-ops (which are now used to implement test_and_set_bit_lock()) seem
> to be missing the backwards branch in the LL/SC case. Yet another diff
> below.
> 
> Will
> 
> --->8
> 
> diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
> index 4e0072730241..f06c5ed672b3 100644
> --- a/arch/arc/include/asm/atomic.h
> +++ b/arch/arc/include/asm/atomic.h
> @@ -84,7 +84,7 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
>  	"1:	llock   %[orig], [%[ctr]]		\n"		\
>  	"	" #asm_op " %[val], %[orig], %[i]	\n"		\
>  	"	scond   %[val], [%[ctr]]		\n"		\
> -	"						\n"		\
> +	"	bnz	1b				\n"		\
>  	: [val]	"=&r"	(val),						\
>  	  [orig] "=&r" (orig)						\
>  	: [ctr]	"r"	(&v->counter),					\

ACK!! sorry about that, no idea how I messed that up.

Also, once it all works, they should look at switching to _relaxed
atomics for LL/SC.
