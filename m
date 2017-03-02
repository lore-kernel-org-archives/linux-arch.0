From: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCHv2 01/14] treewide: Move set_memory_* functions away from
 cacheflush.h
Date: Thu, 2 Mar 2017 12:07:09 +0000
Message-ID: <20170302120709.GL21222@n2100.armlinux.org.uk>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
 <1488413706-9739-2-git-send-email-labbott@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1488413706-9739-2-git-send-email-labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laura Abbott <labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Heiko Carstens <heiko.carstens-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Alexander Shishkin <alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Daniel Borkmann <daniel-FeC+5ew28dpmcu3hnIyYJQ@public.gmane.org>, Jessica Yu <jeyu-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>l
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 01, 2017 at 04:14:53PM -0800, Laura Abbott wrote:
> diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
> index 02454fa..1cb9d11 100644
> --- a/arch/arm/include/asm/cacheflush.h
> +++ b/arch/arm/include/asm/cacheflush.h
> @@ -16,6 +16,7 @@
>  #include <asm/shmparam.h>
>  #include <asm/cachetype.h>
>  #include <asm/outercache.h>
> +#include <asm/set_memory.h>
>  
>  #define CACHE_COLOUR(vaddr)	((vaddr & (SHMLBA - 1)) >> PAGE_SHIFT)
>  
> @@ -478,26 +479,6 @@ static inline void __sync_cache_range_r(volatile void *p, size_t size)
>  	: : : "r0","r1","r2","r3","r4","r5","r6","r7", \
>  	      "r9","r10","lr","memory" )
>  
> -#ifdef CONFIG_MMU
> -int set_memory_ro(unsigned long addr, int numpages);
> -int set_memory_rw(unsigned long addr, int numpages);
> -int set_memory_x(unsigned long addr, int numpages);
> -int set_memory_nx(unsigned long addr, int numpages);
> -#else
> -static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
> -static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
> -static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
> -static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
> -#endif
> -
> -#ifdef CONFIG_STRICT_KERNEL_RWX
> -void set_kernel_text_rw(void);
> -void set_kernel_text_ro(void);
> -#else
> -static inline void set_kernel_text_rw(void) { }
> -static inline void set_kernel_text_ro(void) { }
> -#endif
> -
>  void flush_uprobe_xol_access(struct page *page, unsigned long uaddr,
>  			     void *kaddr, unsigned long len);
>  
> diff --git a/arch/arm/include/asm/set_memory.h b/arch/arm/include/asm/set_memory.h
> new file mode 100644
> index 0000000..5aa4315
> --- /dev/null
> +++ b/arch/arm/include/asm/set_memory.h
> @@ -0,0 +1,32 @@
> +/*
> + * Copyright (C) 1999-2002 Russell King
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _ASMARM_SET_MEMORY_H
> +#define _ASMARM_SET_MEMORY_H
> +
> +#ifdef CONFIG_MMU
> +int set_memory_ro(unsigned long addr, int numpages);
> +int set_memory_rw(unsigned long addr, int numpages);
> +int set_memory_x(unsigned long addr, int numpages);
> +int set_memory_nx(unsigned long addr, int numpages);
> +#else
> +static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
> +static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
> +static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
> +static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
> +#endif
> +
> +#ifdef CONFIG_STRICT_KERNEL_RWX
> +void set_kernel_text_rw(void);
> +void set_kernel_text_ro(void);
> +#else
> +static inline void set_kernel_text_rw(void) { }
> +static inline void set_kernel_text_ro(void) { }
> +#endif
> +
> +#endif

Acked-by: Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
