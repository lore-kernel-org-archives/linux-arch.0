From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [RFC PATCH v3 2/2] arm64: tlb: Use the TLBI RANGE feature in
 arm64
Date: Mon, 1 Jun 2020 22:57:35 +0800
Message-ID: <a159dd5a-7189-308f-9ebc-98f0eadca852@huawei.com>
References: <20200414112835.1121-1-yezhenyu2@huawei.com>
 <20200414112835.1121-3-yezhenyu2@huawei.com> <20200514152840.GC1907@gaia>
 <54468aae-dbb1-66bd-c633-82fc75936206@huawei.com>
 <20200520170759.GE18302@gaia>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:5323 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbgFAO5s (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Jun 2020 10:57:48 -0400
In-Reply-To: <20200520170759.GE18302@gaia>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, suzuki.poulose@arm.com, maz@kernel.org, linux-kernel@vger.kernel.org, xiexiangyou@huawei.com, steven.price@arm.com, zhangshaokun@hisilicon.com, linux-mm@kvack.org, arm@kernel.org, prime.zeng@hisilicon.com, guohanjun@huawei.com, olof@lixom.net, kuhn.chenqun@huawei.com, will@kernel.org, linux-arm-kernel@lists.infradead.org

Hi Catalin,

I have sent the v4 of this series [1] and combine the two function with
a single loop.  See codes for details.

[1] https://lore.kernel.org/linux-arm-kernel/20200601144713.2222-1-yezhenyu2@huawei.com/

On 2020/5/21 1:08, Catalin Marinas wrote:
>> This optimization is only effective when the range is a multiple of 256KB
>> (when the page size is 4KB), and I'm worried about the performance
>> of ilog2().  I traced the __flush_tlb_range() last year and found that in
>> most cases the range is less than 256K (see details in [1]).
> 
> THP or hugetlbfs would exercise bigger strides but I guess it depends on
> the use-case. ilog2() should be reduced to a few instructions on arm64
> AFAICT (haven't tried but it should use the CLZ instruction).
> 

Not bigger than 256K, but the range must be a integer multiple of 256KB,
so I still start from scale 0.

Thanks,
Zhenyu
