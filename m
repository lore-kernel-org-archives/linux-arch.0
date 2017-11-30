From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH v2 25/35] nds32: Build infrastructure
Date: Thu, 30 Nov 2017 18:01:22 +0800
Message-ID: <CAEbi=3ddtygoDSYjeXSERkq3OUZRuboVSPQvDvAgrA=LgBBe0Q@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <5e1be9ebc591c6de79b75f726a5a38b2564eaa92.1511785528.git.green.hu@gmail.com>
 <CAK8P3a1GuH2tgtC5t834-PNeUVYQxreD7seZH8sjraZFtRUWKw@mail.gmail.com>
 <CAEbi=3c=hTCcUOPs+Fc10srzTFsB4MnVxgcFydz12-jH0ZXjog@mail.gmail.com>
 <CAK8P3a0kvt52UTtEmE+tWHZuH_rmgTxP7+CiD9Ddwe2cJLwXTQ@mail.gmail.com>
 <CAMuHMdViO=+-kGdXFPSW+9PsPbf3sUa5xdaJ_1C-cX2vE1G35Q@mail.gmail.com>
 <CAK8P3a3yk7ww+LdQdL+wgz2wYrzXLSsj1PTdfK-qx013jdg4SQ@mail.gmail.com>
 <CAEbi=3cc8e__DnFKmTSMm9xQMx7CGu+1v3e55w8UekwnTTkw5Q@mail.gmail.com>
 <CAK8P3a2d2_jxXehE3xP_G9Tzp6jP4hFmS4CJkh=6bePLEDcdGw@mail.gmail.com>
 <CAEbi=3fmXP=n_tS+-TSFhdht2G=VHOzVCVU=SRy4A6Ym_GToUQ@mail.gmail.com>
 <CAK8P3a3-CexhRkJB7_8TGShuDQP8w=myhkoB8-7ax3my96PrMw@mail.gmail.com>
 <CAEbi=3cTkbt9i7XPXMnY1D6qtbebDW1x8sFVsgqhq-nApAx5mA@mail.gmail.com> <CAK8P3a3-wXAX+bRaDxs8+N5u6d-O6_Uwg7Wzp9m9=tSqQpPrEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:39016 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdK3KCE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Nov 2017 05:02:04 -0500
In-Reply-To: <CAK8P3a3-wXAX+bRaDxs8+N5u6d-O6_Uwg7Wzp9m9=tSqQpPrEw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>

2017-11-30 17:30 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Thu, Nov 30, 2017 at 6:48 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> 2017-11-30 4:27 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Wed, Nov 29, 2017 at 3:10 PM, Greentime Hu <green.hu@gmail.com> wrote:
>>>> 2017-11-29 19:57 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>
>>> When you put them in a sorted list like I mentioned for simplicity, you
>>> could reduce the confusion by naming them differently, e.g.
>>> CONFIG_CPU_N10_OR_NEWER.
>>>
>>> Having only the CPU_CACHE_NONALIASING option is fine if you
>>> never need to make any other decisions based on the CPU core
>>> type, but then the help text should describe specifically which cases
>>> are affected (N10/N13/D13 with 4K page size), and you can decide to
>>> hide the option and make it always-on when using 8K page size.
>>>
>>>        Arnd
>>
>>
>> Hi, Arnd:
>>
>> I think I can use this name "CPU_V3" for all nds32 v3 compatible cpu.
>> It will be implemented like this.
>
> I think I'm still a bit confused about the relation between CPU cores
> and architecture levels. Is it correct to say that there are orthogonal,
> and that you can have e.g. an N10 core implementing either nds32v2
> or nds32v3?
>

Yup, we did having N10 cores are implementing either nds32v3 or
nds32v2, but nds32v2 are not used anymore.
We can assume every nds32 cores are v3.

> There is nothing wrong with that of course, it's just not what I
> expected from having worked with other architectures.
>
> I also see that GCC has no pipeline specific optimizations for
> specific cores, it just understands the differences between the
> architecture levels, so at least today there is way to pass e.g.
> "-march=nds32v2 -mtune=d15" to generate code that would
> work on both v2 and v3 but be optimized for d15.

Thanks. We will work on that.

>> config HWZOL
>>         bool "hardware zero overhead loop support"
>>         depends on CPU_D10 || CPU_D15
>>         default n
>>         help
>>           A set of Zero-Overhead Loop mechanism is provided to reduce the
>>           instruction fetch and execution overhead of loop-control instructions.
>>           It will save 3 registers($LB, $LC, $LE) for context saving if say Y.
>>           You don't need to save these registers if you can make sure your user
>>           program doesn't use these registers.
>>
>>           If unsure, say N.
>>
>> config CPU_CACHE_NONALIASING
>>         bool "Non-aliasing cache"
>>         depends on !CPU_N10 && !CPU_D10
>>         default n
>>         help
>>           If this CPU is using VIPT data cache and its cache way size is larger
>>           than page size, say N. If it is using PIPT data cache, say Y.
>>
>>           If unsure, say N.
>
> This looks ok, yes, but as Geert said, it would seem more intuitive to
> write it as
>
> config CPU_CACHE_ALIASING
>          bool "Aliasing VIPT cache"
>          depends on CPU_N10 || CPU_D10
>
>> choice
>>         prompt "CPU type"
>>         default CPU_V3
>> config CPU_N15
>>         bool "AndesCore N15"
>>         select CPU_CACHE_NONALIASING
>> config CPU_N13
>>         bool "AndesCore N13"
>>         select CPU_CACHE_NONALIASING if ANDES_PAGE_SIZE_8KB
>> config CPU_N10
>>         bool "AndesCore N10"
>> config CPU_D15
>>         bool "AndesCore D15"
>>         select CPU_CACHE_NONALIASING
>> config CPU_D10
>>         bool "AndesCore D10"
>> config CPU_V3
>>         bool "AndesCore v3 compatible"
>>         select ANDES_PAGE_SIZE_4KB
>> endchoice
>
> Two points here:
>
> - Generally you should not mix 'select' and 'depends on' like this.
>   Either you make the cache aliasing a user visible option that
>   uses 'depends on' with a combination of CPU cores, or you
>   make it a hidden option (with no string after the "bool" keyword)
>   that always gets selected from the per-cpu options.
>
> - There is a  little-known trick with choice statements that allows
>   you to use 'tristate' instead of 'bool' in the choice. In that case,
>   you can enable multiple options together as long as all of them
>   are 'm'.
>
>          Arnd


Thanks.
CPU_CACHE_ALIASING is more intuitive. I will apply it.
