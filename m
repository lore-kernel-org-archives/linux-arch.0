Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from condef-03.nifty.com ([202.248.20.68]:23871 "EHLO
        condef-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfLLFMx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Dec 2019 00:12:53 -0500
Received: from conssluserg-01.nifty.com ([10.126.8.80])by condef-03.nifty.com with ESMTP id xBC54FXY002029
        for <linux-arch@vger.kernel.org>; Thu, 12 Dec 2019 14:04:15 +0900
MIME-Version: 1.0
References: <20191211184027.20130-1-catalin.marinas@arm.com> <20191211184027.20130-3-catalin.marinas@arm.com>
In-Reply-To: <20191211184027.20130-3-catalin.marinas@arm.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 12 Dec 2019 14:03:24 +0900
Message-ID: <CAK7LNARR=DjdnZdu=L+0H8ALr4XJNpVbcRTOz_sVZdZpcM0pdQ@mail.gmail.com>
Subject: Re: [PATCH 02/22] kbuild: Add support for 'as-instr' to be used in
 Kconfig files
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, linux-mm@kvack.org, linux-arch <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <20191212050324.UY42TvbBg46EZcWKbM8IO_P_eyJPlMNERuHVP-Za9F8@z>

On Thu, Dec 12, 2019 at 3:40 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Similar to 'cc-option' or 'ld-option', it is occasionally necessary to
> check whether the assembler supports certain ISA extensions. In the
> arm64 code we currently do this in Makefile with an additional define:
>
> lseinstr := $(call as-instr,.arch_extension lse,-DCONFIG_AS_LSE=1)
>
> Add the 'as-instr' option so that it can be used in Kconfig directly:
>
>         def_bool $(as-instr,.arch_extension lse)
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: linux-kbuild@vger.kernel.org
> Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---

Please feel fee to apply this to arm64 tree.
Acked-by: Masahiro Yamada <masahiroy@kernel.org>

>  scripts/Kconfig.include | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
> index d4adfbe42690..9d07e59cbdf7 100644
> --- a/scripts/Kconfig.include
> +++ b/scripts/Kconfig.include
> @@ -31,6 +31,10 @@ cc-option = $(success,$(CC) -Werror $(CLANG_FLAGS) $(1) -E -x c /dev/null -o /de
>  # Return y if the linker supports <flag>, n otherwise
>  ld-option = $(success,$(LD) -v $(1))
>
> +# $(as-instr,<instr>)
> +# Return y if the assembler supports <instr>, n otherwise
> +as-instr = $(success,printf "%b\n" "$(1)" | $(CC) $(CLANG_FLAGS) -c -x assembler -o /dev/null -)
> +
>  # check if $(CC) and $(LD) exist
>  $(error-if,$(failure,command -v $(CC)),compiler '$(CC)' not found)
>  $(error-if,$(failure,command -v $(LD)),linker '$(LD)' not found)



-- 
Best Regards
Masahiro Yamada
