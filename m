From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [RFC v1 4/6] init: main: add KUnit to kernel init
Date: Thu, 23 Jan 2020 14:45:43 -0800
Message-ID: <CAFd5g47=FxbKtm9rA3zKvnipdTdP_VR8zJ3pad-QukL5Ottrjw@mail.gmail.com>
References: <20191216220555.245089-1-brendanhiggins@google.com>
 <20191216220555.245089-5-brendanhiggins@google.com> <20191217075836.C76942072D@mail.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191217075836.C76942072D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alan Maguire <alan.maguire@oracle.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>, Jeff Dike <jdike@addtoit.com>, Kees Cook <keescook@chromium.org>, Richard Weinberger <richard@nod.at>, rppt@linux.ibm.com, Shuah Khan <skhan@linuxfoundation.org>, Iurii Zaikin <yzaikin@google.com>, Greg KH <gregkh@linuxfoundation.org>, Logan Gunthorpe <logang@deltatee.com>, Luis Chamberlain <mcgrof@kernel.org>, Knut Omang <knut.omang@oracle.com>, linux-um <linux-um@lists.infradead.org>, linux-arch@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, KUnit Development <kunit-dev@googlegroups.com>, Linux
List-Id: linux-arch.vger.kernel.org

Sorry for the late reply. I sent this thinking I would check in over
vacation, and then didn't.

On Mon, Dec 16, 2019 at 11:58 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-12-16 14:05:53)
> > Remove KUnit from init calls entirely, instead call directly from
> > kernel_init().
>
> Yes, but why? Is it desired to run the unit tests earlier than opening
> the console or something?

I want to make sure it is called after late_init is done (so that you
can test things initialized in late_init). And I want to make sure it
runs before init*fs is loaded so that there is a mechanism to run
tests without having to put a userland together.

> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > index 978086cfd257d..ca880224c0bab 100644
> > --- a/lib/kunit/executor.c
> > +++ b/lib/kunit/executor.c
> > @@ -32,12 +32,10 @@ static bool kunit_run_all_tests(void)
> >         return !has_test_failed;
> >  }
> >
> > -static int kunit_executor_init(void)
> > +int kunit_executor_init(void)
>
> Should be marked __init? Even before this patch presumably.

Just this function? No strong opinion.

If by "before this patch" you mean other stuff in this patchset?

> >  {
> >         if (kunit_run_all_tests())
> >                 return 0;
> >         else
> >                 return -EFAULT;
> >  }
> > -
> > -late_initcall(kunit_executor_init);
