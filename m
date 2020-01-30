Return-Path: <brendanhiggins@google.com>
MIME-Version: 1.0
References: <20200128072002.79250-1-brendanhiggins@google.com>
 <20200128072002.79250-8-brendanhiggins@google.com> <20200129062709.5B2A22067C@mail.kernel.org>
In-Reply-To: <20200129062709.5B2A22067C@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 30 Jan 2020 15:04:47 -0800
Message-ID: <CAFd5g47cha8DJdS9x=Qjj-vLXjGOugQK38Ln85eznfuN11cLrQ@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] Documentation: Add kunit_shutdown to kernel-parameters.txt
Content-Type: text/plain; charset="UTF-8"
To: Stephen Boyd <sboyd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alan Maguire <alan.maguire@oracle.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>, Frank Rowand <frowand.list@gmail.com>, Jeff Dike <jdike@addtoit.com>, Kees Cook <keescook@chromium.org>, Richard Weinberger <richard@nod.at>, rppt@linux.ibm.com, Shuah Khan <skhan@linuxfoundation.org>, Iurii Zaikin <yzaikin@google.com>, Greg KH <gregkh@linuxfoundation.org>, Logan Gunthorpe <logang@deltatee.com>, Luis Chamberlain <mcgrof@kernel.org>, Knut Omang <knut.omang@oracle.com>, linux-um <linux-um@lists.infradead.org>, linux-arch@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, KUnit Development <kunit-dev@googlegroups.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200130230447.K9EgMj62mMZcuYmrJj040LyGke7Og2OLFLHR8qFKbas@z>

On Tue, Jan 28, 2020 at 10:27 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2020-01-27 23:20:02)
> > Add kunit_shutdown, an option to specify that the kernel shutsdown after
> > running KUnit tests, to the kernel-parameters.txt documentation.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index ade4e6ec23e03..0472b02ce16bb 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2054,6 +2054,13 @@
> >                         0: force disabled
> >                         1: force enabled
> >
> > +       kunit_shutdown  [KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel after
> > +                       running tests.
> > +                       Default:        (flag not present) don't shutdown
> > +                       poweroff:       poweroff the kernel after running tests.
> > +                       halt:           halt the kernel after running tests.
> > +                       reboot:         reboot the kernel after running tests.
>
> Maybe drop the full stops on the short descriptions.

Will fix.

> Otherwise,
>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>

Thanks!
