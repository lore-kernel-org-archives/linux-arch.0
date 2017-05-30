From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [GIT PULL] ARM: SoC fixes (and a cross-arch dt-include fix)
Date: Tue, 30 May 2017 11:13:30 +0200
Message-ID: <CAMuHMdWxNFUnWJjLj7ynWJFEFMAL=TPsdVSzDtohDprC=EXnaQ@mail.gmail.com>
References: <20170519193455.GA24206@localhost> <CACRpkdaRdZTB39-=sAojO+OyHtP02KaFChqGcxy+fWA8qaB2bw@mail.gmail.com>
 <CAOesGMhfrWSvLtDtGRWBTJiAoeSwzGgsdUTm26j1mpoVu0ghDg@mail.gmail.com>
 <CAMuHMdUivf9cw+LTn7UMueH=MMKi6i3wcOdgM6zbZBoxmkTZGQ@mail.gmail.com> <CAK8P3a2E1LtCNoGkAuzwJJdQdUTB_+8d=FM2asEGkXJprvm8oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2E1LtCNoGkAuzwJJdQdUTB_+8d=FM2asEGkXJprvm8oQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>
List-Id: linux-arch.vger.kernel.org

Hi Arnd,

On Tue, May 23, 2017 at 4:17 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, May 23, 2017 at 11:49 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Mon, May 22, 2017 at 5:11 PM, Olof Johansson <olof@lixom.net> wrote:
>>> On Mon, May 22, 2017 at 4:44 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>>> On Fri, May 19, 2017 at 9:34 PM, Olof Johansson <olof@lixom.net> wrote:
>>>
>>> Yeah, asking people to spread out across releases would remove
>>> dependencies a lot, but it would also slow down progress and frustrate
>>> a lot of contributors so we don't do that.
>>
>> The above works fine for new support, or for new platforms.
>>
>> There's still support being migrated from platform code to DT, which
>> requires three steps:
>>   1. New DT-aware driver support,
>>   2. DT update to use the new driver support,
>>   3. Clean up platform code after optional DTB backwards compatibility
>>      grace period,
>> To make matters worse, 1 may conflict with the existing platform code,
>> and 2 must sometimes not be done before 1. Hence you may need three kernel
>> releases.
>> So we're already planning now what to clean up for v4.15 ;-)
>>
>> Would it be acceptable to do step 2 in the same release, after the driver
>> support has entered in -rc1? I know this is more than just replacing
>> numbers by symbolic values.
>
> I'd say it really depends on the individual case. Do you have a particular
> platform in mind? E.g. For some of the more obsolete platforms that
> Linus Walleij has worked on over time, we have sometimes relaxed the
> rules about clean bisection and just merged everything in parallel, knowing
> that nobody else was likely to run that code on a vanilla kernel anyway.

This is for Renesas R-Car Gen2 SoCs, so we do care about DT backward
compatibility (for a while), and about bisection.

Last headache was "[PATCH v4 00/23] soc: renesas: Add R-Car RST driver for
obtaining mode pin state" (https://lkml.org/lkml/2016/10/21/500). This used
a shared immutable branch, but that caused several merge conflicts.

Next one will be smaller, as it's not really moving functionality from
platform code to DT, but switching to a new and better clock driver framework,
so there's only the dependency of DT on the new driver
"[PATCH v2 00/10] clk: renesas: rcar-gen2: Add new CPG/MSSR drivers"
(https://lkml.org/lkml/2017/5/19/212)

I'll go create an inventory of stuff in platform code for Renesas SoCs that
still needs to be converted to DT...

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
