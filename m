Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-4.sys.kth.se ([130.237.48.193]:38719 "EHLO
	smtp-4.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932256AbcCHCoO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Mar 2016 21:44:14 -0500
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v5 2/9] dma-mapping: add {map,unmap}_resource to dma_map_ops
Date: Tue,  8 Mar 2016 03:42:47 +0100
Message-ID: <1457404974-1800-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: vinod.koul@intel.com, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: robin.murphy@arm.com, laurent.pinchart@ideasonboard.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Message-ID: <20160308024247.Yk6N5rlntjLoOn8l0RB78OmekMnJ_R4FOIX1YPxjqZE@z>

Add methods to handle mapping of device resources from a physical
address. This is needed for example to be able to map MMIO FIFO
registers to a IOMMU.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 include/linux/dma-mapping.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 75857cd..e3aba4e 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -49,6 +49,12 @@ struct dma_map_ops {
 			 struct scatterlist *sg, int nents,
 			 enum dma_data_direction dir,
 			 struct dma_attrs *attrs);
+	dma_addr_t (*map_resource)(struct device *dev, phys_addr_t phys_addr,
+			       size_t size, enum dma_data_direction dir,
+			       struct dma_attrs *attrs);
+	void (*unmap_resource)(struct device *dev, dma_addr_t dma_handle,
+			   size_t size, enum dma_data_direction dir,
+			   struct dma_attrs *attrs);
 	void (*sync_single_for_cpu)(struct device *dev,
 				    dma_addr_t dma_handle, size_t size,
 				    enum dma_data_direction dir);
-- 
2.7.2

