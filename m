Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:43188 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933499AbeDXODF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Apr 2018 10:03:05 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/3] dma-debug: unexport dma_debug_resize_entries and debug_dma_dump_mappings
Date: Tue, 24 Apr 2018 16:02:35 +0200
Message-ID: <20180424140235.9125-4-hch@lst.de>
In-Reply-To: <20180424140235.9125-1-hch@lst.de>
References: <20180424140235.9125-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Message-ID: <20180424140235.ryLm0o-08EQBXr25hJTW3DrFHwnfayU4AiPBlfAxzrQ@z>

Only used by the AMD GART driver, which must be built in.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/dma-debug.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/dma-debug.c b/lib/dma-debug.c
index 075253cb613b..6a1ebaa83623 100644
--- a/lib/dma-debug.c
+++ b/lib/dma-debug.c
@@ -444,7 +444,6 @@ void debug_dma_dump_mappings(struct device *dev)
 		spin_unlock_irqrestore(&bucket->lock, flags);
 	}
 }
-EXPORT_SYMBOL(debug_dma_dump_mappings);
 
 /*
  * For each mapping (initial cacheline in the case of
@@ -753,7 +752,6 @@ int dma_debug_resize_entries(u32 num_entries)
 
 	return ret;
 }
-EXPORT_SYMBOL(dma_debug_resize_entries);
 
 /*
  * DMA-API debugging init code
-- 
2.17.0
