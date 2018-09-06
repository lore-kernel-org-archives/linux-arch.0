From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V3 13/26] csky: Library functions
Date: Thu, 6 Sep 2018 17:50:02 +0200
Message-ID: <CAMuHMdW3GhYGPnPf0ph=ZbVpNqiYhAsSMni7SKTC1ZC9zTUUxw@mail.gmail.com>
References: <cover.1536138304.git.ren_guo@c-sky.com> <37f9bd824ede529fdab291a40eef3415f99ec8aa.1536138304.git.ren_guo@c-sky.com>
 <CAK8P3a1xUhyQohifsvs_3th-iPCGL9WKDGj9qKoEaizuu19FeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a1xUhyQohifsvs_3th-iPCGL9WKDGj9qKoEaizuu19FeA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Guo Ren <ren_guo@c-sky.com>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 6, 2018 at 4:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
> > --- /dev/null
> > +++ b/arch/csky/abiv1/memset.c
> > @@ -0,0 +1,38 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> > +#include <linux/types.h>
> > +
> > +void *memset(void *dest, int c, size_t l)
> > +{
> > +       char *d = dest;
> > +       int ch = c;
> > +       int tmp;
> > +
> > +       if ((long)d & 0x3)
> > +               while (l--) *d++ = ch;

while ((uintptr_t)d & 0x3) && l--)
        *d++ =ch;

and remove the else below?

> > +       else {
> > +               ch &= 0xff;
> > +               tmp = (ch | ch << 8 | ch << 16 | ch << 24);
> > +
> > +               while (l >= 16) {
> > +                       *(((long *)d)) = tmp;
> > +                       *(((long *)d)+1) = tmp;
> > +                       *(((long *)d)+2) = tmp;
> > +                       *(((long *)d)+3) = tmp;

s/long/u32/

> > +                       l -= 16;
> > +                       d += 16;
> > +               }
> > +
> > +               while (l > 3) {
> > +                       *(((long *)d)) = tmp;
> > +                       d = d + 4;
> > +                       l -= 4;
> > +               }
> > +
> > +               while (l) {
> > +                       *d++ = ch;
> > +                       l--;
> > +               }
> > +       }
> > +       return dest;
> > +}
>
> I see that we have a trivial memset() implementation in lib/string.c, but yours
> seems to be better optimized. Where did you get it from? Is this a version
> that works particularly well on C-Sky, or is this a generic optimized memset
> that others could use as well? In the latter case, we could add it to
> lib/string.c and let architectures select it in place of the triivial version.

Sounds good to me, after removing the 32-bit-isms.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
