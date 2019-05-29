Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io1-f68.google.com ([209.85.166.68]:41685 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfE2IzL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 04:55:11 -0400
Received: by mail-io1-f68.google.com with SMTP id w25so1130670ioc.8
        for <linux-arch@vger.kernel.org>; Wed, 29 May 2019 01:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190528163258.260144-1-elver@google.com> <20190528163258.260144-2-elver@google.com>
 <20190528171942.GV2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190528171942.GV2623@hirez.programming.kicks-ass.net>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 29 May 2019 10:54:58 +0200
Message-ID: <CACT4Y+ZK5i0r0GSZUOBGGOE0bzumNor1d89W8fvphF6EDqKqHg@mail.gmail.com>
Subject: Re: [PATCH 2/3] tools/objtool: add kasan_check_* to uaccess whitelist
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Marco Elver <elver@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@google.com>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@redhat.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Message-ID: <20190529085458.YbZtdqnxmN_7T-D1TphiAkA67UqTod_cuxY1XHVXUMM@z>

On Tue, May 28, 2019 at 7:19 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, May 28, 2019 at 06:32:57PM +0200, Marco Elver wrote:
> > This is a pre-requisite for enabling bitops instrumentation. Some bitops
> > may safely be used with instrumentation in uaccess regions.
> >
> > For example, on x86, `test_bit` is used to test a CPU-feature in a
> > uaccess region:   arch/x86/ia32/ia32_signal.c:361
>
> That one can easily be moved out of the uaccess region. Any else?

Marco, try to update config with "make allyesconfig" and then build
the kernel without this change.

>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  tools/objtool/check.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index 172f99195726..eff0e5209402 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -443,6 +443,8 @@ static void add_ignores(struct objtool_file *file)
> >  static const char *uaccess_safe_builtin[] = {
> >       /* KASAN */
> >       "kasan_report",
> > +     "kasan_check_read",
> > +     "kasan_check_write",
> >       "check_memory_region",
> >       /* KASAN out-of-line */
> >       "__asan_loadN_noabort",
> > --
> > 2.22.0.rc1.257.g3120a18244-goog
> >
