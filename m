Return-Path: <SRS0=Q31O=AZ=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:57448 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbgGNN5D (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jul 2020 09:57:03 -0400
Subject: Re: [PATCH v2 2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
References: <20200710094420.517-1-yezhenyu2@huawei.com>
 <20200710094420.517-3-yezhenyu2@huawei.com> <20200714103629.GA18793@gaia>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <cda3d6bc-a7e2-5669-372c-3c34cc822e08@huawei.com>
Date: Tue, 14 Jul 2020 21:51:42 +0800
MIME-Version: 1.0
In-Reply-To: <20200714103629.GA18793@gaia>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, suzuki.poulose@arm.com, maz@kernel.org, steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
Message-ID: <20200714135142.Ulnl5SWmjUFPitL6tWpoVCnnCcLxywGPlJQoGgstkAg@z>

On 2020/7/14 18:36, Catalin Marinas wrote:
> On Fri, Jul 10, 2020 at 05:44:20PM +0800, Zhenyu Ye wrote:
>> +#define __TLBI_RANGE_PAGES(num, scale)	(((num) + 1) << (5 * (scale) + 1))
>> +#define MAX_TLBI_RANGE_PAGES		__TLBI_RANGE_PAGES(31, 3)
>> +
>> +#define TLBI_RANGE_MASK			GENMASK_ULL(4, 0)
>> +#define __TLBI_RANGE_NUM(range, scale)	\
>> +	(((range) >> (5 * (scale) + 1)) & TLBI_RANGE_MASK)
> [...]
>> +	int num = 0;
>> +	int scale = 0;
> [...]
>> +			start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT;
> [...]
> 
> Since num is an int, __TLBI_RANGE_PAGES is still an int. Shifting it by
> PAGE_SHIFT can overflow as the maximum would be 8GB for 4K pages (or
> 128GB for 64K pages). I think we probably get away with this because of
> some implicit type conversion but I'd rather make __TLBI_RANGE_PAGES an
> explicit unsigned long:
> 
> #define __TLBI_RANGE_PAGES(num, scale)	((unsigned long)((num) + 1) << (5 * (scale) + 1))
> 

This is valuable and I will update this in next series, with the check
for binutils (or encode the instructions by hand), as soon as possible.

> Without this change, the CBMC check fails (see below for the test). In
> the kernel, we don't have this problem as we encode the address via
> __TLBI_VADDR_RANGE and it doesn't overflow.> The good part is that CBMC reckons the algorithm is correct ;).

Thanks for your test!

Zhenyu
