Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfBZPMk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Feb 2019 10:12:40 -0500
Date: Tue, 26 Feb 2019 15:12:31 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
Message-ID: <20190226151230.GA20230@lakrids.cambridge.arm.com>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218231319.178224-1-yuzhao@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joel@joelfernandes.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Chintan Pandya <cpandya@codeaurora.org>, Jun Yao <yaojun8558363@gmail.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20190226151231.Qb7MzMzNJWDOzCYT0u9vGrxKK6g_HPOaK_pm7Wk1XSI@z>

Hi,

On Mon, Feb 18, 2019 at 04:13:17PM -0700, Yu Zhao wrote:
> For pte page, use pgtable_page_ctor(); for pmd page, use
> pgtable_pmd_page_ctor() if not folded; and for the rest (pud,
> p4d and pgd), don't use any.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  arch/arm64/mm/mmu.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)

[...]

> -static phys_addr_t pgd_pgtable_alloc(void)
> +static phys_addr_t pgd_pgtable_alloc(int shift)
>  {
>  	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
> -	if (!ptr || !pgtable_page_ctor(virt_to_page(ptr)))
> -		BUG();
> +	BUG_ON(!ptr);
> +
> +	/*
> +	 * Initialize page table locks in case later we need to
> +	 * call core mm functions like apply_to_page_range() on
> +	 * this pre-allocated page table.
> +	 */
> +	if (shift == PAGE_SHIFT)
> +		BUG_ON(!pgtable_page_ctor(virt_to_page(ptr)));
> +	else if (shift == PMD_SHIFT && PMD_SHIFT != PUD_SHIFT)
> +		BUG_ON(!pgtable_pmd_page_ctor(virt_to_page(ptr)));

IIUC, this is for nopmd kernels, where we only have real PGD and PTE
levels of table. From my PoV, that would be clearer if we did:

	else if (shift == PMD_SHIFT && !is_defined(__PAGETABLE_PMD_FOLDED))

... though IMO it would be a bit nicer if the generic
pgtable_pmd_page_ctor() were nop'd out for __PAGETABLE_PMD_FOLDED
builds, so that callers don't have to be aware of folding.

I couldn't think of a nicer way of distinguishing levels of table, and
having separate function pointers for each level seems over-the-top, so
otehr than that this looks good to me.

Assuming you're happy with the above change:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
