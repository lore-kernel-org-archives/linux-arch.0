From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: Re: [RFC PATCH v4 0/6] arm64: tlb: add support for TTL feature
Date: Wed, 25 Mar 2020 12:49:45 +0800
Message-ID: <fb06ba92-a3ce-6925-e914-167a85837f27@huawei.com>
References: <20200324134534.1570-1-yezhenyu2@huawei.com>
 <20200324150155.GH20713@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:12125 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725263AbgCYEu1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 25 Mar 2020 00:50:27 -0400
In-Reply-To: <20200324150155.GH20713@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, linux-mm@kvack.org, guohanjun@huawei.com, will@kernel.org, linux-arch@vger.kernel.org, yuzhao@google.com, maz@kernel.org, steven.price@arm.com, arm@kernel.org, Dave.Martin@arm.com, arnd@arndb.de, suzuki.poulose@arm.com, npiggin@gmail.com, zhangshaokun@hisilicon.com, broonie@kernel.org, rostedt@goodmis.org, prime.zeng@hisilicon.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, xiexiangyou@huawei.com, linux-kernel@vger.kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org

Hi Peter,

On 2020/3/24 23:01, Peter Zijlstra wrote:
> On Tue, Mar 24, 2020 at 09:45:28PM +0800, Zhenyu Ye wrote:
>> In order to reduce the cost of TLB invalidation, the ARMv8.4 TTL
>> feature allows TLBs to be issued with a level allowing for quicker
>> invalidation.  This series provide support for this feature. 
>>
>> Patch 1 and Patch 2 was provided by Marc on his NV series[1] patches,
>> which detect the TTL feature and add __tlbi_level interface.
> 
> I realy hate how it makes vma->vm_flags more important for tlbi.
> 

Thanks for your review.

The tlbi interfaces only have two parameters: vma and addr. If we
try to not use vma->vm_flags, we may should have to add a parameter
to some of these interfaces(such as flush_tlb_range), which are
common to all architectures.

I'm not sure if this is feasible, because this feature is only
supported by ARM64 currently.


Thanks,
Zhenyu
