From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
Date: Fri, 24 Jul 2020 11:46:26 +0530
Message-ID: <6BAF6D26-A316-4F0A-AF10-5E43B2C09B90@linux.vnet.ibm.com>
References: <20200723105615.1268126-1-npiggin@gmail.com>
 <20200723114010.GO5523@worktop.programming.kicks-ass.net>
 <1595506730.3mvrxktem5.astroid@bobo.none>
 <1884dcea-9ecd-a1f3-21bb-213c655e2480@ozlabs.ru>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726178AbgGXGQu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Jul 2020 02:16:50 -0400
In-Reply-To: <1884dcea-9ecd-a1f3-21bb-213c655e2480@ozlabs.ru>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org



> On 24-Jul-2020, at 9:46 AM, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
> 
> 
> On 23/07/2020 23:11, Nicholas Piggin wrote:
>> Excerpts from Peter Zijlstra's message of July 23, 2020 9:40 pm:
>>> On Thu, Jul 23, 2020 at 08:56:14PM +1000, Nicholas Piggin wrote:
>>> 
>>>> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
>>>> index 3a0db7b0b46e..35060be09073 100644
>>>> --- a/arch/powerpc/include/asm/hw_irq.h
>>>> +++ b/arch/powerpc/include/asm/hw_irq.h
>>>> @@ -200,17 +200,14 @@ static inline bool arch_irqs_disabled(void)
>>>> #define powerpc_local_irq_pmu_save(flags)			\
>>>> 	 do {							\
>>>> 		raw_local_irq_pmu_save(flags);			\
>>>> -		trace_hardirqs_off();				\
>>>> +		if (!raw_irqs_disabled_flags(flags))		\
>>>> +			trace_hardirqs_off();			\
>>>> 	} while(0)
>>>> #define powerpc_local_irq_pmu_restore(flags)			\
>>>> 	do {							\
>>>> -		if (raw_irqs_disabled_flags(flags)) {		\
>>>> -			raw_local_irq_pmu_restore(flags);	\
>>>> -			trace_hardirqs_off();			\
>>>> -		} else {					\
>>>> +		if (!raw_irqs_disabled_flags(flags))		\
>>>> 			trace_hardirqs_on();			\
>>>> -			raw_local_irq_pmu_restore(flags);	\
>>>> -		}						\
>>>> +		raw_local_irq_pmu_restore(flags);		\
>>>> 	} while(0)
>>> 
>>> You shouldn't be calling lockdep from NMI context!
>> 
>> After this patch it doesn't.
>> 
>> trace_hardirqs_on/off implementation appears to expect to be called in NMI 
>> context though, for some reason.
>> 
>>> That is, I recently
>>> added suport for that on x86:
>>> 
>>>  https://lkml.kernel.org/r/20200623083721.155449112@infradead.org
>>>  https://lkml.kernel.org/r/20200623083721.216740948@infradead.org
>>> 
>>> But you need to be very careful on how you order things, as you can see
>>> the above relies on preempt_count() already having been incremented with
>>> NMI_MASK.
>> 
>> Hmm. My patch seems simpler.
> 
> And your patches fix my error while Peter's do not:
> 
> 
> IRQs not enabled as expected
> WARNING: CPU: 0 PID: 1377 at /home/aik/p/kernel/kernel/softirq.c:169
> __local_bh_enable_ip+0x118/0x190

Hi Nicholas, Alexey

I was able to reproduce the warning which Alexey reported using perf_fuzzer test suite. 
With the patch provided by Nick, I don’t see the issue anymore. This patch fixes the
warnings I got with perf fuzzer run.

Thanks Nick for the fix. 

Tested-by: Athira Rajeev<atrajeev@linux.ibm.com>


> 
> 
>> 
>> I don't know this stuff very well, I don't really understand what your patch 
>> enables for x86 but at least it shouldn't be incompatible with this one 
>> AFAIKS.
>> 
>> Thanks,
>> Nick
>> 
> 
> -- 
> Alexey
