Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:48092 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfDLSNy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Apr 2019 14:13:54 -0400
Date: Fri, 12 Apr 2019 20:13:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: 1808d65b55 ("asm-generic/tlb: Remove arch_tlb*_mmu()"):  BUG:
 KASAN: stack-out-of-bounds in __change_page_attr_set_clr
Message-ID: <20190412181335.GB12232@hirez.programming.kicks-ass.net>
References: <5cae03c4.iIPk2cWlfmzP0Zgy%lkp@intel.com>
 <20190411193906.GA12232@hirez.programming.kicks-ass.net>
 <20190411195424.GL14281@hirez.programming.kicks-ass.net>
 <20190411211348.GA8451@worktop.programming.kicks-ass.net>
 <20190412105633.GM14281@hirez.programming.kicks-ass.net>
 <20190412111756.GO14281@hirez.programming.kicks-ass.net>
 <F18AF0D5-D8B4-4F4B-8469-F9DEC49683C7@vmware.com>
 <E33FDED8-8B95-431D-9AC7-71D45AB49011@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E33FDED8-8B95-431D-9AC7-71D45AB49011@vmware.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nadav Amit <namit@vmware.com>
Cc: kernel test robot <lkp@intel.com>, LKP <lkp@01.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Dave Hansen <dave.hansen@intel.com>
Message-ID: <20190412181335.nf9zHs_p3oJlCrwr0kkehIiWd9C9KzxFQ_P2pECxfwg@z>

On Fri, Apr 12, 2019 at 05:05:53PM +0000, Nadav Amit wrote:
> Peter, what do you say about this one? I assume there are no nested TLB
> flushes, but the code can easily be adapted (assuming there is a limit on
> the nesting level).

Possible. Althoug at this point I think we should just remove the
alignment, and them maybe do this on top later.

> -- >8 --
> 
> Subject: [PATCH] x86: Move flush_tlb_info off the stack
> ---
>  arch/x86/mm/tlb.c | 49 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 35 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index bc4bc7b2f075..15fe90d4e3e1 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -14,6 +14,7 @@
>  #include <asm/cache.h>
>  #include <asm/apic.h>
>  #include <asm/uv/uv.h>
> +#include <asm/local.h>
>  
>  #include "mm_internal.h"
>  
> @@ -722,43 +723,63 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
>   */
>  unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
>  
> +static DEFINE_PER_CPU_SHARED_ALIGNED(struct flush_tlb_info, flush_tlb_info);
> +#ifdef CONFIG_DEBUG_VM
> +static DEFINE_PER_CPU(local_t, flush_tlb_info_idx);
> +#endif
> +
>  void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>  				unsigned long end, unsigned int stride_shift,
>  				bool freed_tables)
>  {
> +	struct flush_tlb_info *info;
>  	int cpu;
>  
> -	struct flush_tlb_info info __aligned(SMP_CACHE_BYTES) = {
> -		.mm = mm,
> -		.stride_shift = stride_shift,
> -		.freed_tables = freed_tables,
> -	};
> -
>  	cpu = get_cpu();
>  
> +	info = this_cpu_ptr(&flush_tlb_info);
> +
> +#ifdef CONFIG_DEBUG_VM
> +	/*
> +	 * Ensure that the following code is non-reentrant and flush_tlb_info
> +	 * is not overwritten. This means no TLB flushing is initiated by
> +	 * interrupt handlers and machine-check exception handlers. If needed,
> +	 * we can add additional flush_tlb_info entries.
> +	 */
> +	BUG_ON(local_inc_return(this_cpu_ptr(&flush_tlb_info_idx)) != 1);

That's what we have this_cpu_inc_return() for.

> +#endif
> +
> +	info->mm = mm;
> +	info->stride_shift = stride_shift;
> +	info->freed_tables = freed_tables;
> +
>  	/* This is also a barrier that synchronizes with switch_mm(). */
> -	info.new_tlb_gen = inc_mm_tlb_gen(mm);
> +	info->new_tlb_gen = inc_mm_tlb_gen(mm);
>  
>  	/* Should we flush just the requested range? */
>  	if ((end != TLB_FLUSH_ALL) &&
>  	    ((end - start) >> stride_shift) <= tlb_single_page_flush_ceiling) {
> -		info.start = start;
> -		info.end = end;
> +		info->start = start;
> +		info->end = end;
>  	} else {
> -		info.start = 0UL;
> -		info.end = TLB_FLUSH_ALL;
> +		info->start = 0UL;
> +		info->end = TLB_FLUSH_ALL;
>  	}
>  
>  	if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
> -		VM_WARN_ON(irqs_disabled());
> +		lockdep_assert_irqs_enabled();
>  		local_irq_disable();
> -		flush_tlb_func_local(&info, TLB_LOCAL_MM_SHOOTDOWN);
> +		flush_tlb_func_local(info, TLB_LOCAL_MM_SHOOTDOWN);
>  		local_irq_enable();
>  	}
>  
>  	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
> -		flush_tlb_others(mm_cpumask(mm), &info);
> +		flush_tlb_others(mm_cpumask(mm), info);
>  
> +#ifdef CONFIG_DEBUG_VM
> +	barrier();
> +	local_dec(this_cpu_ptr(&flush_tlb_info_idx));

this_cpu_dec();

> +#endif
>  	put_cpu();
>  }
>  
> -- 
> 2.17.1
> 
> 
