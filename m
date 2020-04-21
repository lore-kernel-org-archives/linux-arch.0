From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [PATCH v1 5/6] mm: tlb: Provide flush_*_tlb_range wrappers
Date: Tue, 21 Apr 2020 22:18:57 +0800
Message-ID: <8f6e877c-1462-441b-23ec-2a6bd3308099@huawei.com>
References: <20200403090048.938-1-yezhenyu2@huawei.com>
 <20200403090048.938-6-yezhenyu2@huawei.com>
 <20200420120916.GE20696@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:2826 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728337AbgDUOTM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 10:19:12 -0400
In-Reply-To: <20200420120916.GE20696@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com

Hi Peter,

On 2020/4/20 20:09, Peter Zijlstra wrote:
> On Fri, Apr 03, 2020 at 05:00:47PM +0800, Zhenyu Ye wrote:
>> This patch provides flush_{pte|pmd|pud|p4d}_tlb_range() in generic
>> code, which are expressed through the mmu_gather APIs.  These
>> interface set tlb->cleared_* and finally call tlb_flush(), so we
>> can do the tlb invalidation according to the information in
>> struct mmu_gather.
>>
>> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
>> ---
>>  include/asm-generic/pgtable.h | 12 +++++++--
>>  mm/pgtable-generic.c          | 50 +++++++++++++++++++++++++++++++++++
>>  2 files changed, 60 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
>> index e2e2bef07dd2..2bedeee94131 100644
>> --- a/include/asm-generic/pgtable.h
>> +++ b/include/asm-generic/pgtable.h
>> @@ -1160,11 +1160,19 @@ static inline int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>>   * invalidate the entire TLB which is not desitable.
>>   * e.g. see arch/arc: flush_pmd_tlb_range
>>   */
>> -#define flush_pmd_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
>> -#define flush_pud_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
>> +extern void flush_pte_tlb_range(struct vm_area_struct *vma,
>> +				unsigned long addr, unsigned long end);
>> +extern void flush_pmd_tlb_range(struct vm_area_struct *vma,
>> +				unsigned long addr, unsigned long end);
>> +extern void flush_pud_tlb_range(struct vm_area_struct *vma,
>> +				unsigned long addr, unsigned long end);
>> +extern void flush_p4d_tlb_range(struct vm_area_struct *vma,
>> +				unsigned long addr, unsigned long end);
>>  #else
>> +#define flush_pte_tlb_range(vma, addr, end)	BUILD_BUG()
>>  #define flush_pmd_tlb_range(vma, addr, end)	BUILD_BUG()
>>  #define flush_pud_tlb_range(vma, addr, end)	BUILD_BUG()
>> +#define flush_p4d_tlb_range(vma, addr, end)	BUILD_BUG()
>>  #endif
>>  #endif
> 
> Ideally you'd make __HAVE_ARCH_FLUSH_PMD_TLB_RANGE go away. Power
> certainly doesnt need it with the below.
> 

However, arch `arc` also uses __HAVE_ARCH_FLUSH_PMD_TLB_RANGE :

grep -nr __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
	mm/pgtable-generic.c:104:#ifndef __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
	mm/pgtable-generic.c:152:#endif /* __HAVE_ARCH_FLUSH_PMD_TLB_RANGE */
	include/asm-generic/pgtable.h:1153:#ifndef __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
	arch/powerpc/include/asm/book3s/64/tlbflush.h:49:#define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
	arch/arc/include/asm/hugepage.h:69:#define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE

So I am not sure if we can remove it.

And if we remove the __HAVE_ARCH_FLUSH_PMD_TLB_RANGE, how to ensure not
redefine flush_pXX_tlb_range() ?

>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>> index 3d7c01e76efc..0f5414a4a2ec 100644
>> --- a/mm/pgtable-generic.c
>> +++ b/mm/pgtable-generic.c
>> @@ -101,6 +101,56 @@ pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long address,
>>  
>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>  
>> +#ifndef __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
>> +void flush_pte_tlb_range(struct vm_area_struct *vma,
>> +			 unsigned long addr, unsigned long end)
>> +{
>> +	struct mmu_gather tlb;
>> +
>> +	tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);
>> +	tlb_start_vma(&tlb, vma);
>> +	tlb_set_pte_range(&tlb, addr, end - addr);
>> +	tlb_end_vma(&tlb, vma);
>> +	tlb_finish_mmu(&tlb, addr, end);
>> +}
>> +
>> +void flush_pmd_tlb_range(struct vm_area_struct *vma,
>> +			 unsigned long addr, unsigned long end)
>> +{
>> +	struct mmu_gather tlb;
>> +
>> +	tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);
>> +	tlb_start_vma(&tlb, vma);
>> +	tlb_set_pmd_range(&tlb, addr, end - addr);
>> +	tlb_end_vma(&tlb, vma);
>> +	tlb_finish_mmu(&tlb, addr, end);
>> +}
>> +
>> +void flush_pud_tlb_range(struct vm_area_struct *vma,
>> +			 unsigned long addr, unsigned long end)
>> +{
>> +	struct mmu_gather tlb;
>> +
>> +	tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);
>> +	tlb_start_vma(&tlb, vma);
>> +	tlb_set_pud_range(&tlb, addr, end - addr);
>> +	tlb_end_vma(&tlb, vma);
>> +	tlb_finish_mmu(&tlb, addr, end);
>> +}
>> +
>> +void flush_p4d_tlb_range(struct vm_area_struct *vma,
>> +			 unsigned long addr, unsigned long end)
>> +{
>> +	struct mmu_gather tlb;
>> +
>> +	tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);
>> +	tlb_start_vma(&tlb, vma);
>> +	tlb_set_p4d_range(&tlb, addr, end - addr);
>> +	tlb_end_vma(&tlb, vma);
>> +	tlb_finish_mmu(&tlb, addr, end);
>> +}
>> +#endif /* __HAVE_ARCH_FLUSH_PMD_TLB_RANGE */
> 
> You're nowhere near lazy enough:
> 
> #define FLUSH_Pxx_TLB_RANGE(_pxx) \
> void flush_##_pxx##_tlb_range(struct vm_area_struct *vma, \
> 			      unsigned long addr, unsigned long end) \
> { \
> 	struct mmu_gather tlb; \
> 	\
> 	tlb_gather_mmu(&tlb, vma->vm_mm, addr, end); \
> 	tlb_start_vma(&tlb, vma); \
> 	tlb_flush_##_pxx##_range(&tlb, addr, end-addr); \
> 	tlb_end_vma(&tlb, vma); \
> 	tlb_finish_mmu(&tlb, addr, end); \
> }
> 
> FLUSH_Pxx_TLB_RANGE(pte)
> FLUSH_Pxx_TLB_RANGE(pmd)
> FLUSH_Pxx_TLB_RANGE(pud)
> FLUSH_Pxx_TLB_RANGE(p4d)
> 
> 
> .
> 
