From: "yezhenyu (A)" <yezhenyu2@huawei.com>
Subject: Re: [RFC PATCH v1 0/3] arm64: tlb: add support for TTL field
Date: Wed, 11 Mar 2020 19:29:35 +0800
Message-ID: <6279257b-2b8c-10d0-8bb8-b0f4b851febb@huawei.com>
References: <20200311025309.1743-1-yezhenyu2@huawei.com>
 <247ad619edf17eb266f856d937dac826@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:55266 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726000AbgCKL3w (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Mar 2020 07:29:52 -0400
In-Reply-To: <247ad619edf17eb266f856d937dac826@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com

Hi Marc,

On 2020/3/11 17:12, Marc Zyngier wrote:
> Zhenyu,
> 
> On 2020-03-11 02:53, Zhenyu Ye wrote:
>> ARMv8.4-TTL provides the TTL field in tlbi instruction to indicate
>> the level of translation table walk holding the leaf entry for the
>> address that is being invalidated. Hardware can use this information
>> to determine if there was a risk of splintering.
>>
>> This set of patches adds TTL field to __TLBI_ADDR, and uses
>> Architecture-specific MM context to pass the TTL value to tlb interface.
>>
>> The default value of TTL is 0, which will not have any impact on the
>> TLB maintenance instructions. The last patch trys to use TTL field in
>> some obviously tlb-flush interface.
> 
> I have already posted some support for ARMv8.4-TTL as part of my NV series [1],
> patches 62, 67, 68 and 69. This only deals with Stage-2 translation so far.
> If you intend to add Stage-1, please build on top of what I have already posted
> (I can extract the patches on a separate branch if you want).
> 
> Thanks,
> 
>         M.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20200211174938.27809-1-maz@kernel.org/

I just readed your code changes to TTL. You pass the TTL value by changing the
function interface, which only involves the ARM and ARM64 architectures in Stage-2
translation.

However, in Stage-1, many common interfaces(such as flush_tlb_range) need to be
modified, which involves very much architectures. So I try to use MM context in
mm_struct to pass the TTL value.

I will send patch v2 based on top of your kvm-arm64/nv-5.6-rc1 branch soon.

https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm64/nv-5.6-rc1


Thanks,
Zhenyu
