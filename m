From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v1 3/4] arm64: Fix the page leak in pud/pmd_set_huge
Date: Wed, 14 Mar 2018 10:53:43 +0000
Message-ID: <20180314105343.nxw2mwkm4pao3hur@lakrids.cambridge.arm.com>
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
 <1521017305-28518-4-git-send-email-cpandya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1521017305-28518-4-git-send-email-cpandya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 14, 2018 at 02:18:24PM +0530, Chintan Pandya wrote:
> While setting huge page, we need to take care of
> previously existing next level mapping. Since,
> we are going to overrite previous mapping, the
> only reference to next level page table will get
> lost and the next level page table will be zombie,
> occupying space forever. So, free it before
> overriding.

> @@ -939,6 +940,9 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
>  		return 0;
>  
>  	BUG_ON(phys & ~PUD_MASK);
> +	if (pud_val(*pud) && !pud_huge(*pud))
> +		free_page((unsigned long)__va(pud_val(*pud)));
> +
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

As Marc noted, (assuming the subsequent revert is applied) in both of
these cases, these tables are still live, and thus it is not safe to
free them.

Consider that immediately after freeing the pages, they may get
re-allocated elsewhere, where they may be modified. If this happens
before TLB invalidation, page table walks may allocate junk into TLBs,
resulting in a number of problems.

It is *never* safe to free a live page table, therefore NAK to this
patch.

Thanks,
Mark.
