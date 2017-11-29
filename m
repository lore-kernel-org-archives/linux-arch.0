Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36579 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752578AbdK2JKl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Nov 2017 04:10:41 -0500
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0kvt52UTtEmE+tWHZuH_rmgTxP7+CiD9Ddwe2cJLwXTQ@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <5e1be9ebc591c6de79b75f726a5a38b2564eaa92.1511785528.git.green.hu@gmail.com>
 <CAK8P3a1GuH2tgtC5t834-PNeUVYQxreD7seZH8sjraZFtRUWKw@mail.gmail.com>
 <CAEbi=3c=hTCcUOPs+Fc10srzTFsB4MnVxgcFydz12-jH0ZXjog@mail.gmail.com> <CAK8P3a0kvt52UTtEmE+tWHZuH_rmgTxP7+CiD9Ddwe2cJLwXTQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Nov 2017 10:10:39 +0100
Message-ID: <CAMuHMdViO=+-kGdXFPSW+9PsPbf3sUa5xdaJ_1C-cX2vE1G35Q@mail.gmail.com>
Subject: Re: [PATCH v2 25/35] nds32: Build infrastructure
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime Hu <green.hu@gmail.com>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171129091039.p7jBae3xlUDO7_r8jNeOJ44Hy6LvLB3cCBImY96-YUg@z>

Hi Arnd,

On Wed, Nov 29, 2017 at 9:58 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Nov 29, 2017 at 9:39 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> 2017-11-27 22:21 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu@gmail.com> wrote:
>>>> diff --git a/arch/nds32/Kconfig.cpu b/arch/nds32/Kconfig.cpu
>>>> +config CPU_CACHE_NONALIASING
>>>> +       bool "Non-aliasing cache"
>>>> +       help
>>>> +         If this CPU is using VIPT data cache and its cache way size is larger
>>>> +         than page size, say N. If it is using PIPT data cache, say Y.
>>>> +
>>>> +         If unsure, say Y.
>>>
>>> Can you determine this from the CPU type?
>>
>> There is no cpu register to determine it. It also depeneds on page
>> size and way size however page size is configurable by software.
>> These codes are determined at compile time will be benefit to code
>> size and performance.
>> IMHO, I think it would be better to be determined here.
>
> I meant determining it at compile time from other Kconfig symbols,
> if that's possible. Do the CPU cores each have a fixed way-size?
> If they do, it could be done like
>
> menu "CPU selection"
>
> config CPU_N15
>       bool "AndesCore N15"
>       select CPU_CACHE_NONALIASING
>
> config CPU_N13
>       bool "AndesCore N15"
>       select CPU_CACHE_NONALIASING if PAGE_SIZE_16K
>
> ...
>
> endmenu
>
> and then you can use the same CPU_... symbols to make other decisions
> as well, e.g. CPU specific compiler optimizations.

Do you want to support multiple CPU types in a single kernel image
(I see no "choice" statement above)?
If yes, you may have a mix of aliasing and non-aliasing caches, so
you may want to invert the logic, and select CPU_CACHE_ALIASING
instead.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
