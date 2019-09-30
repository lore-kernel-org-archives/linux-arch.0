Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-01.nifty.com ([210.131.2.80]:31243 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbfI3MGT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Sep 2019 08:06:19 -0400
MIME-Version: 1.0
References: <20190830034304.24259-1-yamada.masahiro@socionext.com>
 <f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de> <CAKwvOdk=tr5nqq1CdZnUvRskaVqsUCP0SEciSGonzY5ayXsMXw@mail.gmail.com>
 <CAHk-=wiTy7hrA=LkmApBE9PQtri8qYsSOrf2zbms_crfjgR=Hw@mail.gmail.com> <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
In-Reply-To: <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 30 Sep 2019 21:05:11 +0900
Message-ID: <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Nick Desaulniers <ndesaulniers@google.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Stefan Wahren <wahrenst@gmx.net>, Kees Cook <keescook@google.com>
Message-ID: <20190930120511.LHp2GtUd1FJXXkMzV-Nbymys_LKvjEYgkJCn8ailsn0@z>

On Mon, Sep 30, 2019 at 8:26 PM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Sep 27, 2019 at 03:38:44PM -0700, Linus Torvalds wrote:
> > On Fri, Sep 27, 2019 at 3:08 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > So get_user() was passed a bad value/pointer from userspace? Do you
> > > know which of the tree calls to get_user() from sock_setsockopt() is
> > > failing?  (It's not immediately clear to me how this patch is at
> > > fault, vs there just being a bug in the source somewhere).
> >
> > Based on the error messages, the SO_PASSCRED ones are almost certainly
> > from the get_user() in net/core/sock.c: sock_setsockopt(), which just
> > does
> >
> >         if (optlen < sizeof(int))
> >                 return -EINVAL;
> >
> >         if (get_user(val, (int __user *)optval))
> >                 return -EFAULT;
> >
> >         valbool = val ? 1 : 0;
> >
> > but it's the other messages imply that a lot of other cases are
> > failing too (ie the "Failed to bind netlink socket" is, according to
> > google, a bind() that fails with the same EFAULT error).
> >
> > There are probably even more failures that happen elsewhere and just
> > don't even syslog the fact. I'd guess that all get_user() calls just
> > fail, and those are the ones that happen to get printed out.
> >
> > Now, _why_ it would fail, I have ni idea. There are several inlines in
> > the arm uaccess.h file, and it depends on other headers like
> > <asm/domain.h> with more inlines still - eg get/set_domain() etc.
> >
> > Soem of that code is pretty subtle. They have fixed register usage
> > (but the asm macros actually check them). And the inline asms clobber
> > the link register, but they do seem to clearly _state_ that they
> > clobber it, so who knows.
> >
> > Just based on the EFAULT, I'd _guess_ that it's some interaction with
> > the domain access control register (so that get/set_domain() thing).
> > But I'm not even sure that code is enabled for the Rpi2, so who
> > knows..
>
> FWIW, we've run into issues with CONFIG_OPTIMIZE_INLINING and local
> variables marked as 'register' where GCC would do crazy things and end
> up corrupting data, so I suspect the use of fixed registers in the arm
> uaccess functions is hitting something similar:
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91111


No. Not similar at all.


I fixed it already. See
https://lore.kernel.org/patchwork/patch/1132459/


The problems are fixable by writing correct code.




I think we discussed this already.

- There is nothing arch-specific in CONFIG_OPTIMIZE_INLINING

- 'inline' is just a hint. It does not guarantee function inlining.
  This is standard.

- The kernel macrofies 'inline' to add __attribute__((__always_inline__))
  This terrible hack must end.

-  __attribute__((__always_inline__)) takes aways compiler's freedom,
   and prevents it from optimizing the code for -O2, -Os, or whatever.





> Although this particular case couldn't be reproduced with GCC 9, prior
> versions of the compiler get it wrong so I'm very much opposed to enabling
> CONFIG_OPTIMIZE_INLINING by default on arm/arm64.
>
> Will


--
Best Regards
Masahiro Yamada
