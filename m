Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43003 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbfEVPHf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 11:07:35 -0400
Received: by mail-vs1-f68.google.com with SMTP id z11so1598587vsq.9
        for <linux-arch@vger.kernel.org>; Wed, 22 May 2019 08:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190522132754.46640-1-vincenzo.frascino@arm.com>
 <CAMuHMdXoUWHk-RvgwbDc0YZ+KnBSaL+1XE2n134oAVR7Y5jazg@mail.gmail.com> <c4592dfd-6b56-2837-8c32-495b113e80ee@arm.com>
In-Reply-To: <c4592dfd-6b56-2837-8c32-495b113e80ee@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 May 2019 17:07:21 +0200
Message-ID: <CAMuHMdWaVDe9S1hfhwrZ5D2d74yswvKXeQ9pL7i6Oe7UVJj0MQ@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Fix spdxcheck.py
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, jcline@redhat.com

Hi Vincenzo,

On Wed, May 22, 2019 at 4:32 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> On 22/05/2019 14:48, Geert Uytterhoeven wrote:
> > On Wed, May 22, 2019 at 3:28 PM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> >> The LICENSE directory has recently changed structure and this makes
> >> spdxcheck fails as per below:
> >>
> >> FAIL: "Blob or Tree named 'other' not found"
> >> Traceback (most recent call last):
> >>   File "scripts/spdxcheck.py", line 240, in <module>
> >> spdx = read_spdxdata(repo)
> >>   File "scripts/spdxcheck.py", line 41, in read_spdxdata
> >> for el in lictree[d].traverse():
> >> [...]
> >> KeyError: "Blob or Tree named 'other' not found"
> >>
> >> Fix the script to restore the correctness on checkpatch License
> >> checking.
> >>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Jeremy Cline <jcline@redhat.com>
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> >
> > Thanks for your patch!
> >
> > Looks the issue is already fixed in linux-next:
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/scripts/spdxcheck.py
> >
>
> Thank you for pointing this out, I missed it.
>
> I had a look at the patch in linux-next and seems that the problem is not
> completely solved by the patch you are referring to, in fact:
>  - For how the code it is written, exceptions directory needs to be parsed as
>    last. The only reason why it seems ok at the moment in linux-next it is
>    because there is no "dual" license appears in SPDX-Licenses field of any
>    "exception". A simple test that consists in adding Apache-2.0 to the SPDX-
>    Licenses of Linux-syscall-note generates still an exception.
>  - The SPDXException calls in the case of "SPDX-Licenses" and "License-Text" use
>    undefined parameters.
>
> My patch addresses both the issues, if it helps, I can rebase it on linux-next.
>
> Please let me know.

Rebasing against linux-next is the right thing to do.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
