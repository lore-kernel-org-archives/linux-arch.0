From: Chintan Pandya <cpandya@codeaurora.org>
Subject: Re: [PATCH v2 3/4] arm64: Implement page table free interfaces
Date: Mon, 19 Mar 2018 09:59:15 +0530
Message-ID: <cada7499-acb1-dc99-bec3-f7dba00a80cc@codeaurora.org>
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
 <1521117906-20107-4-git-send-email-cpandya@codeaurora.org>
 <20180315131846.sfpxg3xlpjii3nju@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180315131846.sfpxg3xlpjii3nju@lakrids.cambridge.arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com
List-Id: linux-arch.vger.kernel.org



On 3/15/2018 6:48 PM, Mark Rutland wrote:
> On Thu, Mar 15, 2018 at 06:15:05PM +0530, Chintan Pandya wrote:
>> Implement pud_free_pmd_page() and pmd_free_pte_page().
>>
>> Make sure, that they are indeed a page table before
>> taking them to free.
> 
> As mentioned on the prior patch, if the tables we're freeing contain
> valid entries, then we need additional TLB maintenance to ensure that
> all of these entries have been removed from TLBs.
> 
> Either, we always invalidate the entire range, or we walk the tables
> and invalidate as we remove them.

Right. I'll send v3 and ensure this. Thinking like, we can
invalidate page table in PMD case and invalidate range if it's pud.
Will see if that also can be optimized.

> 
> Thanks,
> Mark.
> 
>>
>> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
>> ---
>>   arch/arm64/mm/mmu.c | 20 ++++++++++++++++++--
>>   1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 2dbb2c9..6f21a65 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -32,6 +32,7 @@
>>   #include <linux/io.h>
>>   #include <linux/mm.h>
>>   #include <linux/vmalloc.h>
>> +#include <linux/hugetlb.h>
>>   
>>   #include <asm/barrier.h>
>>   #include <asm/cputype.h>
>> @@ -45,6 +46,7 @@
>>   #include <asm/memblock.h>
>>   #include <asm/mmu_context.h>
>>   #include <asm/ptdump.h>
>> +#include <asm/page.h>
>>   
>>   #define NO_BLOCK_MAPPINGS	BIT(0)
>>   #define NO_CONT_MAPPINGS	BIT(1)
>> @@ -975,10 +977,24 @@ int pmd_clear_huge(pmd_t *pmdp)
>>   
>>   int pud_free_pmd_page(pud_t *pud)
>>   {
>> -	return pud_none(*pud);
>> +	pmd_t *pmd;
>> +	int i;
>> +
>> +	pmd = __va(pud_val(*pud));
>> +	if (pud_val(*pud) && !pud_huge(*pud)) {
>> +		for (i = 0; i < PTRS_PER_PMD; i++)
>> +			pmd_free_pte_page(&pmd[i]);
>> +
>> +		free_page((unsigned long)pmd);
>> +	}
>> +
>> +	return 1;
>>   }
>>   
>>   int pmd_free_pte_page(pmd_t *pmd)
>>   {
>> -	return pmd_none(*pmd);
>> +	if (pmd_val(*pmd) && !pmd_huge(*pmd))
>> +		free_page((unsigned long)__va(pmd_val(*pmd)));
>> +
>> +	return 1;
>>   }
>> -- 
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation
>> Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
>> Collaborative Project
>>

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
