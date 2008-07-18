From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH-mm] byteorder: wire up arches to use new headers
Date: Fri, 18 Jul 2008 14:36:27 +0100
Message-ID: <20080718133627.GA25816@flint.arm.linux.org.uk>
References: <1216337353.6029.66.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33805 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756398AbYGRNgv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jul 2008 09:36:51 -0400
Content-Disposition: inline
In-Reply-To: <1216337353.6029.66.camel@brick>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>

On Thu, Jul 17, 2008 at 04:29:13PM -0700, Harvey Harrison wrote:
> diff --git a/include/asm-arm/byteorder.h b/include/asm-arm/byteorder.h
> index e6f7fcd..d88a5ce 100644
> --- a/include/asm-arm/byteorder.h
> +++ b/include/asm-arm/byteorder.h
> @@ -18,7 +18,15 @@
>  #include <linux/compiler.h>
>  #include <asm/types.h>
>  
> -static inline __attribute_const__ __u32 ___arch__swab32(__u32 x)
> +#ifdef __ARMEB__
> +# define __BIG_ENDIAN
> +#else
> +# define __LITTLE_ENDIAN
> +#endif
> +
> +#define __SWAB_64_THRU_32__
> +
> +static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
>  {
>  	__u32 t;
>  
> @@ -40,19 +48,8 @@ static inline __attribute_const__ __u32 ___arch__swab32(__u32 x)
>  
>  	return x;
>  }
> +#define HAVE_ARCH_SWAB32
>  
> -#define __arch__swab32(x) ___arch__swab32(x)
> -
> -#if !defined(__STRICT_ANSI__) || defined(__KERNEL__)
> -#  define __BYTEORDER_HAS_U64__
> -#  define __SWAB_64_THRU_32__
> -#endif
> -
> -#ifdef __ARMEB__
> -#include <linux/byteorder/big_endian.h>
> -#else
> -#include <linux/byteorder/little_endian.h>
> -#endif
> +#include <linux/byteorder.h>
>  
>  #endif
> -

For the above,

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
