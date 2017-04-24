Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:35599 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S976009AbdDXSQV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Apr 2017 14:16:21 -0400
MIME-Version: 1.0
In-Reply-To: <CAK8P3a03BTEBgz87k_dhJuqzOYQm_S5FFDrFgcBAE5FCH-e=dQ@mail.gmail.com>
References: <20161216105634.235457-1-arnd@arndb.de> <3302470.IDcDrWa0u6@wuerfel>
 <CAGXu5jLPRYi+HK=07Zndc8szEKD4mZCqaHJFnHmmoYr7tA1xPw@mail.gmail.com>
 <CAK8P3a2C2WhWjzF=HrzU15Ncg0juR+nstZukBEpqCrVNW5pnDA@mail.gmail.com>
 <CAGXu5jLTR+dY_Ayyix5Tg0Yn9LBFAt=j56MQVdJVGue-R-CizA@mail.gmail.com>
 <CAK8P3a114EVbnhbObfq-4pZp8XCT4fWzMXD+WkRi7iPXs1vFMA@mail.gmail.com>
 <CAGXu5jJpofLF0qAf0-2iNTesZt-X704Q7L=DpQYdtHY5n2HD0w@mail.gmail.com>
 <alpine.LFD.2.20.1704220400380.32200@eddie.linux-mips.org>
 <CAK8P3a28fi0GRcz1yLq+wRkaBBO_w74NnBCY7f3myg78JpaCCQ@mail.gmail.com>
 <CAMuHMdWTiurUSacddYXgW69=QwOrZDV3Zt2DezJauPy8j-GMHw@mail.gmail.com>
 <CAK8P3a32Y0AiKyVaotYb14uZZ1jM=nwhFD1vyP56epW1Y9KqSw@mail.gmail.com>
 <alpine.LFD.2.20.1704241249350.32200@eddie.linux-mips.org> <CAK8P3a03BTEBgz87k_dhJuqzOYQm_S5FFDrFgcBAE5FCH-e=dQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Apr 2017 20:16:19 +0200
Message-ID: <CAMuHMdWKngq9TAkjEAYscQRVzKpO63-XVcnjzEM0UNVX_1Ddhg@mail.gmail.com>
Subject: Re: [RFC] minimum gcc version for kernel: raise to gcc-4.3 or 4.6?
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Kees Cook <keescook@chromium.org>, linux-arch <linux-arch@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <rmk+kernel@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, kernel-build-reports@lists.linaro.org, kvmarm@lists.cs.columbia.edu
Message-ID: <20170424181619.zKR3Q8ZWl4_lYNW9DPdJELSDb_RZ8vuJJkzvO3GYYLs@z>

Hi Arnd,

On Mon, Apr 24, 2017 at 7:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Apr 24, 2017 at 6:53 PM, Maciej W. Rozycki <macro@linux-mips.org> wrote:
>> On Mon, 24 Apr 2017, Arnd Bergmann wrote:
>>> > If there's no real good reason (brokenness) to deprecate gcc-4.1, I would not
>>> > do it.I guess most people using old compilers know what they're doing.
>>>
>>> What I'm trying to find out first is whether "people regularly using 10+
>>> year old compilers for the latest kernels" is a strict subset of "people in
>>> Geert's household".
>>
>> Well I do not live with Geert TBH.
>
> Sorry about that, you had mentioned that you had used it recently, which should
> have weighed more than my own results.

If you prefer to consider everyone who's been sleeping in the same room
at one of the Oldenburg Linux meetings as part of my household, that's
fine for me ;-)

> So it still fails, but only because of one compiler error that I can avoid by
> disabling that driver, and you probably use a slightly patched compiler
> version that doesn't have this particular bug, or it was a regression between
> gcc-4.1.2 and 4.1.3.

Mine is also some patched version of 4.1.1, built from Ubuntu sources:

    gcc version 4.1.2 20061115 (prerelease) (Ubuntu 4.1.1-21)

These sources probably even contained the fixes to make gcc-4.1.1
usable on CELL.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
