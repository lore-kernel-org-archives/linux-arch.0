Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46619 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933462AbeALNQy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Jan 2018 08:16:54 -0500
Date: Fri, 12 Jan 2018 08:16:48 -0500
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: [PATCH 19/33] dma-mapping: warn when there is no
 coherent_dma_mask
Message-ID: <20180112131646.GA26900@localhost.localdomain>
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-20-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110080027.13879-20-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180112131648.lKbIYew1wtDyjZ00f_73R0yyXdxUZvEaTKcOKQcPNwI@z>

On Wed, Jan 10, 2018 at 09:00:13AM +0100, Christoph Hellwig wrote:
> These days all devices should have a DMA coherent mask, and most dma_ops
> implementations rely on that fact.  But just to be sure add an assert to
> ring the warning bell if that is not the case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  include/linux/dma-mapping.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index d84951865be7..9f28b2fa329e 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -513,6 +513,7 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
>  	void *cpu_addr;
>  
>  	BUG_ON(!ops);
> +	WARN_ON_ONCE(!dev->coherent_dma_mask);
>  
>  	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
>  		return cpu_addr;
> -- 
> 2.14.2
> 
