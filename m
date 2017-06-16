From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCHv2 3/3] mm: Use updated pmdp_invalidate() inteface to track dirty/accessed bits
Date: Fri, 16 Jun 2017 17:01:30 +0530
Message-ID: <87bmpob23x.fsf@skywalker.in.ibm.com>
References: <20170615145224.66200-1-kirill.shutemov@linux.intel.com> <20170615145224.66200-4-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170615145224.66200-4-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> writes:

> This patch uses modifed pmdp_invalidate(), that return previous value of pmd,
> to transfer dirty and accessed bits.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  fs/proc/task_mmu.c |  8 ++++----
>  mm/huge_memory.c   | 29 ++++++++++++-----------------
>  2 files changed, 16 insertions(+), 21 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index f0c8b33d99b1..f2fc1ef5bba2 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c

.....

> @@ -1965,7 +1955,6 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  	page_ref_add(page, HPAGE_PMD_NR - 1);
>  	write = pmd_write(*pmd);
>  	young = pmd_young(*pmd);
> -	dirty = pmd_dirty(*pmd);
>  	soft_dirty = pmd_soft_dirty(*pmd);
>
>  	pmdp_huge_split_prepare(vma, haddr, pmd);
> @@ -1995,8 +1984,6 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  			if (soft_dirty)
>  				entry = pte_mksoft_dirty(entry);
>  		}
> -		if (dirty)
> -			SetPageDirty(page + i);
>  		pte = pte_offset_map(&_pmd, addr);
>  		BUG_ON(!pte_none(*pte));
>  		set_pte_at(mm, addr, pte, entry);
> @@ -2045,7 +2032,15 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  	 * and finally we write the non-huge version of the pmd entry with
>  	 * pmd_populate.
>  	 */
> -	pmdp_invalidate(vma, haddr, pmd);
> +	old = pmdp_invalidate(vma, haddr, pmd);
> +
> +	/*
> +	 * Transfer dirty bit using value returned by pmd_invalidate() to be
> +	 * sure we don't race with CPU that can set the bit under us.
> +	 */
> +	if (pmd_dirty(old))
> +		SetPageDirty(page);
> +
>  	pmd_populate(mm, pmd, pgtable);
>
>  	if (freeze) {


Can we invalidate the pmd early here ? ie, do pmdp_invalidate instead of
pmdp_huge_split_prepare() ?


-aneesh
