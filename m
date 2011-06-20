Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:9690 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895Ab1FTKq4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2011 06:46:56 -0400
Received: from eu_spt1 (mailout2.w1.samsung.com [210.118.77.12])
 by mailout2.w1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0LN300FU04M7PT@mailout2.w1.samsung.com> for
 linux-arch@vger.kernel.org; Mon, 20 Jun 2011 11:46:55 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LN3001QU4M5Z0@spt1.w1.samsung.com> for
 linux-arch@vger.kernel.org; Mon, 20 Jun 2011 11:46:54 +0100 (BST)
Date: Mon, 20 Jun 2011 12:46:50 +0200
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH 1/8] ARM: dma-mapping: remove offset parameter to prepare
 for generic dma_ops
In-reply-to: <op.vxc8tmru3l0zgt@mnazarewicz-glaptop>
Message-ID: <000001cc2f37$5c5605f0$150211d0$%szyprowski@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-language: pl
Content-transfer-encoding: 7BIT
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
 <1308556213-24970-2-git-send-email-m.szyprowski@samsung.com>
 <op.vxc8tmru3l0zgt@mnazarewicz-glaptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Michal Nazarewicz' <mina86@mina86.com>, linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc: 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Arnd Bergmann' <arnd@arndb.de>, 'Joerg Roedel' <joro@8bytes.org>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <20110620104650.3TnZsg0Qam0vEyHM0GywnHtQ8FZTufZ8kIw6depZL2k@z>

Hello,

On Monday, June 20, 2011 10:36 AM Michal Nazarewicz wrote:

> On Mon, 20 Jun 2011 09:50:06 +0200, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> > +static inline void dma_sync_single_for_cpu(struct device *dev,
> 
> I wouldn't really put inline here or in the function below.
> 
> > +		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> > +{
> > +	BUG_ON(!valid_dma_direction(dir));
> > +
> > +	debug_dma_sync_single_for_cpu(dev, handle, size, dir);
> > +
> > +	if (!dmabounce_sync_for_cpu(dev, handle, size, dir))
> > +		return;
> > +
> > +	__dma_single_dev_to_cpu(dma_to_virt(dev, handle), size, dir);
> 
> I know it is just copy'n'paste but how about:

This patch is just about moving the code between the files and I wanted just
to show what's being changed and how. There is a final cleanup anyway in the
separate patch. All these patches are meant to start the discussion about
the way the dma mapping can be redesigned for further extensions with generic
iommu support. 

> 
> 	if (dmabounce_sync_for_cpu(dev, handle, size, dir))
> 		__dma_single_dev_to_cpu(dma_to_virt(dev, handle), size, dir);

The above lines will be removed by the next patches in this series, so I
really see no point in changing this.

(snipped)

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center


