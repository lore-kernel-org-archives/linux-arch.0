From: peterz@infradead.org
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
Date: Sun, 26 Jul 2020 14:11:38 +0200
Message-ID: <20200726121138.GC119549@hirez.programming.kicks-ass.net>
References: <20200723105615.1268126-1-npiggin@gmail.com>
 <20200725202617.GI10769@hirez.programming.kicks-ass.net>
 <1595735694.b784cvipam.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgGZMLr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Jul 2020 08:11:47 -0400
Content-Disposition: inline
In-Reply-To: <1595735694.b784cvipam.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>

On Sun, Jul 26, 2020 at 02:14:34PM +1000, Nicholas Piggin wrote:
> Excerpts from Peter Zijlstra's message of July 26, 2020 6:26 am:

> > Which is 'funny' when it interleaves like:
> > 
> > 	local_irq_disable();
> > 	...
> > 	local_irq_enable()
> > 	  trace_hardirqs_on();
> > 	  <NMI/>
> > 	  raw_local_irq_enable();
> > 
> > Because then it will undo the trace_hardirqs_on() we just did. With the
> > result that both tracing and lockdep will see a hardirqs-disable without
> > a matching enable, while the hardware state is enabled.
> 
> Seems like an arch problem -- why not disable if it was enabled only?
> I guess the local_irq tracing calls are a mess so maybe they copied 
> those.

Because, as I wrote earlier, then we can miss updating software state.
So your proposal has:

	raw_local_irq_disable()
	<NMI>
	  if (!arch_irqs_disabled(regs->flags) // false
	    trace_hardirqs_off();

	  // tracing/lockdep still think IRQs are enabled
	  // hardware IRQ state is disabled.

With the current code we have:

	local_irq_enable()
	  trace_hardirqs_on();
	  <NMI>
	    trace_hardirqs_off();
	    ...
	    if (!arch_irqs_disabled(regs->flags)) // false
	      trace_hardirqs_on();
	  </NMI>
	  // and now the NMI disabled software state again
	  // while we're about to enable the hardware state
	  raw_local_irq_enable();

> > Which is exactly the state Alexey seems to have ran into.
> 
> No his was what I said, the interruptee's trace_hardirqs_on() in
> local_irq_enable getting lost because the NMI's local_irq_disable
> always disables, but the enable doesn't re-enable.

That's _exactly_ the case above. It doesn't re-enable because hardirqs
are actually still disabled. You _cannot_ rely on hardirq state for
NMIs, that'll get you wrong state.

> It's all just weird asymmetrical special case hacks AFAIKS, the
> code should just be symmetric and lockdep handle it's own weirdness.

It's for non-maskable exceptions/interrupts, because there the hardware
and software state changes non-atomically. For maskable interrupts doing
the software state transitions inside the disabled region makes perfect
sense, because that keeps it atomic.
