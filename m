From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [GIT PULL] ARM: SoC fixes (and a cross-arch dt-include fix)
Date: Tue, 23 May 2017 11:49:00 +0200
Message-ID: <CAMuHMdUivf9cw+LTn7UMueH=MMKi6i3wcOdgM6zbZBoxmkTZGQ@mail.gmail.com>
References: <20170519193455.GA24206@localhost> <CACRpkdaRdZTB39-=sAojO+OyHtP02KaFChqGcxy+fWA8qaB2bw@mail.gmail.com>
 <CAOesGMhfrWSvLtDtGRWBTJiAoeSwzGgsdUTm26j1mpoVu0ghDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:34607 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965563AbdEWJtC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2017 05:49:02 -0400
In-Reply-To: <CAOesGMhfrWSvLtDtGRWBTJiAoeSwzGgsdUTm26j1mpoVu0ghDg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Olof Johansson <olof@lixom.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>

Hi Olof,

On Mon, May 22, 2017 at 5:11 PM, Olof Johansson <olof@lixom.net> wrote:
> On Mon, May 22, 2017 at 4:44 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Fri, May 19, 2017 at 9:34 PM, Olof Johansson <olof@lixom.net> wrote:
>>>  - We've started telling people to avoid cross-tree shared branches if all
>>>    they're doing is picking up one or two DT-used constants from a
>>>    shared include file, and instead to use the numeric values on first
>>>    submission. Follow-up moving over to symbolic names are sent in right
>>>    after -rc1, i.e. here. It's only a few minor patches of this type.
>>
>> OK it seems like a reasonable process.
>>
>> It's not like I can think about anything better.
>>
>> I was more opting for doing things this way:
>>
>> - Create bindings and <dt-bindings/foo/bar.h> merge it into the
>>   foo subsystem.
>>
>> - Merge driver into drivers/foo/bar.c that use <dt-bindings/foo/bar.h>
>>
>> - Submit DTS patch to ARM SoC (or whetever) using only numerical
>>   values.
>>
>> - After the merge window, follow up with a patch replacing the
>>   numerical constants with #defines from <dt-bindings/foo/bar.h>
>
> You're describing exactly what we've been pushing people towards.
>
> If it's just a few simple references it's not significantly more
> awkward, and decouples merges and removes need for stable branches.
> Essentially we've become slightly more lax in what we're willing to
> consider _right after_ -rc1 to include these tweaks (and often patches
> to turn on new drivers in defconfigs).
>
> If the amount of contents grows too large we might need to tweak
> things further, maybe with something pre-rc1 but that's more awkward.
>
>> An alternative would obviously be to wait for the next merge window
>> after merging the driver patch but I guess people are too impatient
>> to do that (including me).
>
> Yeah, asking people to spread out across releases would remove
> dependencies a lot, but it would also slow down progress and frustrate
> a lot of contributors so we don't do that.

The above works fine for new support, or for new platforms.

There's still support being migrated from platform code to DT, which
requires three steps:
  1. New DT-aware driver support,
  2. DT update to use the new driver support,
  3. Clean up platform code after optional DTB backwards compatibility
     grace period,
To make matters worse, 1 may conflict with the existing platform code,
and 2 must sometimes not be done before 1. Hence you may need three kernel
releases.
So we're already planning now what to clean up for v4.15 ;-)

Would it be acceptable to do step 2 in the same release, after the driver
support has entered in -rc1? I know this is more than just replacing
numbers by symbolic values.

Thanks!

Gr{oetje,eeting}s,

                        Geert
