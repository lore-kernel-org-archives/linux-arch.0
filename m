From: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
Date: Fri, 24 Jul 2020 14:16:39 +1000
Message-ID: <1884dcea-9ecd-a1f3-21bb-213c655e2480@ozlabs.ru>
References: <20200723105615.1268126-1-npiggin@gmail.com>
 <20200723114010.GO5523@worktop.programming.kicks-ass.net>
 <1595506730.3mvrxktem5.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgGXEQp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 00:16:45 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ABBC0619E3
        for <linux-arch@vger.kernel.org>; Thu, 23 Jul 2020 21:16:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cv18so5271164pjb.1
        for <linux-arch@vger.kernel.org>; Thu, 23 Jul 2020 21:16:45 -0700 (PDT)
In-Reply-To: <1595506730.3mvrxktem5.astroid@bobo.none>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>



On 23/07/2020 23:11, Nicholas Piggin wrote:
> Excerpts from Peter Zijlstra's message of July 23, 2020 9:40 pm:
>> On Thu, Jul 23, 2020 at 08:56:14PM +1000, Nicholas Piggin wrote:
>>
>>> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
>>> index 3a0db7b0b46e..35060be09073 100644
>>> --- a/arch/powerpc/include/asm/hw_irq.h
>>> +++ b/arch/powerpc/include/asm/hw_irq.h
>>> @@ -200,17 +200,14 @@ static inline bool arch_irqs_disabled(void)
>>>  #define powerpc_local_irq_pmu_save(flags)			\
>>>  	 do {							\
>>>  		raw_local_irq_pmu_save(flags);			\
>>> -		trace_hardirqs_off();				\
>>> +		if (!raw_irqs_disabled_flags(flags))		\
>>> +			trace_hardirqs_off();			\
>>>  	} while(0)
>>>  #define powerpc_local_irq_pmu_restore(flags)			\
>>>  	do {							\
>>> -		if (raw_irqs_disabled_flags(flags)) {		\
>>> -			raw_local_irq_pmu_restore(flags);	\
>>> -			trace_hardirqs_off();			\
>>> -		} else {					\
>>> +		if (!raw_irqs_disabled_flags(flags))		\
>>>  			trace_hardirqs_on();			\
>>> -			raw_local_irq_pmu_restore(flags);	\
>>> -		}						\
>>> +		raw_local_irq_pmu_restore(flags);		\
>>>  	} while(0)
>>
>> You shouldn't be calling lockdep from NMI context!
> 
> After this patch it doesn't.
> 
> trace_hardirqs_on/off implementation appears to expect to be called in NMI 
> context though, for some reason.
> 
>> That is, I recently
>> added suport for that on x86:
>>
>>   https://lkml.kernel.org/r/20200623083721.155449112@infradead.org
>>   https://lkml.kernel.org/r/20200623083721.216740948@infradead.org
>>
>> But you need to be very careful on how you order things, as you can see
>> the above relies on preempt_count() already having been incremented with
>> NMI_MASK.
> 
> Hmm. My patch seems simpler.

And your patches fix my error while Peter's do not:


IRQs not enabled as expected
WARNING: CPU: 0 PID: 1377 at /home/aik/p/kernel/kernel/softirq.c:169
__local_bh_enable_ip+0x118/0x190


> 
> I don't know this stuff very well, I don't really understand what your patch 
> enables for x86 but at least it shouldn't be incompatible with this one 
> AFAIKS.
> 
> Thanks,
> Nick
> 

-- 
Alexey
