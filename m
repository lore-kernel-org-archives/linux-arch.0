Return-Path: <SRS0=w+Hx=56=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406389AbgDNHGH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Apr 2020 03:06:07 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03E747Of128396
        for <linux-arch@vger.kernel.org>; Tue, 14 Apr 2020 03:06:06 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30cx1jy0p7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 14 Apr 2020 03:06:06 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 14 Apr 2020 08:05:59 +0100
Subject: Re: [RFC][Qusetion] the value of cleared_(ptes|pmds|puds|p4ds) in
 struct mmu_gather
References: <fbb00ac0-9104-8d25-f225-7b3d1b17a01f@huawei.com>
 <20200330121654.GL20696@hirez.programming.kicks-ass.net>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 14 Apr 2020 09:05:56 +0200
MIME-Version: 1.0
In-Reply-To: <20200330121654.GL20696@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-ID: <a2eaf3a1-61c7-4598-55bf-4d4bca54a850@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Zhenyu Ye <yezhenyu2@huawei.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: npiggin@gmail.com, will.deacon@arm.com, mingo@kernel.org, torvalds@linux-foundation.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arm@kernel.org, xiexiangyou@huawei.com
Message-ID: <20200414070556.OOQDUS0neav3PSxRGUhM-cMJ3vd1v4PZAZB5d-pfQzs@z>

Gerald,

can you have a look?

On 30.03.20 14:16, Peter Zijlstra wrote:
> On Sat, Mar 28, 2020 at 12:30:50PM +0800, Zhenyu Ye wrote:
>> Hi all,
>>
>> commit a6d60245 "Track which levels of the page tables have been cleared"
>> added cleared_(ptes|pmds|puds|p4ds) in struct mmu_gather, and the values
>> of them are set in some places. For example:
>>
>> In include/asm-generic/tlb.h, pte_free_tlb() set the tlb->cleared_pmds:
>> ---8<---
>> #ifndef pte_free_tlb
>> #define pte_free_tlb(tlb, ptep, address)			\
>> 	do {							\
>> 		__tlb_adjust_range(tlb, address, PAGE_SIZE);	\
>> 		tlb->freed_tables = 1;				\
>> 		tlb->cleared_pmds = 1;				\
>> 		__pte_free_tlb(tlb, ptep, address);		\
>> 	} while (0)
>> #endif
>> ---8<---
>>
>>
>> However, in arch/s390/include/asm/tlb.h, pte_free_tlb() set the tlb->cleared_ptes:
>> ---8<---
>> static inline void pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
>>                                 unsigned long address)
>> {
>> 	__tlb_adjust_range(tlb, address, PAGE_SIZE);
>> 	tlb->mm->context.flush_mm = 1;
>> 	tlb->freed_tables = 1;
>> 	tlb->cleared_ptes = 1;
>> 	/*
>> 	 * page_table_free_rcu takes care of the allocation bit masks
>> 	 * of the 2K table fragments in the 4K page table page,
>> 	 * then calls tlb_remove_table.
>> 	 */
>> 	page_table_free_rcu(tlb, (unsigned long *) pte, address);
>> }
>> ---8<---
>>
>>
>> In my view, the cleared_(ptes|pmds|puds) and (pte|pmd|pud)_free_tlb
>> correspond one-to-one.  So we should set cleared_ptes in pte_free_tlb(),
>> then use it when needed.
> 
> So pte_free_tlb() clears a table of PTE entries, or a PMD level entity,
> also see free_pte_range(). So the generic code makes sense to me. The
> PTE level invalidations will have happened on tlb_remove_tlb_entry().
> 
>> I'm very confused about this. Which is wrong? Or is there something
>> I understand wrong?
> 
> I agree the s390 case is puzzling, Martin does s390 need a PTE level
> invalidate for removing a PTE table or was this a mistake?
> 
