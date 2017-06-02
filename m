From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] ARM: SoC fixes (and a cross-arch dt-include fix)
Date: Fri, 2 Jun 2017 17:27:17 +0200
Message-ID: <CAK8P3a2_V8hs7CRRJNjpkeAaqpRwztHhPpUQz8vB5K3GwJRaGQ@mail.gmail.com>
References: <20170519193455.GA24206@localhost> <CACRpkdaRdZTB39-=sAojO+OyHtP02KaFChqGcxy+fWA8qaB2bw@mail.gmail.com>
 <CAOesGMhfrWSvLtDtGRWBTJiAoeSwzGgsdUTm26j1mpoVu0ghDg@mail.gmail.com>
 <CAMuHMdUivf9cw+LTn7UMueH=MMKi6i3wcOdgM6zbZBoxmkTZGQ@mail.gmail.com>
 <CAK8P3a2E1LtCNoGkAuzwJJdQdUTB_+8d=FM2asEGkXJprvm8oQ@mail.gmail.com> <CAMuHMdWxNFUnWJjLj7ynWJFEFMAL=TPsdVSzDtohDprC=EXnaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33606 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbdFBP1S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jun 2017 11:27:18 -0400
In-Reply-To: <CAMuHMdWxNFUnWJjLj7ynWJFEFMAL=TPsdVSzDtohDprC=EXnaQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>

On Tue, May 30, 2017 at 11:13 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Arnd,
>
> On Tue, May 23, 2017 at 4:17 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Tue, May 23, 2017 at 11:49 AM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>>> On Mon, May 22, 2017 at 5:11 PM, Olof Johansson <olof@lixom.net> wrote:
>>>> On Mon, May 22, 2017 at 4:44 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>>>> On Fri, May 19, 2017 at 9:34 PM, Olof Johansson <olof@lixom.net> wrote:
>>>>
>>>> Yeah, asking people to spread out across releases would remove
>>>> dependencies a lot, but it would also slow down progress and frustrate
>>>> a lot of contributors so we don't do that.
>>>
>>> The above works fine for new support, or for new platforms.
>>>
>>> There's still support being migrated from platform code to DT, which
>>> requires three steps:
>>>   1. New DT-aware driver support,
>>>   2. DT update to use the new driver support,
>>>   3. Clean up platform code after optional DTB backwards compatibility
>>>      grace period,
>>> To make matters worse, 1 may conflict with the existing platform code,
>>> and 2 must sometimes not be done before 1. Hence you may need three kernel
>>> releases.
>>> So we're already planning now what to clean up for v4.15 ;-)
>>>
>>> Would it be acceptable to do step 2 in the same release, after the driver
>>> support has entered in -rc1? I know this is more than just replacing
>>> numbers by symbolic values.
>>
>> I'd say it really depends on the individual case. Do you have a particular
>> platform in mind? E.g. For some of the more obsolete platforms that
>> Linus Walleij has worked on over time, we have sometimes relaxed the
>> rules about clean bisection and just merged everything in parallel, knowing
>> that nobody else was likely to run that code on a vanilla kernel anyway.
>
> This is for Renesas R-Car Gen2 SoCs, so we do care about DT backward
> compatibility (for a while), and about bisection.

Ok, I see.

> Last headache was "[PATCH v4 00/23] soc: renesas: Add R-Car RST driver for
> obtaining mode pin state" (https://lkml.org/lkml/2016/10/21/500). This used
> a shared immutable branch, but that caused several merge conflicts.
>
> Next one will be smaller, as it's not really moving functionality from
> platform code to DT, but switching to a new and better clock driver framework,
> so there's only the dependency of DT on the new driver
> "[PATCH v2 00/10] clk: renesas: rcar-gen2: Add new CPG/MSSR drivers"
> (https://lkml.org/lkml/2017/5/19/212)

Ok, so there is already a working driver for these chips, but you want
to move to a better driver and binding. That's all fine, but I'm not sure
about why you want to do this faster at all. Presumably you want to use
the new driver quickly so you can add new platforms not using the old
driver, but then you'd have a couple of years of grace period before
removing the old driver for customers with existing out of tree dts files,
so I would assume that waiting another release or two before moving
the DT files over is not adding a huge burden.

> I'll go create an inventory of stuff in platform code for Renesas SoCs that
> still needs to be converted to DT...

That would certainly be helpful, yes.

       Arnd
