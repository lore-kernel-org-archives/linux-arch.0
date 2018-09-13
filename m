Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:32937 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbeINAAN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Sep 2018 20:00:13 -0400
Subject: Re: [RFC][PATCH 03/11] x86/mm: Page size aware flush_tlb_mm_range()
References: <20180913092110.817204997@infradead.org>
 <20180913092812.012757318@infradead.org>
 <f89e61a3-0eb0-3d00-fbaa-f30c2cf60be3@linux.intel.com>
 <20180913184230.GD24124@hirez.programming.kicks-ass.net>
 <20180913184632.GM24142@hirez.programming.kicks-ass.net>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <93b19cab-779b-b5dd-a53b-df2c86241d4f@linux.intel.com>
Date: Thu, 13 Sep 2018 11:49:28 -0700
MIME-Version: 1.0
In-Reply-To: <20180913184632.GM24142@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com
Message-ID: <20180913184928.xXVen6pfp1ANaKp8U5g_1xvlfYUY-ftqz1zHVrwH3yg@z>

On 09/13/2018 11:46 AM, Peter Zijlstra wrote:
> On Thu, Sep 13, 2018 at 08:42:30PM +0200, Peter Zijlstra wrote:
>>>> +#define flush_tlb_range(vma, start, end)			\
>>>> +		flush_tlb_mm_range((vma)->vm_mm, start, end,	\
>>>> +				(vma)->vm_flags & VM_HUGETLB ? PMD_SHIFT : PAGE_SHIFT)
>>> This is safe.  But, Couldn't this PMD_SHIFT also be PUD_SHIFT for a 1G
>>> hugetlb page?
>> It could be, but can we tell at that point?
> I had me a look in higetlb.h, would something like so work?
> 
> #define flush_tlb_range(vma, start, end)			\
> 	flush_tlb_mm_range((vma)->vm_mm, start, end,		\
> 			   huge_page_shift(hstate_vma(vma)))
> 

I think you still need the VM_HUGETLB check somewhere because
hstate_vma() won't work on non-VM_HUGETLB VMAs.  But, yeah, something
close to that should be OK.
