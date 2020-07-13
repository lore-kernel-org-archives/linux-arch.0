Return-Path: <SRS0=GmBk=AY=kvack.org=owner-linux-mm@kernel.org>
Subject: Re: [PATCH v2 2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
References: <20200710094420.517-1-yezhenyu2@huawei.com>
 <20200710094420.517-3-yezhenyu2@huawei.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <4040f429-21c8-0825-2ad4-97786c3fe7c1@nvidia.com>
Date: Mon, 13 Jul 2020 15:27:50 +0100
MIME-Version: 1.0
In-Reply-To: <20200710094420.517-3-yezhenyu2@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
To: Zhenyu Ye <yezhenyu2@huawei.com>, catalin.marinas@arm.com, will@kernel.org, suzuki.poulose@arm.com, maz@kernel.org, steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com, linux-tegra <linux-tegra@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200713142750.S4nzLV-l1p-_PhwxtSwbrMHPZ7GRQzt0vgCo928WNoA@z>


On 10/07/2020 10:44, Zhenyu Ye wrote:
> Add __TLBI_VADDR_RANGE macro and rewrite __flush_tlb_range().
> 
> When cpu supports TLBI feature, the minimum range granularity is
> decided by 'scale', so we can not flush all pages by one instruction
> in some cases.
> 
> For example, when the pages = 0xe81a, let's start 'scale' from
> maximum, and find right 'num' for each 'scale':
> 
> 1. scale = 3, we can flush no pages because the minimum range is
>    2^(5*3 + 1) = 0x10000.
> 2. scale = 2, the minimum range is 2^(5*2 + 1) = 0x800, we can
>    flush 0xe800 pages this time, the num = 0xe800/0x800 - 1 = 0x1c.
>    Remaining pages is 0x1a;
> 3. scale = 1, the minimum range is 2^(5*1 + 1) = 0x40, no page
>    can be flushed.
> 4. scale = 0, we flush the remaining 0x1a pages, the num =
>    0x1a/0x2 - 1 = 0xd.
> 
> However, in most scenarios, the pages = 1 when flush_tlb_range() is
> called. Start from scale = 3 or other proper value (such as scale =
> ilog2(pages)), will incur extra overhead.
> So increase 'scale' from 0 to maximum, the flush order is exactly
> opposite to the example.
> 
> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>


After this change I am seeing the following build errors ...

/tmp/cckzq3FT.s: Assembler messages:
/tmp/cckzq3FT.s:854: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
/tmp/cckzq3FT.s:870: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
/tmp/cckzq3FT.s:1095: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
/tmp/cckzq3FT.s:1111: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
/tmp/cckzq3FT.s:1964: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
/tmp/cckzq3FT.s:1980: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
/tmp/cckzq3FT.s:2286: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
/tmp/cckzq3FT.s:2302: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
/tmp/cckzq3FT.s:4833: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
/tmp/cckzq3FT.s:4849: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
/tmp/cckzq3FT.s:5090: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
/tmp/cckzq3FT.s:5106: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
/tmp/cckzq3FT.s:874: Error: attempt to move .org backwards
/tmp/cckzq3FT.s:1115: Error: attempt to move .org backwards
/tmp/cckzq3FT.s:1984: Error: attempt to move .org backwards
/tmp/cckzq3FT.s:2306: Error: attempt to move .org backwards
/tmp/cckzq3FT.s:4853: Error: attempt to move .org backwards
/tmp/cckzq3FT.s:5110: Error: attempt to move .org backwards
scripts/Makefile.build:280: recipe for target 'arch/arm64/mm/hugetlbpage.o' failed
make[3]: *** [arch/arm64/mm/hugetlbpage.o] Error 1
scripts/Makefile.build:497: recipe for target 'arch/arm64/mm' failed
make[2]: *** [arch/arm64/mm] Error 2

Cheers
Jon

-- 
nvpublic
