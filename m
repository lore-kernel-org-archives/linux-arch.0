Return-Path: <SRS0=8Oio=5S=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39072 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388815AbgDBR0l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Apr 2020 13:26:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id g32so2149326pgb.6
        for <linux-arch@vger.kernel.org>; Thu, 02 Apr 2020 10:26:40 -0700 (PDT)
Date: Thu, 2 Apr 2020 10:26:38 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 0/9] Enable orphan section warning
Message-ID: <202004021023.D3D8AA3BE@keescook>
References: <20200228002244.15240-1-keescook@chromium.org>
 <CA+icZUWTnP8DYfbaMwKtJbG30v7bB4w6=ywo8gn8fvwr731mUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUWTnP8DYfbaMwKtJbG30v7bB4w6=ywo8gn8fvwr731mUQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Borislav Petkov <bp@suse.de>, "H.J. Lu" <hjl.tools@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Clang-Built-Linux ML <clang-built-linux@googlegroups.com>, linux-kernel@vger.kernel.org
Message-ID: <20200402172638.2EOK0j1KkO_fLOvAW36Gndqio9cG-Z98KeSWv5o6jtY@z>

On Thu, Apr 02, 2020 at 06:20:57PM +0200, Sedat Dilek wrote:
> On Fri, Feb 28, 2020 at 1:22 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Hi!
> >
> > A recent bug was solved for builds linked with ld.lld, and tracking
> > it down took way longer than it needed to (a year). Ultimately, it
> > boiled down to differences between ld.bfd and ld.lld's handling of
> > orphan sections. Similarly, the recent FGKASLR series brough up orphan
> > section handling too[2]. In both cases, it would have been nice if the
> > linker was running with --orphan-handling=warn so that surprise sections
> > wouldn't silently get mapped into the kernel image at locations up to
> > the whim of the linker's orphan handling logic. Instead, all desired
> > sections should be explicitly identified in the linker script (to be
> > either kept or discarded) with any orphans throwing a warning. The
> > powerpc architecture actually already does this, so this series seeks
> > to extend this coverage to x86, arm64, and arm.
> >
> > This series depends on tip/x86/boot (where recent .eh_frame fixes[3]
> > landed), and has a minor conflict[4] with the ARM tree (related to
> > the earlier mentioned bug). As it uses refactorings in the asm-generic
> > linker script, and makes changes to kbuild, I think the cleanest place
> > for this series to land would also be through -tip. Once again (like
> > my READ_IMPLIES_EXEC series), I'm looking to get maintainer Acks so
> > this can go all together with the least disruption. Splitting it up by
> > architecture seems needlessly difficult.
> >
> > Thanks!
> >
> 
> Hi Kees,
> 
> what is the status of this patchset?
> Looks like it is not in tip or linux-next Git.

Based on the feedback, I have 3 TODO items:

- track down and eliminate (or explain) the source of the .got.plt on arm64
- enable orphan warnings for _all_ architectures
- refactor final link logic to perform the orphan warning in a clean way

I'm working through these (and other work) still. I'm hoping to have
another version up some time next week.

-- 
Kees Cook
