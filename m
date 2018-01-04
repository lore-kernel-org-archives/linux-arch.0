From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v5 1/3] clocksource/drivers/atcpit100: Add andestech
 atcpit100 timer
Date: Thu, 4 Jan 2018 20:48:27 +0100
Message-ID: <efdb249a-8dc0-e076-a1db-20cecdbf4c13@linaro.org>
References: <1513057621-19084-1-git-send-email-rickchen36@gmail.com>
 <1513057621-19084-2-git-send-email-rickchen36@gmail.com>
 <bb7383ba-bb8e-3cbd-4ce0-faaefa8ed114@linaro.org>
 <CAEbi=3cEEtLQRiv-cyUwEmcBNOC2Sz7AhzZkpznQWYb9VUojug@mail.gmail.com>
 <ff51fff7-e963-f9fd-10d6-9b90a64d7aac@linaro.org>
 <CAEbi=3c4yAx7Tejz8aPw3-3vj89t8cg-zNEY-vbF7KaMo8OM0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAEbi=3c4yAx7Tejz8aPw3-3vj89t8cg-zNEY-vbF7KaMo8OM0Q@mail.gmail.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Rick Chen <rickchen36@gmail.com>, Rick Chen <rick@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, linux-serial@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 04/01/2018 15:06, Greentime Hu wrote:
> Hi, Daniel:
> 
> 2018-01-04 21:50 GMT+08:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
>>
>> Hi,
>>
>> sorry I missed your answer. Comments below.
>>
>> On 13/12/2017 07:06, Greentime Hu wrote:
>>> Hi, Daniel:
>>>
>>> 2017-12-12 18:05 GMT+08:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
>>>> On 12/12/2017 06:46, Rick Chen wrote:
>>>>> ATCPIT100 is often used on the Andes architecture,
>>>>> This timer provide 4 PIT channels. Each PIT channel is a
>>>>> multi-function timer, can be configured as 32,16,8 bit timers
>>>>> or PWM as well.
>>>>>
>>>>> For system timer it will set channel 1 32-bit timer0 as clock
>>>>> source and count downwards until underflow and restart again.
>>>>
>>>> [ ... ]
>>>>
>>>>> +config CLKSRC_ATCPIT100
>>>>> +     bool "Clocksource for AE3XX platform"
>>>>> +     depends on NDS32 || COMPILE_TEST
>>>>> +     depends on HAS_IOMEM
>>>>> +     help
>>>>> +       This option enables support for the Andestech AE3XX platform timers.
>>>>
>>>> Hi Rick,
>>>>
>>>> the general rule for the Kconfig is:
>>>>
>>>> bool "Clocksource for AE3XX platform" if COMPILE_TEST

BTW, select TIMER_OF is missing.

>>>> and no deps on the platform.
>>>>
>>>> It is up to the platform Kconfig to select the option.
>>>>
>>>> We want here a silent option but make it selectable in case of
>>>> compilation test coverage.
>>>
>>>
>>> The way we like to use it is because
>>> 1. This timer is a basic component to boot an nds32 CPU and it should
>>> be able to select without COMPILE_TEST for nds32 architecture.
>>
>> Yes, so you don't need it to be selectable, you must select it from the
>> platform's Kconfig.
> 
> I am not sure that I get your point or not.
> We don't have a CONFIG_PLAT_AE3XX.
> Do you mean we should create one and select CLKSRC_ATCPIT100 under
> CONFIG_PLAT_AE3XX?

No. Can't you add in arch/ndis32/Kconfig ?

+select TIMER_ATCPIT100

Like:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/Kconfig#n50


>>> 2. It seems conflict with debug info. I am not sure if there is
>>> another way to debug kernel(with debug info) with COMPILE_TEST and
>>> DEBUG_INFO because we need this driver for nds32 architecture.
>>>
>>> Symbol: DEBUG_INFO [=n]
>>> Type  : boolean
>>> Prompt: Compile the kernel with debug info
>>>   Location:
>>>     -> Kernel hacking
>>>       -> Compile-time checks and compiler options
>>>   Defined at lib/Kconfig.debug:140
>>>   Depends on: DEBUG_KERNEL [=y] && !COMPILE_TEST [=n]
>>
>> The COMPILE_TEST option is only there to allow cross-compilation test
>> coverage, it does not select or unselect the driver in usual way.
>>
>> If the COMPILE_TEST is enabled, then the option will appear in the
>> menuconfig, so that gives the opportunity to select/unselect it.
>>
>> Otherwise, the Kconfig's platform selects automatically the driver and
>> the user *can't* unselect it from the menuconfig as it is a silent
>> option and that is certainly what you want.
>>
>>>> Also, this driver is not a CLKSRC but a TIMER. Rename CLKSRC_ATCPIT100
>>>> to TIMER_ATCPIT100.
>>>
>>> Thanks. We will rename it in the next version patch.
>>
>> You just resend an entire series V5 for the architecture. I'm confused,
>> what is the merging path ?
> 
> Sorry. I didn't get your point.
> We sent the timer patch and the architecture patch together because it
> would be easier for reviewer to check the vdso implementations.
> What do you mean about the merging path?

I received a [Vx y/3] series and I received a [Vx y/39].

The former from Rick Chen means to me "please pick them through your tree".

The latter from you means to me "can you ack the patches so I can merge
them through my tree". Note you will have to resend the entire arch
series for every single review/comment (that could end up upset the
Cc'ed people).

Which one should I review ? I can not track different patchset
implementing the same thing. Which one should I comment, review ? Are
the comments I did on [Vx y/3] taken into account in the arch series ?
etc ...

Please clarify, it is confusing and impossible to review in this situation.

I suggest we stick to the x/3 series, so I can comment it and you can
resend a new version without resending the entire arch series. So I can
merge it through my tree, and you get it via eg. a shared immutable
branch. The arch series will be reduced by 3 patches.

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
