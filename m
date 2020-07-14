Return-Path: <SRS0=Q31O=AZ=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgGNMgI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2020 08:36:08 -0400
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <671d8923-ed43-4600-2628-33ae7cb82ccb@molgen.mpg.de> <CABCJKuedpxAqndgL=jHT22KtjnLkb1dsYaM6hQYyhqrWjkEe6A@mail.gmail.com>
 <2ac9e722-949b-aa92-3553-df1bf69bf9e5@molgen.mpg.de>
In-Reply-To: <2ac9e722-949b-aa92-3553-df1bf69bf9e5@molgen.mpg.de>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 14 Jul 2020 14:35:52 +0200
Message-ID: <CA+icZUXwLocrBNRL+1-koCW50Fm+f4_u3xzy-_eJSxyoW2VTfw@mail.gmail.com>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, Clang-Built-Linux ML <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kbuild <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, x86@kernel.org
Message-ID: <20200714123552.rpZ6r0qzyI1Jow9OyKxV4pwJi0oNBhtK6_Uc0QDQ_II@z>

On Tue, Jul 14, 2020 at 2:16 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Sami,
>
>
> Am 13.07.20 um 01:34 schrieb Sami Tolvanen:
> > On Sat, Jul 11, 2020 at 9:32 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> >> Thank you very much for sending these changes.
> >>
> >> Do you have a branch, where your current work can be pulled from? Your
> >> branch on GitHub [1] seems 15 months old.
> >
> > The clang-lto branch is rebased regularly on top of Linus' tree.
> > GitHub just looks at the commit date of the last commit in the tree,
> > which isn't all that informative.
>
> Thank you for clearing this up, and sorry for not checking myself.
>
> >> Out of curiosity, I applied the changes, allowed the selection for i386
> >> (x86), and with Clang 1:11~++20200701093119+ffee8040534-1~exp1 from
> >> Debian experimental, it failed with `Invalid absolute R_386_32
> >> relocation: KERNEL_PAGES`:
> >
> > I haven't looked at getting this to work on i386, which is why we only
> > select ARCH_SUPPORTS_LTO for x86_64. I would expect there to be a few
> > issues to address.
> >
> >>>    arch/x86/tools/relocs vmlinux > arch/x86/boot/compressed/vmlinux.relocs;arch/x86/tools/relocs --abs-relocs vmlinux
> >>> Invalid absolute R_386_32 relocation: KERNEL_PAGES
> >
> > KERNEL_PAGES looks like a constant, so it's probably safe to ignore
> > the absolute relocation in tools/relocs.c.
>
> Thank you for pointing me to the right direction. I am happy to report,
> that with the diff below (no idea to what list to add the string), Linux
> 5.8-rc5 with the LLVM/Clang/LTO patches on top, builds and boots on the
> ASRock E350M1.
>
> ```
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index 8f3bf34840cef..e91af127ed3c0 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -79,6 +79,7 @@ static const char * const
> sym_regex_kernel[S_NSYMTYPES] = {
>          "__end_rodata_hpage_align|"
>   #endif
>          "__vvar_page|"
> +       "KERNEL_PAGES|"
>          "_end)$"
>   };
> ```
>

What llvm-toolchain and version did you use?

Can you post your linux-config?

Thanks.

- Sedat -
