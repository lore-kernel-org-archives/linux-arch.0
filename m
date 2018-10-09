From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 24/33] powerpc/dma: fix an off-by-one in dma_capable
Date: Tue,  9 Oct 2018 15:24:51 +0200
Message-ID: <20181009132500.17643-25-hch@lst.de>
References: <20181009132500.17643-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009132500.17643-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

We need to compare the last byte in the dma range and not the one after it
for the bus_dma_mask, just like we do for the regular dma_mask.  Fix this
cleanly by merging the two comparisms into one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/dma-direct.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-direct.h b/arch/powerpc/include/asm/dma-direct.h
index e00ab5d0612d..92d8aed86422 100644
--- a/arch/powerpc/include/asm/dma-direct.h
+++ b/arch/powerpc/include/asm/dma-direct.h
@@ -4,15 +4,11 @@
 
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
-#ifdef CONFIG_SWIOTLB
-	if (dev->bus_dma_mask && addr + size > dev->bus_dma_mask)
-		return false;
-#endif
-
 	if (!dev->dma_mask)
 		return false;
 
-	return addr + size - 1 <= *dev->dma_mask;
+	return addr + size - 1 <=
+		min_not_zero(*dev->dma_mask, dev->bus_dma_mask);
 }
 
 static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
-- 
2.19.0
