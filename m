From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 2/3] mm/mmu_gather: Invalidate TLB correctly on batch allocation failure and flush
Date: Thu, 19 Dec 2019 00:13:48 +1100
Message-ID: <87v9qdn5df.fsf@mpe.ellerman.id.au>
References: <20191218053530.73053-1-aneesh.kumar@linux.ibm.com> <20191218053530.73053-2-aneesh.kumar@linux.ibm.com> <20191218091733.GO2844@hirez.programming.kicks-ass.net> <0f0bea3b-b7b5-fa8c-f75c-396cf78c47b4@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0f0bea3b-b7b5-fa8c-f75c-396cf78c47b4@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Paul Mackerras <paulus@ozlabs.org>
Cc: akpm@linux-foundation.org, npiggin@gmail.com, will@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, Scott Wood <oss@buserror.net>
List-Id: linux-arch.vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> On 12/18/19 2:47 PM, Peter Zijlstra wrote:
>> On Wed, Dec 18, 2019 at 11:05:29AM +0530, Aneesh Kumar K.V wrote:
>>> From: Peter Zijlstra <peterz@infradead.org>
>>>
>>> Architectures for which we have hardware walkers of Linux page table should
>>> flush TLB on mmu gather batch allocation failures and batch flush. Some
>>> architectures like POWER supports multiple translation modes (hash and radix)
>> 
>> nohash, hash and radix in fact :-)
>> 
>>> and in the case of POWER only radix translation mode needs the above TLBI.
>> 
>>> This is because for hash translation mode kernel wants to avoid this extra
>>> flush since there are no hardware walkers of linux page table. With radix
>>> translation, the hardware also walks linux page table and with that, kernel
>>> needs to make sure to TLB invalidate page walk cache before page table pages are
>>> freed.
>>>
>>> More details in
>>> commit: d86564a2f085 ("mm/tlb, x86/mm: Support invalidating TLB caches for RCU_TABLE_FREE")
>>>
>>> Fixes: a46cc7a90fd8 ("powerpc/mm/radix: Improve TLB/PWC flushes")
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> ---
>> 
>>> diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
>>> index b2c0be93929d..7f3a8b902325 100644
>>> --- a/arch/powerpc/include/asm/tlb.h
>>> +++ b/arch/powerpc/include/asm/tlb.h
>>> @@ -26,6 +26,17 @@
>>>   
>>>   #define tlb_flush tlb_flush
>>>   extern void tlb_flush(struct mmu_gather *tlb);
>>> +/*
>>> + * book3s:
>>> + * Hash does not use the linux page-tables, so we can avoid
>>> + * the TLB invalidate for page-table freeing, Radix otoh does use the
>>> + * page-tables and needs the TLBI.
>>> + *
>>> + * nohash:
>>> + * We still do TLB invalidate in the __pte_free_tlb routine before we
>>> + * add the page table pages to mmu gather table batch.
>> 
>> I'm a little confused though; if nohash is a software TLB fill, why do
>> you need a TLBI for tables?
>> 
>
> nohash (AKA book3e) has different mmu modes. I don't follow all the 
> details w.r.t book3e. Paul or Michael might be able to explain the need 
> for table flush with book3e.

Some of the Book3E CPUs have a partial hardware table walker. The IBM one (A2)
did, before we ripped that support out. And the Freescale (NXP) e6500
does, see eg:

  28efc35fe68d ("powerpc/e6500: TLB miss handler with hardware tablewalk support")

They only support walking one level IIRC, ie. you can create a TLB entry
that points to a PTE page, and the hardware will dereference that to get
a PTE and load that into the TLB.

cheers
