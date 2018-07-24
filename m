Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-03.nifty.com ([210.131.2.82]:57387 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388194AbeGXC6P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jul 2018 22:58:15 -0400
MIME-Version: 1.0
In-Reply-To: <1530580921-23340-4-git-send-email-yamada.masahiro@socionext.com>
References: <1530580921-23340-1-git-send-email-yamada.masahiro@socionext.com> <1530580921-23340-4-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 24 Jul 2018 10:53:10 +0900
Message-ID: <CAK7LNAS7NE5ZOm1ojCK3Y5LthwDfm5OiEGYMcZC8Pkm2_YkKbQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] microblaze: add endianness options to LDFLAGS instead
 of LD
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <monstr@monstr.eu>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20180724015310.FW4fOoZZoqD7YWw1FFlHSipkkDu39E782LYHDq4S27U@z>

Hi Michal,

Ping?


2018-07-03 10:22 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> With the recent syntax extension, Kconfig is now able to evaluate the
> compiler / toolchain capability.
>
> However, accumulating flags to 'LD' is not compatible with the way
> it works; 'LD' must be passed to Kconfig to call $(ld-option,...)
> from Kconfig files.  If you tweak 'LD' in arch Makefile depending on
> CONFIG_CPU_BIG_ENDIAN, this would end up with circular dependency
> between Makefile and Kconfig.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/microblaze/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> index d269dd4b..7333036 100644
> --- a/arch/microblaze/Makefile
> +++ b/arch/microblaze/Makefile
> @@ -40,11 +40,11 @@ CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_PCMP_INSTR) += -mxl-pattern-compare
>  ifdef CONFIG_CPU_BIG_ENDIAN
>  KBUILD_CFLAGS += -mbig-endian
>  KBUILD_AFLAGS += -mbig-endian
> -LD += -EB
> +LDFLAGS += -EB
>  else
>  KBUILD_CFLAGS += -mlittle-endian
>  KBUILD_AFLAGS += -mlittle-endian
> -LD += -EL
> +LDFLAGS += -EL
>  endif
>
>  CPUFLAGS-1 += $(call cc-option,-mcpu=v$(CPU_VER))
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
