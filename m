From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
Date: Sat, 25 Jul 2020 22:26:17 +0200
Message-ID: <20200725202617.GI10769@hirez.programming.kicks-ass.net>
References: <20200723105615.1268126-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgGYU00 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Jul 2020 16:26:26 -0400
Content-Disposition: inline
In-Reply-To: <20200723105615.1268126-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>

On Thu, Jul 23, 2020 at 08:56:14PM +1000, Nicholas Piggin wrote:
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index 3a0db7b0b46e..35060be09073 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -200,17 +200,14 @@ static inline bool arch_irqs_disabled(void)
>  #define powerpc_local_irq_pmu_save(flags)			\
>  	 do {							\
>  		raw_local_irq_pmu_save(flags);			\
> -		trace_hardirqs_off();				\
> +		if (!raw_irqs_disabled_flags(flags))		\
> +			trace_hardirqs_off();			\
>  	} while(0)

So one problem with the above is something like this:

	raw_local_irq_save();
	<NMI>
	  powerpc_local_irq_pmu_save();

that would now no longer call into tracing/lockdep at all. As a
consequence, lockdep and tracing would show the NMI ran with IRQs
enabled, which is exceptionally weird..

Similar problem with:

	raw_local_irq_disable();
	local_irq_save()

Now, most architectures today seem to do what x86 also did:

	<NMI>
	  trace_hardirqs_off()
	  ...
	  if (irqs_unmasked(regs))
	    trace_hardirqs_on()
	</NMI>

Which is 'funny' when it interleaves like:

	local_irq_disable();
	...
	local_irq_enable()
	  trace_hardirqs_on();
	  <NMI/>
	  raw_local_irq_enable();

Because then it will undo the trace_hardirqs_on() we just did. With the
result that both tracing and lockdep will see a hardirqs-disable without
a matching enable, while the hardware state is enabled.

Which is exactly the state Alexey seems to have ran into.

Now, x86, and at least arm64 call nmi_enter() before
trace_hardirqs_off(), but AFAICT Power never did that, and that's part
of the problem. nmi_enter() does lockdep_off() and that _used_ to also
kill IRQ tracking.

Now, my patch changed that, it makes IRQ tracking not respect
lockdep_off(). And that exposed x86 (and everybody else :/) to the same
problem you have.

And this is why I made x86 look at software state in NMIs. Because then
it all works out. For bonus points, trace_hardirqs_*() also has some
do-it-once logic for tracing.



Anyway, it's Saturday evening, time for a beer. I'll stare at this more
later.
