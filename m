From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 0/8] kbuild: remove CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
 and clean-up code
Date: Mon, 14 May 2018 09:11:37 +0900
Message-ID: <CAK7LNARRBZjvE3obyLsbeir1r57V1fFmn-dKE68E-8PfscUSRQ@mail.gmail.com>
References: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>, Sam Ravnborg <sam@ravnborg.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michal Marek <michal.lkml@markovi.net>, Andy Whitcroft <apw@canonical.com>
List-Id: linux-arch.vger.kernel.org

2018-05-09 16:23 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>
> I got acknowledge to remove CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX entirely.
> (https://lkml.org/lkml/2018/5/5/148)
>
> Several tools can be cleaned-up.
>
> Removing the CONFIG option makes VMLINUX_SYMBOL() no-op,
> so this macro can be removed too.
>
> VMLINUX_SYMBOL() and VMLINUX_SYMBOL_STR() are widely used,
> so it will take some time to kill them entirely.
> (I will send other patches later, splitting per-arch)
>
>
>
> Masahiro Yamada (8):
>   modpost: remove symbol prefix support
>   genksyms: remove symbol prefix support
>   kallsyms: remove symbol prefix support
>   depmod.sh: remove symbol prefix support
>   export.h: remove code for prefixing symbols with underscore
>   kbuild: remove CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
>   vmlinux.lds.h: remove no-op macro VMLINUX_SYMBOL()
>   checkpatch: remove VMLINUX_SYMBOL() check


Applied to linux-kbuild.


>  Makefile                          |   2 +-
>  arch/Kconfig                      |   6 -
>  include/asm-generic/export.h      |  34 ++---
>  include/asm-generic/vmlinux.lds.h | 289 +++++++++++++++++++-------------------
>  include/linux/export.h            |  16 +--
>  scripts/Makefile.build            |   9 +-
>  scripts/adjust_autoksyms.sh       |   3 -
>  scripts/checkpatch.pl             |  10 --
>  scripts/depmod.sh                 |  21 +--
>  scripts/genksyms/genksyms.c       |  11 +-
>  scripts/kallsyms.c                |  47 ++-----
>  scripts/link-vmlinux.sh           |   4 -
>  scripts/mod/modpost.c             |  30 ++--
>  13 files changed, 188 insertions(+), 294 deletions(-)
>
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
