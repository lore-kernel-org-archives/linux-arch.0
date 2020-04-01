Return-Path: <SRS0=5ux+=5R=kvack.org=owner-linux-mm@kernel.org>
Subject: Re: [RFC PATCH v5 4/8] mm: tlb: Pass struct mmu_gather to
 flush_pmd_tlb_range
References: <20200331142927.1237-1-yezhenyu2@huawei.com>
 <20200331142927.1237-5-yezhenyu2@huawei.com>
 <20200331151331.GS20730@hirez.programming.kicks-ass.net>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <fe12101e-8efe-22ad-0258-e6aeafc798cc@huawei.com>
Date: Wed, 1 Apr 2020 16:51:15 +0800
MIME-Version: 1.0
In-Reply-To: <20200331151331.GS20730@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, corbet@lwn.net, vgupta@synopsys.com, tony.luck@intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200401085115.SYQzoxS_n4RTrj36Q4n2k6GDT_pVd7zy7o2ZG3Af0Mo@z>

Hi Peter,

On 2020/3/31 23:13, Peter Zijlstra wrote:
> On Tue, Mar 31, 2020 at 10:29:23PM +0800, Zhenyu Ye wrote:
>> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
>> index e2e2bef07dd2..32d4661e5a56 100644
>> --- a/include/asm-generic/pgtable.h
>> +++ b/include/asm-generic/pgtable.h
>> @@ -1160,10 +1160,10 @@ static inline int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>>   * invalidate the entire TLB which is not desitable.
>>   * e.g. see arch/arc: flush_pmd_tlb_range
>>   */
>> -#define flush_pmd_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
>> +#define flush_pmd_tlb_range(tlb, vma, addr, end)	flush_tlb_range(vma, addr, end)
>>  #define flush_pud_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
>>  #else
>> -#define flush_pmd_tlb_range(vma, addr, end)	BUILD_BUG()
>> +#define flush_pmd_tlb_range(tlb, vma, addr, end)	BUILD_BUG()
>>  #define flush_pud_tlb_range(vma, addr, end)	BUILD_BUG()
>>  #endif
>>  #endif
>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>> index 3d7c01e76efc..96c9cf77bfb5 100644
>> --- a/mm/pgtable-generic.c
>> +++ b/mm/pgtable-generic.c
>> @@ -109,8 +109,14 @@ int pmdp_set_access_flags(struct vm_area_struct *vma,
>>  	int changed = !pmd_same(*pmdp, entry);
>>  	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>>  	if (changed) {
>> +		struct mmu_gather tlb;
>> +		unsigned long tlb_start = address;
>> +		unsigned long tlb_end = address + HPAGE_PMD_SIZE;
>>  		set_pmd_at(vma->vm_mm, address, pmdp, entry);
>> -		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>> +		tlb_gather_mmu(&tlb, vma->vm_mm, tlb_start, tlb_end);
>> +		tlb.cleared_pmds = 1;
>> +		flush_pmd_tlb_range(&tlb, vma, tlb_start, tlb_end);
>> +		tlb_finish_mmu(&tlb, tlb_start, tlb_end);
>>  	}
>>  	return changed;
>>  }
> 
> This is madness. Please, carefully consider what you just wrote and what
> it will do in the generic case.
> 
> Instead of trying to retro-fit flush_*tlb_range() to take an mmu_gather
> parameter, please replace them out-right.
> 

I'm sorry that I'm not sure what "replace them out-right" means.  Do you
mean that I should define flush_*_tlb_range like this?

#define flush_pmd_tlb_range(vma, addr, end)				\
	do {								\
		struct mmu_gather tlb;					\
		tlb_gather_mmu(&tlb, (vma)->vm_mm, addr, end);		\
		tlba.cleared_pmds = 1;					\
		flush_tlb_range(&tlb, vma, addr, end);			\
		tlb_finish_mmu(&tlb, addr, end);			\
	} while (0)


Thanks,
Zhenyu
