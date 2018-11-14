Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:49296 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732080AbeKNSZ4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Nov 2018 13:25:56 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 03/34] powerpc/dma: remove the unused ARCH_HAS_DMA_MMAP_COHERENT define
Date: Wed, 14 Nov 2018 09:22:43 +0100
Message-ID: <20181114082314.8965-4-hch@lst.de>
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181114082243.UroDdIdFQW51Q1r4kLWmExq4qQ2P62zgxJPjBVQPnaQ@z>

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/dma-mapping.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 8fa394520af6..f2a4a7142b1e 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -112,7 +112,5 @@ extern int dma_set_mask(struct device *dev, u64 dma_mask);
 
 extern u64 __dma_get_required_mask(struct device *dev);
 
-#define ARCH_HAS_DMA_MMAP_COHERENT
-
 #endif /* __KERNEL__ */
 #endif	/* _ASM_DMA_MAPPING_H */
-- 
2.19.1
