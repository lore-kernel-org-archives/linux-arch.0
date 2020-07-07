From: Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH v4 2/2] arm64: tlb: Use the TLBI RANGE feature in
 arm64
Date: Tue, 07 Jul 2020 18:43:35 +0100
Message-ID: <d26f23960443a7f270847c90242e07ab@kernel.org>
References: <20200601144713.2222-1-yezhenyu2@huawei.com>
 <20200601144713.2222-3-yezhenyu2@huawei.com> <20200707173617.GA32331@gaia>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbgGGRni (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 7 Jul 2020 13:43:38 -0400
In-Reply-To: <20200707173617.GA32331@gaia>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Zhenyu Ye <yezhenyu2@huawei.com>, will@kernel.org, suzuki.poulose@arm.com, steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com

On 2020-07-07 18:36, Catalin Marinas wrote:
> On Mon, Jun 01, 2020 at 10:47:13PM +0800, Zhenyu Ye wrote:
>> @@ -59,6 +69,47 @@
>>  		__ta;						\
>>  	})
>> 
>> +/*
>> + * __TG defines translation granule of the system, which is decided 
>> by
>> + * PAGE_SHIFT.  Used by TTL.
>> + *  - 4KB	: 1
>> + *  - 16KB	: 2
>> + *  - 64KB	: 3
>> + */
>> +#define __TG	((PAGE_SHIFT - 12) / 2 + 1)
> 
> Nitpick: maybe something like __TLBI_TG to avoid clashes in case 
> someone
> else defines a __TG macro.

I have commented on this in the past, and still maintain that this
would be better served by a switch statement similar to what is used
for TTL already (I don't think this magic formula exists in the
ARM ARM).

         M.
-- 
Jazz is not dead. It just smells funny...
