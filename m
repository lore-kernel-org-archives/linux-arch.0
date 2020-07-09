From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [RFC PATCH v5 2/2] arm64: tlb: Use the TLBI RANGE feature in
 arm64
Date: Thu, 9 Jul 2020 14:51:05 +0800
Message-ID: <27a4d364-d967-c644-83ed-805ba75f13f6@huawei.com>
References: <20200708124031.1414-1-yezhenyu2@huawei.com>
 <20200708124031.1414-3-yezhenyu2@huawei.com> <20200708182451.GF6308@gaia>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:7825 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbgGIGvT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Jul 2020 02:51:19 -0400
In-Reply-To: <20200708182451.GF6308@gaia>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, suzuki.poulose@arm.com, maz@kernel.org, steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com

On 2020/7/9 2:24, Catalin Marinas wrote:
> On Wed, Jul 08, 2020 at 08:40:31PM +0800, Zhenyu Ye wrote:
>> Add __TLBI_VADDR_RANGE macro and rewrite __flush_tlb_range().
>>
>> In this patch, we only use the TLBI RANGE feature if the stride == PAGE_SIZE,
>> because when stride > PAGE_SIZE, usually only a small number of pages need
>> to be flushed and classic tlbi intructions are more effective.
> 
> Why are they more effective? I guess a range op would work on this as
> well, say unmapping a large THP range. If we ignore this stride ==
> PAGE_SIZE, it could make the code easier to read.
> 

OK, I will remove the stride == PAGE_SIZE here.

>> We can also use 'end - start < threshold number' to decide which way
>> to go, however, different hardware may have different thresholds, so
>> I'm not sure if this is feasible.
>>
>> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
>> ---
>>  arch/arm64/include/asm/tlbflush.h | 104 ++++++++++++++++++++++++++----
>>  1 file changed, 90 insertions(+), 14 deletions(-)
> 
> Could you please rebase these patches on top of the arm64 for-next/tlbi
> branch:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/tlbi
> 

OK, I will send a formal version patch of this series soon.

>>  
>> -	if ((end - start) >= (MAX_TLBI_OPS * stride)) {
>> +	if ((!cpus_have_const_cap(ARM64_HAS_TLBI_RANGE) &&
>> +	    (end - start) >= (MAX_TLBI_OPS * stride)) ||
>> +	    range_pages >= MAX_TLBI_RANGE_PAGES) {
>>  		flush_tlb_mm(vma->vm_mm);
>>  		return;
>>  	}
> 
> Is there any value in this range_pages check here? What's the value of
> MAX_TLBI_RANGE_PAGES? If we have TLBI range ops, we make a decision here
> but without including the stride. Further down we use the stride to skip
> the TLBI range ops.
> 

MAX_TLBI_RANGE_PAGES is defined as __TLBI_RANGE_PAGES(31, 3), which is
decided by ARMv8.4 spec. The address range is determined by below formula:

	[BADDR, BADDR + (NUM + 1) * 2^(5*SCALE + 1) * PAGESIZE)

Which has nothing to do with the stride.  After removing the stride ==
PAGE_SIZE below, there will be more clear.


>>  }
> 
> I think the algorithm is correct, though I need to work it out on a
> piece of paper.
> 
> The code could benefit from some comments (above the loop) on how the
> range is built and the right scale found.
> 

OK.

Thanks,
Zhenyu
