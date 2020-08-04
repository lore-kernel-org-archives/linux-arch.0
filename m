From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v5 07/12] kunit: test: create a single centralized
 executor for all tests
Date: Tue, 4 Aug 2020 13:06:10 -0700
Message-ID: <CAFd5g46sH+J9Un-2BTYMjruZ6bd+T35MsR2rCAKeVERV_JSoCw@mail.gmail.com>
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-8-brendanhiggins@google.com> <202006261423.0BC9D830@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <202006261423.0BC9D830@keescook>
Sender: linux-doc-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <skhan@linuxfoundation.org>, Alan Maguire <alan.maguire@oracle.com>, Iurii Zaikin <yzaikin@google.com>, David Gow <davidgow@google.com>, Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com, Frank Rowand <frowand.list@gmail.com>, catalin.marinas@arm.com, will@kernel.org, Michal Simek <monstr@monstr.eu>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Chris Zankel <chris@zankel.net>, jcmvbkbc@gmail.com, Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@kernel.org>, Logan Gunthorpe <logang@deltatee.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Jun 26, 2020 at 2:29 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jun 26, 2020 at 02:09:12PM -0700, Brendan Higgins wrote:
> > From: Alan Maguire <alan.maguire@oracle.com>
> >
> > Add a centralized executor to dispatch tests rather than relying on
> > late_initcall to schedule each test suite separately. Centralized
> > execution is for built-in tests only; modules will execute tests when
> > loaded.
> >
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Co-developed-by: Iurii Zaikin <yzaikin@google.com>
> > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> > Co-developed-by: Brendan Higgins <brendanhiggins@google.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  include/kunit/test.h | 67 +++++++++++++++++++++++++++++---------------
> >  lib/kunit/Makefile   |  3 +-
> >  lib/kunit/executor.c | 28 ++++++++++++++++++
> >  lib/kunit/test.c     |  2 +-
> >  4 files changed, 76 insertions(+), 24 deletions(-)
> >  create mode 100644 lib/kunit/executor.c
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 47e61e1d53370..f3e86c3953a2b 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -224,7 +224,7 @@ size_t kunit_suite_num_test_cases(struct kunit_suite *suite);
> >  unsigned int kunit_test_case_num(struct kunit_suite *suite,
> >                                struct kunit_case *test_case);
> >
> > -int __kunit_test_suites_init(struct kunit_suite **suites);
> > +int __kunit_test_suites_init(struct kunit_suite * const * const suites);
> >
> >  void __kunit_test_suites_exit(struct kunit_suite **suites);
> >
> > @@ -237,34 +237,57 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
> >   * Registers @suites_list with the test framework. See &struct kunit_suite for
> >   * more information.
> >   *
> > - * When builtin, KUnit tests are all run as late_initcalls; this means
> > - * that they cannot test anything where tests must run at a different init
> > - * phase. One significant restriction resulting from this is that KUnit
> > - * cannot reliably test anything that is initialize in the late_init phase;
> > - * another is that KUnit is useless to test things that need to be run in
> > - * an earlier init phase.
> > - *
> > - * An alternative is to build the tests as a module.  Because modules
> > - * do not support multiple late_initcall()s, we need to initialize an
> > - * array of suites for a module.
> > - *
> > - * TODO(brendanhiggins@google.com): Don't run all KUnit tests as
> > - * late_initcalls.  I have some future work planned to dispatch all KUnit
> > - * tests from the same place, and at the very least to do so after
> > - * everything else is definitely initialized.
> > + * If a test suite is built-in, module_init() gets translated into
> > + * an initcall which we don't want as the idea is that for builtins
> > + * the executor will manage execution.  So ensure we do not define
> > + * module_{init|exit} functions for the builtin case when registering
> > + * suites via kunit_test_suites() below.
> >   */
> > -#define kunit_test_suites(suites_list...)                            \
> > -     static struct kunit_suite *suites[] = {suites_list, NULL};      \
> > -     static int kunit_test_suites_init(void)                         \
> > +#ifdef MODULE
> > +#define kunit_test_suites_for_module(__suites)                               \
> > +     static int __init kunit_test_suites_init(void)                  \
> >       {                                                               \
> > -             return __kunit_test_suites_init(suites);                \
> > +             return __kunit_test_suites_init(__suites);              \
> >       }                                                               \
> > -     late_initcall(kunit_test_suites_init);                          \
> > +     module_init(kunit_test_suites_init);                            \
> > +                                                                     \
> >       static void __exit kunit_test_suites_exit(void)                 \
> >       {                                                               \
> > -             return __kunit_test_suites_exit(suites);                \
> > +             return __kunit_test_suites_exit(__suites);              \
> >       }                                                               \
> >       module_exit(kunit_test_suites_exit)
> > +#else
> > +#define kunit_test_suites_for_module(__suites)
> > +#endif /* MODULE */
> > +
> > +#define __kunit_test_suites(unique_array, unique_suites, ...)                       \
> > +     static struct kunit_suite *unique_array[] = { __VA_ARGS__, NULL };     \
> > +     kunit_test_suites_for_module(unique_array);                            \
> > +     static struct kunit_suite **unique_suites                              \
> > +     __used __section(.kunit_test_suites) = unique_array
> > +
> > +/**
> > + * kunit_test_suites() - used to register one or more &struct kunit_suite
> > + *                    with KUnit.
> > + *
> > + * @suites: a statically allocated list of &struct kunit_suite.
> > + *
> > + * Registers @suites with the test framework. See &struct kunit_suite for
> > + * more information.
> > + *
> > + * When builtin,  KUnit tests are all run via executor; this is done
> > + * by placing the array of struct kunit_suite * in the .kunit_test_suites
> > + * ELF section.
> > + *
> > + * An alternative is to build the tests as a module.  Because modules do not
> > + * support multiple initcall()s, we need to initialize an array of suites for a
> > + * module.
> > + *
> > + */
> > +#define kunit_test_suites(...)                                               \
> > +     __kunit_test_suites(__UNIQUE_ID(array),                         \
> > +                         __UNIQUE_ID(suites),                        \
> > +                         __VA_ARGS__)
> >
> >  #define kunit_test_suite(suite)      kunit_test_suites(&suite)
> >
> > diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> > index 724b94311ca36..c49f4ffb6273a 100644
> > --- a/lib/kunit/Makefile
> > +++ b/lib/kunit/Makefile
> > @@ -3,7 +3,8 @@ obj-$(CONFIG_KUNIT) +=                        kunit.o
> >  kunit-objs +=                                test.o \
> >                                       string-stream.o \
> >                                       assert.o \
> > -                                     try-catch.o
> > +                                     try-catch.o \
> > +                                     executor.o
> >
> >  ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
> >  kunit-objs +=                                debugfs.o
> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > new file mode 100644
> > index 0000000000000..7015e7328dce7
> > --- /dev/null
> > +++ b/lib/kunit/executor.c
> > @@ -0,0 +1,28 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <kunit/test.h>
> > +
> > +/*
> > + * These symbols point to the .kunit_test_suites section and are defined in
> > + * include/asm-generic/vmlinux.lds.h, and consequently must be extern.
> > + */
> > +extern struct kunit_suite * const * const __kunit_suites_start[];
> > +extern struct kunit_suite * const * const __kunit_suites_end[];
>
> I would expect these to be in include/asm-generic/sections.h but I guess
> it's not required.

I don't have strong opinions either way, but I think this is less
clutter since KUnit is the only one that uses it.

> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!
