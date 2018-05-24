From: Chintan Pandya <cpandya@codeaurora.org>
Subject: Re: [PATCH v9 3/4] arm64: Implement page table free interfaces
Date: Thu, 24 May 2018 13:04:15 +0530
Message-ID: <9a059bc1-07eb-031b-e561-7e1eaabbf980@codeaurora.org>
References: <1525074094-25839-1-git-send-email-cpandya@codeaurora.org>
 <1525074094-25839-4-git-send-email-cpandya@codeaurora.org>
 <20180523140157.GG26965@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180523140157.GG26965@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Philip Elcan <pelcan@codeaurora.org>, Toshi Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, Kristina Martsenko <kristina.martsenko@arm.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Ingo Molnar <mingo@redhat.com>, James Morse <james.morse@arm.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org



On 5/23/2018 7:31 PM, Will Deacon wrote:
> Hi Chintan,

Hi Will,

> 
> [as a side note: I'm confused on the status of this patch series, as part
>   of it was reposted separately by Toshi. Please can you work together?]

I will share all 4 patches once again as v10 and take latest version of
1/4 as updated by Toshi.

> 
> On Mon, Apr 30, 2018 at 01:11:33PM +0530, Chintan Pandya wrote:
>> Implement pud_free_pmd_page() and pmd_free_pte_page().
>>
>> Implementation requires,
>>   1) Clearing off the current pud/pmd entry
>>   2) Invalidate TLB which could have previously
>>      valid but not stale entry
>>   3) Freeing of the un-used next level page tables
>>
>> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
>> ---
>>   arch/arm64/mm/mmu.c | 29 +++++++++++++++++++++++++----
>>   1 file changed, 25 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index da98828..0f651db 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -45,6 +45,7 @@
>>   #include <asm/memblock.h>
>>   #include <asm/mmu_context.h>
>>   #include <asm/ptdump.h>
>> +#include <asm/tlbflush.h>
>>   
>>   #define NO_BLOCK_MAPPINGS	BIT(0)
>>   #define NO_CONT_MAPPINGS	BIT(1)
>> @@ -973,12 +974,32 @@ int pmd_clear_huge(pmd_t *pmdp)
>>   	return 1;
>>   }
>>   
>> -int pud_free_pmd_page(pud_t *pud, unsigned long addr)
>> +int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
>>   {
>> -	return pud_none(*pud);
>> +	pmd_t *table;
>> +
>> +	if (pmd_present(READ_ONCE(*pmdp))) {
> 
> Might also be worth checking pmd_table here, just in case. (same for pud)

I had that check in v2 as below.

if (pud_val(*pud) && !pud_huge(*pud))

But removed that in v3 as unmap should change this to NONE if it is
not table. I still don't see the need of it.

> 
>> +		table = __va(pmd_val(*pmdp));
> 
> Can you avoid dereferencing *pmdp twice, and instead READ_ONCE into a local
> variable, please? (same for pud)

Okay.

> 
>> +		pmd_clear(pmdp);
>> +		__flush_tlb_kernel_pgtable(addr);
>> +		free_page((unsigned long) table);
> 
> Shouldn't this be pte_free_kernel, to pair with pte_alloc_kernel which
> was used to allocate the page in the first place? (similarly for pud)

Okay.

> 
>> +	}
>> +	return 1;
>>   }
>>   
>> -int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>> +int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>>   {
>> -	return pmd_none(*pmd);
>> +	pmd_t *table;
>> +	int i;
>> +
>> +	if (pud_present(READ_ONCE(*pudp))) {
>> +		table = __va(pud_val(*pudp));
>> +		for (i = 0; i < PTRS_PER_PMD; i++)
>> +			pmd_free_pte_page(&table[i], addr + (i * PMD_SIZE));
> 
> I think it would be cleaner to write this as a do { ... } while, for
> consistency with the ioremap and vmalloc code.

Okay.

I'll raise v10 fixing above things. Thanks for the review.

> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
