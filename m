From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
Date: Mon, 13 Jul 2020 15:27:50 +0100
Message-ID: <4040f429-21c8-0825-2ad4-97786c3fe7c1@nvidia.com>
References: <20200710094420.517-1-yezhenyu2@huawei.com>
 <20200710094420.517-3-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200710094420.517-3-yezhenyu2-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhenyu Ye <yezhenyu2-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, suzuki.poulose-5wv7dgnIgG8@public.gmane.org, maz-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, steven.price-5wv7dgnIgG8@public.gmane.org, guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, xiexiangyou-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, prime.zeng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, zhangshaokun-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, kuhn.chenqun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-tegra <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org


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
> Signed-off-by: Zhenyu Ye <yezhenyu2-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>


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
