Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f194.google.com ([209.85.166.194]:40709 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2Ixp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 04:53:45 -0400
Received: by mail-it1-f194.google.com with SMTP id h11so2263082itf.5
        for <linux-arch@vger.kernel.org>; Wed, 29 May 2019 01:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190528163258.260144-1-elver@google.com> <20190528163258.260144-3-elver@google.com>
 <20190528165036.GC28492@lakrids.cambridge.arm.com>
In-Reply-To: <20190528165036.GC28492@lakrids.cambridge.arm.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 29 May 2019 10:53:32 +0200
Message-ID: <CACT4Y+bV0CczjRWgHQq3kvioLaaKgN+hnYEKCe5wkbdngrm+8g@mail.gmail.com>
Subject: Re: [PATCH 3/3] asm-generic, x86: Add bitops instrumentation for KASAN
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@google.com>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@redhat.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Message-ID: <20190529085332.yTzHtB6RJPNgAoIzxr4C60hd7PnapRg3yeVmi7Bu69U@z>

On Tue, May 28, 2019 at 6:50 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, May 28, 2019 at 06:32:58PM +0200, Marco Elver wrote:
> > This adds a new header to asm-generic to allow optionally instrumenting
> > architecture-specific asm implementations of bitops.
> >
> > This change includes the required change for x86 as reference and
> > changes the kernel API doc to point to bitops-instrumented.h instead.
> > Rationale: the functions in x86's bitops.h are no longer the kernel API
> > functions, but instead the arch_ prefixed functions, which are then
> > instrumented via bitops-instrumented.h.
> >
> > Other architectures can similarly add support for asm implementations of
> > bitops.
> >
> > The documentation text has been copied/moved, and *no* changes to it
> > have been made in this patch.
> >
> > Tested: using lib/test_kasan with bitops tests (pre-requisite patch).
> >
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198439
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  Documentation/core-api/kernel-api.rst     |   2 +-
> >  arch/x86/include/asm/bitops.h             | 210 ++++----------
> >  include/asm-generic/bitops-instrumented.h | 327 ++++++++++++++++++++++
> >  3 files changed, 380 insertions(+), 159 deletions(-)
> >  create mode 100644 include/asm-generic/bitops-instrumented.h
>
> [...]
>
> > +#if !defined(BITOPS_INSTRUMENT_RANGE)
> > +/*
> > + * This may be defined by an arch's bitops.h, in case bitops do not operate on
> > + * single bytes only. The default version here is conservative and assumes that
> > + * bitops operate only on the byte with the target bit.
> > + */
> > +#define BITOPS_INSTRUMENT_RANGE(addr, nr)                                  \
> > +     (const volatile char *)(addr) + ((nr) / BITS_PER_BYTE), 1
> > +#endif
>
> I was under the impression that logically, all the bitops operated on
> the entire long the bit happend to be contained in, so checking the
> entire long would make more sense to me.
>
> FWIW, arm64's atomic bit ops are all implemented atop of atomic_long_*
> functions, which are instrumented, and always checks at the granularity
> of a long. I haven't seen splats from that when fuzzing with Syzkaller.
>
> Are you seeing bugs without this?

bitops are not instrumented on x86 at all at the moment, so we have
not seen any splats. What we've seen are assorted crashes caused by
previous silent memory corruptions by incorrect bitops :)

Good point. If arm already does this, I guess we also need to check
whole long's.
