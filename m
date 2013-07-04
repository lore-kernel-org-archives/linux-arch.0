From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] include/asm-generic/io.h: add dummy fuctions to support 'COMPILE_TEST' in 'asm-generic'.
Date: Thu, 4 Jul 2013 11:25:14 +0200
Message-ID: <201307041125.15083.arnd@arndb.de>
References: <20130704011221.GA11230@kroah.com> <20130704061204.GA12148@kroah.com> <51D517A7.6030908@asianux.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51D517A7.6030908@asianux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, David Sharp <dhsharp@google.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, Ingo Molnar <mingo@kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Mark Brown <broonie@kernel.org>, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <trivial@kernel.org>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-arch.vger.kernel.org

On Thursday 04 July 2013, Chen Gang wrote:

> --------------------------patch begin----------------------------------
> 
> 'asm-generic' need provide necessary configuration checking, if can't
> pass checking, 'asm-generic' shouldn't implement it.
> 
> For 'COMPILE_TEST', according to its help contents, 'asm-generic' need
> let it pass configuration checking, and provide related dummy contents
> for it.
> 
> Part of 'COMPLE_TEST' help contents in "init/Kconfig":
> 
>   "...Despite they cannot be loaded there (or even when they load they cannot be used due to missing HW support)..."
> 
> One sample for using 'COMPILE_TEST':
> 
>   'PTP_1588_CLOCK_PCH' in drivers/ptp/Kconfig, which need depend on 'HAS_IOMEM'.

Then please submit a patch that adds the 'depends on HAS_IOMEM' line there.
That line was clearly left out by accident.

> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  include/asm-generic/io.h |   22 ++++++++++++++++++----
>  1 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index d5afe96..301ce80 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -303,13 +303,18 @@ static inline void *phys_to_virt(unsigned long address)
>  /*
>   * Change "struct page" to physical address.
>   *
> - * This implementation is for the no-MMU case only... if you have an MMU
> - * you'll need to provide your own definitions.
> + * This for the no-MMU, or no-IOMEM but still try to COMPILE_TEST cases.
> + * if you have an MMU and IOMEM, you'll need to provide your own definitions.
>   */
> -#ifndef CONFIG_MMU
> +#if !defined(CONFIG_MMU) || \
> +	(!defined(CONFIG_HAS_IOMEM) && defined(CONFIG_COMPILE_TEST))
>  static inline void __iomem *ioremap(phys_addr_t offset, unsigned long size)
>  {
> +#if !defined(CONFIG_MMU)
>  	return (void __iomem*) (unsigned long)offset;
> +#else
> +	return NULL;
> +#endif
>  }
>  
>  #define __ioremap(offset, size, flags)	ioremap(offset, size)

This is wrong for multiple reasons, all of which have been discussed in
this thread before.

NAK
