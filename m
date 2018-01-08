From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v5 1/3] clocksource/drivers/atcpit100: Add andestech
 atcpit100 timer
Date: Mon, 8 Jan 2018 17:08:50 +0100
Message-ID: <78dc7813-524d-c108-0e3d-516f8f4dabfe@linaro.org>
References: <1513057621-19084-1-git-send-email-rickchen36@gmail.com>
 <1513057621-19084-2-git-send-email-rickchen36@gmail.com>
 <bb7383ba-bb8e-3cbd-4ce0-faaefa8ed114@linaro.org>
 <CAEbi=3cEEtLQRiv-cyUwEmcBNOC2Sz7AhzZkpznQWYb9VUojug@mail.gmail.com>
 <ff51fff7-e963-f9fd-10d6-9b90a64d7aac@linaro.org>
 <CAEbi=3c4yAx7Tejz8aPw3-3vj89t8cg-zNEY-vbF7KaMo8OM0Q@mail.gmail.com>
 <efdb249a-8dc0-e076-a1db-20cecdbf4c13@linaro.org>
 <CAEbi=3frQYZHb0yiMvNk_JUiUCy6ca0tbrsM_pt49LtkMy47mw@mail.gmail.com>
 <1e75edb3-8f7b-796c-6871-1612b027050e@linaro.org>
 <CAK8P3a2NVj_M5eHT92fJYNBG3x9juVnHW6uV32p3-ytfqjARxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2NVj_M5eHT92fJYNBG3x9juVnHW6uV32p3-ytfqjARxg@mail.gmail.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime Hu <green.hu@gmail.com>, Greentime <greentime@andestech.com>, Rick Chen <rickchen36@gmail.com>, Rick Chen <rick@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, linux-serial@vger.kernel.org, John Stultz <john.stultz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On 08/01/2018 16:26, Arnd Bergmann wrote:
> On Fri, Jan 5, 2018 at 10:31 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>>> No. Can't you add in arch/ndis32/Kconfig ?
>>>>
>>>> +select TIMER_ATCPIT100
>>>>
>>>> Like:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/Kconfig#n50
>>>
>>> IMHO, it might be a little bit wierd if we select TIMER_ATCPIT100 in
>>> arch/nds32/Kconfig because it is part of SoC instead of CPU.
>>> If we change to another SoC with another timer, we need to select
>>> another TIMER in arch/nds32/Kconfig and delete TIMER_ATCPIT100.
>>> It seems more flexible to be selected in driver layer.
>>>
>>> It seems to be the timer is part of the arch to be selected in arch's Kconfig.
>>> arch/arc/Kconfig:       select ARC_TIMERS
>>> arch/arc/Kconfig:       select ARC_TIMERS_64BIT
>>> arch/arm/Kconfig:       select ARM_ARCH_TIMER
>>> arch/arm64/Kconfig:     select ARM_ARCH_TIMER
>>> arch/blackfin/Kconfig:  select BFIN_GPTIMERS
>>
>> No, the timer must be selected from the arch/soc's or whatever Kconfig.
>> Not in the clocksource's Kconfig.
>>
>> eg.
>>
>> on ARM:
>>
>> arch/arm/mach-vt8500/Kconfig:   select VT8500_TIMER
>> arch/arm/mach-bcm/Kconfig:      select BCM_KONA_TIMER
>> arch/arm/mach-actions/Kconfig:  select OWL_TIMER
>> arch/arm/mach-digicolor/Kconfig:        select DIGICOLOR_TIMER
>>
>> etc ...
>>
>> on ARM64:
>>
>> arch/arm64/Kconfig.platforms:   select OWL_TIMER
>> arch/arm64/Kconfig.platforms:       select ARM_TIMER_SP804
>> arch/arm64/Kconfig.platforms:       select MTK_TIMER
>>
>> etc ...
> 
> I'd actually prefer to not do it for ARM either: Most other subsystems
> don't do that, and I don't see a strong reason why clocksource should
> be special here.

The majority doing the opposite does not mean it is right.

Do you know which clock belongs to which board ? Who will unselect a
clock ? I'm pretty sure nobody. Everyone relies on the platform Kconfig
and expect it to select the right drivers.

We don't expect the hackers to have a deep knowledge of the hardware and
the driver dependencies. It is very convenient to not care about that
and let the platform's Kconfig to select the right drivers.

And that is the behavior I would like to keep.

> Selecting 'TIMER_OF' from the individual drivers that need it (as you
> suggest) makes sense, but I think for ARM we treat SoC families
> as a bit too special, in the end they are for the most part collections
> of individual hardware blocks that may or may not be present on
> some chip.
> 
> In case of risc-v and nds32, I expect that the separation will be
> even less visibile in the hardware, as a typical model here is
> that one company designs SoCs for multiple customers that each
> have different requirements. Some of them may have one
> timer and some have another timer or multiple timers, but there
> is no strict separation between SoC families as I understand.
> Here we'd be better off not having a per-SoC Kconfig option at
> all, just a generic defconfig that enables all the drivers that might
> be used, and integrators can have a defconfig file that only
> enables the stuff they actually use on a given chip.

Yes, the result is the same, the option is not showed in the menu.

However, I can understand it could be interesting to have the ability to
unselect a driver for experts.

I'm wondering if we can create a bool_expert which shows up only when
CONFIG_EXPERT is set.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
