From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 09/12] unicore32 machine related files: hardware registers
Date: Sun, 27 Feb 2011 18:15:42 +0100
Message-ID: <201102271815.42395.arnd@arndb.de>
References: <015301cbcdae$55cdb7e0$016927a0$@mprc.pku.edu.cn> <201102261416.10050.arnd@arndb.de> <017d01cbd62f$53af8590$fb0e90b0$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <017d01cbd62f$53af8590$fb0e90b0$@mprc.pku.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 'Greg KH' <greg@kroah.com>
List-Id: linux-arch.vger.kernel.org

On Sunday 27 February 2011, Guan Xuetao wrote:
> Please see following patch, __REG removed and __iomem added to io_p2v:
> 
> diff --git a/arch/unicore32/include/mach/hardware.h b/arch/unicore32/include/mach/hardware.h
> index b71405a..b197b0b 100644
> --- a/arch/unicore32/include/mach/hardware.h
> +++ b/arch/unicore32/include/mach/hardware.h
> @@ -17,13 +17,10 @@
>  
>  #include "PKUnity.h"
>  
> -#define io_p2v(x)      ((x) - PKUNITY_MMIO_BASE)
> -#define io_v2p(x)      ((x) + PKUNITY_MMIO_BASE)
> -
>  #ifndef __ASSEMBLY__
> -
> -# define __REG(x)      (void __iomem *)io_p2v(x)
> -
> +#define io_p2v(x)      (void __iomem *)((x) - PKUNITY_MMIO_BASE)
> +#else
> +#define io_p2v(x)      ((x) - PKUNITY_MMIO_BASE)
>  #endif
>  
>  #define PCIBIOS_MIN_IO                 0x4000 /* should lower than 64KB */

Yes, looks good!

Acked-by: Arnd Bergmann <arnd@arndb.de>
