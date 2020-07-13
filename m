From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
Date: Mon, 13 Jul 2020 15:44:16 +0100
Message-ID: <7237888d-2168-cd8b-c83d-c8e54871793d@nvidia.com>
References: <20200710094420.517-1-yezhenyu2@huawei.com>
 <20200710094420.517-3-yezhenyu2@huawei.com>
 <4040f429-21c8-0825-2ad4-97786c3fe7c1@nvidia.com>
 <cee60718-ced2-069f-8dad-48941c6fc09b@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cee60718-ced2-069f-8dad-48941c6fc09b-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhenyu Ye <yezhenyu2-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, suzuki.poulose-5wv7dgnIgG8@public.gmane.org, maz-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, steven.price-5wv7dgnIgG8@public.gmane.org, guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, xiexiangyou-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, prime.zeng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, zhangshaokun-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, kuhn.chenqun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-tegra <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org


On 13/07/2020 15:39, Zhenyu Ye wrote:
> Hi Jon,
> 
> On 2020/7/13 22:27, Jon Hunter wrote:
>> After this change I am seeing the following build errors ...
>>
>> /tmp/cckzq3FT.s: Assembler messages:
>> /tmp/cckzq3FT.s:854: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
>> /tmp/cckzq3FT.s:870: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
>> /tmp/cckzq3FT.s:1095: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
>> /tmp/cckzq3FT.s:1111: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
>> /tmp/cckzq3FT.s:1964: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
>> /tmp/cckzq3FT.s:1980: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
>> /tmp/cckzq3FT.s:2286: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
>> /tmp/cckzq3FT.s:2302: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
>> /tmp/cckzq3FT.s:4833: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
>> /tmp/cckzq3FT.s:4849: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
>> /tmp/cckzq3FT.s:5090: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
>> /tmp/cckzq3FT.s:5106: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
>> /tmp/cckzq3FT.s:874: Error: attempt to move .org backwards
>> /tmp/cckzq3FT.s:1115: Error: attempt to move .org backwards
>> /tmp/cckzq3FT.s:1984: Error: attempt to move .org backwards
>> /tmp/cckzq3FT.s:2306: Error: attempt to move .org backwards
>> /tmp/cckzq3FT.s:4853: Error: attempt to move .org backwards
>> /tmp/cckzq3FT.s:5110: Error: attempt to move .org backwards
>> scripts/Makefile.build:280: recipe for target 'arch/arm64/mm/hugetlbpage.o' failed
>> make[3]: *** [arch/arm64/mm/hugetlbpage.o] Error 1
>> scripts/Makefile.build:497: recipe for target 'arch/arm64/mm' failed
>> make[2]: *** [arch/arm64/mm] Error 2
>>
>> Cheers
>> Jon
>>
> 
> The code must be built with binutils >= 2.30.
> Maybe I should add  a check on whether binutils supports ARMv8.4-a instructions...

Yes I believe so.

Cheers
Jon

-- 
nvpublic
