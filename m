Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-05.nifty.com ([210.131.2.90]:30906 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfKFPmt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Nov 2019 10:42:49 -0500
MIME-Version: 1.0
References: <20191018043148.6285-1-yamada.masahiro@socionext.com> <20191018043148.6285-2-yamada.masahiro@socionext.com>
In-Reply-To: <20191018043148.6285-2-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 7 Nov 2019 00:41:51 +0900
Message-ID: <CAK7LNARpjkd8VpMAp+vx+Ud5ipSsfxPY6cAr31tmG=08_qi1kQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] asm-generic/export.h: remove unneeded __kcrctab_* symbols
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20191106154151.U3E2vxS_dbzplkMwOI_bfmdbLS1mBsmBuTg14tswWZs@z>

On Fri, Oct 18, 2019 at 1:56 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> EXPORT_SYMBOL from assembly code produces an unused symbol __kcrctab_*.
>
> kcrctab is used as a section name (prefixed with three underscores),
> but never used as a symbol.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.

>
>  include/asm-generic/export.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
> index 80ef2dc0c8be..a3983e2ce0fd 100644
> --- a/include/asm-generic/export.h
> +++ b/include/asm-generic/export.h
> @@ -43,7 +43,6 @@ __kstrtab_\name:
>  #ifdef CONFIG_MODVERSIONS
>         .section ___kcrctab\sec+\name,"a"
>         .balign KCRC_ALIGN
> -__kcrctab_\name:
>  #if defined(CONFIG_MODULE_REL_CRCS)
>         .long __crc_\name - .
>  #else
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
