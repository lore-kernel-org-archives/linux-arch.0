From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] csky: Improve abiv1 mem ops performance with glibc codes
Date: Mon, 1 Jul 2019 17:46:09 +0200
Message-ID: <CAK8P3a1j+4u_xdP45rEX7H+m+ttd9AEjeL0ittRZjtKN5fApDw@mail.gmail.com>
References: <1561786601-19512-1-git-send-email-guoren@kernel.org>
 <CAK8P3a0F5-wtJHbLvEwUXE8EnALMpQb5KeX4FK3S90Ce81oN-Q@mail.gmail.com> <CAJF2gTR7ooY=gxKW2zWK9MnuJ9YDm_1r6QTdJ=A=WqRDTuecRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJF2gTR7ooY=gxKW2zWK9MnuJ9YDm_1r6QTdJ=A=WqRDTuecRQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <guoren@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 1, 2019 at 5:26 PM Guo Ren <guoren@kernel.org> wrote:
> On Mon, Jul 1, 2019 at 10:52 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Sat, Jun 29, 2019 at 7:36 AM <guoren@kernel.org> wrote:
> > >
> > > From: Guo Ren <ren_guo@c-sky.com>
> > >
> > > These codes are copied from glibc/string directory, they are the generic
> > > implementation for string operations. We may further optimize them with
> > > assembly code in the future.
> > >
> > > In fact these code isn't tested enough for kernel, but we've tested them
> > > on glibc and it seems good. We just trust them :)
> >
> > Are these files from the architecture independent portion of glibc or
> > are they csky specific? If they are architecture independent, we might
> > want to see if they make sense for other architectures as well, and
> > add them to lib/ rather than arch/csky/lib/
> They are just copied from glibc-2.28/string/*.c and they are generic.
> OK, I'll try to add them to lib/.

Ok. Note that lib/string.c contains very basic versions of these already,
so please see which of the functions you have actually make a
difference in practice over those (if you haven't done that already).

Otherwise you can probably follow the example of the libgcc functions
in lib/ashldi3.c etc: add a Kconfig symbol like CONFIG_GENERIC_LIB_ASHLDI3
for each function you had, put the glibc version into a new file, and allow
architectures to select them individually, which in turn should
replace the version from lib/string.c.

       Arnd
