From: Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v5 29/36] x86/build: Enforce an empty .got.plt section
Date: Fri, 31 Jul 2020 22:12:48 -0400
Message-ID: <20200801021248.GB2700342@rani.riverdale.lan>
References: <20200731230820.1742553-1-keescook@chromium.org>
 <20200731230820.1742553-30-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgHACMw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 22:12:52 -0400
Content-Disposition: inline
In-Reply-To: <20200731230820.1742553-30-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 04:08:13PM -0700, Kees Cook wrote:
> The .got.plt section should always be zero (or filled only with the
> linker-generated lazy dispatch entry). Enforce this with an assert and
> mark the section as NOLOAD. This is more sensitive than just blindly
> discarding the section.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/kernel/vmlinux.lds.S | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 0cc035cb15f1..7faffe7414d6 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -414,8 +414,20 @@ SECTIONS
>  	ELF_DETAILS
>  
>  	DISCARDS
> -}
>  
> +	/*
> +	 * Make sure that the .got.plt is either completely empty or it
> +	 * contains only the lazy dispatch entries.
> +	 */
> +	.got.plt (NOLOAD) : { *(.got.plt) }
> +	ASSERT(SIZEOF(.got.plt) == 0 ||
> +#ifdef CONFIG_X86_64
> +	       SIZEOF(.got.plt) == 0x18,
> +#else
> +	       SIZEOF(.got.plt) == 0xc,
> +#endif
> +	       "Unexpected GOT/PLT entries detected!")
> +}
>  
>  #ifdef CONFIG_X86_32
>  /*
> -- 
> 2.25.1
> 

Is this actually needed? vmlinux is a position-dependent executable, and
it doesn't get linked with any shared libraries, so it should never have
a .got or .got.plt at all I think? Does it show up as an orphan without
this?
