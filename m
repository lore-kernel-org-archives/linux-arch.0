From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 05/22] kbuild: lto: postpone objtool
Date: Wed, 24 Jun 2020 23:19:08 +0200
Message-ID: <20200624211908.GT4817@hirez.programming.kicks-ass.net>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-6-samitolvanen@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389773AbgFXVTf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 17:19:35 -0400
Content-Disposition: inline
In-Reply-To: <20200624203200.78870-6-samitolvanen@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com, kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org

On Wed, Jun 24, 2020 at 01:31:43PM -0700, Sami Tolvanen wrote:
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 30827f82ad62..12b115152532 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -120,7 +120,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  /* Annotate a C jump table to allow objtool to follow the code flow */
>  #define __annotate_jump_table __section(.rodata..c_jump_table)
>  
> -#ifdef CONFIG_DEBUG_ENTRY
> +#if defined(CONFIG_DEBUG_ENTRY) || defined(CONFIG_LTO_CLANG)
>  /* Begin/end of an instrumentation safe region */
>  #define instrumentation_begin() ({					\
>  	asm volatile("%c0:\n\t"						\

Why would you be doing noinstr validation for lto builds? That doesn't
make sense.

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 9ad9210d70a1..9fdba71c135a 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -399,7 +399,7 @@ config STACK_VALIDATION
>  
>  config VMLINUX_VALIDATION
>  	bool
> -	depends on STACK_VALIDATION && DEBUG_ENTRY && !PARAVIRT
> +	depends on STACK_VALIDATION && (DEBUG_ENTRY || LTO_CLANG) && !PARAVIRT
>  	default y
>  

For that very same reason you shouldn't be excluding paravirt either.

> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index d168f0cfe67c..9f1df2f1fab5 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -48,6 +48,21 @@ endif # CC_USING_PATCHABLE_FUNCTION_ENTRY
>  endif # CC_USING_RECORD_MCOUNT
>  endif # CONFIG_FTRACE_MCOUNT_RECORD
>  
> +ifdef CONFIG_STACK_VALIDATION
> +ifneq ($(SKIP_STACK_VALIDATION),1)
> +cmd_ld_ko_o +=								\
> +	$(objtree)/tools/objtool/objtool				\
> +		$(if $(CONFIG_UNWINDER_ORC),orc generate,check)		\
> +		--module						\
> +		$(if $(CONFIG_FRAME_POINTER),,--no-fp)			\
> +		$(if $(CONFIG_GCOV_KERNEL),--no-unreachable,)		\
> +		$(if $(CONFIG_RETPOLINE),--retpoline,)			\
> +		$(if $(CONFIG_X86_SMAP),--uaccess,)			\
> +		$(@:.ko=$(prelink-ext).o);
> +
> +endif # SKIP_STACK_VALIDATION
> +endif # CONFIG_STACK_VALIDATION

What about the objtool invocation from link-vmlinux.sh ?
