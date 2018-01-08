From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 1/3] clocksource/drivers/atcpit100: Add andestech
 atcpit100 timer
Date: Mon, 8 Jan 2018 17:30:11 +0100
Message-ID: <CAK8P3a3opvfT2TfBuPgg65EtjzTBM0kL1TheDc4LZe-RHKiumw@mail.gmail.com>
References: <1513057621-19084-1-git-send-email-rickchen36@gmail.com>
 <1513057621-19084-2-git-send-email-rickchen36@gmail.com> <bb7383ba-bb8e-3cbd-4ce0-faaefa8ed114@linaro.org>
 <CAEbi=3cEEtLQRiv-cyUwEmcBNOC2Sz7AhzZkpznQWYb9VUojug@mail.gmail.com>
 <ff51fff7-e963-f9fd-10d6-9b90a64d7aac@linaro.org> <CAEbi=3c4yAx7Tejz8aPw3-3vj89t8cg-zNEY-vbF7KaMo8OM0Q@mail.gmail.com>
 <efdb249a-8dc0-e076-a1db-20cecdbf4c13@linaro.org> <CAEbi=3frQYZHb0yiMvNk_JUiUCy6ca0tbrsM_pt49LtkMy47mw@mail.gmail.com>
 <1e75edb3-8f7b-796c-6871-1612b027050e@linaro.org> <CAK8P3a2NVj_M5eHT92fJYNBG3x9juVnHW6uV32p3-ytfqjARxg@mail.gmail.com>
 <78dc7813-524d-c108-0e3d-516f8f4dabfe@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <78dc7813-524d-c108-0e3d-516f8f4dabfe@linaro.org>
Sender: netdev-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Greentime Hu <green.hu@gmail.com>, Greentime <greentime@andestech.com>, Rick Chen <rickchen36@gmail.com>, Rick Chen <rick@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, linux-serial@vger.kernel.org, John Stultz <john.stultz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 8, 2018 at 5:08 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 08/01/2018 16:26, Arnd Bergmann wrote:
>> On Fri, Jan 5, 2018 at 10:31 AM, Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:

>>>
>>> etc ...
>>
>> I'd actually prefer to not do it for ARM either: Most other subsystems
>> don't do that, and I don't see a strong reason why clocksource should
>> be special here.
>
> The majority doing the opposite does not mean it is right.
>
> Do you know which clock belongs to which board ? Who will unselect a
> clock ? I'm pretty sure nobody. Everyone relies on the platform Kconfig
> and expect it to select the right drivers.

The point is that there is no platform specific Kconfig that could select
it, as the concept doesn't make a lot of sense here.

If you require the driver to always be selected by the
architecture code, it adds a little bit of bloat on systems
that don't need it. This is possible, but I think it's preferable
to give users a way of tuning a kernel for a particular chip.

> We don't expect the hackers to have a deep knowledge of the hardware and
> the driver dependencies. It is very convenient to not care about that
> and let the platform's Kconfig to select the right drivers.
>
> And that is the behavior I would like to keep.

I'm not worried about the driver bloating the kernel here when it
isn't disabled, this is no different from enabling the USB controller
by default for a board that doesn't have a USB connector, or
enabling ten different pinctrl drivers for all members of a chip
family even though you know which particular chip you are
running on.

>> Selecting 'TIMER_OF' from the individual drivers that need it (as you
>> suggest) makes sense, but I think for ARM we treat SoC families
>> as a bit too special, in the end they are for the most part collections
>> of individual hardware blocks that may or may not be present on
>> some chip.
>>
>> In case of risc-v and nds32, I expect that the separation will be
>> even less visibile in the hardware, as a typical model here is
>> that one company designs SoCs for multiple customers that each
>> have different requirements. Some of them may have one
>> timer and some have another timer or multiple timers, but there
>> is no strict separation between SoC families as I understand.
>> Here we'd be better off not having a per-SoC Kconfig option at
>> all, just a generic defconfig that enables all the drivers that might
>> be used, and integrators can have a defconfig file that only
>> enables the stuff they actually use on a given chip.
>
> Yes, the result is the same, the option is not showed in the menu.
>
> However, I can understand it could be interesting to have the ability to
> unselect a driver for experts.
>
> I'm wondering if we can create a bool_expert which shows up only when
> CONFIG_EXPERT is set.

Having a dependency on CONFIG_EXPERT means that a more
users will end up having to set that for a shipping system. It's
something we can do (even without a special Kconfig keyword),
but it should be used carefully for stuff that 99% of the users want
to enable.

Why not just:

config CLKSRC_ATCPIT100
       bool "Clocksource for AE3XX platform"
       depends on NDS32 || COMPILE_TEST
       depends on HAS_IOMEM
       default NDS32
       help
         This option enables support for the Andestech AE3XX platform timers.

That way, it's simply enabled on NDS32 by default, but just as easy
to disable for systems that don't need it.

      Arnd
