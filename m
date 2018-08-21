Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-02.nifty.com ([210.131.2.81]:59589 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbeHUGIw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Aug 2018 02:08:52 -0400
MIME-Version: 1.0
In-Reply-To: <20180820223618.22319-2-paul.burton@mips.com>
References: <20180820183417.dejfsluih7elbclu@pburton-laptop>
 <20180820223618.22319-1-paul.burton@mips.com> <20180820223618.22319-2-paul.burton@mips.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 21 Aug 2018 11:49:48 +0900
Message-ID: <CAK7LNASarMBH8af=oTPoanEvJOS3zWTKx4MpGZe-AJiP2Wu41g@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] kbuild: Allow arch-specific asm/compiler.h
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Burton <paul.burton@mips.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, James Hogan <jhogan@kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Message-ID: <20180821024948.NYN-8Bba5p7SYMX5MnbjbdfvdIFgNr-kKHtMZ2Pkl50@z>

Hi Paul,


The code diff looks good to me.

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Just comments in the commit description.   See below.


2018-08-21 7:36 GMT+09:00 Paul Burton <paul.burton@mips.com>:
> We have a need to override the definition of
> barrier_before_unreachable() for MIPS, which means we either need to add
> architecture-specific code into linux/compiler-gcc.h or we need to allow
> the architecture to provide a header that can define the macro before
> the generic definition. The latter seems like the better approach.
>
> A straightforward approach to the per-arch header is to make use of
> asm-generic to provide a default empty header & adjust architectures
> which don't need anything specific to make use of that by adding the
> header to generic-y. Unfortunately this doesn't work so well due to
> commit a95b37e20db9 ("kbuild: get <linux/compiler_types.h> out of
> <linux/kconfig.h>") which moved the inclusion of linux/compiler.h to
> cflags using the -include compiler flag.


I doubt this statement.

Commit a95b37e20db9 is not the cause of the problem.

include/linux/kconfig.h is also included
by using the -include compiler flag.


See the top-level Makefile.

USERINCLUDE    := \
                -I$(srctree)/arch/$(SRCARCH)/include/uapi \
                -I$(objtree)/arch/$(SRCARCH)/include/generated/uapi \
                -I$(srctree)/include/uapi \
                -I$(objtree)/include/generated/uapi \
                -include $(srctree)/include/linux/kconfig.h


So, <linux/compiler_types.h> (then, <asm/compiler.h>)
would be also required for all C files
in the archprepare stage regardless of commit a95b37e20db9.


The change happened in commit 28128c61e08e.



One more thing, you are not touching any makefile in this version.

Maybe, you can prefix the subject with "compiler.h:" or something
instead of "kbuild:".





> Because the -include flag is present for all C files we compile, we need
> the architecture-provided header to be present before any C files are
> compiled. If any C files can be compiled prior to the asm-generic header
> wrappers being generated then we hit a build failure due to missing
> header. Such cases do exist - one pointed out by the kbuild test robot
> is the compilation of arch/ia64/kernel/nr-irqs.c, which occurs as part
> of the archprepare target [1].
>
> This leaves us with a few options:
>
>   1) Use generic-y & fix any build failures we find by enforcing
>      ordering such that the asm-generic target occurs before any C
>      compilation, such that linux/compiler_types.h can always include
>      the generated asm-generic wrapper which in turn includes the empty
>      asm-generic header. This would rely on us finding all the
>      problematic cases - I don't know for sure that the ia64 issue is
>      the only one.
>
>   2) Add an actual empty header to each architecture, so that we don't
>      need the generated asm-generic wrapper. This seems messy.
>
>   3) Give up & add #ifdef CONFIG_MIPS or similar to
>      linux/compiler_types.h. This seems messy too.
>
>   4) Include the arch header only when it's actually needed, removing
>      the need for the asm-generic wrapper for all other architectures.
>
> This patch allows us to use approach 4, by including an asm/compiler.h
> header from linux/compiler_types.h after the inclusion of the
> compiler-specific linux/compiler-*.h header(s). We do this
> conditionally, only when CONFIG_HAVE_ARCH_COMPILER_H is selected, in
> order to avoid the need for asm-generic wrappers & the associated build
> ordering issue described above. The asm/compiler.h header is included
> after the generic linux/compiler-*.h header(s) for consistency with the
> way linux/compiler-intel.h & linux/compiler-clang.h are included after
> the linux/compiler-gcc.h header that they override.
>
> [1] https://lists.01.org/pipermail/kbuild-all/2018-August/051175.html
>
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-mips@linux-mips.org
