From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: Re: [RFC patch 07/18] Trace clock core
Date: Fri, 7 Nov 2008 01:16:43 -0500
Message-ID: <20081107061643.GA798@Krystal>
References: <20081107052336.652868737@polymtl.ca> <20081107053349.699011457@polymtl.ca> <20081106215256.a9f01ec4.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from tomts10-srv.bellnexxia.net ([209.226.175.54]:56534 "EHLO
	tomts10-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750998AbYKGGQp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Nov 2008 01:16:45 -0500
Content-Disposition: inline
In-Reply-To: <20081106215256.a9f01ec4.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org, Nicolas Pitre <nico@cam.org>, Ralf Baechle <ralf@linux-mips.org>, benh@kernel.crashing.org, paulus@samba.org, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org

* Andrew Morton (akpm@linux-foundation.org) wrote:
> On Fri, 07 Nov 2008 00:23:43 -0500 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:
> 
> > 32 to 64 bits clock extension. Extracts 64 bits tsc from a [1..32]
> > bits counter, kept up to date by periodical timer interrupt. Lockless.
> > 
> > ...
> >
> > +#include <linux/sched.h> /* FIX for m68k local_irq_enable in on_each_cpu */
> 
> What's going on here?
> 

Hi Andrew,

When I wrote this comment (kernel ~2.6.25), the situation was (and it
still looks valid, although I haven't tried to fix it since then) :

linux/smp.h :
  on_each_cpu() (!SMP)
    local_irq_enable()

but, on m68k :

asm-m68k/system.h defines this ugly macro :

/* interrupt control.. */
#if 0
#define local_irq_enable() asm volatile ("andiw %0,%%sr": : "i" (ALLOWINT) : "memory")
#else
#include <linux/hardirq.h>
#define local_irq_enable() ({                                                   \
        if (MACH_IS_Q40 || !hardirq_count())                                    \
                asm volatile ("andiw %0,%%sr": : "i" (ALLOWINT) : "memory");    \
})
#endif

Which uses !hardirq_count(), which is defined by sched.h. However, I did
try in the past to include sched.h in asm-m68k/system.h, but it ended up
doing a recursive inclusion.

> > +struct synthetic_tsc_struct {
> > +	union {
> > +		u64 val;
> > +		struct {
> > +#ifdef __BIG_ENDIAN
> > +			u32 msb;
> > +			u32 lsb;
> > +#else
> > +			u32 lsb;
> > +			u32 msb;
> > +#endif
> 
> One would expect an identifier called "msb" to mean "most significant
> bit" or possible "most significant byte".
> 
> Maybe ms32 and ls32?
> 

Yep, seems clearer.

> > +		} sel;
> > +	} tsc[2];
> > +	unsigned int index;	/* Index of the current synth. tsc. */
> > +};
> > +
> > +static DEFINE_PER_CPU(struct synthetic_tsc_struct, synthetic_tsc);
> > +
> > +/* Called from IPI : either in interrupt or process context */
> 
> IPI handlers should always be called with local interrupts disabled.
> 
> > +static void update_synthetic_tsc(void)
> > +{
> > +	struct synthetic_tsc_struct *cpu_synth;
> > +	u32 tsc;
> > +
> > +	preempt_disable();
> 
> which would make this unnecessary.
> 

Ah, yes, right.

> > +	cpu_synth = &per_cpu(synthetic_tsc, smp_processor_id());
> > +	tsc = trace_clock_read32();		/* Hardware clocksource read */
> > +
> > +	if (tsc < HW_LSB(cpu_synth->tsc[cpu_synth->index].sel.lsb)) {
> > +		unsigned int new_index = 1 - cpu_synth->index; /* 0 <-> 1 */
> > +		/*
> > +		 * Overflow
> > +		 * Non atomic update of the non current synthetic TSC, followed
> > +		 * by an atomic index change. There is no write concurrency,
> > +		 * so the index read/write does not need to be atomic.
> > +		 */
> > +		cpu_synth->tsc[new_index].val =
> > +			(SW_MSB(cpu_synth->tsc[cpu_synth->index].val)
> > +				| (u64)tsc) + (1ULL << HW_BITS);
> > +		cpu_synth->index = new_index;	/* atomic change of index */
> > +	} else {
> > +		/*
> > +		 * No overflow : We know that the only bits changed are
> > +		 * contained in the 32 LSBs, which can be written to atomically.
> > +		 */
> > +		cpu_synth->tsc[cpu_synth->index].sel.lsb =
> > +			SW_MSB(cpu_synth->tsc[cpu_synth->index].sel.lsb) | tsc;
> > +	}
> > +	preempt_enable();
> > +}
> 
> Is there something we should be fixing in m68k?
> 

Yes, but I fear it's going to go deep into include hell :-(

Mathieu

-- 
Mathieu Desnoyers
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
