Return-Path: <SRS0=/o7P=4U=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52432 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgCCEcy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2020 23:32:54 -0500
Received: by mail-pj1-f66.google.com with SMTP id lt1so770221pjb.2
        for <linux-arch@vger.kernel.org>; Mon, 02 Mar 2020 20:32:53 -0800 (PST)
Date: Mon, 2 Mar 2020 20:32:51 -0800
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 0/9] Enable orphan section warning
Message-ID: <202003022029.B549AA3@keescook>
References: <20200228002244.15240-1-keescook@chromium.org>
 <CA+icZUVRnjOWKZynAGDniXD_H9KRccONmeKHs25DPPU1c8ZcGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUVRnjOWKZynAGDniXD_H9KRccONmeKHs25DPPU1c8ZcGg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Borislav Petkov <bp@suse.de>, "H.J. Lu" <hjl.tools@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Clang-Built-Linux ML <clang-built-linux@googlegroups.com>, linux-kernel@vger.kernel.org
Message-ID: <20200303043251.qYcZtE8wYIYYjJSmSXhxWp7dxtLEvRuIUEIyzBE7pW8@z>

On Fri, Feb 28, 2020 at 07:51:21AM +0100, Sedat Dilek wrote:
> On Fri, Feb 28, 2020 at 1:22 AM Kees Cook <keescook@chromium.org> wrote:
> > This series depends on tip/x86/boot (where recent .eh_frame fixes[3]
> > landed), and has a minor conflict[4] with the ARM tree (related to
> > the earlier mentioned bug). As it uses refactorings in the asm-generic
> > linker script, and makes changes to kbuild, I think the cleanest place
> > for this series to land would also be through -tip. Once again (like
> > my READ_IMPLIES_EXEC series), I'm looking to get maintainer Acks so
> > this can go all together with the least disruption. Splitting it up by
> > architecture seems needlessly difficult.
> 
> Hi Kees,
> 
> is this an updated version of what you have in your
> kees/linux.git#linker/orphans/x86-arm Git branch?

Hi; yes indeed.

> Especially, I saw a difference in [2] and "[PATCH 4/9] x86/boot: Warn
> on orphan section placement"
> 
> [ arch/x86/boot/compressed/Makefile ]
> 
> +KBUILD_LDFLAGS += --no-ld-generated-unwind-info
> 
> Can you comment on why this KBUILD_LDFLAGS was added/needed?

It looks like the linker decided to add .eh_frame sections even when all
the .o files lacked it. Adding this flag solved it (which I prefer over
adding it to DISCARD).

> I like when people offer their work in a Git branch.
> Do you plan to do that?

Since it was based on a -tip sub-branch I didn't push a
copy, but since you asked here it is:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=orphans/tip/x86/boot

And this email can serve as a "ping" to the arch maintainers too...
does this all look okay to you? I think it'd be a nice improvement. :)

Thanks!

-Kees

> Thanks.
> 
> Regards,
> - Sedat -
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=linker/orphans/x86-arm
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=linker/orphans/x86-arm&id=e43aa77956c40b9b6db0b37b3780423aa2e661ad
> 
> 
> 
> > H.J. Lu (1):
> >   Add RUNTIME_DISCARD_EXIT to generic DISCARDS
> >
> > Kees Cook (8):
> >   scripts/link-vmlinux.sh: Delay orphan handling warnings until final
> >     link
> >   vmlinux.lds.h: Add .gnu.version* to DISCARDS
> >   x86/build: Warn on orphan section placement
> >   x86/boot: Warn on orphan section placement
> >   arm64/build: Use common DISCARDS in linker script
> >   arm64/build: Warn on orphan section placement
> >   arm/build: Warn on orphan section placement
> >   arm/boot: Warn on orphan section placement
> >
> >  arch/arm/Makefile                             |  4 ++++
> >  arch/arm/boot/compressed/Makefile             |  2 ++
> >  arch/arm/boot/compressed/vmlinux.lds.S        | 17 ++++++--------
> >  .../arm/{kernel => include/asm}/vmlinux.lds.h | 22 ++++++++++++++-----
> >  arch/arm/kernel/vmlinux-xip.lds.S             |  5 ++---
> >  arch/arm/kernel/vmlinux.lds.S                 |  5 ++---
> >  arch/arm64/Makefile                           |  4 ++++
> >  arch/arm64/kernel/vmlinux.lds.S               | 13 +++++------
> >  arch/x86/Makefile                             |  4 ++++
> >  arch/x86/boot/compressed/Makefile             |  3 ++-
> >  arch/x86/boot/compressed/vmlinux.lds.S        | 13 +++++++++++
> >  arch/x86/kernel/vmlinux.lds.S                 |  7 ++++++
> >  include/asm-generic/vmlinux.lds.h             | 11 ++++++++--
> >  scripts/link-vmlinux.sh                       |  6 +++++
> >  14 files changed, 85 insertions(+), 31 deletions(-)
> >  rename arch/arm/{kernel => include/asm}/vmlinux.lds.h (92%)

-- 
Kees Cook
