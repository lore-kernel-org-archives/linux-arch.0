Return-Path: <SRS0=Lua+=57=kvack.org=owner-linux-mm@kernel.org>
Date: Wed, 15 Apr 2020 11:47:56 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
Message-ID: <20200415104755.GD12621@willie-the-truck>
References: <20200413125303.423864-1-npiggin@gmail.com>
 <20200413125303.423864-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413125303.423864-5-npiggin@gmail.com>
Sender: owner-linux-mm@kvack.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200415104756.jPsnk4T8G84LDBTMgyXzU4QFN2J0FACBBIAjzHE-3mc@z>

Hi Nick,

On Mon, Apr 13, 2020 at 10:53:03PM +1000, Nicholas Piggin wrote:
> For platforms that define HAVE_ARCH_HUGE_VMAP and support PMD vmap mappings,
> have vmalloc attempt to allocate PMD-sized pages first, before falling back
> to small pages. Allocations which use something other than PAGE_KERNEL
> protections are not permitted to use huge pages yet, not all callers expect
> this (e.g., module allocations vs strict module rwx).
> 
> This gives a 6x reduction in dTLB misses for a `git diff` (of linux), from
> 45600 to 6500 and a 2.2% reduction in cycles on a 2-node POWER9.

I wonder if it's worth extending vmap() to handle higher order pages in
a similar way? That might be helpful for tracing PMUs such as Arm SPE,
where the CPU streams tracing data out to a virtually addressed buffer
(see rb_alloc_aux_page()).

> This can result in more internal fragmentation and memory overhead for a
> given allocation. It can also cause greater NUMA unbalance on hashdist
> allocations.
> 
> There may be other callers that expect small pages under vmalloc but use
> PAGE_KERNEL, I'm not sure if it's feasible to catch them all. An
> alternative would be a new function or flag which enables large mappings,
> and use that in callers.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  include/linux/vmalloc.h |   2 +
>  mm/vmalloc.c            | 135 +++++++++++++++++++++++++++++-----------
>  2 files changed, 102 insertions(+), 35 deletions(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 291313a7e663..853b82eac192 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -24,6 +24,7 @@ struct notifier_block;		/* in notifier.h */
>  #define VM_UNINITIALIZED	0x00000020	/* vm_struct is not fully initialized */
>  #define VM_NO_GUARD		0x00000040      /* don't add guard page */
>  #define VM_KASAN		0x00000080      /* has allocated kasan shadow memory */
> +#define VM_HUGE_PAGES		0x00000100	/* may use huge pages */

Please can you add a check for this in the arm64 change_memory_common()
code? Other architectures might need something similar, but we need to
forbid changing memory attributes for portions of the huge page.

In general, I'm a bit wary of software table walkers tripping over this.
For example, I don't think apply_to_existing_page_range() can handle
huge mappings at all, but the one user (KASAN) only ever uses page mappings
so it's ok there.

> @@ -2325,9 +2356,11 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
>  	if (unlikely(!size))
>  		return NULL;
>  
> -	if (flags & VM_IOREMAP)
> -		align = 1ul << clamp_t(int, get_count_order_long(size),
> -				       PAGE_SHIFT, IOREMAP_MAX_ORDER);
> +	if (flags & VM_IOREMAP) {
> +		align = max(align,
> +			    1ul << clamp_t(int, get_count_order_long(size),
> +					   PAGE_SHIFT, IOREMAP_MAX_ORDER));
> +	}


I don't follow this part. Please could you explain why you're potentially
aligning above IOREMAP_MAX_ORDER? It doesn't seem to follow from the rest
of the patch.

Cheers,

Will
