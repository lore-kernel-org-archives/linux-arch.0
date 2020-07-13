Return-Path: <SRS0=ixnu=AY=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbgGMRWE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Jul 2020 13:22:04 -0400
Date: Mon, 13 Jul 2020 18:21:59 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
Message-ID: <20200713172158.GE15829@gaia>
References: <20200710094420.517-1-yezhenyu2@huawei.com>
 <20200710094420.517-3-yezhenyu2@huawei.com>
 <4040f429-21c8-0825-2ad4-97786c3fe7c1@nvidia.com>
 <cee60718-ced2-069f-8dad-48941c6fc09b@huawei.com>
 <7237888d-2168-cd8b-c83d-c8e54871793d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7237888d-2168-cd8b-c83d-c8e54871793d@nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Zhenyu Ye <yezhenyu2@huawei.com>, will@kernel.org, suzuki.poulose@arm.com, maz@kernel.org, steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com, linux-tegra <linux-tegra@vger.kernel.org>
Message-ID: <20200713172159.1kGHEujfjpBhBlXmC8FvfGBue408eZhGLYuw3W3UlYg@z>

On Mon, Jul 13, 2020 at 03:44:16PM +0100, Jon Hunter wrote:
> On 13/07/2020 15:39, Zhenyu Ye wrote:
> > On 2020/7/13 22:27, Jon Hunter wrote:
> >> After this change I am seeing the following build errors ...
> >>
> >> /tmp/cckzq3FT.s: Assembler messages:
> >> /tmp/cckzq3FT.s:854: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
> >> /tmp/cckzq3FT.s:870: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
> >> /tmp/cckzq3FT.s:1095: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
> >> /tmp/cckzq3FT.s:1111: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
> >> /tmp/cckzq3FT.s:1964: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
> >> /tmp/cckzq3FT.s:1980: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
> >> /tmp/cckzq3FT.s:2286: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
> >> /tmp/cckzq3FT.s:2302: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
> >> /tmp/cckzq3FT.s:4833: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
> >> /tmp/cckzq3FT.s:4849: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
> >> /tmp/cckzq3FT.s:5090: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
> >> /tmp/cckzq3FT.s:5106: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
> >> /tmp/cckzq3FT.s:874: Error: attempt to move .org backwards
> >> /tmp/cckzq3FT.s:1115: Error: attempt to move .org backwards
> >> /tmp/cckzq3FT.s:1984: Error: attempt to move .org backwards
> >> /tmp/cckzq3FT.s:2306: Error: attempt to move .org backwards
> >> /tmp/cckzq3FT.s:4853: Error: attempt to move .org backwards
> >> /tmp/cckzq3FT.s:5110: Error: attempt to move .org backwards
> >> scripts/Makefile.build:280: recipe for target 'arch/arm64/mm/hugetlbpage.o' failed
> >> make[3]: *** [arch/arm64/mm/hugetlbpage.o] Error 1
> >> scripts/Makefile.build:497: recipe for target 'arch/arm64/mm' failed
> >> make[2]: *** [arch/arm64/mm] Error 2
> > 
> > The code must be built with binutils >= 2.30.
> > Maybe I should add  a check on whether binutils supports ARMv8.4-a instructions...
> 
> Yes I believe so.

The binutils guys in Arm confirmed that assembling "tlbi rvae1is"
without -march=armv8.4-a is a bug. When it gets fixed, checking for the
binutils version is not sufficient without passing -march. I think we
are better off with a manual encoding of the instruction.

-- 
Catalin
