From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH -rcu] asm-generic, kcsan: Add KCSAN instrumentation for bitops
Date: Mon, 20 Jan 2020 20:02:44 +0100
Message-ID: <CAK8P3a32sVU4umk2FLnWnMGMQxThvMHAKxVM+G4X-hMgpBsXMA@mail.gmail.com>
References: <20200115165749.145649-1-elver@google.com> <CAK8P3a3b=SviUkQw7ZXZF85gS1JO8kzh2HOns5zXoEJGz-+JiQ@mail.gmail.com>
 <CANpmjNOpTYnF3ssqrE_s+=UA-2MpfzzdrXoyaifb3A55_mc0uA@mail.gmail.com>
 <CAK8P3a3WywSsahH2vtZ_EOYTWE44YdN+Pj6G8nt_zrL3sckdwQ@mail.gmail.com>
 <CANpmjNMk2HbuvmN1RaZ=8OV+tx9qZwKyRySONDRQar6RCGM1SA@mail.gmail.com>
 <CAK8P3a066Knr-KC2v4M8Dr1phr0Gbb2KeZZLQ7Ana0fkrgPDPg@mail.gmail.com>
 <CANpmjNO395-atZXu_yEArZqAQ+ib3Ack-miEhA9msJ6_eJsh4g@mail.gmail.com>
 <CANpmjNOH1h=txXnd1aCXTN8THStLTaREcQpzd5QvoXz_3r=8+A@mail.gmail.com>
 <CAK8P3a0p9Y8080T-RR2pp-p2_A0FBae7zB-kSq09sMZ_X7AOhw@mail.gmail.com> <CANpmjNOUTed6FT8X0bUSc1tGBh3jrEJ0DRpQwBfoPF5ah8Wrhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:58153 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgATTDE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 14:03:04 -0500
In-Reply-To: <CANpmjNOUTed6FT8X0bUSc1tGBh3jrEJ0DRpQwBfoPF5ah8Wrhw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Andrey Konovalov <andreyknvl@google.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev <kasan-dev@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, christophe leroy <christophe.leroy@c-s.fr>, Daniel Axtens <dja@axtens.net>, linux-arch <linux-arch@vger.kernel.org>

On Mon, Jan 20, 2020 at 4:11 PM Marco Elver <elver@google.com> wrote:
> On Mon, 20 Jan 2020 at 15:40, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Jan 20, 2020 at 3:23 PM Marco Elver <elver@google.com> wrote:
> > > On Fri, 17 Jan 2020 at 14:14, Marco Elver <elver@google.com> wrote:
> > > > On Fri, 17 Jan 2020 at 13:25, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > On Wed, Jan 15, 2020 at 9:50 PM Marco Elver <elver@google.com> wrote:
> >
> > > > > If you can't find any, I would prefer having the simpler interface
> > > > > with just one set of annotations.
> > > >
> > > > That's fair enough. I'll prepare a v2 series that first introduces the
> > > > new header, and then applies it to the locations that seem obvious
> > > > candidates for having both checks.
> > >
> > > I've sent a new patch series which introduces instrumented.h:
> > >    http://lkml.kernel.org/r/20200120141927.114373-1-elver@google.com
> >
> > Looks good to me, feel free to add
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >
> > if you are merging this through your own tree or someone else's,
> > or let me know if I should put it into the asm-generic git tree.
>
> Thank you!  It seems there is still some debate around the user-copy
> instrumentation.
>
> The main question we have right now is if we should add pre/post hooks
> for them. Although in the version above I added KCSAN checks after the
> user-copies, it seems maybe we want it before. I personally don't have
> a strong preference, and wanted to err on the side of being more
> conservative.
>
> If I send a v2, and it now turns out we do all the instrumentation
> before the user-copies for KASAN and KCSAN, then we have a bunch of
> empty hooks. However, for KMSAN we need the post-hook, at least for
> copy_from_user. Do you mind a bunch of empty functions to provide
> pre/post hooks for user-copies? Could the post-hooks be generally
> useful for something else?

I'd prefer not to add any empty hooks, let's do that once they
are actually used.

      Arnd
