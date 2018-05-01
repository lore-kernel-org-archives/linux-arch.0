Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:37882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbeEAPZb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 May 2018 11:25:31 -0400
Subject: Re: [PATCH 4/5] kernel hacking: new config DEBUG_EXPERIENCE to apply
 GCC -Og optimization
References: <1525179614-14571-1-git-send-email-changbin.du@intel.com>
 <1525179614-14571-5-git-send-email-changbin.du@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f19eae29-3b94-5151-04c5-6fb620bd28e9@infradead.org>
Date: Tue, 1 May 2018 08:25:27 -0700
MIME-Version: 1.0
In-Reply-To: <1525179614-14571-5-git-send-email-changbin.du@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: changbin.du@intel.com, yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org
Cc: x86@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180501152527.50h7u7eTAV76KyNrKteasTgxjbD9P0InN22kJ6aQIMk@z>

Good morning.

On 05/01/2018 06:00 AM, changbin.du@intel.com wrote:
> From: Changbin Du <changbin.du@intel.com>
> 
> 
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> ---
>  Makefile                     |  4 ++++
>  include/linux/compiler-gcc.h |  2 +-
>  include/linux/compiler.h     |  2 +-
>  lib/Kconfig.debug            | 21 +++++++++++++++++++++
>  4 files changed, 27 insertions(+), 2 deletions(-)
> 

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 90f35ad..2432e77d 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -211,6 +211,27 @@ config NO_AUTO_INLINE
>  
>  	  Use only if you want to debug the kernel.
>  
> +config DEBUG_EXPERIENCE
> +	bool "Optimize for better debugging experience (-Og)"
> +	default n
> +	select NO_AUTO_INLINE
> +	depends on !CC_OPTIMIZE_FOR_SIZE
> +	help
> +	  This will apply GCC '-Og' optimization level get supported from

	                                               which is supported since

> +	  GCC 4.8. This optimization level offers a reasonable level of
> +	  optimization while maintaining fast compilation and a good
> +	  debugging experience. It is similar to '-O1' while perfer keeping

	                                               while preferring to keep

> +	  debug ability over runtime speed. The overall performance will
> +	  drop a bit.
> +
> +	  If enabling this option break your kernel, you should either

	                          breaks

> +	  disable this or find a fix (mostly in the arch code). Currently
> +	  this option has only be tested in qemu x86_64 guest.
> +
> +	  Use only if you want to debug the kernel, especially if you want
> +	  to have better kernel debugging experience with gdb facilities
> +	  like kgdb and qemu.
> +
>  config ENABLE_WARN_DEPRECATED
>  	bool "Enable __deprecated logic"
>  	default y
> 

thanks,
-- 
~Randy
