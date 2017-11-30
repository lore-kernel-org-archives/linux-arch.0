From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH v2 25/35] nds32: Build infrastructure
Date: Thu, 30 Nov 2017 13:48:05 +0800
Message-ID: <CAEbi=3cTkbt9i7XPXMnY1D6qtbebDW1x8sFVsgqhq-nApAx5mA@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <5e1be9ebc591c6de79b75f726a5a38b2564eaa92.1511785528.git.green.hu@gmail.com>
 <CAK8P3a1GuH2tgtC5t834-PNeUVYQxreD7seZH8sjraZFtRUWKw@mail.gmail.com>
 <CAEbi=3c=hTCcUOPs+Fc10srzTFsB4MnVxgcFydz12-jH0ZXjog@mail.gmail.com>
 <CAK8P3a0kvt52UTtEmE+tWHZuH_rmgTxP7+CiD9Ddwe2cJLwXTQ@mail.gmail.com>
 <CAMuHMdViO=+-kGdXFPSW+9PsPbf3sUa5xdaJ_1C-cX2vE1G35Q@mail.gmail.com>
 <CAK8P3a3yk7ww+LdQdL+wgz2wYrzXLSsj1PTdfK-qx013jdg4SQ@mail.gmail.com>
 <CAEbi=3cc8e__DnFKmTSMm9xQMx7CGu+1v3e55w8UekwnTTkw5Q@mail.gmail.com>
 <CAK8P3a2d2_jxXehE3xP_G9Tzp6jP4hFmS4CJkh=6bePLEDcdGw@mail.gmail.com>
 <CAEbi=3fmXP=n_tS+-TSFhdht2G=VHOzVCVU=SRy4A6Ym_GToUQ@mail.gmail.com> <CAK8P3a3-CexhRkJB7_8TGShuDQP8w=myhkoB8-7ax3my96PrMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:46378 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbdK3Fsq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Nov 2017 00:48:46 -0500
In-Reply-To: <CAK8P3a3-CexhRkJB7_8TGShuDQP8w=myhkoB8-7ax3my96PrMw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>

2017-11-30 4:27 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Wed, Nov 29, 2017 at 3:10 PM, Greentime Hu <green.hu@gmail.com> wrote:
>> 2017-11-29 19:57 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Wed, Nov 29, 2017 at 12:39 PM, Greentime Hu <green.hu@gmail.com> wrote:
>>>>
>>>> How about this?
>>>>
>>>> choice
>>>>         prompt "CPU type"
>>>>         default CPU_N13
>>>> config CPU_N15
>>>>         bool "AndesCore N15"
>>>>         select CPU_CACHE_NONALIASING
>>>> config CPU_N13
>>>>         bool "AndesCore N13"
>>>>         select CPU_CACHE_NONALIASING if ANDES_PAGE_SIZE_8KB
>>>> config CPU_N10
>>>>         bool "AndesCore N10"
>>>>         select CPU_CACHE_NONALIASING if ANDES_PAGE_SIZE_8KB
>>>> config CPU_D15
>>>>         bool "AndesCore D15"
>>>>         select CPU_CACHE_NONALIASING
>>>>         select HWZOL
>>>> config CPU_D10
>>>>         bool "AndesCore D10"
>>>>         select CPU_CACHE_NONALIASING if ANDES_PAGE_SIZE_8KB
>>>> endchoice
>>>
>>> With a 'choice' statement this works, but I would consider that
>>> suboptimal for another reason: now you cannot build a kernel that
>>> works on e.g. both N13 and N15.
>>>
>>> This is what we had on ARM a long time ago and on MIPS not so long
>>> ago, but it's really a burden for testing and distribution once you get
>>> support for more than a handful of machines supported in the mainline
>>> kernel: If each CPU core is mutually incompatible with the other ones,
>>> this means you likely end up having one defconfig per CPU core,
>>> or even one defconfig per SoC or board.
>>>
>>> I would always try to get the largest amount of hardware to work
>>> in the same kernel concurrently.
>>>
>>> One way of of this would be to define the "CPU type" as the minimum
>>> supported CPU, e.g. selecting D15 would result in a kernel that
>>> only works on D15, while selecting N15 would work on both N15 and
>>> D15, and selecting D10 would work on both D10 and D15.
>>>
>>
>> Hi, Arnd:
>>
>> Maybe we should keep the original implementation for this reason.
>> The default value of CPU_CACHE_NONALIASING and ANDES_PAGE_SIZE_8KB is
>> available for all CPU types for now.
>> User can use these configs built kernel to boot on almost all nds32 CPUs.
>>
>> It might be a little bit weird if we config CPU_N10 but run on a N13 CPU.
>> This might confuse our users.
>
> I think it really depends on how much flexibility you want to give to users.
> The way I suggested first was to allow selecting an arbitrary combination
> of CPUs, and then let Kconfig derive the correct set of optimization flags
> and other options that work with those. That is probably the easiest for
> the users, but can be tricky to get right for all combinations.
>
> When you put them in a sorted list like I mentioned for simplicity, you
> could reduce the confusion by naming them differently, e.g.
> CONFIG_CPU_N10_OR_NEWER.
>
> Having only the CPU_CACHE_NONALIASING option is fine if you
> never need to make any other decisions based on the CPU core
> type, but then the help text should describe specifically which cases
> are affected (N10/N13/D13 with 4K page size), and you can decide to
> hide the option and make it always-on when using 8K page size.
>
>        Arnd


Hi, Arnd:

I think I can use this name "CPU_V3" for all nds32 v3 compatible cpu.
It will be implemented like this.

config HWZOL
        bool "hardware zero overhead loop support"
        depends on CPU_D10 || CPU_D15
        default n
        help
          A set of Zero-Overhead Loop mechanism is provided to reduce the
          instruction fetch and execution overhead of loop-control instructions.
          It will save 3 registers($LB, $LC, $LE) for context saving if say Y.
          You don't need to save these registers if you can make sure your user
          program doesn't use these registers.

          If unsure, say N.

config CPU_CACHE_NONALIASING
        bool "Non-aliasing cache"
        depends on !CPU_N10 && !CPU_D10
        default n
        help
          If this CPU is using VIPT data cache and its cache way size is larger
          than page size, say N. If it is using PIPT data cache, say Y.

          If unsure, say N.

choice
        prompt "CPU type"
        default CPU_V3
config CPU_N15
        bool "AndesCore N15"
        select CPU_CACHE_NONALIASING
config CPU_N13
        bool "AndesCore N13"
        select CPU_CACHE_NONALIASING if ANDES_PAGE_SIZE_8KB
config CPU_N10
        bool "AndesCore N10"
config CPU_D15
        bool "AndesCore D15"
        select CPU_CACHE_NONALIASING
config CPU_D10
        bool "AndesCore D10"
config CPU_V3
        bool "AndesCore v3 compatible"
        select ANDES_PAGE_SIZE_4KB
endchoice
