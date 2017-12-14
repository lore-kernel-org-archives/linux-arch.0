From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCHv4 08/12] sparc64: Update pmdp_invalidate() to return old
 pmd value
Date: Wed, 13 Dec 2017 16:06:55 -0800
Message-ID: <20171213160655.9d95ad8dcf6df855c028fa52@linux-foundation.org>
References: <20171213105756.69879-1-kirill.shutemov@linux.intel.com>
        <20171213105756.69879-9-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:56628 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbdLNAG5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Dec 2017 19:06:57 -0500
In-Reply-To: <20171213105756.69879-9-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@kernel.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Nitin Gupta <nitin.m.gupta@oracle.com>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org

On Wed, 13 Dec 2017 13:57:52 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> From: Nitin Gupta <nitin.m.gupta@oracle.com>
> 
> It's required to avoid losing dirty and accessed bits.
> 
> ...
>
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -1010,7 +1010,7 @@ void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
>  			  pmd_t *pmd);
>  
>  #define __HAVE_ARCH_PMDP_INVALIDATE
> -extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
> +extern pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>  			    pmd_t *pmdp);
>  
>  #define __HAVE_ARCH_PGTABLE_DEPOSIT
> diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
> index 4ae86bc0d35c..5a3ba863b48a 100644
> --- a/arch/sparc/mm/tlb.c
> +++ b/arch/sparc/mm/tlb.c
> @@ -219,17 +219,28 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
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

um, I think I'll put a "do" in there...

And I'll wait until we see a "tested-by" or a nice ack, please.
