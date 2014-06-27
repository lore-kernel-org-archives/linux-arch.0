Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:35162 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753039AbaF0MSS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Jun 2014 08:18:18 -0400
Date: Fri, 27 Jun 2014 13:17:21 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 2/6] arm: mm: Introduce special ptes for LPAE
Message-ID: <20140627121721.GM26276@arm.com>
References: <1403710824-24340-1-git-send-email-steve.capper@linaro.org>
 <1403710824-24340-3-git-send-email-steve.capper@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1403710824-24340-3-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "gary.robertson@linaro.org" <gary.robertson@linaro.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "peterz@infradead.org" <peterz@infradead.org>, "anders.roxell@linaro.org" <anders.roxell@linaro.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Message-ID: <20140627121721.ZvCvohxxRx-ezGE1PkHANL31_nZA-QpzII5NH-WUbrc@z>

On Wed, Jun 25, 2014 at 04:40:20PM +0100, Steve Capper wrote:
> We need a mechanism to tag ptes as being special, this indicates that
> no attempt should be made to access the underlying struct page *
> associated with the pte. This is used by the fast_gup when operating on
> ptes as it has no means to access VMAs (that also contain this
> information) locklessly.
> 
> The L_PTE_SPECIAL bit is already allocated for LPAE, this patch modifies
> pte_special and pte_mkspecial to make use of it, and defines
> __HAVE_ARCH_PTE_SPECIAL.
> 
> This patch also excludes special ptes from the icache/dcache sync logic.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> ---
>  arch/arm/include/asm/pgtable-2level.h | 2 ++
>  arch/arm/include/asm/pgtable-3level.h | 8 ++++++++
>  arch/arm/include/asm/pgtable.h        | 6 ++----
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
> index 219ac88..f027941 100644
> --- a/arch/arm/include/asm/pgtable-2level.h
> +++ b/arch/arm/include/asm/pgtable-2level.h
> @@ -182,6 +182,8 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
>  #define pmd_addr_end(addr,end) (end)
>  
>  #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
> +#define pte_special(pte)	(0)
> +static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
>  
>  /*
>   * We don't have huge page support for short descriptors, for the moment
> diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> index 85c60ad..b286ba9 100644
> --- a/arch/arm/include/asm/pgtable-3level.h
> +++ b/arch/arm/include/asm/pgtable-3level.h
> @@ -207,6 +207,14 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
>  #define pte_huge(pte)		(pte_val(pte) && !(pte_val(pte) & PTE_TABLE_BIT))
>  #define pte_mkhuge(pte)		(__pte(pte_val(pte) & ~PTE_TABLE_BIT))
>  
> +#define pte_special(pte)	(!!(pte_val(pte) & L_PTE_SPECIAL))

Why the !!? Also, shouldn't this be rebased on your series adding the
pte_isset macro to ARM?

> +static inline pte_t pte_mkspecial(pte_t pte)
> +{
> +	pte_val(pte) |= L_PTE_SPECIAL;
> +	return pte;
> +}

If you put this in pgtable.h based on #ifdef __HAVE_ARCH_PTE_SPECIAL, then
you can use PTE_BIT_FUNC to avoid reinventing the wheel (or define
L_PTE_SPECIAL as 0 for 2-level and have one function).

Will
