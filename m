From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v3 2/8] dma-mapping: add {map,unmap}_resource to dma_map_ops
Date: Wed, 10 Feb 2016 01:57:52 +0100
Message-ID: <1455065878-11906-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: robin.murphy@arm.com, vinod.koul@intel.com, laurent.pinchart@ideasonboard.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: linux-arch.vger.kernel.org

Add methods to handle mapping of device resources from a physical
address. This is needed for example to map be able to map MMIO FIFO
registers to a IOMMU.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatec=
h.se>
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
--=20
2.7.1
