From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] mm: Move p?d_alloc_track to separate header file
Date: Tue, 9 Jun 2020 18:07:51 +0300
Message-ID: <20200609150751.GF1149842@linux.ibm.com>
References: <20200609120533.25867-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50688 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728082AbgFIPI5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2020 11:08:57 -0400
Content-Disposition: inline
In-Reply-To: <20200609120533.25867-1-joro@8bytes.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, peterz@infradead.org, jroedel@suse.de, Andy Lutomirski <luto@kernel.org>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, manvanth@linux.vnet.ibm.com, linux-next@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, hch@lst.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org

On Tue, Jun 09, 2020 at 02:05:33PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The functions are only used in two source files, so there is no need
> for them to be in the global <linux/mm.h> header. Move them to the new
> <linux/pgalloc-track.h> header and include it only where needed.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  include/linux/mm.h            | 45 -------------------------------
>  include/linux/pgalloc-track.h | 51 +++++++++++++++++++++++++++++++++++
>  lib/ioremap.c                 |  1 +
>  mm/vmalloc.c                  |  1 +
>  4 files changed, 53 insertions(+), 45 deletions(-)
>  create mode 100644 include/linux/pgalloc-track.h
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9d6042178ca7..22d8b2a2c9bc 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2092,51 +2092,11 @@ static inline pud_t *pud_alloc(struct mm_struct *mm, p4d_t *p4d,
>  		NULL : pud_offset(p4d, address);
>  }
>  
> -static inline p4d_t *p4d_alloc_track(struct mm_struct *mm, pgd_t *pgd,
> -				     unsigned long address,
> -				     pgtbl_mod_mask *mod_mask)
> -
> -{
> -	if (unlikely(pgd_none(*pgd))) {
> -		if (__p4d_alloc(mm, pgd, address))
> -			return NULL;
> -		*mod_mask |= PGTBL_PGD_MODIFIED;
> -	}
> -
> -	return p4d_offset(pgd, address);
> -}
> -
> -static inline pud_t *pud_alloc_track(struct mm_struct *mm, p4d_t *p4d,
> -				     unsigned long address,
> -				     pgtbl_mod_mask *mod_mask)
> -{
> -	if (unlikely(p4d_none(*p4d))) {
> -		if (__pud_alloc(mm, p4d, address))
> -			return NULL;
> -		*mod_mask |= PGTBL_P4D_MODIFIED;
> -	}
> -
> -	return pud_offset(p4d, address);
> -}
> -
>  static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
>  {
>  	return (unlikely(pud_none(*pud)) && __pmd_alloc(mm, pud, address))?
>  		NULL: pmd_offset(pud, address);
>  }
> -
> -static inline pmd_t *pmd_alloc_track(struct mm_struct *mm, pud_t *pud,
> -				     unsigned long address,
> -				     pgtbl_mod_mask *mod_mask)
> -{
> -	if (unlikely(pud_none(*pud))) {
> -		if (__pmd_alloc(mm, pud, address))
> -			return NULL;
> -		*mod_mask |= PGTBL_PUD_MODIFIED;
> -	}
> -
> -	return pmd_offset(pud, address);
> -}
>  #endif /* CONFIG_MMU */
>  
>  #if USE_SPLIT_PTE_PTLOCKS
> @@ -2252,11 +2212,6 @@ static inline void pgtable_pte_page_dtor(struct page *page)
>  	((unlikely(pmd_none(*(pmd))) && __pte_alloc_kernel(pmd))? \
>  		NULL: pte_offset_kernel(pmd, address))
>  
> -#define pte_alloc_kernel_track(pmd, address, mask)			\
> -	((unlikely(pmd_none(*(pmd))) &&					\
> -	  (__pte_alloc_kernel(pmd) || ({*(mask)|=PGTBL_PMD_MODIFIED;0;})))?\
> -		NULL: pte_offset_kernel(pmd, address))
> -
>  #if USE_SPLIT_PMD_PTLOCKS
>  
>  static struct page *pmd_to_page(pmd_t *pmd)
> diff --git a/include/linux/pgalloc-track.h b/include/linux/pgalloc-track.h
> new file mode 100644
> index 000000000000..1dcc865029a2
> --- /dev/null
> +++ b/include/linux/pgalloc-track.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_PGALLLC_TRACK_H
> +#define _LINUX_PGALLLC_TRACK_H
> +
> +#if defined(CONFIG_MMU)
> +static inline p4d_t *p4d_alloc_track(struct mm_struct *mm, pgd_t *pgd,
> +				     unsigned long address,
> +				     pgtbl_mod_mask *mod_mask)
> +{
> +	if (unlikely(pgd_none(*pgd))) {
> +		if (__p4d_alloc(mm, pgd, address))
> +			return NULL;
> +		*mod_mask |= PGTBL_PGD_MODIFIED;
> +	}
> +
> +	return p4d_offset(pgd, address);
> +}
> +
> +static inline pud_t *pud_alloc_track(struct mm_struct *mm, p4d_t *p4d,
> +				     unsigned long address,
> +				     pgtbl_mod_mask *mod_mask)
> +{
> +	if (unlikely(p4d_none(*p4d))) {
> +		if (__pud_alloc(mm, p4d, address))
> +			return NULL;
> +		*mod_mask |= PGTBL_P4D_MODIFIED;
> +	}
> +
> +	return pud_offset(p4d, address);
> +}
> +
> +static inline pmd_t *pmd_alloc_track(struct mm_struct *mm, pud_t *pud,
> +				     unsigned long address,
> +				     pgtbl_mod_mask *mod_mask)
> +{
> +	if (unlikely(pud_none(*pud))) {
> +		if (__pmd_alloc(mm, pud, address))
> +			return NULL;
> +		*mod_mask |= PGTBL_PUD_MODIFIED;
> +	}
> +
> +	return pmd_offset(pud, address);
> +}
> +#endif /* CONFIG_MMU */
> +
> +#define pte_alloc_kernel_track(pmd, address, mask)			\
> +	((unlikely(pmd_none(*(pmd))) &&					\
> +	  (__pte_alloc_kernel(pmd) || ({*(mask)|=PGTBL_PMD_MODIFIED;0;})))?\
> +		NULL: pte_offset_kernel(pmd, address))
> +
> +#endif /* _LINUX_PGALLLC_TRACK_H */
> diff --git a/lib/ioremap.c b/lib/ioremap.c
> index ad485f08173b..608fcccd21c8 100644
> --- a/lib/ioremap.c
> +++ b/lib/ioremap.c
> @@ -11,6 +11,7 @@
>  #include <linux/sched.h>
>  #include <linux/io.h>
>  #include <linux/export.h>
> +#include <linux/pgalloc-track.h>
>  #include <asm/cacheflush.h>
>  #include <asm/pgtable.h>
>  
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 3091c2ca60df..edc43f003165 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -35,6 +35,7 @@
>  #include <linux/bitops.h>
>  #include <linux/rbtree_augmented.h>
>  #include <linux/overflow.h>
> +#include <linux/pgalloc-track.h>
>  
>  #include <linux/uaccess.h>
>  #include <asm/tlbflush.h>
> -- 
> 2.26.2
> 

-- 
Sincerely yours,
Mike.
