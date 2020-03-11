Return-Path: <SRS0=RUJ7=44=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgCKJM5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Mar 2020 05:12:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 11 Mar 2020 09:12:54 +0000
From: Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH v1 0/3] arm64: tlb: add support for TTL field
In-Reply-To: <20200311025309.1743-1-yezhenyu2@huawei.com>
References: <20200311025309.1743-1-yezhenyu2@huawei.com>
Message-ID: <247ad619edf17eb266f856d937dac826@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com
Message-ID: <20200311091254.o5o9Xs1YOVDEI4COfUQ9ErAx4YzRQmtKY_V6xCI21OE@z>

Zhenyu,

On 2020-03-11 02:53, Zhenyu Ye wrote:
> ARMv8.4-TTL provides the TTL field in tlbi instruction to indicate
> the level of translation table walk holding the leaf entry for the
> address that is being invalidated. Hardware can use this information
> to determine if there was a risk of splintering.
> 
> This set of patches adds TTL field to __TLBI_ADDR, and uses
> Architecture-specific MM context to pass the TTL value to tlb 
> interface.
> 
> The default value of TTL is 0, which will not have any impact on the
> TLB maintenance instructions. The last patch trys to use TTL field in
> some obviously tlb-flush interface.

I have already posted some support for ARMv8.4-TTL as part of my NV 
series [1],
patches 62, 67, 68 and 69. This only deals with Stage-2 translation so 
far.
If you intend to add Stage-1, please build on top of what I have already 
posted
(I can extract the patches on a separate branch if you want).

Thanks,

         M.

[1] 
https://lore.kernel.org/linux-arm-kernel/20200211174938.27809-1-maz@kernel.org/
-- 
Jazz is not dead. It just smells funny...
