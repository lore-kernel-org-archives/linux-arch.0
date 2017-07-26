From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 1/1] mm/hugetlb: Make huge_pte_offset() consistent and
 document behaviour
Date: Wed, 26 Jul 2017 10:50:38 +0200
Message-ID: <20170726085038.GB2981@dhcp22.suse.cz>
References: <20170725154114.24131-1-punit.agrawal@arm.com>
 <20170725154114.24131-2-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34619 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750813AbdGZIum (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Jul 2017 04:50:42 -0400
Content-Disposition: inline
In-Reply-To: <20170725154114.24131-2-punit.agrawal@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, steve.capper@arm.com, will.deacon@arm.com, catalin.marinas@arm.com, kirill.shutemov@linux.intel.com, Mike Kravetz <mike.kravetz@oracle.com>

On Tue 25-07-17 16:41:14, Punit Agrawal wrote:
> When walking the page tables to resolve an address that points to
> !p*d_present() entry, huge_pte_offset() returns inconsistent values
> depending on the level of page table (PUD or PMD).
> 
> It returns NULL in the case of a PUD entry while in the case of a PMD
> entry, it returns a pointer to the page table entry.
> 
> A similar inconsitency exists when handling swap entries - returns NULL
> for a PUD entry while a pointer to the pte_t is retured for the PMD
> entry.
> 
> Update huge_pte_offset() to make the behaviour consistent - return NULL
> in the case of p*d_none() and a pointer to the pte_t for hugepage or
> swap entries.
> 
> Document the behaviour to clarify the expected behaviour of this
> function. This is to set clear semantics for architecture specific
> implementations of huge_pte_offset().

hugetlb pte semantic is a disaster and I agree it could see some
cleanup/clarifications but I am quite nervous to see a patchi like this.
How do we check that nothing will get silently broken by this change?

> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> ---
>  mm/hugetlb.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index bc48ee783dd9..72dd1139a8e4 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4603,6 +4603,13 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
>  	return pte;
>  }
>  
> +/*
> + * huge_pte_offset() - Walk the page table to resolve the hugepage
> + * entry at address @addr
> + *
> + * Return: Pointer to page table or swap entry (PUD or PMD) for address @addr
> + * or NULL if the entry is p*d_none().
> + */
>  pte_t *huge_pte_offset(struct mm_struct *mm,
>  		       unsigned long addr, unsigned long sz)
>  {
> @@ -4617,13 +4624,22 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>  	p4d = p4d_offset(pgd, addr);
>  	if (!p4d_present(*p4d))
>  		return NULL;
> +
>  	pud = pud_offset(p4d, addr);
> -	if (!pud_present(*pud))
> +	if (pud_none(*pud))
>  		return NULL;
> -	if (pud_huge(*pud))
> +	/* hugepage or swap? */
> +	if (pud_huge(*pud) || !pud_present(*pud))
>  		return (pte_t *)pud;
> +
>  	pmd = pmd_offset(pud, addr);
> -	return (pte_t *) pmd;
> +	if (pmd_none(*pmd))
> +		return NULL;
> +	/* hugepage or swap? */
> +	if (pmd_huge(*pmd) || !pmd_present(*pmd))
> +		return (pte_t *) pmd;
> +
> +	return NULL;
>  }
>  
>  #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
> -- 
> 2.11.0
> 

-- 
Michal Hocko
SUSE Labs
