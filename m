Return-Path: <SRS0=444k=AH=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFZVXN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Jun 2020 17:23:13 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8948FC03E97B
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2020 14:23:12 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x8so3817970plm.10
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2020 14:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-3-brendanhiggins@google.com> <202006261420.02E8E62@keescook>
In-Reply-To: <202006261420.02E8E62@keescook>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 26 Jun 2020 14:23:00 -0700
Message-ID: <CAFd5g47ZKJHzseyZT73uYB+EpAkyfN+gBj5X8ufZVnD6eG19eQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/12] arch: arm64: add linker section for KUnit test suites
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <skhan@linuxfoundation.org>, Alan Maguire <alan.maguire@oracle.com>, Iurii Zaikin <yzaikin@google.com>, David Gow <davidgow@google.com>, Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com, Frank Rowand <frowand.list@gmail.com>, catalin.marinas@arm.com, will@kernel.org, monstr@monstr.eu, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com, Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Luis Chamberlain <mcgrof@kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-arch@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, KUnit Development <kunit-dev@googlegroups.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org
Message-ID: <20200626212300.E2FqOY7brlFAir4IhxP2UHF7zHebKQjBu5ob1gnzjsc@z>

On Fri, Jun 26, 2020 at 2:20 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jun 26, 2020 at 02:09:07PM -0700, Brendan Higgins wrote:
> > Add a linker section to arm64 where KUnit can put references to its test
> > suites. This patch is an early step in transitioning to dispatching all
> > KUnit tests from a centralized executor rather than having each as its
> > own separate late_initcall.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  arch/arm64/kernel/vmlinux.lds.S | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> > index 6827da7f3aa54..a1cae9cc655d7 100644
> > --- a/arch/arm64/kernel/vmlinux.lds.S
> > +++ b/arch/arm64/kernel/vmlinux.lds.S
> > @@ -181,6 +181,9 @@ SECTIONS
> >               INIT_RAM_FS
> >               *(.init.rodata.* .init.bss)     /* from the EFI stub */
> >       }
> > +     .kunit_test_suites : {
> > +             KUNIT_TEST_SUITES
> > +     }
>
> See my reply to 01/12. Then this patch can be dropped. :)

Sweet, presumably this one and others.

> >       .exit.data : {
> >               EXIT_DATA
> >       }
> > --
> > 2.27.0.212.ge8ba1cc988-goog
> >
>
> --
> Kees Cook
