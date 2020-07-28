From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
Date: Tue, 28 Jul 2020 21:22:47 +1000
Message-ID: <1595934957.l1u0ucmyps.astroid@bobo.none>
References: <20200723105615.1268126-1-npiggin@gmail.com>
        <20200725202617.GI10769@hirez.programming.kicks-ass.net>
        <1595735694.b784cvipam.astroid@bobo.none>
        <20200726121138.GC119549@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbgG1LWy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jul 2020 07:22:54 -0400
In-Reply-To: <20200726121138.GC119549@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>

Excerpts from peterz@infradead.org's message of July 26, 2020 10:11 pm:
> On Sun, Jul 26, 2020 at 02:14:34PM +1000, Nicholas Piggin wrote:
>> Excerpts from Peter Zijlstra's message of July 26, 2020 6:26 am:
>=20
>> > Which is 'funny' when it interleaves like:
>> >=20
>> > 	local_irq_disable();
>> > 	...
>> > 	local_irq_enable()
>> > 	  trace_hardirqs_on();
>> > 	  <NMI/>
>> > 	  raw_local_irq_enable();
>> >=20
>> > Because then it will undo the trace_hardirqs_on() we just did. With th=
e
>> > result that both tracing and lockdep will see a hardirqs-disable witho=
ut
>> > a matching enable, while the hardware state is enabled.
>>=20
>> Seems like an arch problem -- why not disable if it was enabled only?
>> I guess the local_irq tracing calls are a mess so maybe they copied=20
>> those.
>=20
> Because, as I wrote earlier, then we can miss updating software state.
> So your proposal has:
>=20
> 	raw_local_irq_disable()
> 	<NMI>
> 	  if (!arch_irqs_disabled(regs->flags) // false
> 	    trace_hardirqs_off();
>=20
> 	  // tracing/lockdep still think IRQs are enabled
> 	  // hardware IRQ state is disabled.

... and then lockdep_nmi_enter can disable IRQs if they were enabled?

The only reason it's done this way as opposed to a much simple counter=20
increment/decrement AFAIKS is to avoid some overhead of calling=20
trace_hardirqs_on/off (which seems a bit dubious but let's go with it).

In that case the lockdep_nmi_enter code is the right spot to clean up=20
that gap vs NMIs. I guess there's an argument that arch_nmi_enter could
do it. I don't see the problem with fixing it up here though, this is a=20
slow path so it doesn't matter if we have some more logic for it.

Thanks,
Nick
