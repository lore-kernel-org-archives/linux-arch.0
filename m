From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH v3 2/4] asm-generic: Provide a fncpy() implementation
Date: Mon, 19 Jun 2017 02:51:08 +0300
Message-ID: <20170618235108.peaxdi367jpkt542@yury-thinkpad>
References: <20170617000744.22158-1-f.fainelli@gmail.com>
 <20170617000744.22158-3-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2nam02on0080.outbound.protection.outlook.com ([104.47.38.80]:2785
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752503AbdFRXvY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 18 Jun 2017 19:51:24 -0400
Content-Disposition: inline
In-Reply-To: <20170617000744.22158-3-f.fainelli@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Keerthy J <j-keerthy@ti.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>

Hi Florian,

Some questions and thoughts inline.

Yury

On Fri, Jun 16, 2017 at 05:07:42PM -0700, Florian Fainelli wrote:
> Define a generic fncpy() implementation largely based on the ARM version
> that requires an 8 bytes alignment for the destination address where to
> copy this function as well as the function's own address.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  include/asm-generic/fncpy.h | 93 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 include/asm-generic/fncpy.h
> 
> diff --git a/include/asm-generic/fncpy.h b/include/asm-generic/fncpy.h
> new file mode 100644
> index 000000000000..ec03b83b8535
> --- /dev/null
> +++ b/include/asm-generic/fncpy.h
> @@ -0,0 +1,93 @@
> +/*
> + * include/asm-generic/fncpy.h - helper macros for function body copying
> + *
> + * Copyright (C) 2011 Linaro Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + */
> +
> +/*
> + * These macros are intended for use when there is a need to copy a low-level
> + * function body into special memory.
> + *
> + * For example, when reconfiguring the SDRAM controller, the code doing the
> + * reconfiguration may need to run from SRAM.
> + *
> + * NOTE: that the copied function body must be entirely self-contained and
> + * position-independent in order for this to work properly.
> + *
> + * NOTE: in order for embedded literals and data to get referenced correctly,
> + * the alignment of functions must be preserved when copying.  To ensure this,
> + * the source and destination addresses for fncpy() must be aligned to a
> + * multiple of 8 bytes: you will be get a BUG() if this condition is not met.
> + * You will typically need a ".align 3" directive in the assembler where the
> + * function to be copied is defined, and ensure that your allocator for the
> + * destination buffer returns 8-byte-aligned pointers.
> + *
> + * Typical usage example:
> + *
> + * extern int f(args);
> + * extern uint32_t size_of_f;
> + * int (*copied_f)(args);
> + * void *sram_buffer;
> + *
> + * copied_f = fncpy(sram_buffer, &f, size_of_f);
> + *
> + * ... later, call the function: ...
> + *
> + * copied_f(args);
> + *
> + * The size of the function to be copied can't be determined from C:
> + * this must be determined by other means, such as adding assmbler directives
> + * in the file where f is defined.
> + */
> +
> +#ifndef __ASM_FNCPY_H
> +#define __ASM_FNCPY_H
> +
> +#include <linux/types.h>
> +#include <linux/string.h>
> +
> +#include <asm/bug.h>
> +#include <asm/cacheflush.h>
> +
> +/*
> + * Minimum alignment requirement for the source and destination addresses
> + * for function copying.
> + */
> +#define FNCPY_ALIGN 8

From now this is not arm-only, and it's possible that some architectures
might want to redefine it in their arch/xxx/include/asm/fncpy.h files.
So it will be easier for them if you'll wrap FNCPY_ALIGN here with #ifdef
guards.

By the way, compiler already has an information on the proper alignment.
Maybe it's better to use it as the default value here instead of the
hardcoded value?

#ifndef FNCPY_ALIGN
#define FNCPY_ALIGN ({void foo(); __alignof__(&foo);})
#endif

> +
> +#define fncpy(dest_buf, funcp, size) ({					\

Do you really need to check types inside the macro? If not, you can
declare it as function, which is better in general, with the memcpy-like
prototype.

> +	uintptr_t __funcp_address;					\
> +	typeof(funcp) __result;						\
> +									\
> +	asm("" : "=r" (__funcp_address) : "0" (funcp));			\
> +									\
> +	/*								\
> +	 * Ensure alignment of source and destination addresses.	\
> +	 */								\
> +	BUG_ON((uintptr_t)(dest_buf) & (FNCPY_ALIGN - 1) ||		\

People don't like new BUG_ONs. Maybe it's better to use BUILD_BUG_ON()
at compile time and WARN_ON() at runtime?

> +		(__funcp_address & (FNCPY_ALIGN - 1)));			\

There is IS_ALIGNED() macro for things like this.

And I frankly don't understand the 2nd check. One can imagine the
situation when someone wants copy the function from the packed blob or
some intermediate location were the function is unaligned, and it's
impossible with the current implementation.

> +									\
> +	memcpy(dest_buf, (void const *)__funcp_address, size);		\
> +	flush_icache_range((unsigned long)(dest_buf),			\
> +		(unsigned long)(dest_buf) + (size));			\
> +									\
> +	asm("" : "=r" (__result)					\
> +		: "0" ((uintptr_t)(dest_buf)));				\
> +									\
> +	__result;							\
> +})
> +
> +#endif /* !__ASM_FNCPY_H */
> -- 
> 2.9.3
