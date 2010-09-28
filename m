From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH -tip -v6] irq_work: generic hard-irq context callbacks
Date: Tue, 28 Sep 2010 17:56:21 +0200
Message-ID: <20100928155609.GA5354@nowhere>
References: <1285663908.20791.286.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40203 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452Ab0I1P4g (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 28 Sep 2010 11:56:36 -0400
Content-Disposition: inline
In-Reply-To: <1285663908.20791.286.camel@yhuang-dev>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Huang Ying <ying.huang@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, paulus <paulus@samba.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, dhowells <dhowells@redhat.com>, Russell King <rmk@arm.linux.org.uk>, Kyle McMartin <kyle@mcmartin.ca>, Martin Schwidefsky <schwidefsky@de.ibm.com>, davem <davem@davemloft.net>, Linux-Arch <linux-arch@vger.kernel.org>

On Tue, Sep 28, 2010 at 04:51:48PM +0800, Huang Ying wrote:
> +++ b/arch/x86/kernel/irq_work.c
> @@ -0,0 +1,30 @@
> +/*
> + * x86 specific code for irq_work
> + *
> + * Copyright (C) 2010 Red Hat, Inc., Peter Zijlstra <pzijlstr@redhat.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/irq_work.h>
> +#include <linux/hardirq.h>
> +#include <asm/apic.h>
> +
> +void smp_irq_work_interrupt(struct pt_regs *regs)
> +{
> +	irq_enter();
> +	ack_APIC_irq();
> +	inc_irq_stat(apic_irq_work_irqs);
> +	irq_work_run();
> +	irq_exit();
> +}
> +
> +void arch_irq_work_raise(void)
> +{
> +#ifdef CONFIG_X86_LOCAL_APIC
> +	if (!cpu_has_apic)
> +		return;
> +
> +	apic->send_IPI_self(IRQ_WORK_VECTOR);
> +	apic_wait_icr_idle();
> +#endif
> +}



So basically, CONFIG_X86_LOCAL_APIC == !HAVE_IRQ_WORK ?

But IIUC, this will fallback to the timer interrupt:



> @@ -1279,7 +1279,10 @@ void update_process_times(int user_tick)
>  	run_local_timers();
>  	rcu_check_callbacks(cpu, user_tick);
>  	printk_tick();
> -	perf_event_do_pending();
> +#ifdef CONFIG_IRQ_WORK
> +	if (in_irq())
> +		irq_work_run();
> +#endif
>  	scheduler_tick();
>  	run_posix_cpu_timers(p);
>  }



Then HAVE_IRQ_WORK just means that the arch supports self IPIs.
So, CONFIG_IRQ_WORK doesn't need to depend on HAVE_IRQ_WORK
because of the timer fallback. But archs that support self
IPIs should avoid the above fallback because it bloats
the timer interrupt.

Perhaps CONFIG_HAVE_IRQ_WORK should be CONFIG_HAVE_IRQ_WORK_SOURCE
or CONFIG_HAVE_IRQ_WORK_TRIGGER to better denote the capability.
And then:

config IRQ_WORK_TRIGGER
	depends on HAVE_IRQ_WORK_TRIGGER && IRQ_WORK
	default y

And that would define the right condition to build the fallback
in the timer interrupt.

Or I am completely misunderstanding something?

Thanks.
