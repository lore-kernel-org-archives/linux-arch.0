Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43784 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfH3Uyi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Aug 2019 16:54:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3so4095936pgb.10
        for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2019 13:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190830034304.24259-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190830034304.24259-1-yamada.masahiro@socionext.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 30 Aug 2019 13:54:26 -0700
Message-ID: <CAKwvOdmrVG8yYvaZ++r4GVKx_p3YaxdyA85H_roPJf8efQkoiw@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20190830205426.SnuNkkJk1Uwj40CjRU7BRLjYczh7V22WtGdHOgzZTWM@z>

On Thu, Aug 29, 2019 at 8:43 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Commit 9012d011660e ("compiler: allow all arches to enable
> CONFIG_OPTIMIZE_INLINING") allowed all architectures to enable
> this option. A couple of build errors were reported by randconfig,
> but all of them have been ironed out.
>
> Towards the goal of removing CONFIG_OPTIMIZE_INLINING entirely
> (and it will simplify the 'inline' macro in compiler_types.h),
> this commit changes it to always-on option. Going forward, the
> compiler will always be allowed to not inline functions marked
> 'inline'.
>
> This is not a problem for x86 since it has been long used by
> arch/x86/configs/{x86_64,i386}_defconfig.
>
> I am keeping the config option just in case any problem crops up for
> other architectures.
>
> The code clean-up will be done after confirming this is solid.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Just saw akpm picked this up, but
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  lib/Kconfig.debug | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 5960e2980a8a..e25493811df8 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -327,7 +327,7 @@ config HEADERS_CHECK
>           relevant for userspace, say 'Y'.
>
>  config OPTIMIZE_INLINING
> -       bool "Allow compiler to uninline functions marked 'inline'"
> +       def_bool y
>         help
>           This option determines if the kernel forces gcc to inline the functions
>           developers have marked 'inline'. Doing so takes away freedom from gcc to
> @@ -338,8 +338,6 @@ config OPTIMIZE_INLINING
>           decision will become the default in the future. Until then this option
>           is there to test gcc for this.
>
> -         If unsure, say N.
> -
>  config DEBUG_SECTION_MISMATCH
>         bool "Enable full Section mismatch analysis"
>         help
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
