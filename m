Return-Path: <SRS0=8Oio=5S=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38137 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389689AbgDBQUx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Apr 2020 12:20:53 -0400
MIME-Version: 1.0
References: <20200228002244.15240-1-keescook@chromium.org>
In-Reply-To: <20200228002244.15240-1-keescook@chromium.org>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Thu, 2 Apr 2020 18:20:57 +0200
Message-ID: <CA+icZUWTnP8DYfbaMwKtJbG30v7bB4w6=ywo8gn8fvwr731mUQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Enable orphan section warning
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@suse.de>, "H.J. Lu" <hjl.tools@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Clang-Built-Linux ML <clang-built-linux@googlegroups.com>, linux-kernel@vger.kernel.org
Message-ID: <20200402162057.MOJH-lns10Ug2GhgdFqnyqPq9-EIh1o1KNcjMLfxfxI@z>

On Fri, Feb 28, 2020 at 1:22 AM Kees Cook <keescook@chromium.org> wrote:
>
> Hi!
>
> A recent bug was solved for builds linked with ld.lld, and tracking
> it down took way longer than it needed to (a year). Ultimately, it
> boiled down to differences between ld.bfd and ld.lld's handling of
> orphan sections. Similarly, the recent FGKASLR series brough up orphan
> section handling too[2]. In both cases, it would have been nice if the
> linker was running with --orphan-handling=warn so that surprise sections
> wouldn't silently get mapped into the kernel image at locations up to
> the whim of the linker's orphan handling logic. Instead, all desired
> sections should be explicitly identified in the linker script (to be
> either kept or discarded) with any orphans throwing a warning. The
> powerpc architecture actually already does this, so this series seeks
> to extend this coverage to x86, arm64, and arm.
>
> This series depends on tip/x86/boot (where recent .eh_frame fixes[3]
> landed), and has a minor conflict[4] with the ARM tree (related to
> the earlier mentioned bug). As it uses refactorings in the asm-generic
> linker script, and makes changes to kbuild, I think the cleanest place
> for this series to land would also be through -tip. Once again (like
> my READ_IMPLIES_EXEC series), I'm looking to get maintainer Acks so
> this can go all together with the least disruption. Splitting it up by
> architecture seems needlessly difficult.
>
> Thanks!
>

Hi Kees,

what is the status of this patchset?
Looks like it is not in tip or linux-next Git.

Thanks.

Regards,
- Sedat -

> -Kees
>
> [1] https://github.com/ClangBuiltLinux/linux/issues/282
> [2] https://lore.kernel.org/lkml/202002242122.AA4D1B8@keescook/
> [3] https://lore.kernel.org/lkml/158264960194.28353.10560165361470246192.tip-bot2@tip-bot2/
> [4] https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8959/1
>
> H.J. Lu (1):
>   Add RUNTIME_DISCARD_EXIT to generic DISCARDS
>
> Kees Cook (8):
>   scripts/link-vmlinux.sh: Delay orphan handling warnings until final
>     link
>   vmlinux.lds.h: Add .gnu.version* to DISCARDS
>   x86/build: Warn on orphan section placement
>   x86/boot: Warn on orphan section placement
>   arm64/build: Use common DISCARDS in linker script
>   arm64/build: Warn on orphan section placement
>   arm/build: Warn on orphan section placement
>   arm/boot: Warn on orphan section placement
>
>  arch/arm/Makefile                             |  4 ++++
>  arch/arm/boot/compressed/Makefile             |  2 ++
>  arch/arm/boot/compressed/vmlinux.lds.S        | 17 ++++++--------
>  .../arm/{kernel => include/asm}/vmlinux.lds.h | 22 ++++++++++++++-----
>  arch/arm/kernel/vmlinux-xip.lds.S             |  5 ++---
>  arch/arm/kernel/vmlinux.lds.S                 |  5 ++---
>  arch/arm64/Makefile                           |  4 ++++
>  arch/arm64/kernel/vmlinux.lds.S               | 13 +++++------
>  arch/x86/Makefile                             |  4 ++++
>  arch/x86/boot/compressed/Makefile             |  3 ++-
>  arch/x86/boot/compressed/vmlinux.lds.S        | 13 +++++++++++
>  arch/x86/kernel/vmlinux.lds.S                 |  7 ++++++
>  include/asm-generic/vmlinux.lds.h             | 11 ++++++++--
>  scripts/link-vmlinux.sh                       |  6 +++++
>  14 files changed, 85 insertions(+), 31 deletions(-)
>  rename arch/arm/{kernel => include/asm}/vmlinux.lds.h (92%)
>
> --
> 2.20.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200228002244.15240-1-keescook%40chromium.org.
