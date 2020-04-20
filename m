From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v1 5/6] mm: tlb: Provide flush_*_tlb_range wrappers
Date: Mon, 20 Apr 2020 14:09:16 +0200
Message-ID: <20200420120916.GE20696@hirez.programming.kicks-ass.net>
References: <20200403090048.938-1-yezhenyu2@huawei.com>
 <20200403090048.938-6-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200403090048.938-6-yezhenyu2@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Zhenyu Ye <yezhenyu2@huawei.com>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, linux-mm@kvack.org, guohanjun@huawei.com, will@kernel.org, linux-arch@vger.kernel.org, yuzhao@google.com, maz@kernel.org, steven.price@arm.com, arm@kernel.org, Dave.Martin@arm.com, arnd@arndb.de, suzuki.poulose@arm.com, npiggin@gmail.com, zhangshaokun@hisilicon.com, broonie@kernel.org, rostedt@goodmis.org, prime.zeng@hisilicon.com, kuhn.chenqun@huawei.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, xiexiangyou@huawei.com, linux-kernel@vger.kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 03, 2020 at 05:00:47PM +0800, Zhenyu Ye wrote:
> This patch provides flush_{pte|pmd|pud|p4d}_tlb_range() in generic
> code, which are expressed through the mmu_gather APIs.  These
> interface set tlb->cleared_* and finally call tlb_flush(), so we
> can do the tlb invalidation according to the information in
> struct mmu_gather.
> 
> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
> ---
>  include/asm-generic/pgtable.h | 12 +++++++--
>  mm/pgtable-generic.c          | 50 +++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index e2e2bef07dd2..2bedeee94131 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -1160,11 +1160,19 @@ static inline int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>   * invalidate the entire TLB which is not desitable.
>   * e.g. see arch/arc: flush_pmd_tlb_range
>   */
> -#define flush_pmd_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
> -#define flush_pud_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
> +extern void flush_pte_tlb_range(struct vm_area_struct *vma,
> +				unsigned long addr, unsigned long end);
> +extern void flush_pmd_tlb_range(struct vm_area_struct *vma,
> +				unsigned long addr, unsigned long end);
> +extern void flush_pud_tlb_range(struct vm_area_struct *vma,
> +				unsigned long addr, unsigned long end);
> +extern void flush_p4d_tlb_range(struct vm_area_struct *vma,
> +				unsigned long addr, unsigned long end);
>  #else
> +#define flush_pte_tlb_range(vma, addr, end)	BUILD_BUG()
>  #define flush_pmd_tlb_range(vma, addr, end)	BUILD_BUG()
>  #define flush_pud_tlb_range(vma, addr, end)	BUILD_BUG()
> +#define flush_p4d_tlb_range(vma, addr, end)	BUILD_BUG()
>  #endif
>  #endif

Ideally you'd make __HAVE_ARCH_FLUSH_PMD_TLB_RANGE go away. Power
certainly doesnt need it with the below.

> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index 3d7c01e76efc..0f5414a4a2ec 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -101,6 +101,56 @@ pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long address,
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  
> +#ifndef __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
> +void flush_pte_tlb_range(struct vm_area_struct *vma,
> +			 unsigned long addr, unsigned long end)
> +{
> +	struct mmu_gather tlb;
> +
> +	tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);
> +	tlb_start_vma(&tlb, vma);
> +	tlb_set_pte_range(&tlb, addr, end - addr);
> +	tlb_end_vma(&tlb, vma);
> +	tlb_finish_mmu(&tlb, addr, end);
> +}
> +
> +void flush_pmd_tlb_range(struct vm_area_struct *vma,
> +			 unsigned long addr, unsigned long end)
> +{
> +	struct mmu_gather tlb;
> +
> +	tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);
> +	tlb_start_vma(&tlb, vma);
> +	tlb_set_pmd_range(&tlb, addr, end - addr);
> +	tlb_end_vma(&tlb, vma);
> +	tlb_finish_mmu(&tlb, addr, end);
> +}
> +
> +void flush_pud_tlb_range(struct vm_area_struct *vma,
> +			 unsigned long addr, unsigned long end)
> +{
> +	struct mmu_gather tlb;
> +
> +	tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);
> +	tlb_start_vma(&tlb, vma);
> +	tlb_set_pud_range(&tlb, addr, end - addr);
> +	tlb_end_vma(&tlb, vma);
> +	tlb_finish_mmu(&tlb, addr, end);
> +}
> +
> +void flush_p4d_tlb_range(struct vm_area_struct *vma,
> +			 unsigned long addr, unsigned long end)
> +{
> +	struct mmu_gather tlb;
> +
> +	tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);
> +	tlb_start_vma(&tlb, vma);
> +	tlb_set_p4d_range(&tlb, addr, end - addr);
> +	tlb_end_vma(&tlb, vma);
> +	tlb_finish_mmu(&tlb, addr, end);
> +}
> +#endif /* __HAVE_ARCH_FLUSH_PMD_TLB_RANGE */

You're nowhere near lazy enough:

#define FLUSH_Pxx_TLB_RANGE(_pxx) \
void flush_##_pxx##_tlb_range(struct vm_area_struct *vma, \
			      unsigned long addr, unsigned long end) \
{ \
	struct mmu_gather tlb; \
	\
	tlb_gather_mmu(&tlb, vma->vm_mm, addr, end); \
	tlb_start_vma(&tlb, vma); \
	tlb_flush_##_pxx##_range(&tlb, addr, end-addr); \
	tlb_end_vma(&tlb, vma); \
	tlb_finish_mmu(&tlb, addr, end); \
}

FLUSH_Pxx_TLB_RANGE(pte)
FLUSH_Pxx_TLB_RANGE(pmd)
FLUSH_Pxx_TLB_RANGE(pud)
FLUSH_Pxx_TLB_RANGE(p4d)
