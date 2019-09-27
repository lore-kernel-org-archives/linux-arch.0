Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41364 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfI0WId (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Sep 2019 18:08:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id t10so1583578plr.8
        for <linux-arch@vger.kernel.org>; Fri, 27 Sep 2019 15:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190830034304.24259-1-yamada.masahiro@socionext.com> <f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de>
In-Reply-To: <f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 27 Sep 2019 15:08:20 -0700
Message-ID: <CAKwvOdk=tr5nqq1CdZnUvRskaVqsUCP0SEciSGonzY5ayXsMXw@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, rmk+kernel@arm.linux.org.uk, Will Deacon <will@kernel.org>, Stefan Wahren <wahrenst@gmx.net>, Kees Cook <keescook@google.com>
Message-ID: <20190927220820.74ib3pRWqwJmALMwKvtymHoFyWKIZ_OldMfi92zAO1s@z>

On Fri, Sep 27, 2019 at 3:43 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Fri, 2019-08-30 at 12:43 +0900, Masahiro Yamada wrote:
> > Commit 9012d011660e ("compiler: allow all arches to enable
> > CONFIG_OPTIMIZE_INLINING") allowed all architectures to enable
> > this option. A couple of build errors were reported by randconfig,
> > but all of them have been ironed out.
> >
> > Towards the goal of removing CONFIG_OPTIMIZE_INLINING entirely
> > (and it will simplify the 'inline' macro in compiler_types.h),
> > this commit changes it to always-on option. Going forward, the
> > compiler will always be allowed to not inline functions marked
> > 'inline'.
> >
> > This is not a problem for x86 since it has been long used by
> > arch/x86/configs/{x86_64,i386}_defconfig.
> >
> > I am keeping the config option just in case any problem crops up for
> > other architectures.
> >
> > The code clean-up will be done after confirming this is solid.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> [ Adding some ARM people as they might be able to help ]
>
> This was found to cause a regression on a Raspberry Pi 2 B built with
> bcm2835_defconfig which among other things has no SMP support.
>
> The relevant logs (edited to remove the noise) are:
>
> [    5.827333] Run /init as init process
> Loading, please wait...
> Failed to set SO_PASSCRED: Bad address
> Failed to bind netlink socket: Bad address
> Failed to create manager: Bad address
> Failed to set SO_PASSCRED: Bad address
> [    9.021623] systemd[1]: SO_PASSCRED failed: Bad address
> [!!!!!!] Failed to start up manager.
> [    9.079148] systemd[1]: Freezing execution.
>
> I looked into it, it turns out that the call to get_user() in sock_setsockopt()
> is returning -EFAULT. Down the assembly rabbit hole that get_user() is I
> found-out that it's the macro 'check_uaccess' who's triggering the error.
>
> I'm clueless at this point, so I hope you can give me some hints on what's
> going bad here.

So get_user() was passed a bad value/pointer from userspace? Do you
know which of the tree calls to get_user() from sock_setsockopt() is
failing?  (It's not immediately clear to me how this patch is at
fault, vs there just being a bug in the source somewhere).
-- 
Thanks,
~Nick Desaulniers
