From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH v5 1/3] clocksource/drivers/atcpit100: Add andestech
 atcpit100 timer
Date: Wed, 13 Dec 2017 14:06:07 +0800
Message-ID: <CAEbi=3cEEtLQRiv-cyUwEmcBNOC2Sz7AhzZkpznQWYb9VUojug@mail.gmail.com>
References: <1513057621-19084-1-git-send-email-rickchen36@gmail.com>
 <1513057621-19084-2-git-send-email-rickchen36@gmail.com> <bb7383ba-bb8e-3cbd-4ce0-faaefa8ed114@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:45367 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbdLMGGt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Dec 2017 01:06:49 -0500
In-Reply-To: <bb7383ba-bb8e-3cbd-4ce0-faaefa8ed114@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Greentime <greentime@andestech.com>
Cc: Rick Chen <rickchen36@gmail.com>, Rick Chen <rick@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, linux-serial@vger.kernel.org

Hi, Daniel:

2017-12-12 18:05 GMT+08:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
> On 12/12/2017 06:46, Rick Chen wrote:
>> ATCPIT100 is often used on the Andes architecture,
>> This timer provide 4 PIT channels. Each PIT channel is a
>> multi-function timer, can be configured as 32,16,8 bit timers
>> or PWM as well.
>>
>> For system timer it will set channel 1 32-bit timer0 as clock
>> source and count downwards until underflow and restart again.
>
> [ ... ]
>
>> +config CLKSRC_ATCPIT100
>> +     bool "Clocksource for AE3XX platform"
>> +     depends on NDS32 || COMPILE_TEST
>> +     depends on HAS_IOMEM
>> +     help
>> +       This option enables support for the Andestech AE3XX platform timers.
>
> Hi Rick,
>
> the general rule for the Kconfig is:
>
> bool "Clocksource for AE3XX platform" if COMPILE_TEST
>
> and no deps on the platform.
>
> It is up to the platform Kconfig to select the option.
>
> We want here a silent option but make it selectable in case of
> compilation test coverage.


The way we like to use it is because
1. This timer is a basic component to boot an nds32 CPU and it should
be able to select without COMPILE_TEST for nds32 architecture.
2. It seems conflict with debug info. I am not sure if there is
another way to debug kernel(with debug info) with COMPILE_TEST and
DEBUG_INFO because we need this driver for nds32 architecture.

Symbol: DEBUG_INFO [=n]
Type  : boolean
Prompt: Compile the kernel with debug info
  Location:
    -> Kernel hacking
      -> Compile-time checks and compiler options
  Defined at lib/Kconfig.debug:140
  Depends on: DEBUG_KERNEL [=y] && !COMPILE_TEST [=n]


> Also, this driver is not a CLKSRC but a TIMER. Rename CLKSRC_ATCPIT100
> to TIMER_ATCPIT100.

Thanks. We will rename it in the next version patch.

>> +
>>  endmenu
>> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
>> index 72711f1..7d072f5 100644
>> --- a/drivers/clocksource/Makefile
>> +++ b/drivers/clocksource/Makefile
>> @@ -75,3 +75,4 @@ obj-$(CONFIG_H8300_TMR16)           += h8300_timer16.o
>>  obj-$(CONFIG_H8300_TPU)                      += h8300_tpu.o
>>  obj-$(CONFIG_CLKSRC_ST_LPC)          += clksrc_st_lpc.o
>>  obj-$(CONFIG_X86_NUMACHIP)           += numachip.o
>> +obj-$(CONFIG_CLKSRC_ATCPIT100)               += timer-atcpit100.o
>
> [ ... ]
>
>> +static struct timer_of to = {
>> +     .flags = TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE,
>> +
>> +     .clkevt = {
>> +             .name = "atcpit100_tick",
>> +             .rating = 300,
>> +             .features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
>> +             .set_state_shutdown = atcpit100_clkevt_shutdown,
>> +             .set_state_periodic = atcpit100_clkevt_set_periodic,
>> +             .set_state_oneshot = atcpit100_clkevt_set_oneshot,
>> +             .tick_resume = atcpit100_clkevt_shutdown,
>> +             .set_next_event = atcpit100_clkevt_next_event,
>> +             .cpumask = cpu_all_mask,
>
> You may consider CLOCK_EVT_DYN_IRQ
> https://lwn.net/Articles/540160/

Thanks.
We will consider to implement this feature once we support SMP or our
CPU has local timer.

>> +     },
>> +
>> +     .of_irq = {
>> +             .handler = atcpit100_timer_interrupt,
>> +             .flags = IRQF_TIMER | IRQF_IRQPOLL,
>> +     },
>> +
>> +     /*
>> +      * FIXME: we currently only support clocking using PCLK
>> +      * and using EXTCLK is not supported in the driver.
>> +      */
>> +     .of_clk = {
>> +             .name = "PCLK",
>> +     }
>
> What do you mean ? We can't specify several clock names with timer-of?

It means we currently support PCLK only.
https://lkml.org/lkml/2017/12/1/316

Thanks.
