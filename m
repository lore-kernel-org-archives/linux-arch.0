From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v3 4/7] init: main: add KUnit to kernel init
Date: Wed, 24 Jun 2020 13:20:35 -0700
Message-ID: <CAFd5g45Jz-5wtO-YNuqPN2Zc_rJtoA1qbPLVs2wrJFQyZpd5QQ@mail.gmail.com>
References: <20200228012036.15682-5-brendanhiggins@google.com> <202003021439.A6B6FD8@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <202003021439.A6B6FD8@keescook>
Sender: linux-doc-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Frank Rowand <frowand.list@gmail.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <skhan@linuxfoundation.org>, Alan Maguire <alan.maguire@oracle.com>, Iurii Zaikin <yzaikin@google.com>, David Gow <davidgow@google.com>, Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com, Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Luis Chamberlain <mcgrof@kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-arch@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, KUnit Development <kunit-dev@googlegroups.com>, Linux
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 2, 2020 at 2:45 PM Kees Cook <keescook@chromium.org> wrote:

Sorry it took so long to respond. I am reviving this patchset now,
about to send out a new revision and I just saw this comment.

> On 2/27/20 7:20 PM, Brendan Higgins wrote:
> > Remove KUnit from init calls entirely, instead call directly from
> > kernel_init().
> >
> > Co-developed-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > [...]
> > diff --git a/init/main.c b/init/main.c
> > index ee4947af823f3..7875a5c486dc4 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -104,6 +104,8 @@
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/initcall.h>
> >
> > +#include <kunit/test.h>
> > +
> >  static int kernel_init(void *);
> >
> >  extern void init_IRQ(void);
> > @@ -1444,6 +1446,8 @@ static noinline void __init kernel_init_freeable(void)
> >
> >       do_basic_setup();
> >
> > +     kunit_run_all_tests();
> > +
> >       console_on_rootfs();
> >
> >       /*
>
> I'm nervous about this happening before two key pieces of the kernel
> setup, which might lead to weird timing-sensitive bugs or false
> positives:
>         async_synchronize_full()
>         mark_readonly()
>
> Now, I realize kunit tests _should_ be self-contained, but this seems
> like a possible robustness problem. Is there any reason this can't be
> moved after rcu_end_inkernel_boot() in kernel_init() instead?

I tried that, but it doesn't work without an initramfs. We could add
an initramfs for KUnit at some point if highly desired, but I think
that is outside the scope of this patchset. Additionally, this patch
actually moves running tests to later in the init process, which is
still an improvement over the way KUnit works today.

There are some other reasons I wouldn't want to make that change right
now, which will become apparent in a patch that I will send out in
short order.

Cheers
