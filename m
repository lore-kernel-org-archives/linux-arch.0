From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
Date: Fri, 24 Jul 2020 02:20:20 +1000
Message-ID: <1595520766.9z4077xel7.astroid@bobo.none>
References: <20200723105615.1268126-1-npiggin@gmail.com>
        <20200723114010.GO5523@worktop.programming.kicks-ass.net>
        <1595506730.3mvrxktem5.astroid@bobo.none>
        <20200723145904.GU5523@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgGWQU1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 12:20:27 -0400
In-Reply-To: <20200723145904.GU5523@worktop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>

Excerpts from Peter Zijlstra's message of July 24, 2020 12:59 am:
> On Thu, Jul 23, 2020 at 11:11:03PM +1000, Nicholas Piggin wrote:
>> Excerpts from Peter Zijlstra's message of July 23, 2020 9:40 pm:
>> > On Thu, Jul 23, 2020 at 08:56:14PM +1000, Nicholas Piggin wrote:
>> >=20
>> >> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include=
/asm/hw_irq.h
>> >> index 3a0db7b0b46e..35060be09073 100644
>> >> --- a/arch/powerpc/include/asm/hw_irq.h
>> >> +++ b/arch/powerpc/include/asm/hw_irq.h
>> >> @@ -200,17 +200,14 @@ static inline bool arch_irqs_disabled(void)
>> >>  #define powerpc_local_irq_pmu_save(flags)			\
>> >>  	 do {							\
>> >>  		raw_local_irq_pmu_save(flags);			\
>> >> -		trace_hardirqs_off();				\
>> >> +		if (!raw_irqs_disabled_flags(flags))		\
>> >> +			trace_hardirqs_off();			\
>> >>  	} while(0)
>> >>  #define powerpc_local_irq_pmu_restore(flags)			\
>> >>  	do {							\
>> >> -		if (raw_irqs_disabled_flags(flags)) {		\
>> >> -			raw_local_irq_pmu_restore(flags);	\
>> >> -			trace_hardirqs_off();			\
>> >> -		} else {					\
>> >> +		if (!raw_irqs_disabled_flags(flags))		\
>> >>  			trace_hardirqs_on();			\
>> >> -			raw_local_irq_pmu_restore(flags);	\
>> >> -		}						\
>> >> +		raw_local_irq_pmu_restore(flags);		\
>> >>  	} while(0)
>> >=20
>> > You shouldn't be calling lockdep from NMI context!
>>=20
>> After this patch it doesn't.
>=20
> You sure, trace_hardirqs_{on,off}() calls into lockdep.

At least for irq enable/disable functions yes. NMI runs with
interrupts disabled so these will never call trace_hardirqs_on/off
after this patch.

> (FWIW they're
> also broken vs entry ordering, but that's another story).
>=20
>> trace_hardirqs_on/off implementation appears to expect to be called in N=
MI=20
>> context though, for some reason.
>=20
> Hurpm, not sure.. I'll have to go grep arch code now :/ The generic NMI
> code didn't touch that stuff.
>=20
> Argh, yes, there might be broken there... damn! I'll go frob around.
>=20

Thanks,
Nick
