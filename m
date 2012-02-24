Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59616 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876Ab2BXOYL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Feb 2012 09:24:11 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] [PATCH] asm-generic/unistd.h: handle symbol prefixes in cond_syscall
Date: Fri, 24 Feb 2012 14:24:07 +0000
References: <4F47981F.4020305@imgtec.com>
In-Reply-To: <4F47981F.4020305@imgtec.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201202241424.07319.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <20120224142407.weOsDMOmcFlSkWsJ4piLE06J_jTuOAEaa2O3GXhV8bg@z>

On Friday 24 February 2012, James Hogan wrote:
> Some architectures have symbol prefixes and set CONFIG_SYMBOL_PREFIX,
> but this wasn't taken into account by the generic cond_syscall. It's
> easy enough to fix in a generic fashion, so add the symbol prefix to
> symbol names in cond_syscall when CONFIG_SYMBOL_PREFIX is set.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> ---
>  include/asm-generic/unistd.h |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/include/asm-generic/unistd.h b/include/asm-generic/unistd.h
> index 2292d1a..c9a5ba4 100644
> --- a/include/asm-generic/unistd.h
> +++ b/include/asm-generic/unistd.h
> @@ -924,7 +924,14 @@ __SYSCALL(__NR_fork, sys_ni_syscall)
>   * but it doesn't work on all toolchains, so we just do it by hand
>   */
>  #ifndef cond_syscall
> -#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
> +#ifdef CONFIG_SYMBOL_PREFIX
> +#define __SYMBOL_PREFIX CONFIG_SYMBOL_PREFIX
> +#else
> +#define __SYMBOL_PREFIX
> +#endif
> +#define cond_syscall(x) asm(".weak\t" __SYMBOL_PREFIX #x "\n\t" \
> +                           ".set\t" __SYMBOL_PREFIX #x "," \
> +                           __SYMBOL_PREFIX "sys_ni_syscall")
>  #endif

Our trend is to move away from arch specific Kconfig symbols and __ARCH_HAS_*
macros towards just defining whatever you need in the architecture as an
override for the generic definition.

Just provide your own unistd.h that does

#define cond_syscall(x) asm(".weak\t." #x "\n\t.set\t." #x ",.sys_ni_syscall")
#include <asm-generic/unistd.h>

BTW, are you planning to submit arch/metag for inclusion? I've looked at
the code recently and it appears that you are on the right track overall,
and it shouldn't be too hard to get to the same quality level as
arch/openrisc.

	Arnd
