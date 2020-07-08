Return-Path: <SRS0=HA2T=AT=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41078 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgGHEbb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2020 00:31:31 -0400
Date: Wed, 8 Jul 2020 04:31:28 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v5 01/12] vmlinux.lds.h: add linker section for KUnit
 test suites
Message-ID: <20200708043128.GY4332@42.do-not-panic.com>
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-2-brendanhiggins@google.com>
 <202006261416.F4EAAE47E3@keescook>
 <CAFd5g47vu5vmrXnS0sLu+hdC2HmYz7GY82sE8rhcHfNkuC1NRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g47vu5vmrXnS0sLu+hdC2HmYz7GY82sE8rhcHfNkuC1NRw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Kees Cook <keescook@chromium.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <skhan@linuxfoundation.org>, Alan Maguire <alan.maguire@oracle.com>, Iurii Zaikin <yzaikin@google.com>, David Gow <davidgow@google.com>, Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com, Frank Rowand <frowand.list@gmail.com>, catalin.marinas@arm.com, will@kernel.org, monstr@monstr.eu, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com, Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, linux-um <linux-um@lists.infradead.org>, linux-arch@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, KUnit Development <kunit-dev@googlegroups.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org
Message-ID: <20200708043128.qPsoEPohRqZl1uXx9qIFGbZGnJTtf5v8hBCILB6zf7M@z>

On Fri, Jun 26, 2020 at 02:22:11PM -0700, Brendan Higgins wrote:
> On Fri, Jun 26, 2020 at 2:20 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Jun 26, 2020 at 02:09:06PM -0700, Brendan Higgins wrote:
> > > Add a linker section where KUnit can put references to its test suites.
> > > This patch is the first step in transitioning to dispatching all KUnit
> > > tests from a centralized executor rather than having each as its own
> > > separate late_initcall.
> > >
> > > Co-developed-by: Iurii Zaikin <yzaikin@google.com>
> > > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > > ---
> > >  include/asm-generic/vmlinux.lds.h | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > > index db600ef218d7d..4f9b036fc9616 100644
> > > --- a/include/asm-generic/vmlinux.lds.h
> > > +++ b/include/asm-generic/vmlinux.lds.h
> > > @@ -881,6 +881,13 @@
> > >               KEEP(*(.con_initcall.init))                             \
> > >               __con_initcall_end = .;
> > >
> > > +/* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
> >
> > Nit on naming:
> >
> > > +#define KUNIT_TEST_SUITES                                            \
> >
> > I would call this KUNIT_TABLE to maintain the same names as other things
> > of this nature.
> >
> > > +             . = ALIGN(8);                                           \
> > > +             __kunit_suites_start = .;                               \
> > > +             KEEP(*(.kunit_test_suites))                             \
> > > +             __kunit_suites_end = .;
> > > +
> > >  #ifdef CONFIG_BLK_DEV_INITRD
> > >  #define INIT_RAM_FS                                                  \
> > >       . = ALIGN(4);                                                   \
> > > @@ -1056,6 +1063,7 @@
> > >               INIT_CALLS                                              \
> > >               CON_INITCALL                                            \
> > >               INIT_RAM_FS                                             \
> > > +             KUNIT_TEST_SUITES                                       \
> > >       }
> >
> > Nack: this must be in INIT_DATA, not in INIT_DATA_SECTION. Not all
> > architectures use the INIT_DATA_SECTION macro (e.g. arm64), but everything
> > uses INIT_DATA.
> 
> Oh, maybe that would eliminate the need for the other linkerscript
> patches? That would be nice.

Curious, did changing it as Kees suggest fix it for m68k?

  Luis
