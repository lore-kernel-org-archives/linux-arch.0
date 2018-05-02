Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751020AbeEBOHw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 May 2018 10:07:52 -0400
Date: Wed, 2 May 2018 10:07:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 3/5] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
Message-ID: <20180502100748.3fd41bae@gandalf.local.home>
In-Reply-To: <1525268700-10631-4-git-send-email-changbin.du@intel.com>
References: <1525268700-10631-1-git-send-email-changbin.du@intel.com>
        <1525268700-10631-4-git-send-email-changbin.du@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: changbin.du@intel.com
Cc: yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org, rdunlap@infradead.org, x86@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180502140748.2jmIuyQzlaV-mUsEHBAASRTsYHbFLRB9Qht6L2_GJk0@z>

On Wed,  2 May 2018 21:44:58 +0800
changbin.du@intel.com wrote:

> From: Changbin Du <changbin.du@intel.com>
> 
> This patch add a new kernel hacking option NO_AUTO_INLINE. Selecting
> this option will prevent the compiler from optimizing the kernel by
> auto-inlining functions not marked with the inline keyword.
> 
> With this option, only functions explicitly marked with "inline" will
> be inlined. This will allow the function tracer to trace more functions
> because it only traces functions that the compiler has not inlined.
> 
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>

I'm fine with this patch if others are OK with it too.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> ---
> v2: Some grammar updates from Steven.
> ---
>  Makefile          |  6 ++++++
>  lib/Kconfig.debug | 18 ++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 619a85a..eb694f6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -775,6 +775,12 @@ KBUILD_CFLAGS 	+= $(call cc-option, -femit-struct-debug-baseonly) \
>  		   $(call cc-option,-fno-var-tracking)
>  endif
>  
> +ifdef CONFIG_NO_AUTO_INLINE
> +KBUILD_CFLAGS   += $(call cc-option, -fno-inline-functions) \
> +		   $(call cc-option, -fno-inline-small-functions) \
> +		   $(call cc-option, -fno-inline-functions-called-once)
> +endif
> +
>  ifdef CONFIG_FUNCTION_TRACER
>  ifndef CC_FLAGS_FTRACE
>  CC_FLAGS_FTRACE := -pg
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c40c7b7..ab55801 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -198,6 +198,24 @@ config GDB_SCRIPTS
>  	  instance. See Documentation/dev-tools/gdb-kernel-debugging.rst
>  	  for further details.
>  
> +config NO_AUTO_INLINE
> +	bool "Disable compiler auto-inline optimizations"
> +	default n
> +	help
> +	  This will prevent the compiler from optimizing the kernel by
> +	  auto-inlining functions not marked with the inline keyword.
> +	  With this option, only functions explicitly marked with
> +	  "inline" will be inlined. This will allow the function tracer
> +	  to trace more functions because it only traces functions that
> +	  the compiler has not inlined.
> +
> +	  Enabling this function can help debugging a kernel if using
> +	  the function tracer. But it can also change how the kernel
> +	  works, because inlining functions may change the timing,
> +	  which could make it difficult while debugging race conditions.
> +
> +	  If unsure, select N.
> +
>  config ENABLE_WARN_DEPRECATED
>  	bool "Enable __deprecated logic"
>  	default y
