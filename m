From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH] csky: Improve abiv1 mem ops performance with glibc codes
Date: Mon, 1 Jul 2019 23:26:05 +0800
Message-ID: <CAJF2gTR7ooY=gxKW2zWK9MnuJ9YDm_1r6QTdJ=A=WqRDTuecRQ@mail.gmail.com>
References: <1561786601-19512-1-git-send-email-guoren@kernel.org> <CAK8P3a0F5-wtJHbLvEwUXE8EnALMpQb5KeX4FK3S90Ce81oN-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a0F5-wtJHbLvEwUXE8EnALMpQb5KeX4FK3S90Ce81oN-Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

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
