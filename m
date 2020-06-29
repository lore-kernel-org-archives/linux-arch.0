From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v4 08/17] arm64/mm: Remove needless section quotes
Date: Mon, 29 Jun 2020 12:53:47 -0700
Message-ID: <CAKwvOd=r6bsBfSZxVYrnbm1Utq==ApWBDjx+0Fxsm90Aq3Jghw@mail.gmail.com>
References: <20200629061840.4065483-1-keescook@chromium.org> <20200629061840.4065483-9-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731850AbgF2Tx7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 15:53:59 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51374C03E97A
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 12:53:59 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j12so8333119pfn.10
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 12:53:59 -0700 (PDT)
In-Reply-To: <20200629061840.4065483-9-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, linux-arch <linux-arch@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.in>

On Sun, Jun 28, 2020 at 11:18 PM Kees Cook <keescook@chromium.org> wrote:
>
> Fix a case of needless quotes in __section(), which Clang doesn't like.
>
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Yep, I remember bugs from this.  Probably should scan the kernel for
other instances of this.  +Joe for checkpatch.pl validation.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/arm64/mm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 1df25f26571d..dce024ea6084 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -42,7 +42,7 @@
>  u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
>  u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
>
> -u64 __section(".mmuoff.data.write") vabits_actual;
> +u64 __section(.mmuoff.data.write) vabits_actual;
>  EXPORT_SYMBOL(vabits_actual);
>
>  u64 kimage_voffset __ro_after_init;
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
