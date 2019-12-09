Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46627 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfLISp7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Dec 2019 13:45:59 -0500
Date: Mon, 9 Dec 2019 10:46:54 -0800
From: Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH 1/2] MIPS: define ioremap_nocache to ioremap
Message-ID: <20191209184654.w2d7mguzfc5cyage@lantea.localdomain>
References: <20191209135823.28465-1-hch@lst.de>
 <20191209135823.28465-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191209135823.28465-2-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, James Hogan <jhogan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-mips@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20191209184654.wkWIkFcD0ip2bwH0RGyRXn1Oud-Aqk_c_o0UIcKFttY@z>

Hi Christoph,

On Mon, Dec 09, 2019 at 02:58:21PM +0100, Christoph Hellwig wrote:
> They are both defined the same way, but this makes it easier to validate
> the scripted ioremap_nocache removal following soon.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Paul Burton <paulburton@kernel.org>

Thanks,
    Paul

> ---
>  arch/mips/include/asm/io.h | 25 ++-----------------------
>  1 file changed, 2 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index 3f6ce74335b4..d9caa811a2fa 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -227,29 +227,8 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset,
>   */
>  #define ioremap(offset, size)						\
>  	__ioremap_mode((offset), (size), _CACHE_UNCACHED)
> -
> -/*
> - * ioremap_nocache     -   map bus memory into CPU space
> - * @offset:    bus address of the memory
> - * @size:      size of the resource to map
> - *
> - * ioremap_nocache performs a platform specific sequence of operations to
> - * make bus memory CPU accessible via the readb/readw/readl/writeb/
> - * writew/writel functions and the other mmio helpers. The returned
> - * address is not guaranteed to be usable directly as a virtual
> - * address.
> - *
> - * This version of ioremap ensures that the memory is marked uncachable
> - * on the CPU as well as honouring existing caching rules from things like
> - * the PCI bus. Note that there are other caches and buffers on many
> - * busses. In particular driver authors should read up on PCI writes
> - *
> - * It's useful if some control registers are in such an area and
> - * write combining or read caching is not desirable:
> - */
> -#define ioremap_nocache(offset, size)					\
> -	__ioremap_mode((offset), (size), _CACHE_UNCACHED)
> -#define ioremap_uc ioremap_nocache
> +#define ioremap_nocache		ioremap
> +#define ioremap_uc		ioremap
>  
>  /*
>   * ioremap_cache -	map bus memory into CPU space
> -- 
> 2.20.1
> 
