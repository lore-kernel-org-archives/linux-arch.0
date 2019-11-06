Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-01.nifty.com ([210.131.2.80]:30369 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfKFPmT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Nov 2019 10:42:19 -0500
MIME-Version: 1.0
References: <20191018043148.6285-1-yamada.masahiro@socionext.com>
In-Reply-To: <20191018043148.6285-1-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 7 Nov 2019 00:41:25 +0900
Message-ID: <CAK7LNATeTR=hZ9Ebh=R7_KTxeB0tfLCeRPOMqwZj9XUdZHTAkw@mail.gmail.com>
Subject: Re: [PATCH 1/2] asm-generic/export.h: make __ksymtab_* local symbols
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20191106154125.5UOnMuj5XuYcZz4O1lI8-e22QH_uX9LNwBM6XI_1EQY@z>

On Fri, Oct 18, 2019 at 2:03 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> For EXPORT_SYMBOL from C files, <linux/export.h> defines __ksymtab_*
> as local symbols.
>
> For EXPORT_SYMBOL from assembly, in contrast, <asm-generic/export.h>
> produces globally-visible __ksymtab_* symbols due to this .globl
> directive.
>
> I do not understand why this must be global.  It still works without
> this .globl directive.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

I did not get objection, at least.

Applied to linux-kbuild.



>
>  include/asm-generic/export.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
> index fa577978fbbd..80ef2dc0c8be 100644
> --- a/include/asm-generic/export.h
> +++ b/include/asm-generic/export.h
> @@ -31,7 +31,6 @@
>   */
>  .macro ___EXPORT_SYMBOL name,val,sec
>  #ifdef CONFIG_MODULES
> -       .globl __ksymtab_\name
>         .section ___ksymtab\sec+\name,"a"
>         .balign KSYM_ALIGN
>  __ksymtab_\name:
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
