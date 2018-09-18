Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45554 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727756AbeIRTnD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Sep 2018 15:43:03 -0400
Date: Tue, 18 Sep 2018 15:10:34 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC][PATCH 07/11] arm/tlb: Convert to generic mmu_gather
Message-ID: <20180918141034.GF16498@arm.com>
References: <20180913092110.817204997@infradead.org>
 <20180913092812.247989787@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913092812.247989787@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com
Message-ID: <20180918141034.siSLKtRFsHGY6Ue-j5wsRw1flr6PG95yKeqYuHvk27E@z>

Hi Peter,

On Thu, Sep 13, 2018 at 11:21:17AM +0200, Peter Zijlstra wrote:
> Generic mmu_gather provides everything that ARM needs:
> 
>  - range tracking
>  - RCU table free
>  - VM_EXEC tracking
>  - VIPT cache flushing
> 
> The one notable curiosity is the 'funny' range tracking for classical
> ARM in __pte_free_tlb().
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nick Piggin <npiggin@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arm/include/asm/tlb.h |  255 ++-------------------------------------------
>  1 file changed, 14 insertions(+), 241 deletions(-)

So whilst I was reviewing this, I realised that I think we should be
selecting HAVE_RCU_TABLE_INVALIDATE for arch/arm/ if HAVE_RCU_TABLE_FREE.

Whilst we don't distinguish between invalidation of intermediate and leaf
levels on 32-bit, the CPU is still permitted to cache partial translation
table walks even if the leaf entry indicates a fault. That means that
after tearing down the PTEs, we can still get walk cache allocations and
so if the RCU batching of the page tables fails, we need to invalidate
the TLB after clearing the intermediate entries but before freeing them.

> -static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
> -	unsigned long addr)
> +__pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
>  {
>  	pgtable_page_dtor(pte);
>  
> -#ifdef CONFIG_ARM_LPAE
> -	tlb_add_flush(tlb, addr);
> -#else
> +#ifndef CONFIG_ARM_LPAE
>  	/*
>  	 * With the classic ARM MMU, a pte page has two corresponding pmd
>  	 * entries, each covering 1MB.
>  	 */
> -	addr &= PMD_MASK;
> -	tlb_add_flush(tlb, addr + SZ_1M - PAGE_SIZE);
> -	tlb_add_flush(tlb, addr + SZ_1M);
> +	addr = (addr & PMD_MASK) + SZ_1M;
> +	__tlb_adjust_range(tlb, addr - PAGE_SIZE, addr + PAGE_SIZE);

Hmm, I don't think you've got the range correct here. Don't we want
something like:

	__tlb_adjust_range(tlb, addr - PAGE_SIZE, 2 * PAGE_SIZE)

to ensure that we flush on both sides of the 1M boundary?

Will
