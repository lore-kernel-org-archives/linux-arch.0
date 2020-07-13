Return-Path: <SRS0=ixnu=AY=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:56962 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729644AbgGMOjM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Jul 2020 10:39:12 -0400
Subject: Re: [PATCH v2 2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
References: <20200710094420.517-1-yezhenyu2@huawei.com>
 <20200710094420.517-3-yezhenyu2@huawei.com>
 <4040f429-21c8-0825-2ad4-97786c3fe7c1@nvidia.com>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <cee60718-ced2-069f-8dad-48941c6fc09b@huawei.com>
Date: Mon, 13 Jul 2020 22:39:00 +0800
MIME-Version: 1.0
In-Reply-To: <4040f429-21c8-0825-2ad4-97786c3fe7c1@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>, catalin.marinas@arm.com, will@kernel.org, suzuki.poulose@arm.com, maz@kernel.org, steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com, linux-tegra <linux-tegra@vger.kernel.org>
Message-ID: <20200713143900.EDtG2eCKMoXUksZrvuhaMU78FXMIYAWnbhpilVmsrMM@z>

Hi Jon,

On 2020/7/13 22:27, Jon Hunter wrote:
> After this change I am seeing the following build errors ...
> 
> /tmp/cckzq3FT.s: Assembler messages:
> /tmp/cckzq3FT.s:854: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
> /tmp/cckzq3FT.s:870: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
> /tmp/cckzq3FT.s:1095: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
> /tmp/cckzq3FT.s:1111: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
> /tmp/cckzq3FT.s:1964: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
> /tmp/cckzq3FT.s:1980: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
> /tmp/cckzq3FT.s:2286: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
> /tmp/cckzq3FT.s:2302: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
> /tmp/cckzq3FT.s:4833: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
> /tmp/cckzq3FT.s:4849: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
> /tmp/cckzq3FT.s:5090: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
> /tmp/cckzq3FT.s:5106: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
> /tmp/cckzq3FT.s:874: Error: attempt to move .org backwards
> /tmp/cckzq3FT.s:1115: Error: attempt to move .org backwards
> /tmp/cckzq3FT.s:1984: Error: attempt to move .org backwards
> /tmp/cckzq3FT.s:2306: Error: attempt to move .org backwards
> /tmp/cckzq3FT.s:4853: Error: attempt to move .org backwards
> /tmp/cckzq3FT.s:5110: Error: attempt to move .org backwards
> scripts/Makefile.build:280: recipe for target 'arch/arm64/mm/hugetlbpage.o' failed
> make[3]: *** [arch/arm64/mm/hugetlbpage.o] Error 1
> scripts/Makefile.build:497: recipe for target 'arch/arm64/mm' failed
> make[2]: *** [arch/arm64/mm] Error 2
> 
> Cheers
> Jon
> 

The code must be built with binutils >= 2.30.
Maybe I should add  a check on whether binutils supports ARMv8.4-a instructions...

Thanks,
Zhenyu
