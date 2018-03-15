From: Chintan Pandya <cpandya@codeaurora.org>
Subject: Re: [PATCH v2 2/4] ioremap: Implement TLB_INV before huge mapping
Date: Thu, 15 Mar 2018 19:49:01 +0530
Message-ID: <b6c7622d-9676-5584-d52b-10ece6a3877c@codeaurora.org>
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
 <1521117906-20107-3-git-send-email-cpandya@codeaurora.org>
 <20180315133157.ucbdg25jo5ew3t2h@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180315133157.ucbdg25jo5ew3t2h@lakrids.cambridge.arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arch@vger.kernel.org, toshi.kani@hpe.com, arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com, gregkh@linuxfoundation.org, tglx@linutronix.de, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org



On 3/15/2018 7:01 PM, Mark Rutland wrote:
> On Thu, Mar 15, 2018 at 06:15:04PM +0530, Chintan Pandya wrote:
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
> 
> Can we have something like a pmd_can_set_huge() helper? Then we could
> avoid pointless modification and TLB invalidation work when
> pmd_set_huge() will fail.

Actually, pmd_set_huge() will never fail because, if
CONFIG_HAVE_ARCH_HUGE_VMAP is disabled, ioremap_pmd_enabled()
will fail and if enabled (i.e. ARM64 & x86), they don't fail
in their implementation. So, rather we can do the following.

-                       if (pmd_set_huge(pmd, phys_addr + addr, prot)) {
-                               pmd_free_pte_page(&old_pmd);
-                               continue;
-                       } else
-                               set_pmd(pmd, old_pmd);
+                       pmd_set_huge(pmd, phys_addr + addr, prot)
+                       pmd_free_pte_page(&old_pmd);
+                       continue;

> 
> 	if (ioremap_pmd_enabled() &&
> 	    ((next - addr) == PMD_SIZE) &&
> 	    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
> 	    pmd_can_set_huge(pmd, phys_addr + addr, prot)) {
> 	    	// clear entries, invalidate TLBs, and free tables
> 		...
> 		continue;
> 
> 	}
> 
> Thanks,
> MArk.
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
