From: Karsten Merker <merker@debian.org>
Subject: Re: [patches] Re: [PATCH 1/9] RISC-V: Init and Halt Code
Date: Tue, 4 Jul 2017 23:17:50 +0200
Message-ID: <20170704211749.jqgfbgjqzm2bcppy@excalibur.cnev.de>
References: <20170704195102.3974-1-palmer@dabbelt.com>
 <20170704195102.3974-2-palmer@dabbelt.com>
 <alpine.DEB.2.20.1707042224560.2131@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:55593 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752204AbdGDVTe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2017 17:19:34 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1707042224560.2131@nanos>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: patches@groups.riscv.org, peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

On Tue, Jul 04, 2017 at 10:37:37PM +0200, Thomas Gleixner wrote:
> On Tue, 4 Jul 2017, Palmer Dabbelt wrote:

> > +unsigned long riscv_timebase;
> > +
> > +static int next_event(unsigned long delta, struct clock_event_device *ce)
> > +{
> > +	BUG_ON(ce != timer_riscv_device(smp_processor_id()));
> > +	sbi_set_timer(get_cycles64() + delta);
> > +	return 0;
> > +}
> > +
> > +static unsigned long long rdtime(struct clocksource *cs)
> > +{
> > +	BUG_ON(cs != timer_riscv_source(smp_processor_id()));
> > +	return get_cycles64();
> > +}
> > +
> > +void riscv_timer_interrupt(void)
> > +{
> > +	int cpu = smp_processor_id();
> > +	struct clock_event_device *evdev = timer_riscv_device(cpu);
> > +
> > +	evdev->event_handler(evdev);
> > +}
> > +
> > +void __init time_init(void)
> > +{
> > +	struct device_node *cpu;
> > +	u32 prop;
> > +	int cpu_id = smp_processor_id();
> > +
> > +	cpu = of_find_node_by_path("/cpus");
> > +	if (!cpu || of_property_read_u32(cpu, "timebase-frequency", &prop))
> > +		panic(KERN_WARNING "RISC-V system with no 'timebase-frequency' in DTS\n");
> > +	riscv_timebase = prop;
> > +
> > +	lpj_fine = riscv_timebase / HZ;
> > +
> > +	timer_riscv_init(cpu_id, riscv_timebase, &rdtime, &next_event);
> 
> This function is nowhere.... Neither can I find the header file.

It is part of the RISC-V clock driver patchset, please cf.
https://github.com/riscv/riscv-linux/commit/0705a31372d4714e54c5104e02021441785c1fd5

https://github.com/riscv/riscv-linux/commits/riscv-for-submission-v4
has the various RISC-V-related driver patchsets merged in (in
addition to this arch patchset).

Regards,
Karsten
-- 
Gem. Par. 28 Abs. 4 Bundesdatenschutzgesetz widerspreche ich der Nutzung
sowie der Weitergabe meiner personenbezogenen Daten für Zwecke der
Werbung sowie der Markt- oder Meinungsforschung.
