From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: + lib-consolidate-debug_per_cpu_maps.patch added to -mm tree
Date: Wed, 20 Apr 2011 14:21:37 +1000
Message-ID: <1303273297.2513.23.camel@pasglop>
References: <201104122148.p3CLmhea004694@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:56936 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797Ab1DTEzC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Apr 2011 00:55:02 -0400
In-Reply-To: <201104122148.p3CLmhea004694@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, sboyd@codeaurora.org, hpa@zytor.com, linux-arch@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de

On Tue, 2011-04-12 at 14:48 -0700, akpm@linux-foundation.org wrote:
> The patch titled
>      lib: consolidate DEBUG_PER_CPU_MAPS
> has been added to the -mm tree.  Its filename is
>      lib-consolidate-debug_per_cpu_maps.patch
> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> 
> See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
> out what to do about this
> 
> The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/
> 
> ------------------------------------------------------
> Subject: lib: consolidate DEBUG_PER_CPU_MAPS
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> DEBUG_PER_CPU_MAPS is used in lib/cpumask.c as well as in
> inlcude/linux/cpumask.h and thus it has outgrown its use within x86 and
> powerpc alone.  Any arch with SMP support may want to get some more
> debugging, so make this option generic.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Cc: <linux-arch@vger.kernel.org>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/powerpc/Kconfig.debug |   12 ------------
>  arch/x86/Kconfig.debug     |   11 -----------
>  lib/Kconfig.debug          |   11 +++++++++++
>  3 files changed, 11 insertions(+), 23 deletions(-)
> 
> diff -puN arch/powerpc/Kconfig.debug~lib-consolidate-debug_per_cpu_maps arch/powerpc/Kconfig.debug
> --- a/arch/powerpc/Kconfig.debug~lib-consolidate-debug_per_cpu_maps
> +++ a/arch/powerpc/Kconfig.debug
> @@ -44,18 +44,6 @@ config DEBUG_STACK_USAGE
>  
>  	  This option will slow down process creation somewhat.
>  
> -config DEBUG_PER_CPU_MAPS
> -	bool "Debug access to per_cpu maps"
> -	depends on DEBUG_KERNEL
> -	depends on SMP
> -	default n
> -	---help---
> -	  Say Y to verify that the per_cpu map being accessed has
> -	  been setup.  Adds a fair amount of code to kernel memory
> -	  and decreases performance.
> -
> -	  Say N if unsure.
> -
>  config HCALL_STATS
>  	bool "Hypervisor call instrumentation"
>  	depends on PPC_PSERIES && DEBUG_FS && TRACEPOINTS
> diff -puN arch/x86/Kconfig.debug~lib-consolidate-debug_per_cpu_maps arch/x86/Kconfig.debug
> --- a/arch/x86/Kconfig.debug~lib-consolidate-debug_per_cpu_maps
> +++ a/arch/x86/Kconfig.debug
> @@ -75,17 +75,6 @@ config DEBUG_STACK_USAGE
>  
>  	  This option will slow down process creation somewhat.
>  
> -config DEBUG_PER_CPU_MAPS
> -	bool "Debug access to per_cpu maps"
> -	depends on DEBUG_KERNEL
> -	depends on SMP
> -	---help---
> -	  Say Y to verify that the per_cpu map being accessed has
> -	  been setup.  Adds a fair amount of code to kernel memory
> -	  and decreases performance.
> -
> -	  Say N if unsure.
> -
>  config X86_PTDUMP
>  	bool "Export kernel pagetable layout to userspace via debugfs"
>  	depends on DEBUG_KERNEL
> diff -puN lib/Kconfig.debug~lib-consolidate-debug_per_cpu_maps lib/Kconfig.debug
> --- a/lib/Kconfig.debug~lib-consolidate-debug_per_cpu_maps
> +++ a/lib/Kconfig.debug
> @@ -968,6 +968,17 @@ config DEBUG_FORCE_WEAK_PER_CPU
>  	  To ensure that generic code follows the above rules, this
>  	  option forces all percpu variables to be defined as weak.
>  
> +config DEBUG_PER_CPU_MAPS
> +	bool "Debug access to per_cpu maps"
> +	depends on DEBUG_KERNEL
> +	depends on SMP
> +	help
> +	  Say Y to verify that the per_cpu map being accessed has
> +	  been set up. This adds a fair amount of code to kernel memory
> +	  and decreases performance.
> +
> +	  Say N if unsure.
> +
>  config LKDTM
>  	tristate "Linux Kernel Dump Test Tool Module"
>  	depends on DEBUG_FS
> _
> 
> Patches currently in -mm which might be from sboyd@codeaurora.org are
> 
> linux-next.patch
> msm-timer-migrate-to-timer-based-__delay.patch
> lib-consolidate-debug_per_cpu_maps.patch
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
