From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v5 3/4] arm64: Implement page table free interfaces
Date: Tue, 27 Mar 2018 19:00:48 +0100
Message-ID: <20180327180048.GJ18435@arm.com>
References: <1522157100-16879-1-git-send-email-cpandya@codeaurora.org>
 <1522157100-16879-4-git-send-email-cpandya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1522157100-16879-4-git-send-email-cpandya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: catalin.marinas@arm.com, mark.rutland@arm.com, toshi.kani@hpe.com, arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

Hi Chintan,

On Tue, Mar 27, 2018 at 06:54:59PM +0530, Chintan Pandya wrote:
> Implement pud_free_pmd_page() and pmd_free_pte_page().
> 
> Implementation requires,
>  1) Freeing of the un-used next level page tables
>  2) Clearing off the current pud/pmd entry
>  3) Invalidate TLB which could have previously
>     valid but not stale entry
> 
> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> ---
> V4->V5:
>  - Using __flush_tlb_kernel_pgtable instead of
>    flush_tlb_kernel_range
> 
> 
>  arch/arm64/mm/mmu.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index da98828..3552c7a 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -45,6 +45,7 @@
>  #include <asm/memblock.h>
>  #include <asm/mmu_context.h>
>  #include <asm/ptdump.h>
> +#include <asm/tlbflush.h>
>  
>  #define NO_BLOCK_MAPPINGS	BIT(0)
>  #define NO_CONT_MAPPINGS	BIT(1)
> @@ -973,12 +974,40 @@ int pmd_clear_huge(pmd_t *pmdp)
>  	return 1;
>  }
>  
> +static int __pmd_free_pte_page(pmd_t *pmd, unsigned long addr, bool tlb_inv)
> +{
> +	pmd_t *table;
> +
> +	if (pmd_val(*pmd)) {

Please can you follow what I did in 20a004e7b017 ("arm64: mm: Use
READ_ONCE/WRITE_ONCE when accessing page tables") and:

  1. Use consistent naming, so pmd_t * pmdp.
  2. Use READ_ONCE to dereference the entry once into a local.

Similarly for the pud code below.

> +		table = __va(pmd_val(*pmd));
> +		pmd_clear(pmd);
> +		if (tlb_inv)
> +			__flush_tlb_kernel_pgtable(addr);
> +
> +		free_page((unsigned long) table);

Hmm. Surely it's only safe to call free_page if !tlb_inv in situations when
the page table is already disconnected at a higher level? That doesn't
appear to be the case with the function below, which still has the pud
installed. What am I missing?

> +	}
> +	return 1;
> +}
> +
>  int pud_free_pmd_page(pud_t *pud, unsigned long addr)
>  {
> -	return pud_none(*pud);
> +	pmd_t *table;
> +	int i;
> +
> +	if (pud_val(*pud)) {
> +		table = __va(pud_val(*pud));
> +		for (i = 0; i < PTRS_PER_PMD; i++)
> +			__pmd_free_pte_page(&table[i], addr + (i * PMD_SIZE),
> +						false);
> +
> +		pud_clear(pud);
> +		flush_tlb_kernel_range(addr, addr + PUD_SIZE);

Why aren't you using __flush_tlb_kernel_pgtable here?

Will
