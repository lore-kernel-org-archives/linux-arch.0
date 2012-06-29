From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH] common: dma-mapping: add support for generic dma_mmap_*
 calls
Date: Fri, 29 Jun 2012 15:00:37 +0200
Message-ID: <00a501cd55f7$323946f0$96abd4d0$%szyprowski@samsung.com>
References: <1339741135-7841-1-git-send-email-m.szyprowski@samsung.com>
 <4FED8D03.10507@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:49198 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754723Ab2F2NAz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jun 2012 09:00:55 -0400
In-reply-to: <4FED8D03.10507@ladisch.de>
Content-language: pl
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Clemens Ladisch' <clemens@ladisch.de>
Cc: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Arnd Bergmann' <arnd@arndb.de>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, 'Konrad Rzeszutek Wilk' <konrad.wilk@oracle.com>, 'David Gibson' <david@gibson.dropbear.id.au>, 'Subash Patel' <subash.ramaswamy@linaro.org>, 'Sumit Semwal' <sumit.semwal@linaro.org>

Hi,

On Friday, June 29, 2012 1:10 PM Clemens Ladisch wrote:

> Marek Szyprowski wrote:
> > +++ b/drivers/base/dma-mapping.c
> > ...
> > +int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
> > +		    void *cpu_addr, dma_addr_t dma_addr, size_t size)
> > +{
> > +	int ret = -ENXIO;
> > +	...
> > +	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
> > +		return ret;
> 
> This will return -ENXIO if dma_mmap_from_coherent() succeeds.
 
Thanks for spotting this! I will fix it in the next version of the patch.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
