From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 09/17] clocksource/timer-riscv: New RISC-V Clocksource
Date: Wed, 7 Jun 2017 09:25:37 +0200
Message-ID: <CAK8P3a2tprg+z5yZ4SySLdWBbqGKSk0SGf4SOejAFB8p6sKPKQ@mail.gmail.com>
References: <20170523004107.536-1-palmer@dabbelt.com> <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-10-palmer@dabbelt.com> <CAMuHMdXkO-r1kVow-PqyRNYy32Eq5jr9fn75neFcMWhDUvGCPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:32968 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbdFGHZi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jun 2017 03:25:38 -0400
In-Reply-To: <CAMuHMdXkO-r1kVow-PqyRNYy32Eq5jr9fn75neFcMWhDUvGCPA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Wed, Jun 7, 2017 at 9:12 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> CC clocksource folks
>
> On Wed, Jun 7, 2017 at 12:59 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> The RISC-V ISA defines a single RTC as well as an SBI oneshot timer.
>> This timer is present on all RISC-V systems.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>> ---
>>  drivers/clocksource/Kconfig       |   8 +++
>>  drivers/clocksource/Makefile      |   1 +
>>  drivers/clocksource/timer-riscv.c | 118 ++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 127 insertions(+)
>>  create mode 100644 drivers/clocksource/timer-riscv.c
>>
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index 545d541ae20e..1c2c6e7c7fab 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -612,4 +612,12 @@ config CLKSRC_ST_LPC
>>           Enable this option to use the Low Power controller timer
>>           as clocksource.
>>
>> +config CLKSRC_RISCV
>> +       #bool "Clocksource for the RISC-V platform"
>> +       def_bool y if RISCV
>> +       depends on RISCV

I don't like the commenting out parts of the entry. If there are no
build-time dependencies, you can just make it 'default y' and still allow
users to disabled the driver if they really want to (e.g. on a machine
specific kernel that has a driver for another clocksource), or you
just leave it 'def_bool RISCV'.

>> +
>> +static int riscv_timer_set_oneshot(struct clock_event_device *evt)
>> +{
>> +       /* no-op; only one mode */
>> +       return 0;
>> +}
>> +
>> +static int riscv_timer_set_shutdown(struct clock_event_device *evt)
>> +{
>> +       /* can't stop the clock! */
>> +       return 0;
>> +}

I'd just leave out the empty callbacks, the callers all protect NULL
pointers.

>> +static u64 riscv_rdtime(struct clocksource *cs)
>> +{
>> +       return get_cycles();
>> +}
>> +
>> +static struct clocksource riscv_clocksource = {
>> +       .name = "riscv_clocksource",
>> +       .rating = 300,
>> +       .read = riscv_rdtime,
>> +#ifdef CONFIG_64BITS
>> +       .mask = CLOCKSOURCE_MASK(64),
>> +#else
>> +       .mask = CLOCKSOURCE_MASK(32),
>> +#endif /* CONFIG_64BITS */
>> +       .flags = CLOCK_SOURCE_IS_CONTINUOUS,
>> +};

     ".mask = BITS_PER_LONG" maybe?

>> +void riscv_timer_interrupt(void)
>> +{
>> +       int cpu = smp_processor_id();
>> +       struct clock_event_device *evdev = &per_cpu(clock_event, cpu);
>> +
>> +       evdev->event_handler(evdev);
>> +}
>> +
>> +void __init init_clockevent(void)
>> +{
>> +       int cpu = smp_processor_id();
>> +       struct clock_event_device *ce = &per_cpu(clock_event, cpu);
>> +
>> +       *ce = (struct clock_event_device){
>> +               .name = "riscv_timer_clockevent",
>> +               .features = CLOCK_EVT_FEAT_ONESHOT,
>> +               .rating = 300,
>> +               .cpumask = cpumask_of(cpu),
>> +               .set_next_event = riscv_timer_set_next_event,
>> +               .set_state_oneshot  = riscv_timer_set_oneshot,
>> +               .set_state_shutdown = riscv_timer_set_shutdown,
>> +       };
>> +
>> +       /* Enable timer interrupts */
>> +       csr_set(sie, SIE_STIE);
>> +
>> +       clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
>> +}
>> +
>> +static unsigned long __init of_timebase(void)
>> +{
>> +       struct device_node *cpu;
>> +       const __be32 *prop;
>> +
>> +       cpu = of_find_node_by_path("/cpus");
>> +       if (cpu) {
>> +               prop = of_get_property(cpu, "timebase-frequency", NULL);
>> +               if (prop)
>> +                       return be32_to_cpu(*prop);

of_property_read_u32()

>> +       }
>> +
>> +       return 10000000;

The default seems rather arbitrary. Any reason for this particular
number? Maybe it's better to fail if the property is missing.

       Arnd
