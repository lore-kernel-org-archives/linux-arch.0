From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
Date: Sun, 26 Jul 2020 14:14:34 +1000
Message-ID: <1595735694.b784cvipam.astroid@bobo.none>
References: <20200723105615.1268126-1-npiggin@gmail.com>
        <20200725202617.GI10769@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200725202617.GI10769@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

Excerpts from Peter Zijlstra's message of July 26, 2020 6:26 am:
> On Thu, Jul 23, 2020 at 08:56:14PM +1000, Nicholas Piggin wrote:
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
>=20
> So one problem with the above is something like this:
>=20
> 	raw_local_irq_save();
> 	<NMI>
> 	  powerpc_local_irq_pmu_save();
>=20
> that would now no longer call into tracing/lockdep at all. As a
> consequence, lockdep and tracing would show the NMI ran with IRQs
> enabled, which is exceptionally weird..

powerpc perf NMIs will trace_hardirqs_off() if they were enabled,
and trace_hardirqs_on() at exit in that case too.

Machine check and system reset (like x86's "nmi") don't, but that's
deliberate to avoid any tracing in those cases which often causes
more problems than it's worth (and we have flags to prevent ftrace,
etc too for those cases).

> Similar problem with:
>=20
> 	raw_local_irq_disable();
> 	local_irq_save()
>=20
> Now, most architectures today seem to do what x86 also did:
>=20
> 	<NMI>
> 	  trace_hardirqs_off()
> 	  ...
> 	  if (irqs_unmasked(regs))
> 	    trace_hardirqs_on()
> 	</NMI>
>=20
> Which is 'funny' when it interleaves like:
>=20
> 	local_irq_disable();
> 	...
> 	local_irq_enable()
> 	  trace_hardirqs_on();
> 	  <NMI/>
> 	  raw_local_irq_enable();
>=20
> Because then it will undo the trace_hardirqs_on() we just did. With the
> result that both tracing and lockdep will see a hardirqs-disable without
> a matching enable, while the hardware state is enabled.

Seems like an arch problem -- why not disable if it was enabled only?
I guess the local_irq tracing calls are a mess so maybe they copied=20
those.

> Which is exactly the state Alexey seems to have ran into.

No his was what I said, the interruptee's trace_hardirqs_on() in
local_irq_enable getting lost because the NMI's local_irq_disable
always disables, but the enable doesn't re-enable.

It's all just weird asymmetrical special case hacks AFAIKS, the
code should just be symmetric and lockdep handle it's own weirdness.

>=20
> Now, x86, and at least arm64 call nmi_enter() before
> trace_hardirqs_off(), but AFAICT Power never did that, and that's part
> of the problem. nmi_enter() does lockdep_off() and that _used_ to also
> kill IRQ tracking.

Power does do nmi_enter -- __perf_event_interrupt()

        nmi =3D perf_intr_is_nmi(regs);
        if (nmi)
                nmi_enter();
        else
                irq_enter();

Thanks,
Nick

> Now, my patch changed that, it makes IRQ tracking not respect
> lockdep_off(). And that exposed x86 (and everybody else :/) to the same
> problem you have.
>=20
> And this is why I made x86 look at software state in NMIs. Because then
> it all works out. For bonus points, trace_hardirqs_*() also has some
> do-it-once logic for tracing.
>=20
>=20
>=20
> Anyway, it's Saturday evening, time for a beer. I'll stare at this more
> later.
>=20
