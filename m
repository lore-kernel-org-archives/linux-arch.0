From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 1/5] include/linux: Add instrumented.h infrastructure
Date: Mon, 20 Jan 2020 15:58:45 +0100
Message-ID: <CACT4Y+YuTT6kZ-AkgU0c1o09qmQdFWr4_Sds4jaDg-Va6g6jkA@mail.gmail.com>
References: <20200120141927.114373-1-elver@google.com> <CACT4Y+bnRoKinPopVqyxj4av6_xa_OUN0wwnidpO3dX3iYq_gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36087 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgATO65 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 09:58:57 -0500
Received: by mail-qk1-f194.google.com with SMTP id a203so30363249qkc.3
        for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 06:58:56 -0800 (PST)
In-Reply-To: <CACT4Y+bnRoKinPopVqyxj4av6_xa_OUN0wwnidpO3dX3iYq_gg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: paulmck@kernel.org, Andrey Konovalov <andreyknvl@google.com>, Alexander Potapenko <glider@google.com>, kasan-dev <kasan-dev@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>, Christophe Leroy <christophe.leroy@c-s.fr>, Daniel Axtens <dja@axtens.net>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>, Christian Brauner <christian.brauner@ubuntu.com>, Daniel Borkmann <daniel@iogearbox.net>, cyphar@cyphar.com, Kees Cook <keescook@chromium.o>

On Mon, Jan 20, 2020 at 3:45 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Jan 20, 2020 at 3:19 PM Marco Elver <elver@google.com> wrote:
> >
> > This adds instrumented.h, which provides generic wrappers for memory
> > access instrumentation that the compiler cannot emit for various
> > sanitizers. Currently this unifies KASAN and KCSAN instrumentation. In
> > future this will also include KMSAN instrumentation.
> >
> > Note that, copy_{to,from}_user require special instrumentation,
> > providing hooks before and after the access, since we may need to know
> > the actual bytes accessed (currently this is relevant for KCSAN, and is
> > also relevant in future for KMSAN).
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  include/linux/instrumented.h | 153 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 153 insertions(+)
> >  create mode 100644 include/linux/instrumented.h
> >
> > diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> > new file mode 100644
> > index 000000000000..9f83c8520223
> > --- /dev/null
> > +++ b/include/linux/instrumented.h
> > @@ -0,0 +1,153 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * This header provides generic wrappers for memory access instrumentation that
> > + * the compiler cannot emit for: KASAN, KCSAN.
> > + */
> > +#ifndef _LINUX_INSTRUMENTED_H
> > +#define _LINUX_INSTRUMENTED_H
> > +
> > +#include <linux/compiler.h>
> > +#include <linux/kasan-checks.h>
> > +#include <linux/kcsan-checks.h>
> > +#include <linux/types.h>
> > +
> > +/**
> > + * instrument_read - instrument regular read access
> > + *
> > + * Instrument a regular read access. The instrumentation should be inserted
> > + * before the actual read happens.
> > + *
> > + * @ptr address of access
> > + * @size size of access
> > + */
>
> Based on offline discussion, that's what we add for KMSAN:
>
> > +static __always_inline void instrument_read(const volatile void *v, size_t size)
> > +{
> > +       kasan_check_read(v, size);
> > +       kcsan_check_read(v, size);
>
> KMSAN: nothing

KMSAN also has instrumentation in
copy_to_user_page/copy_from_user_page. Do we need to do anything for
KASAN/KCSAN for these functions?
