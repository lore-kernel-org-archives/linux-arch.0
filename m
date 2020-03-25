From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [RFC PATCH v4 3/6] arm64: Add level-hinted TLB invalidation
 helper to tlbi_user
Date: Wed, 25 Mar 2020 10:47:31 +0800
Message-ID: <8cf6c576-f0e2-9a52-6919-cb5e27d2ffb5@huawei.com>
References: <20200324134534.1570-1-yezhenyu2@huawei.com>
 <20200324134534.1570-4-yezhenyu2@huawei.com> <20200324141939.51917225@why>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:12122 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727253AbgCYCro (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Mar 2020 22:47:44 -0400
In-Reply-To: <20200324141939.51917225@why>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: will@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, peterz@infradead.org, arnd@arndb.de, rostedt@goodmis.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com

Hi Marc,

On 2020/3/24 22:19, Marc Zyngier wrote:
> On Tue, 24 Mar 2020 21:45:31 +0800
> Zhenyu Ye <yezhenyu2@huawei.com> wrote:
> 
>> Add a level-hinted parameter to __tlbi_user, which only gets used
>> if ARMv8.4-TTL gets detected.
>>
>> ARMv8.4-TTL provides the TTL field in tlbi instruction to indicate
>> the level of translation table walk holding the leaf entry for the
>> address that is being invalidated.
>>
>> This patch set the default level value to 0.
>>
>> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
>> ---
>>  arch/arm64/include/asm/tlbflush.h | 42 ++++++++++++++++++++++++++-----
>>  1 file changed, 36 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>> index a3f70778a325..d141c080e494 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -89,6 +89,36 @@
>>  		__tlbi(op,  arg);					\
>>  	} while(0)
>>  
>> +#define __tlbi_user_level(op, addr, level)				\
>> +	do {								\
>> +		u64 arg = addr;						\
>> +									\
>> +		if (!arm64_kernel_unmapped_at_el0())			\
>> +			break;						\
>> +									\
>> +		if (cpus_have_const_cap(ARM64_HAS_ARMv8_4_TTL) &&	\
>> +		    level) {						\
>> +			u64 ttl = level;				\
>> +									\
>> +			switch (PAGE_SIZE) {				\
>> +			case SZ_4K:					\
>> +				ttl |= 1 << 2;				\
>> +				break;					\
>> +			case SZ_16K:					\
>> +				ttl |= 2 << 2;				\
>> +				break;					\
>> +			case SZ_64K:					\
>> +				ttl |= 3 << 2;				\
>> +				break;					\
>> +			}						\
>> +									\
>> +			arg &= ~TLBI_TTL_MASK;				\
>> +			arg |= FIELD_PREP(TLBI_TTL_MASK, ttl);		\
>> +		}							\
>> +									\
>> +		__tlbi(op,  (arg) | USER_ASID_FLAG);
>> 	\
>> +	} while (0)
>> +
> 
> Isn't this just:
> 
> define __tlbi_user_level(op, addr, level)			\
> 	do {							\
> 		if (!arm64_kernel_unmapped_at_el0())		\
> 			break;					\
> 								\
> 		__tlbi_level(op, addr | USER_ASID_FLAG, level);	\
> 	} while (0)
> 
> Thanks,
> 
> 	M.
> 

Yeah, your code is more clear!  I will take it in next version. ;-)

Thanks,
zhenyu
