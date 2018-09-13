Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28930 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbeIMX67 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Sep 2018 19:58:59 -0400
Subject: Re: [RFC][PATCH 03/11] x86/mm: Page size aware flush_tlb_mm_range()
References: <20180913092110.817204997@infradead.org>
 <20180913092812.012757318@infradead.org>
 <f89e61a3-0eb0-3d00-fbaa-f30c2cf60be3@linux.intel.com>
 <20180913184230.GD24124@hirez.programming.kicks-ass.net>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <559a0a91-d8d1-453c-6071-1a6ce891c66f@linux.intel.com>
Date: Thu, 13 Sep 2018 11:47:59 -0700
MIME-Version: 1.0
In-Reply-To: <20180913184230.GD24124@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com
Message-ID: <20180913184759.8WYIbI7OCW0qHnqQpZ2xMxFS7tYvvl7Rh5egkVlky5Q@z>

>>> --- a/arch/x86/include/asm/tlbflush.h
>>> +++ b/arch/x86/include/asm/tlbflush.h
>>> @@ -507,23 +507,25 @@ struct flush_tlb_info {
>>>  	unsigned long		start;
>>>  	unsigned long		end;
>>>  	u64			new_tlb_gen;
>>> +	unsigned int		invl_shift;
>>>  };
>>
>> Maybe we really should just call this flush_stride or something.
> 
> But its a shift, not a size. stride_shift?

Yeah, sounds better than 'invl' to me.

>>>  #define local_flush_tlb() __flush_tlb()
>>>  
>>>  #define flush_tlb_mm(mm)	flush_tlb_mm_range(mm, 0UL, TLB_FLUSH_ALL, 0UL)
>>>  
>>> -#define flush_tlb_range(vma, start, end)	\
>>> -		flush_tlb_mm_range(vma->vm_mm, start, end, vma->vm_flags)
>>> +#define flush_tlb_range(vma, start, end)			\
>>> +		flush_tlb_mm_range((vma)->vm_mm, start, end,	\
>>> +				(vma)->vm_flags & VM_HUGETLB ? PMD_SHIFT : PAGE_SHIFT)
>>
>> This is safe.  But, Couldn't this PMD_SHIFT also be PUD_SHIFT for a 1G
>> hugetlb page?
> 
> It could be, but can we tell at that point?

We should have the page size via huge_page_shift(hstate_vma(vma)).  No
idea if it'll work in practice, though.
