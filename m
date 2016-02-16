Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-3.sys.kth.se ([130.237.48.192]:58044 "EHLO
	smtp-3.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbcBPUkN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Feb 2016 15:40:13 -0500
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v4 3/8] dma-mapping: add dma_{map,unmap}_resource
Date: Tue, 16 Feb 2016 21:39:39 +0100
Message-ID: <1455655184-14478-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <1455655184-14478-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1455655184-14478-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: vinod.koul@intel.com, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: robin.murphy@arm.com, laurent.pinchart@ideasonboard.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Message-ID: <20160216203939.hs7CLYTJ-Wu-sNLrW_rQYQMTSBW4-KB532BRUOOHmYE@z>

Map/Unmap a device resource from a physical address. If no dma_map_ops
method is available the operation is a no-op.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 include/linux/dma-mapping.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index e3aba4e..cc305d1 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -216,6 +216,38 @@ static inline void dma_unmap_page(struct device *dev, dma_addr_t addr,
 	debug_dma_unmap_page(dev, addr, size, dir, false);
 }
 
+static inline dma_addr_t dma_map_resource(struct device *dev,
+					  phys_addr_t phys_addr,
+					  size_t size,
+					  enum dma_data_direction dir,
+					  struct dma_attrs *attrs)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+	unsigned long pfn = __phys_to_pfn(phys_addr);
+
+	BUG_ON(!valid_dma_direction(dir));
+
+	/* Don't allow RAM to be mapped */
+	BUG_ON(pfn_valid(pfn));
+
+	if (ops->map_resource)
+		return ops->map_resource(dev, phys_addr, size, dir, attrs);
+
+	return phys_addr;
+}
+
+static inline void dma_unmap_resource(struct device *dev, dma_addr_t addr,
+				      size_t size, enum dma_data_direction dir,
+				      struct dma_attrs *attrs)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (ops->unmap_resource)
+		ops->unmap_resource(dev, addr, size, dir, attrs);
+
+}
+
 static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
 					   size_t size,
 					   enum dma_data_direction dir)
-- 
2.7.1

