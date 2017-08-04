From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] [RESEND] mtd: only use __xipram annotation when
 XIP_KERNEL is set
Date: Fri, 4 Aug 2017 09:35:50 +0200
Message-ID: <20170804093550.41e5936c@bbrezillon>
References: <20170721202636.3361536-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:50040 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdHDHfx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2017 03:35:53 -0400
In-Reply-To: <20170721202636.3361536-1-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Russell King <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Nicholas Piggin <npiggin@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Michal Marek <mmarek@suse.com>, Linus Walleij <linus.walleij@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Chris Metcalf <cmetcalf@mellanox.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org

On Fri, 21 Jul 2017 22:26:25 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> When XIP_KERNEL is enabled, some functions are defined in the .data
> ELF section because we require them to be in RAM whenever we communicate
> with the flash chip. However this causes problems when FTRACE is
> enabled and gcc emits calls to __gnu_mcount_nc in the function
> prolog:
> 
> drivers/built-in.o: In function `cfi_chip_setup':
> :(.data+0x272fc): relocation truncated to fit: R_ARM_CALL against symbol `__gnu_mcount_nc' defined in .text section in arch/arm/kernel/built-in.o
> drivers/built-in.o: In function `cfi_probe_chip':
> :(.data+0x27de8): relocation truncated to fit: R_ARM_CALL against symbol `__gnu_mcount_nc' defined in .text section in arch/arm/kernel/built-in.o
> /tmp/ccY172rP.s: Assembler messages:
> /tmp/ccY172rP.s:70: Warning: ignoring changed section attributes for .data
> /tmp/ccY172rP.s: Error: 1 warning, treating warnings as errors
> make[5]: *** [drivers/mtd/chips/cfi_probe.o] Error 1
> /tmp/ccK4rjeO.s: Assembler messages:
> /tmp/ccK4rjeO.s:421: Warning: ignoring changed section attributes for .data
> /tmp/ccK4rjeO.s: Error: 1 warning, treating warnings as errors
> make[5]: *** [drivers/mtd/chips/cfi_util.o] Error 1
> /tmp/ccUvhCYR.s: Assembler messages:
> /tmp/ccUvhCYR.s:1895: Warning: ignoring changed section attributes for .data
> /tmp/ccUvhCYR.s: Error: 1 warning, treating warnings as errors
> 
> Specifically, this does not work because the .data section is not
> marked executable, which leads LD to not generate trampolines for
> long calls.
> 
> This moves the __xipram functions into their own .xiptext section instead.
> The section is still placed next to .data and located in RAM but is marked
> executable, which avoids the build errors.
> 
> Also, we only need to place the XIP functions into a separate section
> if both CONFIG_XIP_KERNEL and CONFIG_MTD_XIP are set: When only MTD_XIP
> is used, the whole kernel is still in RAM and we do not need to worry
> about pulling out the rug under it. When only XIP_KERNEL but not MTD_XIP
> is set, the kernel is in some form of ROM, but we never write to it.
> 
> Note that MTD_XIP has been broken on ARM since around 2011 or 2012. I
> have sent another patch[2] to fix compilation, which I plan to merge
> through arm-soc unless there are objections. The obvious alternative
> to that would be to completely rip out the MTD_XIP support from the
> kernel, since obviously nobody has been using it in a long while.
> 
> Link: [1] https://patchwork.kernel.org/patch/8109771/
> Link: [2] https://patchwork.kernel.org/patch/9855225/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/asm-generic/vmlinux.lds.h |  1 +
>  include/linux/mtd/xip.h           | 10 ++++++----

For the MTD part,

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index da0be9a8d1de..ff507c178327 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -203,6 +203,7 @@
>   * pull in .data..stuff which has its own requirements. Same for bss.
>   */
>  #define DATA_DATA							\
> +	*(.xiptext)							\
>  	*(.data .data.[0-9a-zA-Z_]*)					\
>  	*(.ref.data)							\
>  	*(.data..shared_aligned) /* percpu related */			\
> diff --git a/include/linux/mtd/xip.h b/include/linux/mtd/xip.h
> index abed4dec5c2f..e373690cce0a 100644
> --- a/include/linux/mtd/xip.h
> +++ b/include/linux/mtd/xip.h
> @@ -30,7 +30,9 @@
>   * obviously not be running from flash.  The __xipram is therefore marking
>   * those functions so they get relocated to ram.
>   */
> -#define __xipram noinline __attribute__ ((__section__ (".data")))
> +#ifdef CONFIG_XIP_KERNEL
> +#define __xipram noinline __attribute__ ((__section__ (".xiptext")))
> +#endif
>  
>  /*
>   * Each architecture has to provide the following macros.  They must access
> @@ -90,10 +92,10 @@
>  #define xip_cpu_idle()  do { } while (0)
>  #endif
>  
> -#else
> +#endif /* CONFIG_MTD_XIP */
>  
> +#ifndef __xipram
>  #define __xipram
> -
> -#endif /* CONFIG_MTD_XIP */
> +#endif
>  
>  #endif /* __LINUX_MTD_XIP_H__ */
