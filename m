Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:39224 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLRJRn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Dec 2019 04:17:43 -0500
Date: Wed, 18 Dec 2019 10:17:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/3] mm/mmu_gather: Invalidate TLB correctly on batch
 allocation failure and flush
Message-ID: <20191218091733.GO2844@hirez.programming.kicks-ass.net>
References: <20191218053530.73053-1-aneesh.kumar@linux.ibm.com>
 <20191218053530.73053-2-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218053530.73053-2-aneesh.kumar@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: akpm@linux-foundation.org, npiggin@gmail.com, mpe@ellerman.id.au, will@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Message-ID: <20191218091733.Mm4xqnHH4YVGgmq1irKjhoGAIZoOc9n-h1ohgYrTZF8@z>

On Wed, Dec 18, 2019 at 11:05:29AM +0530, Aneesh Kumar K.V wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Architectures for which we have hardware walkers of Linux page table should
> flush TLB on mmu gather batch allocation failures and batch flush. Some
> architectures like POWER supports multiple translation modes (hash and radix)

nohash, hash and radix in fact :-)

> and in the case of POWER only radix translation mode needs the above TLBI.

> This is because for hash translation mode kernel wants to avoid this extra
> flush since there are no hardware walkers of linux page table. With radix
> translation, the hardware also walks linux page table and with that, kernel
> needs to make sure to TLB invalidate page walk cache before page table pages are
> freed.
> 
> More details in
> commit: d86564a2f085 ("mm/tlb, x86/mm: Support invalidating TLB caches for RCU_TABLE_FREE")
> 
> Fixes: a46cc7a90fd8 ("powerpc/mm/radix: Improve TLB/PWC flushes")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---

> diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
> index b2c0be93929d..7f3a8b902325 100644
> --- a/arch/powerpc/include/asm/tlb.h
> +++ b/arch/powerpc/include/asm/tlb.h
> @@ -26,6 +26,17 @@
>  
>  #define tlb_flush tlb_flush
>  extern void tlb_flush(struct mmu_gather *tlb);
> +/*
> + * book3s:
> + * Hash does not use the linux page-tables, so we can avoid
> + * the TLB invalidate for page-table freeing, Radix otoh does use the
> + * page-tables and needs the TLBI.
> + *
> + * nohash:
> + * We still do TLB invalidate in the __pte_free_tlb routine before we
> + * add the page table pages to mmu gather table batch.

I'm a little confused though; if nohash is a software TLB fill, why do
you need a TLBI for tables?

> + */
> +#define tlb_needs_table_invalidate()	radix_enabled()
>  
>  /* Get the generic bits... */
>  #include <asm-generic/tlb.h>
