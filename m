From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [PATCH v2 2/6] arm64: Add level-hinted TLB invalidation helper
Date: Mon, 25 May 2020 14:54:51 +0800
Message-ID: <3852291c-37cf-39b6-564d-8b4f50f9d86e@huawei.com>
References: <20200423135656.2712-1-yezhenyu2@huawei.com>
 <20200423135656.2712-3-yezhenyu2@huawei.com> <20200522155017.GG26492@gaia>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200522155017.GG26492@gaia>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
List-Id: linux-arch.vger.kernel.org

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
