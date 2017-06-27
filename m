From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 09/17] clocksource/timer-riscv: New RISC-V Clocksource
Date: Mon, 26 Jun 2017 17:56:13 -0700 (PDT)
Message-ID: <mhng-1e468c2f-4630-4028-b4ff-652e1aaad498@palmer-si-x1c4>
References: <20170607201659.GI2345@mai>
Mime-Version: 1.0 (MHng)
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36586 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751461AbdF0A4P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2017 20:56:15 -0400
Received: by mail-pg0-f65.google.com with SMTP id u36so2190643pgn.3
        for <linux-arch@vger.kernel.org>; Mon, 26 Jun 2017 17:56:15 -0700 (PDT)
In-Reply-To: <20170607201659.GI2345@mai>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: daniel.lezcano@linaro.org
Cc: geert@linux-m68k.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org, tglx@linutronix.de

On Wed, 07 Jun 2017 13:16:59 PDT (-0700), daniel.lezcano@linaro.org wrote:
> Hi,
>
> I prefer the term 'timer' when we have a clocksource + clockevent.
>
> Reply-To:
> In-Reply-To: <CAMuHMdXkO-r1kVow-PqyRNYy32Eq5jr9fn75neFcMWhDUvGCPA@mail.gmail.com>
>
> On Wed, Jun 07, 2017 at 09:12:28AM +0200, Geert Uytterhoeven wrote:
>> CC clocksource folks
>
> Thanks Geert.
>
>> On Wed, Jun 7, 2017 at 12:59 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> > The RISC-V ISA defines a single RTC as well as an SBI oneshot timer.
>> > This timer is present on all RISC-V systems.
>
> As it is a new driver, please give a detailed description of the timer for the
> record.

OK.  I've gone ahead and added it as a comment

>
>> > Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>> > ---
>> >  drivers/clocksource/Kconfig       |   8 +++
>> >  drivers/clocksource/Makefile      |   1 +
>> >  drivers/clocksource/timer-riscv.c | 118 ++++++++++++++++++++++++++++++++++++++
>> >  3 files changed, 127 insertions(+)
>> >  create mode 100644 drivers/clocksource/timer-riscv.c
>> >
>> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> > index 545d541ae20e..1c2c6e7c7fab 100644
>> > --- a/drivers/clocksource/Kconfig
>> > +++ b/drivers/clocksource/Kconfig
>> > @@ -612,4 +612,12 @@ config CLKSRC_ST_LPC
>> >           Enable this option to use the Low Power controller timer
>> >           as clocksource.
>> >
>> > +config CLKSRC_RISCV
>
> config TIMER_RISCV
>
>> > +       #bool "Clocksource for the RISC-V platform"
>> > +       def_bool y if RISCV
>> > +       depends on RISCV
>> > +       help
>> > +         This enables a clocksource based on the RISC-V SBI timer, which is
>> > +         built in to all RISC-V systems.
>
> Please stick to the other drivers options format.
>
>  ... if COMPILE_TEST ...
>
> And set the timer from the platform's Kconfig.

OK.  https://github.com/riscv/riscv-linux/commit/345d431e021c4e80d3ae777acd64fdb8685b9ab9

>> >  endmenu
>> > diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
>> > index 2b5b56a6f00f..408ed9d314dc 100644
>> > --- a/drivers/clocksource/Makefile
>> > +++ b/drivers/clocksource/Makefile
>> > @@ -73,3 +73,4 @@ obj-$(CONFIG_H8300_TMR16)             += h8300_timer16.o
>> >  obj-$(CONFIG_H8300_TPU)                        += h8300_tpu.o
>> >  obj-$(CONFIG_CLKSRC_ST_LPC)            += clksrc_st_lpc.o
>> >  obj-$(CONFIG_X86_NUMACHIP)             += numachip.o
>> > +obj-$(CONFIG_CLKSRC_RISCV)             += timer-riscv.o
>> > diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
>> > new file mode 100644
>> > index 000000000000..04ef7b9130b3
>> > --- /dev/null
>> > +++ b/drivers/clocksource/timer-riscv.c
>> > @@ -0,0 +1,118 @@
>> > +/*
>> > + * Copyright (C) 2012 Regents of the University of California
>> > + * Copyright (C) 2017 SiFive
>> > + *
>> > + *   This program is free software; you can redistribute it and/or
>> > + *   modify it under the terms of the GNU General Public License
>> > + *   as published by the Free Software Foundation, version 2.
>> > + *
>> > + *   This program is distributed in the hope that it will be useful,
>> > + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > + *   GNU General Public License for more details.
>> > + */
>> > +
>> > +#include <linux/clocksource.h>
>> > +#include <linux/clockchips.h>
>> > +#include <linux/interrupt.h>
>> > +#include <linux/irq.h>
>> > +#include <linux/delay.h>
>> > +#include <linux/of.h>
>> > +
>> > +#include <asm/irq.h>
>> > +#include <asm/csr.h>
>> > +#include <asm/sbi.h>
>> > +#include <asm/delay.h>
>
> Are all these headers needed?
>
> I don't see in the code a delay.
>
> Please remove these asm headers and add the missing macros in this file.
>
>> > +unsigned long riscv_timebase;
>
> It is pointless to have this global variable.

That's actually used internally elsewhere inside the RISC-V arch port.  I've
gone ahead and split out the code that should be in our arch port from the
stuff that's relevant to the timer subsystem.  I'll go ahead and repost the
patch.

