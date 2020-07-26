From: peterz@infradead.org
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
Date: Sun, 26 Jul 2020 13:59:44 +0200
Message-ID: <20200726115944.GB119549@hirez.programming.kicks-ass.net>
References: <20200723105615.1268126-1-npiggin@gmail.com>
 <20200725202617.GI10769@hirez.programming.kicks-ass.net>
 <1595735694.b784cvipam.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGZL7z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Jul 2020 07:59:55 -0400
Content-Disposition: inline
In-Reply-To: <1595735694.b784cvipam.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>

On Sun, Jul 26, 2020 at 02:14:34PM +1000, Nicholas Piggin wrote:
> > Now, x86, and at least arm64 call nmi_enter() before
> > trace_hardirqs_off(), but AFAICT Power never did that, and that's part
> > of the problem. nmi_enter() does lockdep_off() and that _used_ to also
> > kill IRQ tracking.
> 
> Power does do nmi_enter -- __perf_event_interrupt()
> 
>         nmi = perf_intr_is_nmi(regs);
>         if (nmi)
>                 nmi_enter();
>         else
>                 irq_enter();

That's _waaaay_ too late, you've done the trace_hardirqs_{off,on} in
arch/powerpc/kernel/exceptions-64e.S, you need to _first_ do nmi_enter()
and _then_ trace_hardirqs_off(), or rather, that's still broken, but
then we get into the details of entry ordering.
