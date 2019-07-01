Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728801AbfGAP0S (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Jul 2019 11:26:18 -0400
MIME-Version: 1.0
References: <1561786601-19512-1-git-send-email-guoren@kernel.org> <CAK8P3a0F5-wtJHbLvEwUXE8EnALMpQb5KeX4FK3S90Ce81oN-Q@mail.gmail.com>
In-Reply-To: <CAK8P3a0F5-wtJHbLvEwUXE8EnALMpQb5KeX4FK3S90Ce81oN-Q@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 1 Jul 2019 23:26:05 +0800
Message-ID: <CAJF2gTR7ooY=gxKW2zWK9MnuJ9YDm_1r6QTdJ=A=WqRDTuecRQ@mail.gmail.com>
Subject: Re: [PATCH] csky: Improve abiv1 mem ops performance with glibc codes
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190701152605.nWr3hmioJPHRfxj4avKqHr2z38hiwv8aGy1PCNKmXuA@z>

Hi Arnd,

On Mon, Jul 1, 2019 at 10:52 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Jun 29, 2019 at 7:36 AM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <ren_guo@c-sky.com>
> >
> > These codes are copied from glibc/string directory, they are the generic
> > implementation for string operations. We may further optimize them with
> > assembly code in the future.
> >
> > In fact these code isn't tested enough for kernel, but we've tested them
> > on glibc and it seems good. We just trust them :)
>
> Are these files from the architecture independent portion of glibc or
> are they csky specific? If they are architecture independent, we might
> want to see if they make sense for other architectures as well, and
> add them to lib/ rather than arch/csky/lib/
They are just copied from glibc-2.28/string/*.c and they are generic.
OK, I'll try to add them to lib/.

>
> Should the SPDX identifier list the original LGPL-2.1 license instead
> of GPL-2.0?
Yes, I removed full Licenses' description:
   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version

I'll change it to:
// SPDX-License-Identifier: LGPL-2.1

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
