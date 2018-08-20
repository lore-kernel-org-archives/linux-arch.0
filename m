Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr730113.outbound.protection.outlook.com ([40.107.73.113]:28539
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726089AbeHTVvY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Aug 2018 17:51:24 -0400
Date: Mon, 20 Aug 2018 11:34:17 -0700
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v8 1/2] kbuild: Allow asm-specific compiler_types.h
Message-ID: <20180820183417.dejfsluih7elbclu@pburton-laptop>
References: <20180818181017.1246-1-paul.burton@mips.com>
 <20180818181017.1246-2-paul.burton@mips.com>
 <CAK7LNASM_ZThZRwFQJFaYqurqUVayNGPM6c7gnuHERYN7T4M3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASM_ZThZRwFQJFaYqurqUVayNGPM6c7gnuHERYN7T4M3g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, James Hogan <jhogan@kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Message-ID: <20180820183417.ORORaQC3XSqyuPSsTzx_3TqHGYmCRVESAn2oU_ZL-DQ@z>

Hi Masahiro,

On Mon, Aug 20, 2018 at 02:04:24PM +0900, Masahiro Yamada wrote:
> 2018-08-19 3:10 GMT+09:00 Paul Burton <paul.burton@mips.com>:
> > We have a need to override the definition of
> > barrier_before_unreachable() for MIPS, which means we either need to add
> > architecture-specific code into linux/compiler-gcc.h or we need to allow
> > the architecture to provide a header that can define the macro before
> > the generic definition. The latter seems like the better approach.
> >
> > A straightforward approach to the per-arch header is to make use of
> > asm-generic to provide a default empty header & adjust architectures
> > which don't need anything specific to make use of that by adding the
> > header to generic-y. Unfortunately this doesn't work so well due to
> > commit a95b37e20db9 ("kbuild: get <linux/compiler_types.h> out of
> > <linux/kconfig.h>") which moved the inclusion of linux/compiler.h to
> > cflags using the -include compiler flag.
> >
> > Because the -include flag is present for all C files we compile, we need
> > the architecture-provided header to be present before any C files are
> > compiled. If any C files can be compiled prior to the asm-generic header
> > wrappers being generated then we hit a build failure due to missing
> > header. Such cases do exist - one pointed out by the kbuild test robot
> > is the compilation of arch/ia64/kernel/nr-irqs.c, which occurs as part
> > of the archprepare target [1].
> >
> > This leaves us with a few options:
> >
> >   1) Use generic-y & fix any build failures we find by enforcing
> >      ordering such that the asm-generic target occurs before any C
> >      compilation, such that linux/compiler_types.h can always include
> >      the generated asm-generic wrapper which in turn includes the empty
> >      asm-generic header. This would rely on us finding all the
> >      problematic cases - I don't know for sure that the ia64 issue is
> >      the only one.
> >
> >   2) Add an actual empty header to each architecture, so that we don't
> >      need the generated asm-generic wrapper. This seems messy.
> >
> >   3) Give up & add #ifdef CONFIG_MIPS or similar to
> >      linux/compiler_types.h. This seems messy too.
> >
> >   4) Include the arch header only when it's actually needed, removing
> >      the need for the asm-generic wrapper for all other architectures.
> >
> > This patch allows us to use approach 4, by including an
> > asm/compiler_types.h header using the -include flag in the same way we
> > do for linux/compiler_types.h, but only if the header actually exists.
> 
> I agree with the approach 4),
> but I am of two minds about how to implement it.
> 
> I guess the cost of evaluating 'wildcard' for each C file
> is unnoticeable level, but I am slightly in favor of
> including <asm/compilr_types.h> from <linux/compiler_types.h>
> conditionally.
> 
> I am not sure about the CONFIG name, but for example, like this.
> 
> #ifdef CONFIG_HAVE_ARCH_COMPILER_TYPES
> #include <asm/compiler_types.h>
> #endif
> 
> What do you think?

That sounds fine to me - I'll submit a v9 shortly :)

Thanks,
    Paul
