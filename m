From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH 6/7] common: dma-mapping: change alloc/free_coherent	method
 to more generic alloc/free_attrs
Date: Thu, 22 Sep 2011 16:00:28 +0200
Message-ID: <006301cc792f$fc3a3a40$f4aeaec0$%szyprowski@samsung.com>
References: <1314971599-14428-1-git-send-email-m.szyprowski@samsung.com>
 <1314971599-14428-7-git-send-email-m.szyprowski@samsung.com>
 <20110905104352.GD5203@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:65186 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735Ab1IVOAk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 22 Sep 2011 10:00:40 -0400
Received: from euspt1 (mailout1.w1.samsung.com [210.118.77.11])
 by mailout1.w1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0LRX005UAG91CX@mailout1.w1.samsung.com> for
 linux-arch@vger.kernel.org; Thu, 22 Sep 2011 15:00:37 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LRX00E63G90C7@spt1.w1.samsung.com> for
 linux-arch@vger.kernel.org; Thu, 22 Sep 2011 15:00:37 +0100 (BST)
In-reply-to: <20110905104352.GD5203@8bytes.org>
Content-language: pl
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Joerg Roedel' <joro@8bytes.org>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Arnd Bergmann' <arnd@arndb.de>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Shariq Hasnain' <shariq.hasnain@linaro.org>, 'Chunsang Jeong' <chunsang.jeong@linaro.org>

Hello,

On Monday, September 05, 2011 12:44 PM Joerg Roedel wrote:

> On Fri, Sep 02, 2011 at 03:53:18PM +0200, Marek Szyprowski wrote:
> >  struct dma_map_ops {
> > -	void* (*alloc_coherent)(struct device *dev, size_t size,
> > -				dma_addr_t *dma_handle, gfp_t gfp);
> > -	void (*free_coherent)(struct device *dev, size_t size,
> > -			      void *vaddr, dma_addr_t dma_handle);
> > +	void* (*alloc)(struct device *dev, size_t size,
> > +				dma_addr_t *dma_handle, gfp_t gfp,
> > +				struct dma_attrs *attrs);
> > +	void (*free)(struct device *dev, size_t size,
> > +			      void *vaddr, dma_addr_t dma_handle,
> > +			      struct dma_attrs *attrs);
> > +	int (*mmap)(struct device *, struct vm_area_struct *,
> > +			  void *, dma_addr_t, size_t, struct dma_attrs *attrs);
> > +
> >  	dma_addr_t (*map_page)(struct device *dev, struct page *page,
> >  			       unsigned long offset, size_t size,
> >  			       enum dma_data_direction dir,
> > --
> > 1.7.1.569.g6f426
> 
> This needs conversion of all drivers implementing dma_map_ops or you
> will break a lot of architectures. A better approach is to keep
> *_coherent and implement alloc/free/mmap side-by-side until all drivers
> are converted.
> Also I miss some documentation about the new call-backs.

Right this patch will break all other architectures, however it was just 
a snapshot of my work-in-progress. Converting all other architectures from
alloc_coherent to alloc with NULL attribute shouldn't be really hard and will
be added in the final version - together with documentation.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
