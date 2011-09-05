Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 8bytes.org ([88.198.83.132]:40926 "EHLO 8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365Ab1IEKx3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 5 Sep 2011 06:53:29 -0400
Date: Mon, 5 Sep 2011 12:43:52 +0200
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 6/7] common: dma-mapping: change alloc/free_coherent
	method to more generic alloc/free_attrs
Message-ID: <20110905104352.GD5203@8bytes.org>
References: <1314971599-14428-1-git-send-email-m.szyprowski@samsung.com> <1314971599-14428-7-git-send-email-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1314971599-14428-7-git-send-email-m.szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Shariq Hasnain <shariq.hasnain@linaro.org>, Chunsang Jeong <chunsang.jeong@linaro.org>
Message-ID: <20110905104352.58XLdwxROPw8_KgvGTAcFgyzweM0gztBjeTGYk2BExA@z>

On Fri, Sep 02, 2011 at 03:53:18PM +0200, Marek Szyprowski wrote:
>  struct dma_map_ops {
> -	void* (*alloc_coherent)(struct device *dev, size_t size,
> -				dma_addr_t *dma_handle, gfp_t gfp);
> -	void (*free_coherent)(struct device *dev, size_t size,
> -			      void *vaddr, dma_addr_t dma_handle);
> +	void* (*alloc)(struct device *dev, size_t size,
> +				dma_addr_t *dma_handle, gfp_t gfp,
> +				struct dma_attrs *attrs);
> +	void (*free)(struct device *dev, size_t size,
> +			      void *vaddr, dma_addr_t dma_handle,
> +			      struct dma_attrs *attrs);
> +	int (*mmap)(struct device *, struct vm_area_struct *,
> +			  void *, dma_addr_t, size_t, struct dma_attrs *attrs);
> +
>  	dma_addr_t (*map_page)(struct device *dev, struct page *page,
>  			       unsigned long offset, size_t size,
>  			       enum dma_data_direction dir,
> -- 
> 1.7.1.569.g6f426

This needs conversion of all drivers implementing dma_map_ops or you
will break a lot of architectures. A better approach is to keep
*_coherent and implement alloc/free/mmap side-by-side until all drivers
are converted.
Also I miss some documentation about the new call-backs.

	Joerg

