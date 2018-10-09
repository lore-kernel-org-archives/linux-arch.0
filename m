Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:49098 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeJIUm5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Oct 2018 16:42:57 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/33] powerpc/dma: remove the unused dma_iommu_ops export
Date: Tue,  9 Oct 2018 15:24:31 +0200
Message-ID: <20181009132500.17643-5-hch@lst.de>
In-Reply-To: <20181009132500.17643-1-hch@lst.de>
References: <20181009132500.17643-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181009132431.KUm4Y21b-yhl9huC11kISnrlX2Pf7PiNCr5h3eXxUnQ@z>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/kernel/dma-iommu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index f9fe2080ceb9..2ca6cfaebf65 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -6,7 +6,6 @@
  * busses using the iommu infrastructure
  */
 
-#include <linux/export.h>
 #include <asm/iommu.h>
 
 /*
@@ -123,4 +122,3 @@ struct dma_map_ops dma_iommu_ops = {
 	.get_required_mask	= dma_iommu_get_required_mask,
 	.mapping_error		= dma_iommu_mapping_error,
 };
-EXPORT_SYMBOL(dma_iommu_ops);
-- 
2.19.0
