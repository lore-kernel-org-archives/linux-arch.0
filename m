From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH v2 25/35] nds32: Build infrastructure
Date: Wed, 29 Nov 2017 22:10:47 +0800
Message-ID: <CAEbi=3fmXP=n_tS+-TSFhdht2G=VHOzVCVU=SRy4A6Ym_GToUQ@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <5e1be9ebc591c6de79b75f726a5a38b2564eaa92.1511785528.git.green.hu@gmail.com>
 <CAK8P3a1GuH2tgtC5t834-PNeUVYQxreD7seZH8sjraZFtRUWKw@mail.gmail.com>
 <CAEbi=3c=hTCcUOPs+Fc10srzTFsB4MnVxgcFydz12-jH0ZXjog@mail.gmail.com>
 <CAK8P3a0kvt52UTtEmE+tWHZuH_rmgTxP7+CiD9Ddwe2cJLwXTQ@mail.gmail.com>
 <CAMuHMdViO=+-kGdXFPSW+9PsPbf3sUa5xdaJ_1C-cX2vE1G35Q@mail.gmail.com>
 <CAK8P3a3yk7ww+LdQdL+wgz2wYrzXLSsj1PTdfK-qx013jdg4SQ@mail.gmail.com>
 <CAEbi=3cc8e__DnFKmTSMm9xQMx7CGu+1v3e55w8UekwnTTkw5Q@mail.gmail.com> <CAK8P3a2d2_jxXehE3xP_G9Tzp6jP4hFmS4CJkh=6bePLEDcdGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2d2_jxXehE3xP_G9Tzp6jP4hFmS4CJkh=6bePLEDcdGw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

2017-11-29 19:57 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Wed, Nov 29, 2017 at 12:39 PM, Greentime Hu <green.hu@gmail.com> wrote:
>> 2017-11-29 17:25 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Wed, Nov 29, 2017 at 10:10 AM, Geert Uytterhoeven
>>> <geert@linux-m68k.org> wrote:
>>>> Hi Arnd,
>>>>
>>>> On Wed, Nov 29, 2017 at 9:58 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>>> On Wed, Nov 29, 2017 at 9:39 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>>>>> 2017-11-27 22:21 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>>>>>> On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu@gmail.com> wrote:
>>>>>>>> diff --git a/arch/nds32/Kconfig.cpu b/arch/nds32/Kconfig.cpu
>>>>>>>> +config CPU_CACHE_NONALIASING
>>>>>>>> +       bool "Non-aliasing cache"
>>>>>>>> +       help
>>>>>>>> +         If this CPU is using VIPT data cache and its cache way size is larger
>>>>>>>> +         than page size, say N. If it is using PIPT data cache, say Y.
>>>>>>>> +
>>>>>>>> +         If unsure, say Y.
>>>>>>>
>>>>>>> Can you determine this from the CPU type?
>>>>>>
>>>>>> There is no cpu register to determine it. It also depeneds on page
>>>>>> size and way size however page size is configurable by software.
>>>>>> These codes are determined at compile time will be benefit to code
>>>>>> size and performance.
>>>>>> IMHO, I think it would be better to be determined here.
>>>>>
>>>>> I meant determining it at compile time from other Kconfig symbols,
>>>>> if that's possible. Do the CPU cores each have a fixed way-size?
>>>>> If they do, it could be done like
>>>>>
>>>>> menu "CPU selection"
>>>>>
>>>>> config CPU_N15
>>>>>       bool "AndesCore N15"
>>>>>       select CPU_CACHE_NONALIASING
>>>>>
>>>>> config CPU_N13
>>>>>       bool "AndesCore N15"
>>>>>       select CPU_CACHE_NONALIASING if PAGE_SIZE_16K
>>>>>
>>>>> ...
>>>>>
>>>>> endmenu
>>>>>
>>>>> and then you can use the same CPU_... symbols to make other decisions
>>>>> as well, e.g. CPU specific compiler optimizations.
>>>>
>>>> Do you want to support multiple CPU types in a single kernel image
>>>> (I see no "choice" statement above)?
>>>> If yes, you may have a mix of aliasing and non-aliasing caches, so
>>>> you may want to invert the logic, and select CPU_CACHE_ALIASING
>>>> instead.
>>>
>>> Right, my mistake.
>>>
>>
>> Thanks to Arnd and Geert!
>>
>> How about this?
>>
>> choice
>>         prompt "CPU type"
>>         default CPU_N13
>> config CPU_N15
>>         bool "AndesCore N15"
>>         select CPU_CACHE_NONALIASING
>> config CPU_N13
>>         bool "AndesCore N13"
>>         select CPU_CACHE_NONALIASING if ANDES_PAGE_SIZE_8KB
>> config CPU_N10
>>         bool "AndesCore N10"
>>         select CPU_CACHE_NONALIASING if ANDES_PAGE_SIZE_8KB
>> config CPU_D15
>>         bool "AndesCore D15"
>>         select CPU_CACHE_NONALIASING
>>         select HWZOL
>> config CPU_D10
>>         bool "AndesCore D10"
>>         select CPU_CACHE_NONALIASING if ANDES_PAGE_SIZE_8KB
>> endchoice
>
> With a 'choice' statement this works, but I would consider that
> suboptimal for another reason: now you cannot build a kernel that
> works on e.g. both N13 and N15.
>
> This is what we had on ARM a long time ago and on MIPS not so long
> ago, but it's really a burden for testing and distribution once you get
> support for more than a handful of machines supported in the mainline
> kernel: If each CPU core is mutually incompatible with the other ones,
> this means you likely end up having one defconfig per CPU core,
> or even one defconfig per SoC or board.
>
> I would always try to get the largest amount of hardware to work
> in the same kernel concurrently.
>
> One way of of this would be to define the "CPU type" as the minimum
> supported CPU, e.g. selecting D15 would result in a kernel that
> only works on D15, while selecting N15 would work on both N15 and
> D15, and selecting D10 would work on both D10 and D15.
>

Hi, Arnd:

Maybe we should keep the original implementation for this reason.
The default value of CPU_CACHE_NONALIASING and ANDES_PAGE_SIZE_8KB is
available for all CPU types for now.
User can use these configs built kernel to boot on almost all nds32 CPUs.

It might be a little bit weird if we config CPU_N10 but run on a N13 CPU.
This might confuse our users.
