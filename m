From: Michal Marek <mmarek@suse.com>
Subject: Re: [PATCH 3/6] kbuild: add arch specific post-link pass
Date: Tue, 16 Aug 2016 11:23:45 +0200
Message-ID: <57B2DBA1.6090304@suse.com>
References: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
 <1470910580-18458-4-git-send-email-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43642 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753103AbcHPJYA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 16 Aug 2016 05:24:00 -0400
In-Reply-To: <1470910580-18458-4-git-send-email-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>

Dne 11.8.2016 v 12:16 Nicholas Piggin napsal(a):
> Add an option for architectures to pass over modules after they are
> linked. powerpc will use this to check linker relocations for sanity,
> and possibly to fix up alternate instruction patch relocations.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Since v1,
> - Switched to a more flexible arch makefile invocation.
> - Provide a powerpc patch to use it to help existing build issue
>   (rather than only justification being out-of-tree patch).
> 
>  Documentation/kbuild/makefiles.txt | 10 ++++++++++
>  arch/Kconfig                       |  7 +++++++
>  scripts/Makefile.modpost           |  3 +++
>  scripts/link-vmlinux.sh            |  4 ++++
>  4 files changed, 24 insertions(+)
> 
> diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
> index 385a5ef..8581e38 100644
> --- a/Documentation/kbuild/makefiles.txt
> +++ b/Documentation/kbuild/makefiles.txt
> @@ -41,6 +41,7 @@ This document describes the Linux kernel Makefiles.
>  	   --- 6.8 Custom kbuild commands
>  	   --- 6.9 Preprocessing linker scripts
>  	   --- 6.10 Generic header files
> +	   --- 6.11 Post-link pass
>  
>  	=== 7 Kbuild syntax for exported headers
>  		--- 7.1 header-y
> @@ -1237,6 +1238,15 @@ When kbuild executes, the following steps are followed (roughly):
>  	to list the file in the Kbuild file.
>  	See "7.4 generic-y" for further info on syntax etc.
>  
> +--- 6.11 Post-link pass
> +
> +	CONFIG_BUILD_ARCH_POSTLINK can be selected in order to have
> +	arch/?/Makefile.postlink invoked on vmlinux and module.ko
> +	files after final link.
> +
> +	For example, powerpc uses this to check relocations on the
> +	linked vmlinux file.
> +
>  === 7 Kbuild syntax for exported headers
>  
>  The kernel includes a set of headers that is exported to userspace.
> diff --git a/arch/Kconfig b/arch/Kconfig
> index fc3f9e1..3a36ea8 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -461,6 +461,13 @@ config CC_STACKPROTECTOR_STRONG
>  
>  endchoice
>  
> +config BUILD_ARCH_POSTLINK
> +	bool
> +	help
> +	  Select this if the architecture wants to have a Makefile invoked
> +	  on modules and vmlinux after they are linked. The architecture
> +	  must provide arch/?/Makefile.postlink
> +
>  config THIN_ARCHIVES
>  	bool
>  	help
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 1366a94..1acaa20 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -123,6 +123,9 @@ quiet_cmd_ld_ko_o = LD [M]  $@
>  
>  $(modules): %.ko :%.o %.mod.o FORCE
>  	$(call if_changed,ld_ko_o)
> +ifdef CONFIG_BUILD_ARCH_POSTLINK
> +	$(Q)$(MAKE) -f $(srctree)/arch/$(SRCARCH)/Makefile.postlink $@
> +endif

Why not simply branch off the existence of arch/*/Makefile.postlink and
drop the kconfig option?

Thanks,
Michal
