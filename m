From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH -tip -v6] irq_work: generic hard-irq context callbacks
Date: Wed, 29 Sep 2010 15:11:02 +0200
Message-ID: <20100929131052.GA5602@nowhere>
References: <1285663908.20791.286.camel@yhuang-dev> <20100928155609.GA5354@nowhere> <AANLkTinO6rOmKhQGP9jqN_qaA5bweeXy3bwdDwt9FToG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37103 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094Ab0I2NLO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 Sep 2010 09:11:14 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinO6rOmKhQGP9jqN_qaA5bweeXy3bwdDwt9FToG@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: huang ying <huang.ying.caritas@gmail.com>
Cc: Huang Ying <ying.huang@intel.com>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, paulus <paulus@samba.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, dhowells <dhowells@redhat.com>, Russell King <rmk@arm.linux.org.uk>, Kyle McMartin <kyle@mcmartin.ca>, Martin Schwidefsky <schwidefsky@de.ibm.com>, davem <davem@davemloft.net>, Linux-Arch <linux-arch@vger.kernel.org>

On Wed, Sep 29, 2010 at 04:29:52PM +0800, huang ying wrote:
> Hi, Frederic,
>=20
> On Tue, Sep 28, 2010 at 11:56 PM, Frederic Weisbecker
> <fweisbec@gmail.com> wrote:
> > On Tue, Sep 28, 2010 at 04:51:48PM +0800, Huang Ying wrote:
> >> +++ b/arch/x86/kernel/irq_work.c
> >> @@ -0,0 +1,30 @@
> >> +/*
> >> + * x86 specific code for irq_work
> >> + *
> >> + * Copyright (C) 2010 Red Hat, Inc., Peter Zijlstra <pzijlstr@red=
hat.com>
> >> + */
> >> +
> >> +#include <linux/kernel.h>
> >> +#include <linux/irq_work.h>
> >> +#include <linux/hardirq.h>
> >> +#include <asm/apic.h>
> >> +
> >> +void smp_irq_work_interrupt(struct pt_regs *regs)
> >> +{
> >> + =A0 =A0 irq_enter();
> >> + =A0 =A0 ack_APIC_irq();
> >> + =A0 =A0 inc_irq_stat(apic_irq_work_irqs);
> >> + =A0 =A0 irq_work_run();
> >> + =A0 =A0 irq_exit();
> >> +}
> >> +
> >> +void arch_irq_work_raise(void)
> >> +{
> >> +#ifdef CONFIG_X86_LOCAL_APIC
> >> + =A0 =A0 if (!cpu_has_apic)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return;
> >> +
> >> + =A0 =A0 apic->send_IPI_self(IRQ_WORK_VECTOR);
> >> + =A0 =A0 apic_wait_icr_idle();
> >> +#endif
> >> +}
> >
> >
> >
> > So basically, CONFIG_X86_LOCAL_APIC =3D=3D !HAVE_IRQ_WORK ?
> >
> > But IIUC, this will fallback to the timer interrupt:
>=20
> If !CONFIG_X86_LOCAL_APIC or !cpu_has_apic, this will fallback to the
> timer interrupt.


Ah right, there is cpu_has_apic, so we may need the dynamic and adaptiv=
e
fallback. May be cpu_has_apic only appears on very particular configs t=
hough,
so that we can narrow down this situation statically?


=20
> >> @@ -1279,7 +1279,10 @@ void update_process_times(int user_tick)
> >> =A0 =A0 =A0 run_local_timers();
> >> =A0 =A0 =A0 rcu_check_callbacks(cpu, user_tick);
> >> =A0 =A0 =A0 printk_tick();
> >> - =A0 =A0 perf_event_do_pending();
> >> +#ifdef CONFIG_IRQ_WORK
> >> + =A0 =A0 if (in_irq())
> >> + =A0 =A0 =A0 =A0 =A0 =A0 irq_work_run();
> >> +#endif
> >> =A0 =A0 =A0 scheduler_tick();
> >> =A0 =A0 =A0 run_posix_cpu_timers(p);
> >> =A0}
> >
> > Then HAVE_IRQ_WORK just means that the arch supports self IPIs.
>=20
> HAVE_IRQ_WORK means IRQ_WORK is supported on the architecture, it has
> nothing to do with self IPIs.


Ok, but IRQ_WORK is always supported on the architecture because of
the fallback. It seems that archs enable HAVE_IRQ_WORK when they find
an optimization (self IPIs in x86, other shortcuts in other archs), but
these optimizations never change the core code anyway, right?
It would have been nice to avoid building the fallback when the archs c=
an
already manage the path by themselves.
