From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v2 1/2] mm: Introduce common STRUCT_PAGE_MAX_SHIFT define
Date: Thu, 8 Nov 2018 20:13:44 +0100
Message-ID: <CAKv+Gu9c+img+yqpmG9HD_bOihXLzQ70W+5Wki0FTmx7wYj37w@mail.gmail.com>
References: <20181107205433.3875-1-logang@deltatee.com> <20181107205433.3875-2-logang@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107205433.3875-2-logang@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, linux-riscv@lists.infradead.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Palmer Dabbelt <palmer@sifive.com>, Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>
List-Id: linux-arch.vger.kernel.org

On 7 November 2018 at 21:54, Logan Gunthorpe <logang@deltatee.com> wrote:
> This define is used by arm64 to calculate the size of the vmemmap
> region. It is defined as the log2 of the upper bound on the size
> of a struct page.
>
> We move it into mm_types.h so it can be defined properly instead of
> set and checked with a build bug. This also allows us to use the same
> define for riscv.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Acked-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christoph Hellwig <hch@lst.de>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/include/asm/memory.h | 9 ---------
>  arch/arm64/mm/init.c            | 8 --------
>  include/asm-generic/fixmap.h    | 1 +
>  include/linux/mm_types.h        | 5 +++++
>  4 files changed, 6 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index b96442960aea..f0a5c9531e8b 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -34,15 +34,6 @@
>   */
>  #define PCI_IO_SIZE            SZ_16M
>
> -/*
> - * Log2 of the upper bound of the size of a struct page. Used for sizing
> - * the vmemmap region only, does not affect actual memory footprint.
> - * We don't use sizeof(struct page) directly since taking its size here
> - * requires its definition to be available at this point in the inclusion
> - * chain, and it may not be a power of 2 in the first place.
> - */
> -#define STRUCT_PAGE_MAX_SHIFT  6
> -
>  /*
>   * VMEMMAP_SIZE - allows the whole linear region to be covered by
>   *                a struct page array
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 9d9582cac6c4..1a3e411a1d08 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -612,14 +612,6 @@ void __init mem_init(void)
>         BUILD_BUG_ON(TASK_SIZE_32                       > TASK_SIZE_64);
>  #endif
>
> -#ifdef CONFIG_SPARSEMEM_VMEMMAP
> -       /*
> -        * Make sure we chose the upper bound of sizeof(struct page)
> -        * correctly when sizing the VMEMMAP array.
> -        */
> -       BUILD_BUG_ON(sizeof(struct page) > (1 << STRUCT_PAGE_MAX_SHIFT));
> -#endif
> -
>         if (PAGE_SIZE >= 16384 && get_num_physpages() <= 128) {
>                 extern int sysctl_overcommit_memory;
>                 /*
> diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
> index 827e4d3bbc7a..8cc7b09c1bc7 100644
> --- a/include/asm-generic/fixmap.h
> +++ b/include/asm-generic/fixmap.h
> @@ -16,6 +16,7 @@
>  #define __ASM_GENERIC_FIXMAP_H
>
>  #include <linux/bug.h>
> +#include <linux/mm_types.h>
>
>  #define __fix_to_virt(x)       (FIXADDR_TOP - ((x) << PAGE_SHIFT))
>  #define __virt_to_fix(x)       ((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5ed8f6292a53..2c471a2c43fa 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -206,6 +206,11 @@ struct page {
>  #endif
>  } _struct_page_alignment;
>
> +/*
> + * Used for sizing the vmemmap region on some architectures
> + */
> +#define STRUCT_PAGE_MAX_SHIFT  (order_base_2(sizeof(struct page)))
> +
>  #define PAGE_FRAG_CACHE_MAX_SIZE       __ALIGN_MASK(32768, ~PAGE_MASK)
>  #define PAGE_FRAG_CACHE_MAX_ORDER      get_order(PAGE_FRAG_CACHE_MAX_SIZE)
>
> --
> 2.19.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
