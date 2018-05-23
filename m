From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v9 3/4] arm64: Implement page table free interfaces
Date: Wed, 23 May 2018 15:01:58 +0100
Message-ID: <20180523140157.GG26965@arm.com>
References: <1525074094-25839-1-git-send-email-cpandya@codeaurora.org>
 <1525074094-25839-4-git-send-email-cpandya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1525074094-25839-4-git-send-email-cpandya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Philip Elcan <pelcan@codeaurora.org>, James Morse <james.morse@arm.com>, Kristina Martsenko <kristina.martsenko@arm.com>, Toshi Kani <toshi.kani@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Chintan,

[as a side note: I'm confused on the status of this patch series, as part
 of it was reposted separately by Toshi. Please can you work together?]

On Mon, Apr 30, 2018 at 01:11:33PM +0530, Chintan Pandya wrote:
> Implement pud_free_pmd_page() and pmd_free_pte_page().
> 
> Implementation requires,
>  1) Clearing off the current pud/pmd entry
>  2) Invalidate TLB which could have previously
>     valid but not stale entry
>  3) Freeing of the un-used next level page tables
> 
> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> ---
>  arch/arm64/mm/mmu.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index da98828..0f651db 100644
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
> @@ -973,12 +974,32 @@ int pmd_clear_huge(pmd_t *pmdp)
>  	return 1;
>  }
>  
> -int pud_free_pmd_page(pud_t *pud, unsigned long addr)
> +int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
>  {
> -	return pud_none(*pud);
> +	pmd_t *table;
> +
> +	if (pmd_present(READ_ONCE(*pmdp))) {

Might also be worth checking pmd_table here, just in case. (same for pud)

> +		table = __va(pmd_val(*pmdp));

Can you avoid dereferencing *pmdp twice, and instead READ_ONCE into a local
variable, please? (same for pud)

> +		pmd_clear(pmdp);
> +		__flush_tlb_kernel_pgtable(addr);
> +		free_page((unsigned long) table);

Shouldn't this be pte_free_kernel, to pair with pte_alloc_kernel which
was used to allocate the page in the first place? (similarly for pud)

> +	}
> +	return 1;
>  }
>  
> -int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
> +int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>  {
> -	return pmd_none(*pmd);
> +	pmd_t *table;
> +	int i;
> +
> +	if (pud_present(READ_ONCE(*pudp))) {
> +		table = __va(pud_val(*pudp));
> +		for (i = 0; i < PTRS_PER_PMD; i++)
> +			pmd_free_pte_page(&table[i], addr + (i * PMD_SIZE));

I think it would be cleaner to write this as a do { ... } while, for
consistency with the ioremap and vmalloc code.

Will
