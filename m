From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] mm, thp: Do not loose dirty bit in
 __split_huge_pmd_locked()
Date: Wed, 14 Jun 2017 20:58:45 +0530
Message-ID: <4f87514b-e00e-065b-aa04-802a3302aa1d@linux.vnet.ibm.com>
References: <20170614135143.25068-1-kirill.shutemov@linux.intel.com>
 <20170614135143.25068-4-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170614135143.25068-4-kirill.shutemov@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org



On Wednesday 14 June 2017 07:21 PM, Kirill A. Shutemov wrote:
> Until pmdp_invalidate() pmd entry is present and CPU can update it,
> setting dirty. Currently, we tranfer dirty bit to page too early and
> there is window when we can miss dirty bit.
> 
> Let's call SetPageDirty() after pmdp_invalidate().
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   mm/huge_memory.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index a84909cf20d3..c4ee5c890910 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1928,7 +1928,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>   	struct page *page;
>   	pgtable_t pgtable;
>   	pmd_t _pmd;
> -	bool young, write, dirty, soft_dirty;
> +	bool young, write, soft_dirty;
>   	unsigned long addr;
>   	int i;
> 
> @@ -1965,7 +1965,6 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>   	page_ref_add(page, HPAGE_PMD_NR - 1);
>   	write = pmd_write(*pmd);
>   	young = pmd_young(*pmd);
> -	dirty = pmd_dirty(*pmd);
>   	soft_dirty = pmd_soft_dirty(*pmd);
> 
>   	pmdp_huge_split_prepare(vma, haddr, pmd);
> @@ -1995,8 +1994,6 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>   			if (soft_dirty)
>   				entry = pte_mksoft_dirty(entry);
>   		}
> -		if (dirty)
> -			SetPageDirty(page + i);
>   		pte = pte_offset_map(&_pmd, addr);
>   		BUG_ON(!pte_none(*pte));
>   		set_pte_at(mm, addr, pte, entry);
> @@ -2046,6 +2043,14 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>   	 * pmd_populate.
>   	 */
>   	pmdp_invalidate(vma, haddr, pmd);
> +
> +	/*
> +	 * Transfer dirty bit to page after pmd invalidated, so CPU would not
> +	 * be able to set it under us.
> +	 */
> +	if (pmd_dirty(*pmd))
> +		SetPageDirty(page);
> +
>   	pmd_populate(mm, pmd, pgtable);
> 

you fixed dirty bit loosing i discussed in my previous mail here.

thanks
-aneesh
