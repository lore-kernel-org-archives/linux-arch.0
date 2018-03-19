From: Chintan Pandya <cpandya@codeaurora.org>
Subject: Re: [PATCH v2 2/4] ioremap: Implement TLB_INV before huge mapping
Date: Mon, 19 Mar 2018 09:56:21 +0530
Message-ID: <471d5888-af4d-6c37-8e8d-097879fd8c82@codeaurora.org>
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
 <1521117906-20107-3-git-send-email-cpandya@codeaurora.org>
 <1521130368.2693.177.camel@hpe.com>
 <0cec2b79-1668-68d1-32db-531f5a8a9db2@codeaurora.org>
 <1521211837.2693.187.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521211837.2693.187.camel@hpe.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Kani, Toshi" <toshi.kani@hpe.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "arnd@arndb.de" <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>, "james.morse@arm.com" <james.morse@arm.com>, "kristina.martsenko@arm.com" <kristina.martsenko@arm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org



On 3/16/2018 8:20 PM, Kani, Toshi wrote:
> On Fri, 2018-03-16 at 13:10 +0530, Chintan Pandya wrote:
>>
>> On 3/15/2018 9:42 PM, Kani, Toshi wrote:
>>> On Thu, 2018-03-15 at 18:15 +0530, Chintan Pandya wrote:
>>>> Huge mapping changes PMD/PUD which could have
>>>> valid previous entries. This requires proper
>>>> TLB maintanance on some architectures, like
>>>> ARM64.
>>>>
>>>> Implent BBM (break-before-make) safe TLB
>>>> invalidation.
>>>>
>>>> Here, I've used flush_tlb_pgtable() instead
>>>> of flush_kernel_range() because invalidating
>>>> intermediate page_table entries could have
>>>> been optimized for specific arch. That's the
>>>> case with ARM64 at least.
>>>>
>>>> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
>>>> ---
>>>>    lib/ioremap.c | 25 +++++++++++++++++++------
>>>>    1 file changed, 19 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/lib/ioremap.c b/lib/ioremap.c
>>>> index 54e5bba..55f8648 100644
>>>> --- a/lib/ioremap.c
>>>> +++ b/lib/ioremap.c
>>>> @@ -13,6 +13,7 @@
>>>>    #include <linux/export.h>
>>>>    #include <asm/cacheflush.h>
>>>>    #include <asm/pgtable.h>
>>>> +#include <asm-generic/tlb.h>
>>>>    
>>>>    #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>>>>    static int __read_mostly ioremap_p4d_capable;
>>>> @@ -80,6 +81,7 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
>>>>    		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
>>>>    {
>>>>    	pmd_t *pmd;
>>>> +	pmd_t old_pmd;
>>>>    	unsigned long next;
>>>>    
>>>>    	phys_addr -= addr;
>>>> @@ -91,10 +93,15 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
>>>>    
>>>>    		if (ioremap_pmd_enabled() &&
>>>>    		    ((next - addr) == PMD_SIZE) &&
>>>> -		    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
>>>> -		    pmd_free_pte_page(pmd)) {
>>>> -			if (pmd_set_huge(pmd, phys_addr + addr, prot))
>>>> +		    IS_ALIGNED(phys_addr + addr, PMD_SIZE)) {
>>>> +			old_pmd = *pmd;
>>>> +			pmd_clear(pmd);
>>>
>>> pmd_clear() is one of the operations pmd_free_pte_page() needs to do.
>>> See the x86 version.
>>>
>>>> +			flush_tlb_pgtable(&init_mm, addr);
>>>
>>> You can call it in pmd_free_pte_page() on arm64 as well.
>>>
>>>> +			if (pmd_set_huge(pmd, phys_addr + addr, prot)) {
>>>> +				pmd_free_pte_page(&old_pmd);
>>>>    				continue;
>>>> +			} else
>>>> +				set_pmd(pmd, old_pmd);
>>>
>>> I do not understand why you needed to make this change.
>>> pmd_free_pte_page() is defined as an arch-specific function so that you
>>> can additionally perform TLB purges on arm64.  Please try to make proper
>>> arm64 implementation of this interface.  And if you find any issue in
>>> this interface, please let me know.
>>
>> TLB ops require VA at least. And this interface passes just the PMD/PUD.
> 
> You can add 'addr' as the 2nd arg.  Such minor tweak is expected when
> implementing on multiple arches.
> 
>> Second is, if we clear the previous table entry inside the arch specific
>> code and then we fail in pmd/pud_set_huge, we can't fallback (x86 case).
>>
>> So, we can do something like this (following Mark's suggestion),
>>
>> 	if (ioremap_pmd_enabled() &&
>>           	((next - addr) == PMD_SIZE) &&
>> 		IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
>> 		pmd_can_set_huge(pmd, phys_addr + addr, prot)) {
>> 			/*
>> 			 * Clear existing table entry,
>> 			 * Invalidate,
>> 			 * Free the page table
>> 			 * inside this code
>> 			 */
>> 			pmd_free_pte_page(pmd, addr, addr + PMD_SIZE);
>> 			pmd_set_huge(...) //without fail
>> 			continue;
>> 	}
> 
> That's not necessary.  pmd being none is a legitimate state.  In fact,
> it is the case when pmd_alloc() allocated and populated a new pmd.

Alright. I'll send v3 today.

> 
> Thanks,
> -Toshi
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
