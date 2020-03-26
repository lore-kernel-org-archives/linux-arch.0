From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [RFC PATCH v4 5/6] arm64: tlb: Use translation level hint in
 vm_flags
Date: Thu, 26 Mar 2020 15:11:23 +0800
Message-ID: <6e2fece0-a7d7-a470-6911-5891fd09a140@huawei.com>
References: <20200324134534.1570-1-yezhenyu2@huawei.com>
 <20200324134534.1570-6-yezhenyu2@huawei.com> <20200324144514.340c78d9@why>
 <986be927-02c6-3cc2-ca39-30ccad60eae0@huawei.com>
 <2f4cb3ef52c5589b388225e487651a2b@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:33160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbgCZHLm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Mar 2020 03:11:42 -0400
In-Reply-To: <2f4cb3ef52c5589b388225e487651a2b@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: will@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, peterz@infradead.org, arnd@arndb.de, rostedt@goodmis.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com

Hi Marc,

On 2020/3/25 22:13, Marc Zyngier wrote:
>>>>
>>>> +inline unsigned int get_vma_level(struct vm_area_struct *vma)
>>>> +{
>>>> +    unsigned int level = 0;
>>>> +    if (vma->vm_flags & VM_LEVEL_PUD)
>>>> +        level = 1;
>>>> +    else if (vma->vm_flags & VM_LEVEL_PMD)
>>>> +        level = 2;
>>>> +    else if (vma->vm_flags & VM_LEVEL_PTE)
>>>> +        level = 3;
>>>> +
>>>> +    vma->vm_flags &= ~(VM_LEVEL_PUD | VM_LEVEL_PMD | VM_LEVEL_PTE);
>>>> +    return level;
>>>> +}
>>>> +
>>>>  void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
>>>>  {
>>>>      pgd_t *fixmap_pgdp;
>>>
>>>
>>> If feels bizarre a TLBI is now a destructive operation: you've lost the
>>> flags by having cleared them. Even if that's not really a problem in
>>> practice (you issue TLBI because you've unmapped the VMA), it remains
>>> that the act of invalidating TLBs isn't expected to change a kernel
>>> structure (and I'm not even thinking about potential races here).
>>
>> I cleared vm_flags here just out of caution, because every TLBI flush
>> action should set vm_flags themself. As I know, the TLB_LEVEL of an vma
>> will only be changed by transparent hugepage collapse and merge when
>> the page is not mapped, so there may not have potential races.
>>
>> But you are right that TLBI should't change a kernel structure.
>> I will remove the clear action and add some notices here.
> 
> More than that. You are changing the VMA flags at TLBI time already,
> when calling get_vma_level(). That is already unacceptable -- I don't
> think (and Peter will certainly correct me if I'm wrong) that you
> are allowed to change the flags on that code path, as you probably
> don't hold the write_lock.
>

Thanks for your review.  I will avoid this problem in next version.

>>> If anything, I feel this should be based around the mmu_gather
>>> structure, which already tracks the right level of information and
>>> additionally knows about the P4D level which is missing in your patches
>>> (even if arm64 is so far limited to 4 levels).
>>>
>>> Thanks,
>>>
>>>     M.
>>>
>>
>> mmu_gather structure has tracked the level information, but we can only
>> use the info in the tlb_flush interface. If we want to use the info in
>> flush_tlb_range, we may should have to add a parameter to this interface,
>> such as:
>>
>>     flush_tlb_range(vma, start, end, flags);
>>
>> However, the flush_tlb_range is a common interface to all architectures,
>> I'm not sure if this is feasible because this feature is only supported
>> by ARM64 currently.
> 
> You could always build an on-stack mmu_gather structure and pass it down
> to the TLB invalidation helpers.
> 
> And frankly, you are not going to be able to fit such a change in the
> way Linux deals with TLBs by adding hacks at the periphery. You'll need
> to change some of the core abstractions.
> 
> Finally, as Peter mentioned separately, there is Power9 which has similar
> instructions, and could make use of it too. So that's yet another reason
> to stop hacking at the arch level.
> 

OK, I will try to add struct mmu_gather to flush_tlb_range, such as:

	void flush_tlb_range(struct mmu_gather *tlb,
			     struct vm_area_struct *vma,
			     unsigned long start, unsigned long end);

This will involve all architectures, I will do it carefully.

>>
>> Or can we ignore the flush_tlb_range and only set the TTL field in
>> tlb_flush?  Waiting for your suggestion...
> 
> You could, but you could also ignore TTL altogether (what's the point
> in only having half of it?). See my suggestion above.
> 
>> For P4D level, the TTL field is limited to 4 bit(2 for translation granule
>> and 2 for page table level), so we can no longer afford more levels :).
> 
> You clearly didn't read the bit that said "even if arm64 is so far limited
> to 4 levels". But again, this is Linux, a multi-architecture kernel, and
> not an arm64-special. Changes you make have to work for all architectures,
> and be extensible enough for future changes.
> 

Using the struct mmu_gather to pass the TTL value will not have
this problem :).


Thanks,
Zhenyu
