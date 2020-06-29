From: Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Date: Mon, 29 Jun 2020 16:20:59 -0700
Message-ID: <20200629232059.GA3787278@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <CAK7LNASvb0UDJ0U5wkYYRzTAdnEs64HjXpEUL7d=V0CXiAXcNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbgF2XVG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 19:21:06 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A02AC03E979
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 16:21:06 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u5so8559780pfn.7
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 16:21:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAK7LNASvb0UDJ0U5wkYYRzTAdnEs64HjXpEUL7d=V0CXiAXcNw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, X86 ML <x86@kernel.org>

Hi Masahiro,

On Mon, Jun 29, 2020 at 01:56:19AM +0900, Masahiro Yamada wrote:
> On Thu, Jun 25, 2020 at 5:32 AM 'Sami Tolvanen' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
> >
> > This patch series adds support for building x86_64 and arm64 kernels
> > with Clang's Link Time Optimization (LTO).
> >
> > In addition to performance, the primary motivation for LTO is to allow
> > Clang's Control-Flow Integrity (CFI) to be used in the kernel. Google's
> > Pixel devices have shipped with LTO+CFI kernels since 2018.
> >
> > Most of the patches are build system changes for handling LLVM bitcode,
> > which Clang produces with LTO instead of ELF object files, postponing
> > ELF processing until a later stage, and ensuring initcall ordering.
> >
> > Note that first objtool patch in the series is already in linux-next,
> > but as it's needed with LTO, I'm including it also here to make testing
> > easier.
> 
> 
> I put this series on a testing branch,
> and 0-day bot started reporting some issues.

Yes, I'll fix those issues in v2.

> (but 0-day bot is quieter than I expected.
> Perhaps, 0-day bot does not turn on LLVM=1 ?)

In order for it to test an LTO build, it would need to enable LTO_CLANG
explicitly though, in addition to LLVM=1.

> I also got an error for
> ARCH=arm64 allyesconfig + CONFIG_LTO_CLANG=y
> 
> 
> 
> $ make ARCH=arm64 LLVM=1 LLVM_IAS=1
> CROSS_COMPILE=~/tools/aarch64-linaro-7.5/bin/aarch64-linux-gnu-
> -j24
> 
>   ...
> 
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   AR      init/built-in.a
>   GEN     .tmp_initcalls.lds
>   GEN     .tmp_symversions.lds
>   LTO     vmlinux.o
>   MODPOST vmlinux.symvers
>   MODINFO modules.builtin.modinfo
>   GEN     modules.builtin
>   LD      .tmp_vmlinux.kallsyms1
> ld.lld: error: undefined symbol: __compiletime_assert_905
> >>> referenced by irqbypass.c
> >>>               vmlinux.o:(jeq_imm)
> make: *** [Makefile:1161: vmlinux] Error 1

I can reproduce this with ToT LLVM and it's BUILD_BUG_ON_MSG(..., "value
too large for the field") in drivers/net/ethernet/netronome/nfp/bpf/jit.c.
Specifically, the FIELD_FIT / __BF_FIELD_CHECK macro in ur_load_imm_any.

This compiles just fine with an earlier LLVM revision, so it could be a
relatively recent regression. I'll take a look. Thanks for catching this!

Sami
