Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A11835A384;
	Thu,  4 Jun 2026 05:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780549551; cv=none; b=kT9wYd5IMeu2OrgX2/5jokvAA/0RfA9uicgAhy6NpPf1ISUlenHsWvfaObwOSrTHDrfw7QwZBpq7/MQjHdvSvGHbvMcL/Mci2Z5gdHIOgYCj9K6m+y983eCvt4BXTY4xGQ1eyCN5eUqMdbaNBXZVrqfHRjpg9OCPRypnK8VG95o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780549551; c=relaxed/simple;
	bh=MWGOCqWYdZAP4/qaHsjqNhfXESNfFPYh2+DFF+ZSeDs=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=d+x8TKIC5gkCpWfhDkId0dCgQQrDQVsA7ZM13SsmPX+I+NZh2+E+Xsdh+zrxRRfB79jQFxRXXTfC6g1N3QpW83oefw5pw9Vue4XJuYQhgPiZGnvOV1FYgD8EvQJ1Za9DzU0/nNQzA90rnetZzc94uhcXOySicrbmX15ixjTjL5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxBOmjByFqNmoQAA--.39610S3;
	Thu, 04 Jun 2026 13:05:40 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCx2+CiByFq916bAA--.32845S3;
	Thu, 04 Jun 2026 13:05:39 +0800 (CST)
Subject: Re: [RFC PATCH 1/3] LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260428072021.7289-1-yangtiezhu@loongson.cn>
 <20260428072021.7289-2-yangtiezhu@loongson.cn>
 <CAAhV-H5tLpXtnMJOx=b5MCDY71jMNkQ5pv1YhgCf72FV=ewcxg@mail.gmail.com>
 <0def4127-3850-1114-d576-42748456f400@loongson.cn>
 <CAAhV-H51mJpbYjQJYo_a_8mWuG9CSbvbvQNHrpV1G3jmp0Vkaw@mail.gmail.com>
 <9fe9a1f4-bdd0-d6b4-6b76-269e4ffdbc7e@loongson.cn>
Message-ID: <0dcead8f-7178-5ab9-7367-898c63a30910@loongson.cn>
Date: Thu, 4 Jun 2026 13:05:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9fe9a1f4-bdd0-d6b4-6b76-269e4ffdbc7e@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx2+CiByFq916bAA--.32845S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr45Xr4UZrW7WFyxCF1rAFc_yoW5ArWfpa
	y8Ka1DKw4DGa42yF4xKw47ZF13Z3ykXw47Kr1rK3yxAr4Yvr98XrsrKw4UCryvvr1Iqa4I
	vFW7tasFga4UJagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8r9
	N3UUUUU==

On 2026/6/4 上午10:26, Tiezhu Yang wrote:
> On 2026/6/3 下午10:24, Huacai Chen wrote:
>> On Wed, Jun 3, 2026 at 10:30 AM Tiezhu Yang <yangtiezhu@loongson.cn> 
>> wrote:
> 
> ...
> 
>>> For static structures like init_task, any uninitialized fields are
>>> automatically zeroed out by the compiler according to the C standard.
>>> Stripping away dozens of lines of ".field = 0" complies with modern
>>> Linux kernel code-cleaning standards. It makes the macro much shorter
>>> and highlights the only field that actually requires a special
>>> runtime value (the kernel stack top in .reg03).
>> I know it is the same for compilers, I mean the current way gives more
>> information for humans.
>>
>> In addition, without reg02, this piece completely has no relationship
>> with CONFIG_THREAD_INFO_IN_TASK, so please drop it.
> 
> Do you mean keep the original INIT_THREAD as is? No any changes for it?
> ".reg03 = (unsigned long)&init_stack + sizeof(init_stack)," is not
> necessary?
> 
> That is to say, do not modify arch/loongarch/include/asm/processor.h?

I tested with stress-ng, it works well without modifying processor.h,
so I will keep the original INIT_THREAD in the upstream code.

>>> For reference, please see how INIT_THREAD is defined in other major
>>> architectures, where they only initialize what is strictly necessary:
> 
> ...
> 
>> None of these commits remove current_pt_regs. Some of them has no
>> current_pt_regs before THREAD_INFO_IN_TASK, and ARM32 still has its
>> own implementations in arch/arm/include/asm/ptrace.h now which is
>> nearly the same as LoongArch.
> 
> If you think it should keep current_pt_regs() as is, I am OK, will do
> it in the next version.
> 
> That is to say, do not modify arch/loongarch/include/asm/ptrace.h?

I tested with stress-ng, it works well without modifying ptrace.h,
so I will keep the original current_pt_regs in the upstream code
for now. We can delete it if there is obvious benefit in the future.

>>>>>    /* Helpers for working with the user stack pointer */
> 
> ...
> 
>> set_current() is a very good friend of get_current(). Though "$tp" is
>> enough for get_current(), from the x86 implementation we know that it
>> can also get from the per-cpu array (but suboptimal).
>>
>> Move set_current() to current.h also don't need to include
>> <linux/percpu.h> and <linux/sched.h>, it only need to forwarding
>> declare "task_struct" and include <asm/percpu.h>, which is exactly
>> done in the x86 implementation.
>>
>> And you needn't worry about the compiling, I have tested before I 
>> comment.
> 
> If you think this is proper, I am OK.
> 
> Replace __entry_task with current_task (x86) or cpu_tasks (uml)?
> Replace entry_task_switch() with set_current()? or something else?
> It seems a little strange for the following code in smp.c:

I will use current_task variable and set_current() in the next version
if no more comments.

Thanks,
Tiezhu

