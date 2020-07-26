From: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
Date: Sun, 26 Jul 2020 17:40:10 +1000
Message-ID: <600a08a0-4b33-03a5-4749-bda8fa1e572d@ozlabs.ru>
References: <20200723105615.1268126-1-npiggin@gmail.com>
 <20200723114010.GO5523@worktop.programming.kicks-ass.net>
 <1595506730.3mvrxktem5.astroid@bobo.none>
 <1884dcea-9ecd-a1f3-21bb-213c655e2480@ozlabs.ru>
 <1595568105.4eodjnxzwp.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGZHkS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Jul 2020 03:40:18 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4F7C0619D4
        for <linux-arch@vger.kernel.org>; Sun, 26 Jul 2020 00:40:18 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t6so7689265pgq.1
        for <linux-arch@vger.kernel.org>; Sun, 26 Jul 2020 00:40:18 -0700 (PDT)
In-Reply-To: <1595568105.4eodjnxzwp.astroid@bobo.none>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>



On 24/07/2020 15:59, Nicholas Piggin wrote:
> Excerpts from Alexey Kardashevskiy's message of July 24, 2020 2:16 pm:
>>
>>
>> On 23/07/2020 23:11, Nicholas Piggin wrote:
>>> Excerpts from Peter Zijlstra's message of July 23, 2020 9:40 pm:
>>>> On Thu, Jul 23, 2020 at 08:56:14PM +1000, Nicholas Piggin wrote:
>>>>
>>>>> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
>>>>> index 3a0db7b0b46e..35060be09073 100644
>>>>> --- a/arch/powerpc/include/asm/hw_irq.h
>>>>> +++ b/arch/powerpc/include/asm/hw_irq.h
>>>>> @@ -200,17 +200,14 @@ static inline bool arch_irqs_disabled(void)
>>>>>  #define powerpc_local_irq_pmu_save(flags)			\
>>>>>  	 do {							\
>>>>>  		raw_local_irq_pmu_save(flags);			\
>>>>> -		trace_hardirqs_off();				\
>>>>> +		if (!raw_irqs_disabled_flags(flags))		\
>>>>> +			trace_hardirqs_off();			\
>>>>>  	} while(0)
>>>>>  #define powerpc_local_irq_pmu_restore(flags)			\
>>>>>  	do {							\
>>>>> -		if (raw_irqs_disabled_flags(flags)) {		\
>>>>> -			raw_local_irq_pmu_restore(flags);	\
>>>>> -			trace_hardirqs_off();			\
>>>>> -		} else {					\
>>>>> +		if (!raw_irqs_disabled_flags(flags))		\
>>>>>  			trace_hardirqs_on();			\
>>>>> -			raw_local_irq_pmu_restore(flags);	\
>>>>> -		}						\
>>>>> +		raw_local_irq_pmu_restore(flags);		\
>>>>>  	} while(0)
>>>>
>>>> You shouldn't be calling lockdep from NMI context!
>>>
>>> After this patch it doesn't.
>>>
>>> trace_hardirqs_on/off implementation appears to expect to be called in NMI 
>>> context though, for some reason.
>>>
>>>> That is, I recently
>>>> added suport for that on x86:
>>>>
>>>>   https://lkml.kernel.org/r/20200623083721.155449112@infradead.org
>>>>   https://lkml.kernel.org/r/20200623083721.216740948@infradead.org
>>>>
>>>> But you need to be very careful on how you order things, as you can see
>>>> the above relies on preempt_count() already having been incremented with
>>>> NMI_MASK.
>>>
>>> Hmm. My patch seems simpler.
>>
>> And your patches fix my error while Peter's do not:
>>
>>
>> IRQs not enabled as expected
>> WARNING: CPU: 0 PID: 1377 at /home/aik/p/kernel/kernel/softirq.c:169
>> __local_bh_enable_ip+0x118/0x190
> 
> I think they would have needed some powerpc bits as well. 

True, there is quite a lot to repeat of what x86 does, I was in a hurry
and did not think it through :)

> But I don't
> see a reason we can't merge my patches, at least they fix this case and
> don't seem to make things worse in any way.

True. Or we could keep these lockdep_stats::redundant_softirqs_on/etc
and make powerpc_local_irq_pmu_restore()/local_irq_restore() call
trace_hardirqs_on() always and let lockdep do reference counting, may be?


-- 
Alexey
