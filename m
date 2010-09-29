From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH -tip -v6] irq_work: generic hard-irq context callbacks
Date: Wed, 29 Sep 2010 16:29:52 +0800
Message-ID: <AANLkTinO6rOmKhQGP9jqN_qaA5bweeXy3bwdDwt9FToG@mail.gmail.com>
References: <1285663908.20791.286.camel@yhuang-dev>
	<20100928155609.GA5354@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47061 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970Ab0I2IaC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 Sep 2010 04:30:02 -0400
In-Reply-To: <20100928155609.GA5354@nowhere>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Huang Ying <ying.huang@intel.com>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, paulus <paulus@samba.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, dhowells <dhowells@redhat.com>, Russell King <rmk@arm.linux.org.uk>, Kyle McMartin <kyle@mcmartin.ca>, Martin Schwidefsky <schwidefsky@de.ibm.com>, davem <davem@davemloft.net>, Linux-Arch <linux-arch@vger.kernel.org>

Hi, Frederic,

On Tue, Sep 28, 2010 at 11:56 PM, Frederic Weisbecker
<fweisbec@gmail.com> wrote:
> On Tue, Sep 28, 2010 at 04:51:48PM +0800, Huang Ying wrote:
>> +++ b/arch/x86/kernel/irq_work.c
>> @@ -0,0 +1,30 @@
>> +/*
>> + * x86 specific code for irq_work
>> + *
>> + * Copyright (C) 2010 Red Hat, Inc., Peter Zijlstra <pzijlstr@redha=
t.com>
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/irq_work.h>
>> +#include <linux/hardirq.h>
>> +#include <asm/apic.h>
>> +
>> +void smp_irq_work_interrupt(struct pt_regs *regs)
>> +{
>> + =C2=A0 =C2=A0 irq_enter();
>> + =C2=A0 =C2=A0 ack_APIC_irq();
>> + =C2=A0 =C2=A0 inc_irq_stat(apic_irq_work_irqs);
>> + =C2=A0 =C2=A0 irq_work_run();
>> + =C2=A0 =C2=A0 irq_exit();
>> +}
>> +
>> +void arch_irq_work_raise(void)
>> +{
>> +#ifdef CONFIG_X86_LOCAL_APIC
>> + =C2=A0 =C2=A0 if (!cpu_has_apic)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> +
>> + =C2=A0 =C2=A0 apic->send_IPI_self(IRQ_WORK_VECTOR);
>> + =C2=A0 =C2=A0 apic_wait_icr_idle();
>> +#endif
>> +}
>
>
>
> So basically, CONFIG_X86_LOCAL_APIC =3D=3D !HAVE_IRQ_WORK ?
>
> But IIUC, this will fallback to the timer interrupt:

If !CONFIG_X86_LOCAL_APIC or !cpu_has_apic, this will fallback to the
timer interrupt.

>> @@ -1279,7 +1279,10 @@ void update_process_times(int user_tick)
>> =C2=A0 =C2=A0 =C2=A0 run_local_timers();
>> =C2=A0 =C2=A0 =C2=A0 rcu_check_callbacks(cpu, user_tick);
>> =C2=A0 =C2=A0 =C2=A0 printk_tick();
>> - =C2=A0 =C2=A0 perf_event_do_pending();
>> +#ifdef CONFIG_IRQ_WORK
>> + =C2=A0 =C2=A0 if (in_irq())
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 irq_work_run();
>> +#endif
>> =C2=A0 =C2=A0 =C2=A0 scheduler_tick();
>> =C2=A0 =C2=A0 =C2=A0 run_posix_cpu_timers(p);
>> =C2=A0}
>
> Then HAVE_IRQ_WORK just means that the arch supports self IPIs.

HAVE_IRQ_WORK means IRQ_WORK is supported on the architecture, it has
nothing to do with self IPIs.

Best Regards,
Huang Ying
