From: Greg Ungerer <gerg@snapgear.com>
Subject: Re: [PATCH -mm 6/6] m68knommu: convert little-endian bitops macros
 to static inline functions
Date: Fri, 28 Jan 2011 10:36:24 +1000
Message-ID: <4D420F88.5030301@snapgear.com>
References: <1296136583-13815-1-git-send-email-akinobu.mita@gmail.com> <1296136583-13815-7-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sncsmrelay2.nai.com ([67.97.80.206]:41584 "EHLO
	sncsmrelay2.nai.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762Ab1A1Ajq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jan 2011 19:39:46 -0500
In-Reply-To: <1296136583-13815-7-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, Greg Ungerer <gerg@uclinux.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>

On 27/01/11 23:56, Akinobu Mita wrote:
> (This patch is intended to be folded into the patch in -mm:
> m68knommu-introduce-little-endian-bitops.patch)
>
> A few little-endian bitops on m68knommu are written as preprocessor
> macros with the cast to "unsigned long *".
> This means that even non-pointers will be accepted without an error, and
> that is a Very Bad Thing.
>
> This converts the little-endian bitops macros to static inline functions
> with proper prototypes.
>
> Suggested-by: "H. Peter Anvin"<hpa@zytor.com>
> Signed-off-by: Akinobu Mita<akinobu.mita@gmail.com>
> Cc: Greg Ungerer<gerg@uclinux.org>
> Cc: Greg Ungerer<gerg@snapgear.com>

You drop both of these "CC"'s and add:

Acked-by: Greg Ungerer <gerg@uclinux.org>


> Cc: Geert Uytterhoeven<geert@linux-m68k.org>
> Cc: Roman Zippel<zippel@linux-m68k.org>
> Cc: Andreas Schwab<schwab@linux-m68k.org>
> ---
>   arch/m68k/include/asm/bitops_no.h |   12 ++++++++----
>   1 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/m68k/include/asm/bitops_no.h b/arch/m68k/include/asm/bitops_no.h
> index c5f5a78..7d3779f 100644
> --- a/arch/m68k/include/asm/bitops_no.h
> +++ b/arch/m68k/include/asm/bitops_no.h
> @@ -198,11 +198,15 @@ static __inline__ int __test_bit(int nr, const volatile unsigned long * addr)
>
>   #define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1)&  ~0x7)
>
> -#define __set_bit_le(nr, addr) \
> -	__set_bit((nr) ^ BITOP_LE_SWIZZLE, (unsigned long *)(addr))
> +static inline void __set_bit_le(int nr, void *addr)
> +{
> +	__set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
> +}
>
> -#define __clear_bit_le(nr, addr) \
> -	__clear_bit((nr) ^ BITOP_LE_SWIZZLE, (unsigned long *)(addr))
> +static inline void __clear_bit_le(int nr, void *addr)
> +{
> +	__clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
> +}
>
>   static inline int __test_and_set_bit_le(int nr, volatile void *addr)
>   {


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
