Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:39759 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbdFZIyw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2017 04:54:52 -0400
Subject: Re: [PATCH 1/7] drm/tilcdc: don't use volatile with iowrite64
References: <20170622164817.25515-1-logang@deltatee.com>
 <20170622164817.25515-2-logang@deltatee.com>
From: Jyri Sarha <jsarha@ti.com>
Message-ID: <33b6c00f-1982-69dd-86b2-107266d238d0@ti.com>
Date: Mon, 26 Jun 2017 11:54:25 +0300
MIME-Version: 1.0
In-Reply-To: <20170622164817.25515-2-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-ntb@googlegroups.com, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Bates <sbates@raithlin.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, David Airlie <airlied@linux.ie>
Message-ID: <20170626085425.wXVOLetDAiOrGOYFptSiSsNXHsI_10iM_eQnBslNfwU@z>

On 06/22/17 19:48, Logan Gunthorpe wrote:
> This is a prep patch for adding a universal iowrite64.
> 
> The patch is to prevent compiler warnings when we add iowrite64 that
> would occur because there is an unnecessary volatile in this driver.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Jyri Sarha <jsarha@ti.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: David Airlie <airlied@linux.ie>

Acked-by: Jyri Sarha <jsarha@ti.com>

> ---
>  drivers/gpu/drm/tilcdc/tilcdc_regs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_regs.h b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
> index 9d528c0a67a4..e9ce725698a9 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_regs.h
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
> @@ -131,14 +131,14 @@ static inline void tilcdc_write(struct drm_device *dev, u32 reg, u32 data)
>  static inline void tilcdc_write64(struct drm_device *dev, u32 reg, u64 data)
>  {
>  	struct tilcdc_drm_private *priv = dev->dev_private;
> -	volatile void __iomem *addr = priv->mmio + reg;
> +	void __iomem *addr = priv->mmio + reg;
>  
>  #ifdef iowrite64
>  	iowrite64(data, addr);
>  #else
>  	__iowmb();
>  	/* This compiles to strd (=64-bit write) on ARM7 */
> -	*(volatile u64 __force *)addr = __cpu_to_le64(data);
> +	*(u64 __force *)addr = __cpu_to_le64(data);
>  #endif
>  }
>  
> 
