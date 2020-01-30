From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v1 6/7] kunit: Add 'kunit_shutdown' option
Date: Thu, 30 Jan 2020 14:56:47 -0800
Message-ID: <CAFd5g44OO7Lany3U9dn-Axbsf2YBQ4fynvRpkqYYf-N1AhNMQQ@mail.gmail.com>
References: <20200128072002.79250-1-brendanhiggins@google.com>
 <20200128072002.79250-7-brendanhiggins@google.com> <20200129063307.19CB4206F0@mail.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200129063307.19CB4206F0@mail.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alan Maguire <alan.maguire@oracle.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>, Frank Rowand <frowand.list@gmail.com>, Jeff Dike <jdike@addtoit.com>, Kees Cook <keescook@chromium.org>, Richard Weinberger <richard@nod.at>, rppt@linux.ibm.com, Shuah Khan <skhan@linuxfoundation.org>, Iurii Zaikin <yzaikin@google.com>, Greg KH <gregkh@linuxfoundation.org>, Logan Gunthorpe <logang@deltatee.com>, Luis Chamberlain <mcgrof@kernel.org>, Knut Omang <knut.omang@oracle.com>, linux-um <linux-um@lists.infradead.org>, linux-arch@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, KUnit Development <kunit-d>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 28, 2020 at 10:33 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2020-01-27 23:20:01)
> > From: David Gow <davidgow@google.com>
> >
> > Add a new kernel command-line option, 'kunit_shutdown', which allows the
> > user to specify that the kernel poweroff, halt, or reboot after
> > completing all KUnit tests; this is very handy for running KUnit tests
> > on UML or a VM so that the UML/VM process exits cleanly immediately
> > after running all tests without needing a special initramfs.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
>
> Two nitpicks below
>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>
> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > index 7fd16feff157e..d3ec1265a72fd 100644
> > --- a/lib/kunit/executor.c
> > +++ b/lib/kunit/executor.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >
> >  #include <kunit/test.h>
> > +#include <linux/reboot.h>
>
> Should this include come before kunit/test.h? I imagine the order of
> includes would be linux, kunit, local?

I think some reviewers/maintainers want them all to be alphabetical.
So I have probably done it both ways in the past. Will fix.

> >
> >  /*
> >   * These symbols point to the .kunit_test_suites section and are defined in
> > @@ -11,6 +12,23 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
> >
> >  #if IS_BUILTIN(CONFIG_KUNIT)
> >
> > +static char *kunit_shutdown;
> > +core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
> > +
> > +static void kunit_handle_shutdown(void)
> > +{
> > +       if (!kunit_shutdown)
> > +               return;
> > +
> > +       if (!strcmp(kunit_shutdown, "poweroff")) {
> > +               kernel_power_off();
> > +       } else if (!strcmp(kunit_shutdown, "halt")) {
> > +               kernel_halt();
> > +       } else if (!strcmp(kunit_shutdown, "reboot")) {
> > +               kernel_restart(NULL);
> > +       }
>
> Kernel style would be to not have braces on single line if statements.

Whoops. Sometimes I forget :-)

> > +}
> > +
> >  static void kunit_print_tap_header(void)
> >  {
> >         struct kunit_suite * const * const *suites, * const *subsuite;

Thanks!
