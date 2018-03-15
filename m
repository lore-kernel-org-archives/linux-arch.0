From: Chintan Pandya <cpandya@codeaurora.org>
Subject: Re: [PATCH v2 2/4] ioremap: Implement TLB_INV before huge mapping
Date: Thu, 15 Mar 2018 18:55:32 +0530
Message-ID: <839387ee-e1c2-cc71-c06a-7bc2d0eda73d@codeaurora.org>
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
 <1521117906-20107-3-git-send-email-cpandya@codeaurora.org>
 <20180315131316.fd5ftqwgdb5bf5we@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180315131316.fd5ftqwgdb5bf5we@lakrids.cambridge.arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com
List-Id: linux-arch.vger.kernel.org



On 3/15/2018 6:43 PM, Mark Rutland wrote:
> Hi,
> 
> As a general note, pleas wrap commit text to 72 characters.
> 
> On Thu, Mar 15, 2018 at 06:15:04PM +0530, Chintan Pandya wrote:
>> Huge mapping changes PMD/PUD which could have
>> valid previous entries. This requires proper
>> TLB maintanance on some architectures, like
>> ARM64.
> 
> Just to check, I take it that you mean we could have a valid table
> entry, but all the entries in that next level table must be invalid,
> right?

That was my assumption but my assumption can be wrong if any VA gets
block mapping for 1G directly (instead of the 2M cases we discussed
so far), then this would go for a toss.

> 
>>
>> Implent BBM (break-before-make) safe TLB
>> invalidation.
>>
>> Here, I've used flush_tlb_pgtable() instead
>> of flush_kernel_range() because invalidating
>> intermediate page_table entries could have
>> been optimized for specific arch. That's the
>> case with ARM64 at least.
> 
> ... because if there are valid entries in the next level table,
> __flush_tlb_pgtable() is not sufficient to ensure all of these are
> removed from the TLB.

oh !! In case of huge_pgd, next level pmd may or may not be valid. So, 
better I be using flush_kernel_range()

I will upload v3. But, would wait for other comments...

> 
> Assuming that all entries in the next level table are invalid, this
> looks ok to me.
> 
> Thanks,
> Mark.
> 
>> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
>> ---
>>   lib/ioremap.c | 25 +++++++++++++++++++------
>>   1 file changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/lib/ioremap.c b/lib/ioremap.c
>> index 54e5bba..55f8648 100644
>> --- a/lib/ioremap.c
>> +++ b/lib/ioremap.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/export.h>
>>   #include <asm/cacheflush.h>
>>   #include <asm/pgtable.h>
>> +#include <asm-generic/tlb.h>
>>   
>>   #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>>   static int __read_mostly ioremap_p4d_capable;
>> @@ -80,6 +81,7 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
>>   		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
>>   {
>>   	pmd_t *pmd;
>> +	pmd_t old_pmd;
>>   	unsigned long next;
>>   
>>   	phys_addr -= addr;
>> @@ -91,10 +93,15 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
>>   
>>   		if (ioremap_pmd_enabled() &&
>>   		    ((next - addr) == PMD_SIZE) &&
>> -		    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
>> -		    pmd_free_pte_page(pmd)) {
>> -			if (pmd_set_huge(pmd, phys_addr + addr, prot))
>> +		    IS_ALIGNED(phys_addr + addr, PMD_SIZE)) {
>> +			old_pmd = *pmd;
>> +			pmd_clear(pmd);
>> +			flush_tlb_pgtable(&init_mm, addr);
>> +			if (pmd_set_huge(pmd, phys_addr + addr, prot)) {
>> +				pmd_free_pte_page(&old_pmd);
>>   				continue;
>> +			} else
>> +				set_pmd(pmd, old_pmd);
>>   		}
>>   
>>   		if (ioremap_pte_range(pmd, addr, next, phys_addr + addr, prot))
>> @@ -107,6 +114,7 @@ static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
>>   		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
>>   {
>>   	pud_t *pud;
>> +	pud_t old_pud;
>>   	unsigned long next;
>>   
>>   	phys_addr -= addr;
>> @@ -118,10 +126,15 @@ static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
>>   
>>   		if (ioremap_pud_enabled() &&
>>   		    ((next - addr) == PUD_SIZE) &&
>> -		    IS_ALIGNED(phys_addr + addr, PUD_SIZE) &&
>> -		    pud_free_pmd_page(pud)) {
>> -			if (pud_set_huge(pud, phys_addr + addr, prot))
>> +		    IS_ALIGNED(phys_addr + addr, PUD_SIZE)) {
>> +			old_pud = *pud;
>> +			pud_clear(pud);
>> +			flush_tlb_pgtable(&init_mm, addr);
>> +			if (pud_set_huge(pud, phys_addr + addr, prot)) {
>> +				pud_free_pmd_page(&old_pud);
>>   				continue;
>> +			} else
>> +				set_pud(pud, old_pud);
>>   		}
>>   
>>   		if (ioremap_pmd_range(pud, addr, next, phys_addr + addr, prot))
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
