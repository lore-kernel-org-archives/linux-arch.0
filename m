From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v1 4/4] Revert "arm64: Enforce BBM for huge IO/VMAP
 mappings"
Date: Wed, 14 Mar 2018 10:46:04 +0000
Message-ID: <bdcc02a1-cf1b-4887-06e9-4867415ca214@arm.com>
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
 <1521017305-28518-5-git-send-email-cpandya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521017305-28518-5-git-send-email-cpandya@codeaurora.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Chintan Pandya <cpandya@codeaurora.org>, catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de
Cc: mark.rutland@arm.com, ard.biesheuvel@linaro.org, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com
List-Id: linux-arch.vger.kernel.org

On 14/03/18 08:48, Chintan Pandya wrote:
> This commit 15122ee2c515a ("arm64: Enforce BBM for huge
> IO/VMAP mappings") is a temporary work-around until the
> issues with CONFIG_HAVE_ARCH_HUGE_VMAP gets fixed.
> 
> Revert this change as we have fixes for the issue.
> 
> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> ---
>  arch/arm64/mm/mmu.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index c0df264..19116c6 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -935,10 +935,6 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
>  	pgprot_t sect_prot = __pgprot(PUD_TYPE_SECT |
>  					pgprot_val(mk_sect_prot(prot)));
>  
> -	/* ioremap_page_range doesn't honour BBM */
> -	if (pud_present(READ_ONCE(*pudp)))
> -		return 0;
> -
>  	BUG_ON(phys & ~PUD_MASK);
>  	if (pud_val(*pud) && !pud_huge(*pud))
>  		free_page((unsigned long)__va(pud_val(*pud)));
> @@ -952,10 +948,6 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
>  	pgprot_t sect_prot = __pgprot(PMD_TYPE_SECT |
>  					pgprot_val(mk_sect_prot(prot)));
>  
> -	/* ioremap_page_range doesn't honour BBM */
> -	if (pmd_present(READ_ONCE(*pmdp)))
> -		return 0;
> -
>  	BUG_ON(phys & ~PMD_MASK);
>  	if (pmd_val(*pmd) && !pmd_huge(*pmd))
>  		free_page((unsigned long)__va(pmd_val(*pmd)));
> 

But you're still not doing a BBM, right? What prevents a speculative
access from using the (now freed) entry? The TLB invalidation you've
introduce just narrows the window where bad things can happen.

My gut feeling is that this series introduces more bugs than it fixes...
If you're going to fix it, please fix it by correctly implementing BBM
for huge mappings.

Or am I missing something terribly obvious?

	M.
-- 
Jazz is not dead. It just smells funny...
