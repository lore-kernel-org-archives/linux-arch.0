Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729038AbfBRPMe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 Feb 2019 10:12:34 -0500
Date: Mon, 18 Feb 2019 15:12:23 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] arm64: mm: enable per pmd page table lock
Message-ID: <20190218151223.GB16091@fuggles.cambridge.arm.com>
References: <20190214211642.2200-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214211642.2200-1-yuzhao@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joel@joelfernandes.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, mark.rutland@arm.com
Message-ID: <20190218151223.vqLQn5QJs3ZVXc3A6XHIUK4MbeQj7q2mzPTa4VCTIqU@z>

[+Mark]

On Thu, Feb 14, 2019 at 02:16:42PM -0700, Yu Zhao wrote:
> Switch from per mm_struct to per pmd page table lock by enabling
> ARCH_ENABLE_SPLIT_PMD_PTLOCK. This provides better granularity for
> large system.
> 
> I'm not sure if there is contention on mm->page_table_lock. Given
> the option comes at no cost (apart from initializing more spin
> locks), why not enable it now.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  arch/arm64/Kconfig               |  3 +++
>  arch/arm64/include/asm/pgalloc.h | 12 +++++++++++-
>  arch/arm64/include/asm/tlb.h     |  5 ++++-
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a4168d366127..104325a1ffc3 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -872,6 +872,9 @@ config ARCH_WANT_HUGE_PMD_SHARE
>  config ARCH_HAS_CACHE_LINE_SIZE
>  	def_bool y
>  
> +config ARCH_ENABLE_SPLIT_PMD_PTLOCK
> +	def_bool y
> +
>  config SECCOMP
>  	bool "Enable seccomp to safely compute untrusted bytecode"
>  	---help---
> diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
> index 52fa47c73bf0..dabba4b2c61f 100644
> --- a/arch/arm64/include/asm/pgalloc.h
> +++ b/arch/arm64/include/asm/pgalloc.h
> @@ -33,12 +33,22 @@
>  
>  static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
>  {
> -	return (pmd_t *)__get_free_page(PGALLOC_GFP);
> +	struct page *page;
> +
> +	page = alloc_page(PGALLOC_GFP);
> +	if (!page)
> +		return NULL;
> +	if (!pgtable_pmd_page_ctor(page)) {
> +		__free_page(page);
> +		return NULL;
> +	}
> +	return page_address(page);

I'm a bit worried as to how this interacts with the page-table code in
arch/arm64/mm/mmu.c when pgd_pgtable_alloc is used as the allocator. It
looks like that currently always calls pgtable_page_ctor(), regardless of
level. Do we now need a separate allocator function for the PMD level?

Will
