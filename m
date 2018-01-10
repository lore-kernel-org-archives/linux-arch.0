Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:52958 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752265AbeAJIJl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jan 2018 03:09:41 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: consolidate swiotlb dma_map implementations
Date: Wed, 10 Jan 2018 09:09:10 +0100
Message-ID: <20180110080932.14157-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: iommu@lists.linux-foundation.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, Michal Simek <monstr@monstr.eu>, Guan Xuetao <gxt@mprc.pku.edu.cn>, =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180110080910.7EBV9lcc6kQtoUSmAtkXCfp-kt3_LGvh-GC5qSNMbYI@z>

A lot of architectures have essentially identical dma_map_ops
implementations to use swiotlb.  This series adds new generic
swiotlb_alloc/free helpers that take the attrs argument exposed
in dma_map_ops, and which do an enhanced direct allocation
modelled after x86 and reused from the dma-direct code, and
then switches most architectures over to it.  The only exceptions
are mips, which requires additional cache flushing which will
need a new abstraction, and x86 itself which will be handled in
a later series with other x86 dma mapping changes.

To support the generic code a few architectures that currently
use ZONE_DMA/GFP_DMA for <= 32-bit allocations are switched to
implement ZONE_DMA32 instead.

This series is based on the previously sent series to consolidate
the direct dma mapping implementation.  A git tree with this
series as well as the prerequisites is available here:

   git://git.infradead.org/users/hch/misc.git swiotlb

Gitweb:

   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/swiotlb
