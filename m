Return-Path: <SRS0=uIBl=7H=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:5277 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388385AbgEYGzD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 May 2020 02:55:03 -0400
Subject: Re: [PATCH v2 2/6] arm64: Add level-hinted TLB invalidation helper
References: <20200423135656.2712-1-yezhenyu2@huawei.com>
 <20200423135656.2712-3-yezhenyu2@huawei.com> <20200522155017.GG26492@gaia>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <3852291c-37cf-39b6-564d-8b4f50f9d86e@huawei.com>
Date: Mon, 25 May 2020 14:54:51 +0800
MIME-Version: 1.0
In-Reply-To: <20200522155017.GG26492@gaia>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
Message-ID: <20200525065451.vn5QWErJPGtJN8ACJJjTuMl34PwyqszB7MUUTPrwAl4@z>

On 2020/5/22 23:50, Catalin Marinas wrote:
> On Thu, Apr 23, 2020 at 09:56:52PM +0800, Zhenyu Ye wrote:
>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>> index bc3949064725..5f9f189bc6d2 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -10,6 +10,7 @@
>>  
>>  #ifndef __ASSEMBLY__
>>  
>> +#include <linux/bitfield.h>
>>  #include <linux/mm_types.h>
>>  #include <linux/sched.h>
>>  #include <asm/cputype.h>
>> @@ -59,6 +60,35 @@
>>  		__ta;						\
>>  	})
>>  
>> +#define TLBI_TTL_MASK	GENMASK_ULL(47, 44)
>> +
>> +#define __tlbi_level(op, addr, level)					\
>> +	do {								\
> 
> Nitpick: move "do {" on the same line as __tlbi_level() to reduce the
> indentation levels of the whole block.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 

OK.
