Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbfLRLhz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Dec 2019 06:37:55 -0500
Subject: Re: [PATCH v2 2/3] mm/mmu_gather: Invalidate TLB correctly on batch
 allocation failure and flush
References: <20191218053530.73053-1-aneesh.kumar@linux.ibm.com>
 <20191218053530.73053-2-aneesh.kumar@linux.ibm.com>
 <20191218091733.GO2844@hirez.programming.kicks-ass.net>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <0f0bea3b-b7b5-fa8c-f75c-396cf78c47b4@linux.ibm.com>
Date: Wed, 18 Dec 2019 17:07:02 +0530
MIME-Version: 1.0
In-Reply-To: <20191218091733.GO2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Paul Mackerras <paulus@ozlabs.org>
Cc: akpm@linux-foundation.org, npiggin@gmail.com, mpe@ellerman.id.au, will@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Message-ID: <20191218113702.bualJvmXfMCKJadLi3kNMs5CLIiGp7XdcYdmYbSx6hU@z>

On 12/18/19 2:47 PM, Peter Zijlstra wrote:
> On Wed, Dec 18, 2019 at 11:05:29AM +0530, Aneesh Kumar K.V wrote:
>> From: Peter Zijlstra <peterz@infradead.org>
>>
>> Architectures for which we have hardware walkers of Linux page table should
>> flush TLB on mmu gather batch allocation failures and batch flush. Some
>> architectures like POWER supports multiple translation modes (hash and radix)
> 
> nohash, hash and radix in fact :-)
> 
>> and in the case of POWER only radix translation mode needs the above TLBI.
> 
>> This is because for hash translation mode kernel wants to avoid this extra
>> flush since there are no hardware walkers of linux page table. With radix
>> translation, the hardware also walks linux page table and with that, kernel
>> needs to make sure to TLB invalidate page walk cache before page table pages are
>> freed.
>>
>> More details in
>> commit: d86564a2f085 ("mm/tlb, x86/mm: Support invalidating TLB caches for RCU_TABLE_FREE")
>>
>> Fixes: a46cc7a90fd8 ("powerpc/mm/radix: Improve TLB/PWC flushes")
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
> 
>> diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
>> index b2c0be93929d..7f3a8b902325 100644
>> --- a/arch/powerpc/include/asm/tlb.h
>> +++ b/arch/powerpc/include/asm/tlb.h
>> @@ -26,6 +26,17 @@
>>   
>>   #define tlb_flush tlb_flush
>>   extern void tlb_flush(struct mmu_gather *tlb);
>> +/*
>> + * book3s:
>> + * Hash does not use the linux page-tables, so we can avoid
>> + * the TLB invalidate for page-table freeing, Radix otoh does use the
>> + * page-tables and needs the TLBI.
>> + *
>> + * nohash:
>> + * We still do TLB invalidate in the __pte_free_tlb routine before we
>> + * add the page table pages to mmu gather table batch.
> 
> I'm a little confused though; if nohash is a software TLB fill, why do
> you need a TLBI for tables?
> 

nohash (AKA book3e) has different mmu modes. I don't follow all the 
details w.r.t book3e. Paul or Michael might be able to explain the need 
for table flush with book3e.

Documentation/powerpc/cpu-faimilies.rst shows different hardware assist 
TLB fill support.

What I wanted to convey with the above comment way we handle only radix 
translation mode with tlb_needs_table_invalidate() check. Other 
translations (hash,  different variants of book3e) are all good because 
of the reason outlined above.

-aneesh
