Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-02.nifty.com ([210.131.2.81]:20323 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfI3GFD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Sep 2019 02:05:03 -0400
MIME-Version: 1.0
References: <20190830034304.24259-1-yamada.masahiro@socionext.com> <dc80461e8b9d2e715976ed0b02f41b84922d06f1.camel@suse.de>
In-Reply-To: <dc80461e8b9d2e715976ed0b02f41b84922d06f1.camel@suse.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 30 Sep 2019 15:04:18 +0900
Message-ID: <CAK7LNASsmRVDHeCyFTnWhQ1isTrWZ5LRpdf463yaqj6ycZiGQw@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Will Deacon <will@kernel.org>, Stefan Wahren <wahrenst@gmx.net>
Message-ID: <20190930060418.-63Hrrc4OaaGNfQQA31zrKnbXH9_GcJDBD8z49aypi8@z>

Hi.

On Fri, Sep 27, 2019 at 7:58 PM Nicolas Saenz Julienne
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
> [ Resending as the mail delivery system failed to resolve some the hosts,
> namely Masahiro's ]
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
>
> Regards,
> Nicolas
>
>

I posted a fix:
https://lore.kernel.org/patchwork/patch/1132459/

Thanks.



-- 
Best Regards
Masahiro Yamada
