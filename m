From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 09/17] clocksource/timer-riscv: New RISC-V Clocksource
Date: Fri, 23 Jun 2017 16:24:03 -0700 (PDT)
Message-ID: <mhng-18b5fd0f-c7ac-4d0a-8ee6-395103eb46df@palmer-si-x1c4>
References: <CAK8P3a2tprg+z5yZ4SySLdWBbqGKSk0SGf4SOejAFB8p6sKPKQ@mail.gmail.com>
Mime-Version: 1.0 (MHng)
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2tprg+z5yZ4SySLdWBbqGKSk0SGf4SOejAFB8p6sKPKQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: geert@linux-m68k.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org, tglx@linutronix.de, daniel.lezcano@linaro.org
List-Id: linux-arch.vger.kernel.org

On Wed, 07 Jun 2017 00:25:37 PDT (-0700), Arnd Bergmann wrote:
> On Wed, Jun 7, 2017 at 9:12 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> CC clocksource folks
>>
>> On Wed, Jun 7, 2017 at 12:59 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>> The RISC-V ISA defines a single RTC as well as an SBI oneshot timer.
>>> This timer is present on all RISC-V systems.
>>>
>>> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>>> ---
>>>  drivers/clocksource/Kconfig       |   8 +++
>>>  drivers/clocksource/Makefile      |   1 +
>>>  drivers/clocksource/timer-riscv.c | 118 ++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 127 insertions(+)
>>>  create mode 100644 drivers/clocksource/timer-riscv.c
>>>
>>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>>> index 545d541ae20e..1c2c6e7c7fab 100644
>>> --- a/drivers/clocksource/Kconfig
>>> +++ b/drivers/clocksource/Kconfig
>>> @@ -612,4 +612,12 @@ config CLKSRC_ST_LPC
>>>           Enable this option to use the Low Power controller timer
>>>           as clocksource.
>>>
>>> +config CLKSRC_RISCV
>>> +       #bool "Clocksource for the RISC-V platform"
>>> +       def_bool y if RISCV
>>> +       depends on RISCV
>
> I don't like the commenting out parts of the entry. If there are no
> build-time dependencies, you can just make it 'default y' and still allow
> users to disabled the driver if they really want to (e.g. on a machine
> specific kernel that has a driver for another clocksource), or you
> just leave it 'def_bool RISCV'.
>
>>> +
>>> +static int riscv_timer_set_oneshot(struct clock_event_device *evt)
>>> +{
>>> +       /* no-op; only one mode */
>>> +       return 0;
>>> +}
>>> +
>>> +static int riscv_timer_set_shutdown(struct clock_event_device *evt)
>>> +{
>>> +       /* can't stop the clock! */
>>> +       return 0;
>>> +}
>
> I'd just leave out the empty callbacks, the callers all protect NULL
> pointers.
>
>>> +static u64 riscv_rdtime(struct clocksource *cs)
>>> +{
>>> +       return get_cycles();
>>> +}
>>> +
>>> +static struct clocksource riscv_clocksource = {
>>> +       .name = "riscv_clocksource",
>>> +       .rating = 300,
>>> +       .read = riscv_rdtime,
>>> +#ifdef CONFIG_64BITS
>>> +       .mask = CLOCKSOURCE_MASK(64),
>>> +#else
>>> +       .mask = CLOCKSOURCE_MASK(32),
>>> +#endif /* CONFIG_64BITS */
>>> +       .flags = CLOCK_SOURCE_IS_CONTINUOUS,
>>> +};
>
>      ".mask = BITS_PER_LONG" maybe?
>
>>> +void riscv_timer_interrupt(void)
>>> +{
>>> +       int cpu = smp_processor_id();
>>> +       struct clock_event_device *evdev = &per_cpu(clock_event, cpu);
>>> +
>>> +       evdev->event_handler(evdev);
>>> +}
>>> +
>>> +void __init init_clockevent(void)
>>> +{
>>> +       int cpu = smp_processor_id();
>>> +       struct clock_event_device *ce = &per_cpu(clock_event, cpu);
>>> +
>>> +       *ce = (struct clock_event_device){
>>> +               .name = "riscv_timer_clockevent",
>>> +               .features = CLOCK_EVT_FEAT_ONESHOT,
>>> +               .rating = 300,
>>> +               .cpumask = cpumask_of(cpu),
>>> +               .set_next_event = riscv_timer_set_next_event,
>>> +               .set_state_oneshot  = riscv_timer_set_oneshot,
>>> +               .set_state_shutdown = riscv_timer_set_shutdown,
>>> +       };
>>> +
>>> +       /* Enable timer interrupts */
>>> +       csr_set(sie, SIE_STIE);
>>> +
>>> +       clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
>>> +}
>>> +
>>> +static unsigned long __init of_timebase(void)
>>> +{
>>> +       struct device_node *cpu;
>>> +       const __be32 *prop;
>>> +
>>> +       cpu = of_find_node_by_path("/cpus");
>>> +       if (cpu) {
>>> +               prop = of_get_property(cpu, "timebase-frequency", NULL);
>>> +               if (prop)
>>> +                       return be32_to_cpu(*prop);
>
> of_property_read_u32()
>
>>> +       }
>>> +
>>> +       return 10000000;
>
> The default seems rather arbitrary. Any reason for this particular
> number? Maybe it's better to fail if the property is missing.

This was just there for compatibility with the systems before we had device
tree up and running, there's no reason for it to be there any more.  I've
changed this to panic instead, as our delay code relies on this clock source
initializing correctly.  I think that's safer than just having a bogus timer.

I've included this and your other CR comments here

  https://github.com/riscv/riscv-linux/commit/4b8dffa13a5d965d1aefe9f5f4fed41b0a4835d7

which I'll include in a v3 patch set.
