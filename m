From: Chintan Pandya <cpandya@codeaurora.org>
Subject: Re: [PATCH v1 2/4] ioremap: Invalidate TLB after huge mappings
Date: Wed, 14 Mar 2018 16:50:35 +0530
Message-ID: <a278b3ca-b54f-ee5e-5828-b8859eea5cc6@codeaurora.org>
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
 <1521017305-28518-3-git-send-email-cpandya@codeaurora.org>
 <20180314104823.yumqomzmbu3cj442@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314104823.yumqomzmbu3cj442@lakrids.cambridge.arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com
List-Id: linux-arch.vger.kernel.org



On 3/14/2018 4:18 PM, Mark Rutland wrote:
> On Wed, Mar 14, 2018 at 02:18:23PM +0530, Chintan Pandya wrote:
>> If huge mappings are enabled, they can override
>> valid intermediate previous mappings. Some MMU
>> can speculatively pre-fetch these intermediate
>> entries even after unmap. That's because unmap
>> will clear only last level entries in page table
>> keeping intermediate (pud/pmd) entries still valid.
>>
>> This can potentially lead to stale TLB entries
>> which needs invalidation after map.
>>
>> Some more info: https://lkml.org/lkml/2017/12/23/3
>>
>> There is one noted case for ARM64 where such stale
>> TLB entries causes 3rd level translation fault even
>> after correct (huge) mapping is available.
> 
>> Hence, invalidate once we override pmd/pud with huge
>> mappings.
> 
>>   static int __read_mostly ioremap_p4d_capable;
>> @@ -92,8 +93,10 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
>>   		if (ioremap_pmd_enabled() &&
>>   		    ((next - addr) == PMD_SIZE) &&
>>   		    IS_ALIGNED(phys_addr + addr, PMD_SIZE)) {
>> -			if (pmd_set_huge(pmd, phys_addr + addr, prot))
>> +			if (pmd_set_huge(pmd, phys_addr + addr, prot)) {
>> +				flush_tlb_pgtable(&init_mm, addr);
>>   				continue;
>> +			}
>>   		}
>>   
>>   		if (ioremap_pte_range(pmd, addr, next, phys_addr + addr, prot))
>> @@ -118,8 +121,10 @@ static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
>>   		if (ioremap_pud_enabled() &&
>>   		    ((next - addr) == PUD_SIZE) &&
>>   		    IS_ALIGNED(phys_addr + addr, PUD_SIZE)) {
>> -			if (pud_set_huge(pud, phys_addr + addr, prot))
>> +			if (pud_set_huge(pud, phys_addr + addr, prot)) {
>> +				flush_tlb_pgtable(&init_mm, addr);
>>   				continue;
>> +			}
>>   		}
> 
> As has been noted in previous threads, the ARM architecture requires a
> Break-Before-Make sequence when changing an entry from a table to a
> block, as is the case here.
> 
> The means the necessary sequence is:
> 
> 	1. Make the entry invalid
> 	2. Invalidate relevant TLB entries
> 	3. Write the new entry
> 
We do this for PTEs. I don't see this applicable to PMDs. Because,

1) To mark any PMD invalid, we need to be sure that next level page
    table (I mean all the 512 PTEs) should be zero. That requires us
    to scan entire last level page. A big perf hit !
2) We need to perform step 1 for every unmap as we never know which
    unmap will make last level page table empty.

Moreover, problem comes only when 4K mapping was followed by 2M
mapping. In all other cases, retaining valid PMD has obvious perf
gain. That's what walk-cache is supposed to be introduced for.

So, I think to touch only problematic case and fix it with TLB
invalidate.

> Whereas above, the sequence is
> 
> 	1. Write the new entry
> 	2. invalidate relevant TLB entries
> 
> Which is insufficient, and will lead to a number of problems.
I couldn't think of new problems with this approach. Could you share
any problematic scenarios ?

Also, my test-case runs fine with these patches for 10+ hours.

> 
> Therefore, NAK to this patch.
> 
> Please read up on the Break-Before-Make requirements in the ARM ARM.
Sure, will get more from here.

> 
> Thanks,
> Mark.
> 
Thanks for the review Mark.

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
