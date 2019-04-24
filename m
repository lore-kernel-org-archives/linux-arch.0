Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-03.nifty.com ([210.131.2.82]:39541 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfDXDlx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Apr 2019 23:41:53 -0400
MIME-Version: 1.0
References: <CAK7LNAQwHRJL=3yD_7P2mMSVnwZbayww+dHC22+v4oTpMZv58w@mail.gmail.com>
 <CALCETrVSM0vrMVr2y0ECAQ=tNGvBs=im2Kxongq-jvdzUBevbg@mail.gmail.com> <CAHk-=wiV2gLQkp6JFQYewL1uzgWnwEK9fKWP3AfZbcu2Lv_GrQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiV2gLQkp6JFQYewL1uzgWnwEK9fKWP3AfZbcu2Lv_GrQ@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 24 Apr 2019 12:40:48 +0900
Message-ID: <CAK7LNAQYXE6R+ZPCP_3D3YPczbsmeqHUFN-r0NhFu_TPYz99Qw@mail.gmail.com>
Subject: Re: Does vdso_install attempt to re-compile objects under root privilege?
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <20190424034048.suKhhRIeohaqdDwbtG6Y1H5ADkWNA-HcImqj_u9wxzw@z>

On Wed, Apr 24, 2019 at 8:40 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Apr 23, 2019 at 11:47 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > Hmm.  I suppose an alternative would be for vdso_install to fail if
> > the vdso isn't built?
>
> I absolutely abhor even the concept of building the kernel as root,
> and I think it should be actively disallowed. Our build system is
> good, but it's good as in "clever and complex" rather than necessarily
> good as in "very secure".
>
> So anybody who builds the kernel as root is doing something seriously
> wrong, in my opinion.
>
> That's partly exactly _because_ we have a lot of magical and very
> powerful build rules, and complicated implicit things going on.
>
> For example, our dependencies aren't even about just the files in the
> kernel repository itself, we have clever things like "if the compiler
> has been updated and features or version changes, we'll automatically
> rebuild, because it's part of our clever build system checks".
>
> But that is also part of the reason why I absolutely do *not* want any
> root-building to happen, because our build setup is simply way too
> clever.
>
> If root builds stuff, you'll end up with root-owned generated
> subdirectories or various config files etc, and even if you don't have
> security issues, it can complicate the build later as a regular user.
>
> I've had the build occasionally fail in odd ways, because some
> root-owned file was now no longer removable (usually it's the
> auto-generated header files in the directory, and the root-generated
> and owned directory is now not writable by the developer any more).
> And every time it happens, I shudder.
>
> So all of that simply boils down to "root should not be running those
> complex rules for our config and dependency magic".
>
> At the same time, "make install" obviously needs to be done as root.
>
> All of which is why I opine that "make install" should never build
> anything at all, it should purely be used as a "install previously
> built files".
>
> So yes, I'd much prefer just failing over trying to build as root (or
> even trying to figure out dependencies as root).
>
> > What's the ideal outcome here?
>
> I'd basically like the rule for "make install" to be that it never
> ever generates a single file in the build tree, so that there are
> never any root-owned (or root-overwritten) files there.
>
> So "make install" should even avoid all dependency checking, for the
> simple reason that if you happen to do a system update between "make"
> and "make install", our smart dependencies should never say "oh, the
> compiler version has changed, so now I'll rebuild everything as root
> just because 'make install'".
>
> So I think the ideal outcome is just "fail if you can't find the files
> to install".
>
>                      Linus

I assume this is ACK to change vdso Makefiles.
I will send patches.

Thanks.

-- 
Best Regards
Masahiro Yamada
