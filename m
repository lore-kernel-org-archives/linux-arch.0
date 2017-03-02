Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752978AbdCBOTT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Mar 2017 09:19:19 -0500
Date: Thu, 2 Mar 2017 14:11:50 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv2 01/14] treewide: Move set_memory_* functions away from
 cacheflush.h
Message-ID: <20170302141150.GL19632@leverpostej>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
 <1488413706-9739-2-git-send-email-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488413706-9739-2-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>, Jessica Yu <jeyu@redhat.com>, Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20170302141150.p5ACJdJPyXifQT2tpv0qGeqMv0v1Shf455Jt2Nl2jF0@z>

On Wed, Mar 01, 2017 at 04:14:53PM -0800, Laura Abbott wrote:
> diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
> index a12f1af..e419965 100644
> --- a/arch/arm64/include/asm/Kbuild
> +++ b/arch/arm64/include/asm/Kbuild
> @@ -27,6 +27,7 @@ generic-y += preempt.h
>  generic-y += resource.h
>  generic-y += rwsem.h
>  generic-y += segment.h
> +generic-y += set_memory.h
>  generic-y += sembuf.h
>  generic-y += serial.h

Nit: alphabetical order, please.

>  generic-y += shmbuf.h
> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> index 5a2a6ee..7db6962 100644
> --- a/arch/arm64/include/asm/cacheflush.h
> +++ b/arch/arm64/include/asm/cacheflush.h
> @@ -20,6 +20,7 @@
>  #define __ASM_CACHEFLUSH_H
>  
>  #include <linux/mm.h>
> +#include <asm/set_memory.h>
>  
>  /*
>   * This flag is used to indicate that the page pointed to by a pte is clean
> @@ -150,9 +151,4 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
>  {
>  }
>  
> -int set_memory_ro(unsigned long addr, int numpages);
> -int set_memory_rw(unsigned long addr, int numpages);
> -int set_memory_x(unsigned long addr, int numpages);
> -int set_memory_nx(unsigned long addr, int numpages);
> -
>  #endif

> diff --git a/include/asm-generic/set_memory.h b/include/asm-generic/set_memory.h
> new file mode 100644
> index 0000000..83e81f8
> --- /dev/null
> +++ b/include/asm-generic/set_memory.h
> @@ -0,0 +1,12 @@
> +#ifndef __ASM_SET_MEMORY_H
> +#define __ASM_SET_MEMORY_H
> +
> +/*
> + * Functions to change memory attributes.
> + */
> +int set_memory_ro(unsigned long addr, int numpages);
> +int set_memory_rw(unsigned long addr, int numpages);
> +int set_memory_x(unsigned long addr, int numpages);
> +int set_memory_nx(unsigned long addr, int numpages);
> +
> +#endif

Otherwise, this looks fine to me. FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
