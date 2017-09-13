From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCHv3 08/11] sparc64: update pmdp_invalidate to return old pmd value
Date: Wed, 13 Sep 2017 10:36:13 +0530
Message-ID: <87r2vbur0a.fsf@linux.vnet.ibm.com>
References: <20170912153941.47012-1-kirill.shutemov@linux.intel.com> <20170912153941.47012-9-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37405 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751052AbdIMFG2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Sep 2017 01:06:28 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8D53fO2066280
        for <linux-arch@vger.kernel.org>; Wed, 13 Sep 2017 01:06:27 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2cxp6x9puy-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 13 Sep 2017 01:06:27 -0400
Received: from localhost
        by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
        Wed, 13 Sep 2017 15:06:25 +1000
In-Reply-To: <20170912153941.47012-9-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Nitin Gupta <nitin.m.gupta@oracle.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> writes:

> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>


You got the author wrong there.

>
> It's required to avoid loosing dirty and accessed bits.
>
> Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/sparc/include/asm/pgtable_64.h |  2 +-
>  arch/sparc/mm/tlb.c                 | 23 ++++++++++++++++++-----
>  2 files changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 4fefe3762083..83b06c98bb94 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -979,7 +979,7 @@ void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
>  			  pmd_t *pmd);
>
>  #define __HAVE_ARCH_PMDP_INVALIDATE
> -extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
> +extern pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>  			    pmd_t *pmdp);
>
>  #define __HAVE_ARCH_PGTABLE_DEPOSIT
> diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
> index ee8066c3d96c..d36c65fc55cf 100644
> --- a/arch/sparc/mm/tlb.c
> +++ b/arch/sparc/mm/tlb.c
> @@ -218,17 +218,28 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>  	}
>  }
>
> +static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
> +		unsigned long address, pmd_t *pmdp, pmd_t pmd)
> +{
> +	pmd_t old;
> +
> +	{
> +		old = *pmdp;
> +	} while (cmpxchg64(&pmdp->pmd, old.pmd, pmd.pmd) != old.pmd);
> +
> +	return old;
> +}
> +
>  /*
>   * This routine is only called when splitting a THP
>   */
> -void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
> +pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>  		     pmd_t *pmdp)
>  {
> -	pmd_t entry = *pmdp;
> -
> -	pmd_val(entry) &= ~_PAGE_VALID;
> +	pmd_t old, entry;
>
> -	set_pmd_at(vma->vm_mm, address, pmdp, entry);
> +	entry = __pmd(pmd_val(*pmdp) & ~_PAGE_VALID);
> +	old = pmdp_establish(vma, address, pmdp, entry);
>  	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>
>  	/*
> @@ -239,6 +250,8 @@ void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>  	if ((pmd_val(entry) & _PAGE_PMD_HUGE) &&
>  	    !is_huge_zero_page(pmd_page(entry)))
>  		(vma->vm_mm)->context.thp_pte_count--;
> +
> +	return old;
>  }
>
>  void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
> -- 
> 2.14.1
