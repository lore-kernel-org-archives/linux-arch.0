From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] ARM: SoC fixes (and a cross-arch dt-include fix)
Date: Mon, 22 May 2017 08:11:27 -0700
Message-ID: <CAOesGMhfrWSvLtDtGRWBTJiAoeSwzGgsdUTm26j1mpoVu0ghDg@mail.gmail.com>
References: <20170519193455.GA24206@localhost> <CACRpkdaRdZTB39-=sAojO+OyHtP02KaFChqGcxy+fWA8qaB2bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:36258 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934986AbdEVPL3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2017 11:11:29 -0400
Received: by mail-ua0-f195.google.com with SMTP id i46so7918318uaa.3
        for <linux-arch@vger.kernel.org>; Mon, 22 May 2017 08:11:29 -0700 (PDT)
In-Reply-To: <CACRpkdaRdZTB39-=sAojO+OyHtP02KaFChqGcxy+fWA8qaB2bw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>

[adding ksummit-discuss]

On Mon, May 22, 2017 at 4:44 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, May 19, 2017 at 9:34 PM, Olof Johansson <olof@lixom.net> wrote:
>
>>  - We've started telling people to avoid cross-tree shared branches if all
>>    they're doing is picking up one or two DT-used constants from a
>>    shared include file, and instead to use the numeric values on first
>>    submission. Follow-up moving over to symbolic names are sent in right
>>    after -rc1, i.e. here. It's only a few minor patches of this type.
>
> OK it seems like a reasonable process.
>
> It's not like I can think about anything better.
>
> I was more opting for doing things this way:
>
> - Create bindings and <dt-bindings/foo/bar.h> merge it into the
>   foo subsystem.
>
> - Merge driver into drivers/foo/bar.c that use <dt-bindings/foo/bar.h>
>
> - Submit DTS patch to ARM SoC (or whetever) using only numerical
>   values.
>
> - After the merge window, follow up with a patch replacing the
>   numerical constants with #defines from <dt-bindings/foo/bar.h>

You're describing exactly what we've been pushing people towards.

If it's just a few simple references it's not significantly more
awkward, and decouples merges and removes need for stable branches.
Essentially we've become slightly more lax in what we're willing to
consider _right after_ -rc1 to include these tweaks (and often patches
to turn on new drivers in defconfigs).

If the amount of contents grows too large we might need to tweak
things further, maybe with something pre-rc1 but that's more awkward.

> An alternative would obviously be to wait for the next merge window
> after merging the driver patch but I guess people are too impatient
> to do that (including me).

Yeah, asking people to spread out across releases would remove
dependencies a lot, but it would also slow down progress and frustrate
a lot of contributors so we don't do that.

> We discussed cross-tree dependencies a bit on ksummit-discuss
> but this solution was not mentioned back then.

I thought it was, but I wasn't fully engaged in the discussion. We've
also only started this over the last release or two so it's early to
tell just how well it'll work in reality. Cc:ing the list.



-Olof
