From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v1 3/4] arm64: Fix the page leak in pud/pmd_set_huge
Date: Wed, 14 Mar 2018 10:35:55 +0000
Message-ID: <4b955357-23a0-c0ac-4407-79a1198e1913@arm.com>
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
 <1521017305-28518-4-git-send-email-cpandya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521017305-28518-4-git-send-email-cpandya@codeaurora.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Chintan Pandya <cpandya@codeaurora.org>, catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de
Cc: mark.rutland@arm.com, ard.biesheuvel@linaro.org, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com
List-Id: linux-arch.vger.kernel.org

On 14/03/18 08:48, Chintan Pandya wrote:
> While setting huge page, we need to take care of
> previously existing next level mapping. Since,
> we are going to overrite previous mapping, the
> only reference to next level page table will get
> lost and the next level page table will be zombie,
> occupying space forever. So, free it before
> overriding.
> 
> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> ---
>  arch/arm64/mm/mmu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 8c704f1..c0df264 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -32,7 +32,7 @@
>  #include <linux/io.h>
>  #include <linux/mm.h>
>  #include <linux/vmalloc.h>
> -
> +#include <linux/hugetlb.h>
>  #include <asm/barrier.h>
>  #include <asm/cputype.h>
>  #include <asm/fixmap.h>
> @@ -45,6 +45,7 @@
>  #include <asm/memblock.h>
>  #include <asm/mmu_context.h>
>  #include <asm/ptdump.h>
> +#include <asm/page.h>
>  
>  #define NO_BLOCK_MAPPINGS	BIT(0)
>  #define NO_CONT_MAPPINGS	BIT(1)
> @@ -939,6 +940,9 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
>  		return 0;
>  
>  	BUG_ON(phys & ~PUD_MASK);
> +	if (pud_val(*pud) && !pud_huge(*pud))
> +		free_page((unsigned long)__va(pud_val(*pud)));
> +

This is absolutely scary. Isn't this page still referenced in the page
tables (assuming patch 4 has been applied too)?

>  	set_pud(pudp, pfn_pud(__phys_to_pfn(phys), sect_prot));
>  	return 1;
>  }
> @@ -953,6 +957,9 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
>  		return 0;
>  
>  	BUG_ON(phys & ~PMD_MASK);
> +	if (pmd_val(*pmd) && !pmd_huge(*pmd))
> +		free_page((unsigned long)__va(pmd_val(*pmd)));
> +
>  	set_pmd(pmdp, pfn_pmd(__phys_to_pfn(phys), sect_prot));
>  	return 1;
>  }
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
