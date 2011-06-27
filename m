Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:63012 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab1F0OUv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jun 2011 10:20:51 -0400
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; charset=us-ascii
Received: from spt2.w1.samsung.com ([210.118.77.14]) by mailout4.w1.samsung.com
 (Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009; 32bit))
 with ESMTP id <0LNG00FBDD6P0590@mailout4.w1.samsung.com> for
 linux-arch@vger.kernel.org; Mon, 27 Jun 2011 15:20:49 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LNG00015D6NNS@spt2.w1.samsung.com> for
 linux-arch@vger.kernel.org; Mon, 27 Jun 2011 15:20:48 +0100 (BST)
Date: Mon, 27 Jun 2011 16:20:44 +0200
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH 5/8] ARM: dma-mapping: move all dma bounce code to separate
 dma ops structure
In-reply-to: <201106241747.03113.arnd@arndb.de>
Message-ID: <000901cc34d5$66ff7d80$34fe7880$%szyprowski@samsung.com>
Content-language: pl
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
 <20110620144247.GF26089@n2100.arm.linux.org.uk>
 <000901cc2f5f$237795a0$6a66c0e0$%szyprowski@samsung.com>
 <201106241747.03113.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Arnd Bergmann' <arnd@arndb.de>
Cc: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>
Message-ID: <20110627142044.E8HZyosoccaa7q2S2aWZrMSkmzcsjxMlkkCW6iD_-yg@z>

Hello,

On Friday, June 24, 2011 5:47 PM Arnd Bergmann wrote:

> On Monday 20 June 2011, Marek Szyprowski wrote:
> > On Monday, June 20, 2011 4:43 PM Russell King - ARM Linux wrote:
> >
> > > On Mon, Jun 20, 2011 at 09:50:10AM +0200, Marek Szyprowski wrote:
> > > > This patch removes dma bounce hooks from the common dma mapping
> > > > implementation on ARM architecture and creates a separate set of
> > > > dma_map_ops for dma bounce devices.
> > >
> > > Why all this additional indirection for no gain?
> >
> > I've did it to really separate dmabounce code and let it be completely
> > independent of particular internal functions of the main generic dma-
> mapping
> > code.
> >
> > dmabounce is just one of possible dma-mapping implementation and it is
> really
> > convenient to have it closed into common interface (dma_map_ops) rather
> than
> > having it spread around and hardcoded behind some #ifdefs in generic ARM
> > dma-mapping.
> >
> > There will be also other dma-mapping implementations in the future - I
> > thinking mainly of some iommu capable versions.
> >
> > In terms of speed I really doubt that these changes have any impact on
> the
> > system performance, but they significantly improves the code readability
> > (see next patch with cleanup of dma-mapping.c).
> 
> Yes. I believe the main effect of splitting out dmabounce into its own
> set of operations is improved readability for people that are not
> familiar with the existing code (which excludes Russell ;-) ), by
> separating the two codepaths and losing various #ifdef.
> 
> The simplification becomes more obvious when you look at patch 6, which
> removes a lot of the code that becomes redundant after this one.

This separation might also help in future with code consolidation across
different architectures. It was suggested that ARM DMA bounce code has a lot
in common with SWIOTBL (if I'm right) dma-mapping implementation.

The separation will also help in integrating the IOMMU based dma-mapping,
which will probably share again some code with linear dma-mapping code.
Having these 3 implementations mixed together might not help in code
readability.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center



