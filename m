From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [RFC PATCH v4 2/2] arm64: tlb: Use the TLBI RANGE feature in
 arm64
Date: Wed, 8 Jul 2020 17:01:08 +0800
Message-ID: <f362680d-b16f-e713-153d-2e026fa8bfd4@huawei.com>
References: <20200601144713.2222-1-yezhenyu2@huawei.com>
 <20200601144713.2222-3-yezhenyu2@huawei.com> <20200707173617.GA32331@gaia>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:58014 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbgGHJBW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Jul 2020 05:01:22 -0400
In-Reply-To: <20200707173617.GA32331@gaia>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, suzuki.poulose@arm.com, maz@kernel.org, steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com

Hi Catalin,

On 2020/7/8 1:36, Catalin Marinas wrote:
> On Mon, Jun 01, 2020 at 10:47:13PM +0800, Zhenyu Ye wrote:
>> @@ -59,6 +69,47 @@
>>  		__ta;						\
>>  	})
>>  
>> +/*
>> + * __TG defines translation granule of the system, which is decided by
>> + * PAGE_SHIFT.  Used by TTL.
>> + *  - 4KB	: 1
>> + *  - 16KB	: 2
>> + *  - 64KB	: 3
>> + */
>> +#define __TG	((PAGE_SHIFT - 12) / 2 + 1)
> 
> Nitpick: maybe something like __TLBI_TG to avoid clashes in case someone
> else defines a __TG macro.
> 

Thanks for your review. According to Marc and Robin's suggestion, I will remove this
macro.
I'd like implement this in a function beacause it's used in both TTL and TLB RANGE.

>> -	for (addr = start; addr < end; addr += stride) {
>> -		if (last_level) {
>> -			__tlbi(vale1is, addr);
>> -			__tlbi_user(vale1is, addr);
>> -		} else {
>> -			__tlbi(vae1is, addr);
>> -			__tlbi_user(vae1is, addr);
>> +	while (range_pages > 0) {
>> +		if (cpus_have_const_cap(ARM64_HAS_TLBI_RANGE) &&
>> +		    stride == PAGE_SIZE) {
> 
> I think we could have the odd range_pages check here:
> 
> 		if (cpus_have_const_cap(ARM64_HAS_TLBI_RANGE) &&
> 		    stride == PAGE_SIZE && range_pages % 2 == 0) {
> 
> and avoid the one outside the loop.
> 

This may need some other necessary changes to do this. See in next version series.

Thanks,
Zhenyu
