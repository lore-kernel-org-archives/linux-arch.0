Return-Path: <SRS0=uZ41=BC=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgGWNLK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 09:11:10 -0400
Date: Thu, 23 Jul 2020 23:11:03 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
References: <20200723105615.1268126-1-npiggin@gmail.com>
        <20200723114010.GO5523@worktop.programming.kicks-ass.net>
In-Reply-To: <20200723114010.GO5523@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <1595506730.3mvrxktem5.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Message-ID: <20200723131103.-SvThe4PFX6IAdo3Ye9sbLr66Nr-CiBgd_afT9IidHk@z>

Excerpts from Peter Zijlstra's message of July 23, 2020 9:40 pm:
> On Thu, Jul 23, 2020 at 08:56:14PM +1000, Nicholas Piggin wrote:
>=20
>> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/as=
m/hw_irq.h
>> index 3a0db7b0b46e..35060be09073 100644
>> --- a/arch/powerpc/include/asm/hw_irq.h
>> +++ b/arch/powerpc/include/asm/hw_irq.h
>> @@ -200,17 +200,14 @@ static inline bool arch_irqs_disabled(void)
>>  #define powerpc_local_irq_pmu_save(flags)			\
>>  	 do {							\
>>  		raw_local_irq_pmu_save(flags);			\
>> -		trace_hardirqs_off();				\
>> +		if (!raw_irqs_disabled_flags(flags))		\
>> +			trace_hardirqs_off();			\
>>  	} while(0)
>>  #define powerpc_local_irq_pmu_restore(flags)			\
>>  	do {							\
>> -		if (raw_irqs_disabled_flags(flags)) {		\
>> -			raw_local_irq_pmu_restore(flags);	\
>> -			trace_hardirqs_off();			\
>> -		} else {					\
>> +		if (!raw_irqs_disabled_flags(flags))		\
>>  			trace_hardirqs_on();			\
>> -			raw_local_irq_pmu_restore(flags);	\
>> -		}						\
>> +		raw_local_irq_pmu_restore(flags);		\
>>  	} while(0)
>=20
> You shouldn't be calling lockdep from NMI context!

After this patch it doesn't.

trace_hardirqs_on/off implementation appears to expect to be called in NMI=20
context though, for some reason.

> That is, I recently
> added suport for that on x86:
>=20
>   https://lkml.kernel.org/r/20200623083721.155449112@infradead.org
>   https://lkml.kernel.org/r/20200623083721.216740948@infradead.org
>=20
> But you need to be very careful on how you order things, as you can see
> the above relies on preempt_count() already having been incremented with
> NMI_MASK.

Hmm. My patch seems simpler.

I don't know this stuff very well, I don't really understand what your patc=
h=20
enables for x86 but at least it shouldn't be incompatible with this one=20
AFAIKS.

Thanks,
Nick
