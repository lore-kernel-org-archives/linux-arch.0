From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
Date: Thu, 23 Jul 2020 13:40:10 +0200
Message-ID: <20200723114010.GO5523@worktop.programming.kicks-ass.net>
References: <20200723105615.1268126-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGWLkU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 07:40:20 -0400
Content-Disposition: inline
In-Reply-To: <20200723105615.1268126-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>

On Thu, Jul 23, 2020 at 08:56:14PM +1000, Nicholas Piggin wrote:

> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index 3a0db7b0b46e..35060be09073 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -200,17 +200,14 @@ static inline bool arch_irqs_disabled(void)
>  #define powerpc_local_irq_pmu_save(flags)			\
>  	 do {							\
>  		raw_local_irq_pmu_save(flags);			\
> -		trace_hardirqs_off();				\
> +		if (!raw_irqs_disabled_flags(flags))		\
> +			trace_hardirqs_off();			\
>  	} while(0)
>  #define powerpc_local_irq_pmu_restore(flags)			\
>  	do {							\
> -		if (raw_irqs_disabled_flags(flags)) {		\
> -			raw_local_irq_pmu_restore(flags);	\
> -			trace_hardirqs_off();			\
> -		} else {					\
> +		if (!raw_irqs_disabled_flags(flags))		\
>  			trace_hardirqs_on();			\
> -			raw_local_irq_pmu_restore(flags);	\
> -		}						\
> +		raw_local_irq_pmu_restore(flags);		\
>  	} while(0)

You shouldn't be calling lockdep from NMI context! That is, I recently
added suport for that on x86:

  https://lkml.kernel.org/r/20200623083721.155449112@infradead.org
  https://lkml.kernel.org/r/20200623083721.216740948@infradead.org

But you need to be very careful on how you order things, as you can see
the above relies on preempt_count() already having been incremented with
NMI_MASK.
