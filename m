From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v5 1/3] clocksource/drivers/atcpit100: Add andestech
 atcpit100 timer
Date: Fri, 5 Jan 2018 10:31:32 +0100
Message-ID: <1e75edb3-8f7b-796c-6871-1612b027050e@linaro.org>
References: <1513057621-19084-1-git-send-email-rickchen36@gmail.com>
 <1513057621-19084-2-git-send-email-rickchen36@gmail.com>
 <bb7383ba-bb8e-3cbd-4ce0-faaefa8ed114@linaro.org>
 <CAEbi=3cEEtLQRiv-cyUwEmcBNOC2Sz7AhzZkpznQWYb9VUojug@mail.gmail.com>
 <ff51fff7-e963-f9fd-10d6-9b90a64d7aac@linaro.org>
 <CAEbi=3c4yAx7Tejz8aPw3-3vj89t8cg-zNEY-vbF7KaMo8OM0Q@mail.gmail.com>
 <efdb249a-8dc0-e076-a1db-20cecdbf4c13@linaro.org>
 <CAEbi=3frQYZHb0yiMvNk_JUiUCy6ca0tbrsM_pt49LtkMy47mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAEbi=3frQYZHb0yiMvNk_JUiUCy6ca0tbrsM_pt49LtkMy47mw@mail.gmail.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Rick Chen <rickchen36@gmail.com>, Rick Chen <rick@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, linux-serial@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 05/01/2018 09:45, Greentime Hu wrote:
> Hi, Daniel:

[ ... ]

>>>>>> [ ... ]
>>>>>>
>>>>>>> +config CLKSRC_ATCPIT100
>>>>>>> +     bool "Clocksource for AE3XX platform"
>>>>>>> +     depends on NDS32 || COMPILE_TEST
>>>>>>> +     depends on HAS_IOMEM
>>>>>>> +     help
>>>>>>> +       This option enables support for the Andestech AE3XX platform timers.
>>>>>>
>>>>>> Hi Rick,
>>>>>>
>>>>>> the general rule for the Kconfig is:
>>>>>>
>>>>>> bool "Clocksource for AE3XX platform" if COMPILE_TEST
>>
>> BTW, select TIMER_OF is missing.
> 
> We don't select here because we select TIMER_OF in arch/nds32/Kconfig
> I am not sure if I still need to select TIMER_OF here?

Actually, I want the drivers/clocksource/Kconfig to be consistent across
all entries. As TIMER_OF is needed by the driver and nothing else, it
must be selected in the TIMER entry.

As there are a lot of timers and we do the changes little by little,
there are still entries with different format.

It should be something like that:

config ASM9260_TIMER
        bool "ASM9260 timer driver" if COMPILE_TEST
        select CLKSRC_MMIO
        select TIMER_OF
        help
          Enables support for the ASM9260 timer.

Move the select TIMER_OF to the timer option entry.

>>>>>> and no deps on the platform.
>>>>>>
>>>>>> It is up to the platform Kconfig to select the option.
>>>>>>
>>>>>> We want here a silent option but make it selectable in case of
>>>>>> compilation test coverage.
>>>>>
>>>>>
>>>>> The way we like to use it is because
>>>>> 1. This timer is a basic component to boot an nds32 CPU and it should
>>>>> be able to select without COMPILE_TEST for nds32 architecture.
>>>>
>>>> Yes, so you don't need it to be selectable, you must select it from the
>>>> platform's Kconfig.
>>>
>>> I am not sure that I get your point or not.
>>> We don't have a CONFIG_PLAT_AE3XX.
>>> Do you mean we should create one and select CLKSRC_ATCPIT100 under
>>> CONFIG_PLAT_AE3XX?
>>
>> No. Can't you add in arch/ndis32/Kconfig ?
>>
>> +select TIMER_ATCPIT100
>>
>> Like:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/Kconfig#n50
> 
> IMHO, it might be a little bit wierd if we select TIMER_ATCPIT100 in
> arch/nds32/Kconfig because it is part of SoC instead of CPU.
> If we change to another SoC with another timer, we need to select
> another TIMER in arch/nds32/Kconfig and delete TIMER_ATCPIT100.
> It seems more flexible to be selected in driver layer.
> 
> It seems to be the timer is part of the arch to be selected in arch's Kconfig.
> arch/arc/Kconfig:       select ARC_TIMERS
> arch/arc/Kconfig:       select ARC_TIMERS_64BIT
> arch/arm/Kconfig:       select ARM_ARCH_TIMER
> arch/arm64/Kconfig:     select ARM_ARCH_TIMER
> arch/blackfin/Kconfig:  select BFIN_GPTIMERS

No, the timer must be selected from the arch/soc's or whatever Kconfig.
Not in the clocksource's Kconfig.

eg.

on ARM:

arch/arm/mach-vt8500/Kconfig:   select VT8500_TIMER
arch/arm/mach-bcm/Kconfig:      select BCM_KONA_TIMER
arch/arm/mach-actions/Kconfig:  select OWL_TIMER
arch/arm/mach-digicolor/Kconfig:        select DIGICOLOR_TIMER

etc ...

on ARM64:

arch/arm64/Kconfig.platforms:   select OWL_TIMER
arch/arm64/Kconfig.platforms:       select ARM_TIMER_SP804
arch/arm64/Kconfig.platforms:       select MTK_TIMER

etc ...

Thanks.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
