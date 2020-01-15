Return-Path: <SRS0=vo9y=3E=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:36717 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbgAOTzS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jan 2020 14:55:18 -0500
MIME-Version: 1.0
References: <20200115165749.145649-1-elver@google.com> <CAK8P3a3b=SviUkQw7ZXZF85gS1JO8kzh2HOns5zXoEJGz-+JiQ@mail.gmail.com>
 <CANpmjNOpTYnF3ssqrE_s+=UA-2MpfzzdrXoyaifb3A55_mc0uA@mail.gmail.com>
In-Reply-To: <CANpmjNOpTYnF3ssqrE_s+=UA-2MpfzzdrXoyaifb3A55_mc0uA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 15 Jan 2020 20:54:59 +0100
Message-ID: <CAK8P3a3WywSsahH2vtZ_EOYTWE44YdN+Pj6G8nt_zrL3sckdwQ@mail.gmail.com>
Subject: Re: [PATCH -rcu] asm-generic, kcsan: Add KCSAN instrumentation for bitops
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Andrey Konovalov <andreyknvl@google.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev <kasan-dev@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, christophe leroy <christophe.leroy@c-s.fr>, Daniel Axtens <dja@axtens.net>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20200115195459.En0qxHHFfXXgMWCpEo1DlIbVswa06EiFqUMaUh6bvbM@z>

On Wed, Jan 15, 2020 at 8:51 PM Marco Elver <elver@google.com> wrote:
>
> On Wed, 15 Jan 2020 at 20:27, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Wed, Jan 15, 2020 at 5:58 PM Marco Elver <elver@google.com> wrote:
> > >   * set_bit - Atomically set a bit in memory
> > > @@ -26,6 +27,7 @@
> > >  static inline void set_bit(long nr, volatile unsigned long *addr)
> > >  {
> > >         kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> > > +       kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
> > >         arch_set_bit(nr, addr);
> > >  }
> >
> > It looks like you add a kcsan_check_atomic_write or kcsan_check_write directly
> > next to almost any instance of kasan_check_write().
> >
> > Are there any cases where we actually just need one of the two but not the
> > other? If not, maybe it's better to rename the macro and have it do both things
> > as needed?
>
> Do you mean adding an inline helper at the top of each bitops header
> here, similar to what we did for atomic-instrumented?  Happy to do
> that if it improves readability.

I was thinking of treewide wrappers, given that there are only a couple of files
calling kasan_check_write():

$ git grep -wl kasan_check_write
arch/arm64/include/asm/barrier.h
arch/arm64/include/asm/uaccess.h
arch/x86/include/asm/uaccess_64.h
include/asm-generic/atomic-instrumented.h
include/asm-generic/bitops/instrumented-atomic.h
include/asm-generic/bitops/instrumented-lock.h
include/asm-generic/bitops/instrumented-non-atomic.h
include/linux/kasan-checks.h
include/linux/uaccess.h
lib/iov_iter.c
lib/strncpy_from_user.c
lib/usercopy.c
scripts/atomic/gen-atomic-instrumented.sh

Are there any that really just want kasan_check_write() but not one
of the kcsan checks?

      Arnd
