Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:40770 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbbBKMxT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Feb 2015 07:53:19 -0500
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 1/2] asm/dma-mapping-common: Clarify output of  dma_map_sg_attrs
Date: Wed, 11 Feb 2015 13:53:14 +0100
Message-ID: <1423659195-23265-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Marek Szyprowski <m.szyprowski@samsung.com>, James Bottomley <jbottomley@Parallels.com>, Will Deacon <will.deacon@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <treding@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Message-ID: <20150211125314.IXpcQJdVuXGIxkPd4CJpTKUJSpB9RGgj_AP60o03YRM@z>

Although dma_map_sg_attrs returns 0 on error and it cannot return a
value < 0, the function returns a signed integer.

Most of the time, this function is used with a scatterlist structure.
This structure uses an unsigned integer for the number of memory.

A dma developer that has not read in detail DMA-API.txt, can wrongly
return a value < 0 on error.

The comment will help the driver developer, and the WARN_ON the dma
developer.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 include/asm-generic/dma-mapping-common.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/asm-generic/dma-mapping-common.h b/include/asm-generic/dma-mapping-common.h
index 3378dcf..940d5ec 100644
--- a/include/asm-generic/dma-mapping-common.h
+++ b/include/asm-generic/dma-mapping-common.h
@@ -39,6 +39,10 @@ static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
 	debug_dma_unmap_page(dev, addr, size, dir, true);
 }
 
+/*
+ * dma_maps_sg_attrs returns 0 on error and > 0 on success.
+ * It should never return a value < 0.
+ */
 static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 				   int nents, enum dma_data_direction dir,
 				   struct dma_attrs *attrs)
@@ -51,6 +55,7 @@ static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 		kmemcheck_mark_initialized(sg_virt(s), s->length);
 	BUG_ON(!valid_dma_direction(dir));
 	ents = ops->map_sg(dev, sg, nents, dir, attrs);
+	BUG_ON(ents < 0);
 	debug_dma_map_sg(dev, sg, nents, ents, dir);
 
 	return ents;
-- 
2.1.4

