From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCHv4 4/6] byteorder: wire up arches to use new headers
Date: Mon, 2 Jun 2008 13:06:05 +0100
Message-ID: <20080602120605.GA27125@flint.arm.linux.org.uk>
References: <1212090962.28403.51.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42321 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbYFBMGW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jun 2008 08:06:22 -0400
Content-Disposition: inline
In-Reply-To: <1212090962.28403.51.camel@brick>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>

On Thu, May 29, 2008 at 12:56:02PM -0700, Harvey Harrison wrote:
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

On the face of it, looks fine.  However, I noticed that in your reply to
patch 3 you said you'll resend stuff - is there any point in me looking
at the remainder of this patch set?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
