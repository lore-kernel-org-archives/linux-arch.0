Return-Path: <SRS0=nYHR=3J=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35098 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgATPkz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 10:40:55 -0500
Received: by mail-ot1-f66.google.com with SMTP id i15so138027oto.2
        for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 07:40:54 -0800 (PST)
MIME-Version: 1.0
References: <20200120141927.114373-1-elver@google.com> <CACT4Y+bnRoKinPopVqyxj4av6_xa_OUN0wwnidpO3dX3iYq_gg@mail.gmail.com>
 <CACT4Y+YuTT6kZ-AkgU0c1o09qmQdFWr4_Sds4jaDg-Va6g6jkA@mail.gmail.com> <CACT4Y+acrXkA-ixjQXqNf1EC=fpgTWf3Rcevxxon0DfrPdD-UQ@mail.gmail.com>
In-Reply-To: <CACT4Y+acrXkA-ixjQXqNf1EC=fpgTWf3Rcevxxon0DfrPdD-UQ@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Mon, 20 Jan 2020 16:40:42 +0100
Message-ID: <CANpmjNNcXUF-=Y-hmry9-xEoNpJd0WH+fOcJJM6kv2eRm5v-kg@mail.gmail.com>
Subject: Re: [PATCH 1/5] include/linux: Add instrumented.h infrastructure
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Andrey Konovalov <andreyknvl@google.com>, Alexander Potapenko <glider@google.com>, kasan-dev <kasan-dev@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>, Christophe Leroy <christophe.leroy@c-s.fr>, Daniel Axtens <dja@axtens.net>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>, Christian Brauner <christian.brauner@ubuntu.com>, Daniel Borkmann <daniel@iogearbox.net>, cyphar@cyphar.com, Kees Cook <keescook@chromium.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20200120154042.IxvtFEbRinGGLXNSIKcuGcWQcDrtyHC2Xwz9hbtJfs8@z>

On Mon, 20 Jan 2020 at 16:09, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Jan 20, 2020 at 3:58 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Mon, Jan 20, 2020 at 3:45 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Mon, Jan 20, 2020 at 3:19 PM Marco Elver <elver@google.com> wrote:
> > > >
> > > > This adds instrumented.h, which provides generic wrappers for memory
> > > > access instrumentation that the compiler cannot emit for various
> > > > sanitizers. Currently this unifies KASAN and KCSAN instrumentation. In
> > > > future this will also include KMSAN instrumentation.
> > > >
> > > > Note that, copy_{to,from}_user require special instrumentation,
> > > > providing hooks before and after the access, since we may need to know
> > > > the actual bytes accessed (currently this is relevant for KCSAN, and is
> > > > also relevant in future for KMSAN).
> > > >
> > > > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > ---
> > > >  include/linux/instrumented.h | 153 +++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 153 insertions(+)
> > > >  create mode 100644 include/linux/instrumented.h
> > > >
> > > > diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> > > > new file mode 100644
> > > > index 000000000000..9f83c8520223
> > > > --- /dev/null
> > > > +++ b/include/linux/instrumented.h
> > > > @@ -0,0 +1,153 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +
> > > > +/*
> > > > + * This header provides generic wrappers for memory access instrumentation that
> > > > + * the compiler cannot emit for: KASAN, KCSAN.
> > > > + */
> > > > +#ifndef _LINUX_INSTRUMENTED_H
> > > > +#define _LINUX_INSTRUMENTED_H
> > > > +
> > > > +#include <linux/compiler.h>
> > > > +#include <linux/kasan-checks.h>
> > > > +#include <linux/kcsan-checks.h>
> > > > +#include <linux/types.h>
> > > > +
> > > > +/**
> > > > + * instrument_read - instrument regular read access
> > > > + *
> > > > + * Instrument a regular read access. The instrumentation should be inserted
> > > > + * before the actual read happens.
> > > > + *
> > > > + * @ptr address of access
> > > > + * @size size of access
> > > > + */
> > >
> > > Based on offline discussion, that's what we add for KMSAN:
> > >
> > > > +static __always_inline void instrument_read(const volatile void *v, size_t size)
> > > > +{
> > > > +       kasan_check_read(v, size);
> > > > +       kcsan_check_read(v, size);
> > >
> > > KMSAN: nothing
> >
> > KMSAN also has instrumentation in
> > copy_to_user_page/copy_from_user_page. Do we need to do anything for
> > KASAN/KCSAN for these functions?

copy_to_user_page/copy_from_user_page can be instrumented with
instrument_copy_{to,from}_user_. I prefer keeping this series with no
functional change intended for KASAN at least.

> There is also copy_user_highpage.
>
> And ioread/write8/16/32_rep: do we need any instrumentation there. It
> seems we want both KSAN and KCSAN too. One may argue that KCSAN
> instrumentation there is to super critical at this point, but KASAN
> instrumentation is important, if anything to prevent silent memory
> corruptions. How do we instrument there? I don't see how it maps to
> any of the existing instrumentation functions.

These should be able to use the regular instrument_{read,write}. I
prefer keeping this series with no functional change intended for
KASAN at least.

> There is also kmsan_check_skb/kmsan_handle_dma/kmsan_handle_urb that
> does not seem to map to any of the instrumentation functions.

For now, I would rather that there are some one-off special
instrumentation, like for KMSAN. Coming up with a unified interface
here that, without the use-cases even settled, seems hard to justify.
Once instrumentation for these have settled, unifying the interface
would have better justification.

This patch series is merely supposed to introduce instrumented.h and
replace the kasan_checks (also implicitly introducing kcsan_checks
there), however, with no further functional change intended.

I propose that adding entirely new instrumentation for both KASAN and
KCSAN, we should send a separate patch-series.

Thanks,
-- Marco
