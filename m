From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v4 14/17] arm/build: Warn on orphan section placement
Date: Mon, 29 Jun 2020 12:47:03 -0700
Message-ID: <CAKwvOdnErUWrJUaw9gm3ZSOpD2JepZKod3REBctzBr4QuHLiAA@mail.gmail.com>
References: <20200629061840.4065483-1-keescook@chromium.org> <20200629061840.4065483-15-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388014AbgF2TrP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 15:47:15 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054E3C03E979
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 12:47:16 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d10so7496448pls.5
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 12:47:16 -0700 (PDT)
In-Reply-To: <20200629061840.4065483-15-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, linux-arch <linux-arch@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.in>

On Sun, Jun 28, 2020 at 11:18 PM Kees Cook <keescook@chromium.org> wrote:
>
> We don't want to depend on the linker's orphan section placement
> heuristics as these can vary between linkers, and may change between
> versions. All sections need to be explicitly named in the linker
> script.
>
> Specifically, this would have made a recently fixed bug very obvious:
>
> ld: warning: orphan section `.fixup' from `arch/arm/lib/copy_from_user.o' being placed in section `.fixup'
>
> Discard unneeded sections .iplt, .rel.iplt, .igot.plt, and .modinfo.
>
> Add missing text stub sections .vfp11_veneer and .v4_bx.
>
> Add debug sections explicitly.
>
> Finally enable orphan section warning.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for following up on the previous suggestion regarding .glu_7 /
.glu_7t ordering. LGTM
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/arm/include/asm/vmlinux.lds.h | 6 +++++-
>  arch/arm/kernel/vmlinux-xip.lds.S  | 1 +
>  arch/arm/kernel/vmlinux.lds.S      | 1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
> index c66b16cd8837..d44fae722e7a 100644
> --- a/arch/arm/include/asm/vmlinux.lds.h
> +++ b/arch/arm/include/asm/vmlinux.lds.h
> @@ -39,6 +39,8 @@
>                 __idmap_text_end = .;                                   \
>
>  #define ARM_COMMON_DISCARD                                             \
> +               *(.iplt) *(.rel.iplt) *(.igot.plt)                      \
> +               *(.modinfo)                                             \
>                 *(.discard)                                             \
>                 *(.discard.*)
>
> @@ -63,7 +65,9 @@
>  #define ARM_STUBS_TEXT                                                 \
>                 *(.gnu.warning)                                         \
>                 *(.glue_7)                                              \
> -               *(.glue_7t)
> +               *(.glue_7t)                                             \
> +               *(.vfp11_veneer)                                        \
> +               *(.v4_bx)
>
>  #define ARM_TEXT                                                       \
>                 IDMAP_TEXT                                              \
> diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
> index 57fcbf55f913..11ffa79751da 100644
> --- a/arch/arm/kernel/vmlinux-xip.lds.S
> +++ b/arch/arm/kernel/vmlinux-xip.lds.S
> @@ -150,6 +150,7 @@ SECTIONS
>         _end = .;
>
>         STABS_DEBUG
> +       DWARF_DEBUG
>         ARM_DETAILS
>  }
>
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index 1d3d3b599635..dc672fe35de3 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -149,6 +149,7 @@ SECTIONS
>         _end = .;
>
>         STABS_DEBUG
> +       DWARF_DEBUG
>         ARM_DETAILS
>  }
>
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200629061840.4065483-15-keescook%40chromium.org.



-- 
Thanks,
~Nick Desaulniers