>> > +static DEFINE_PER_CPU(struct clock_event_device, clock_event);
>
> The description tells there is one clockevent but here we have percpu
> clockevents. Either the description is inaccurate or the percpu code is wrong.

Sorry that was confusing: the RISC-V ISA defines per CPU timers, but allows
them to be implemented as a single physical timer and a handful of comparison
registers.  While cleaning up the rest of the code I've gone ahead and addded a
big comment that describes what's going on

  /*
   * All RISC-V systems have a timer attached to every hart.  These timers can be
   * read by the 'rdcycle' pseudo instruction, and can use the SBI to setup
   * events.  In order to abstract the arcitecture-specific timer reading and
   * setting functions away from the clock event insertion code, we provide
   * function pointers to the clockevent subsystem that perform two basic operations:
   * rdtime() reads the timer on the current CPU, and next_event(delta) sets the
   * next timer event to 'delta' cycles in the future.  As the timers are
   * inherently a per-cpu resource, these callbacks perform operations on the
   * current hart.  There is guarnteed to be exactly one timer per hart on all
   * RISC-V systems.
   */

>> > +static int riscv_timer_set_next_event(unsigned long delta,
>> > +       struct clock_event_device *evdev)
>
> indent.
>
>> > +{
>> > +       sbi_set_timer(get_cycles() + delta);
>> > +       return 0;
>> > +}
>> > +
>> > +static int riscv_timer_set_oneshot(struct clock_event_device *evt)
>> > +{
>> > +       /* no-op; only one mode */
>> > +       return 0;
>> > +}
>> > +
>> > +static int riscv_timer_set_shutdown(struct clock_event_device *evt)
>> > +{
>> > +       /* can't stop the clock! */
>> > +       return 0;
>> > +}
>> > +
>> > +static u64 riscv_rdtime(struct clocksource *cs)
>> > +{
>> > +       return get_cycles();
>> > +}
>> > +
>> > +static struct clocksource riscv_clocksource = {
>> > +       .name = "riscv_clocksource",
>> > +       .rating = 300,
>> > +       .read = riscv_rdtime,
>> > +#ifdef CONFIG_64BITS
>> > +       .mask = CLOCKSOURCE_MASK(64),
>> > +#else
>> > +       .mask = CLOCKSOURCE_MASK(32),
>> > +#endif /* CONFIG_64BITS */
>> > +       .flags = CLOCK_SOURCE_IS_CONTINUOUS,
>> > +};
>
> Consider using clocksource_mmio_init().
>
>> > +void riscv_timer_interrupt(void)
>
> static.
>
>> > +{
>> > +       int cpu = smp_processor_id();
>> > +       struct clock_event_device *evdev = &per_cpu(clock_event, cpu);
>> > +
>> > +       evdev->event_handler(evdev);
>> > +}
>
> riscv_timer_interrupt() not used.
>
> Wrong function signature for an interrupt handler.
>
> Missing IRQ_HANDLED returned value.

Sorry, this was an internal RISC-V function that shouldn't have been exposed.

>> > +void __init init_clockevent(void)
>
> static.
>
>> > +{
>> > +       int cpu = smp_processor_id();
>> > +       struct clock_event_device *ce = &per_cpu(clock_event, cpu);
>> > +
>> > +       *ce = (struct clock_event_device){
>> > +               .name = "riscv_timer_clockevent",
>> > +               .features = CLOCK_EVT_FEAT_ONESHOT,
>> > +               .rating = 300,
>> > +               .cpumask = cpumask_of(cpu),
>> > +               .set_next_event = riscv_timer_set_next_event,
>> > +               .set_state_oneshot  = riscv_timer_set_oneshot,
>> > +               .set_state_shutdown = riscv_timer_set_shutdown,
>> > +       };
>> > +
>> > +       /* Enable timer interrupts */
>> > +       csr_set(sie, SIE_STIE);
>
> Where is the request_irq call?

The timer interrupt comes into RISC-V cores via a special interrupt controller.
This interrupt controller has interrupt IDs allocated in the ISA manual for the
timer interrupt, software interrupts, and then all other interrupts (which are
forwarded from the platform-level interrupt controller).

>> > +       clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
>> > +}
>> > +
>> > +static unsigned long __init of_timebase(void)
>> > +{
>> > +       struct device_node *cpu;
>> > +       const __be32 *prop;
>> > +
>> > +       cpu = of_find_node_by_path("/cpus");
>> > +       if (cpu) {
>> > +               prop = of_get_property(cpu, "timebase-frequency", NULL);
>> > +               if (prop)
>> > +                       return be32_to_cpu(*prop);
>> > +       }
>
> Couldn't this be replaced by a clock?
>
>> > +
>> > +       return 10000000;
>
> Macro please.

It's actually obselete: I've changed the init code to fail if there isn't a
"timebase-frequency" in the DTS based on another code review.

>> > +}
>> > +
>> > +void __init time_init(void)
>> > +{
>> > +       riscv_timebase = of_timebase();
>> > +       lpj_fine = riscv_timebase / HZ;
>
> Where is used lpj_fine ?
>
>> > +       clocksource_register_hz(&riscv_clocksource, riscv_timebase);
>> > +       init_clockevent();
>> > +}
>
> I don't have the context, from where is called this function (time_init())?

These should really be in arch/riscv.  I've split it out.

Sorry this was a bit of a mess.  I've gone and split out most of the
arch-specific stuff from the timer, so hopefully it'll be cleaner next time.
I'll submit another patch soon with the cleaned up version.

Thanks for your time!
