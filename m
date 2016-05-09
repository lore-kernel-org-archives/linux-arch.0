Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-3.sys.kth.se ([130.237.48.192]:38522 "EHLO
	smtp-3.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbcEIQzH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2016 12:55:07 -0400
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCHv6 6/8] dmaengine: rcar-dmac: add iommu support for slave transfers
Date: Mon,  9 May 2016 18:44:05 +0200
Message-ID: <1462812247-3414-7-git-send-email-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <1462812247-3414-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1462812247-3414-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: vinod.koul@intel.com, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, hch@infradead.org
Cc: robin.murphy@arm.com, laurent.pinchart@ideasonboard.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Message-ID: <20160509164405.WvwZcpE2k9IlzOH3hc0mfjtqt7xv9NMwUWPAde0WAYo@z>

Enable slave transfers to a device behind a IPMMU by mapping the slave
addresses using the dma-mapping API.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/dma/sh/rcar-dmac.c | 82 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index b0c3bb2..8592598 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -128,6 +128,18 @@ struct rcar_dmac_chan_slave {
 };
 
 /*
+ * struct rcar_dmac_chan_map - Map of slave device phys to dma address
+ * @addr: slave dma address
+ * @dir: direction of mapping
+ * @slave: slave configuration that is mapped
+ */
+struct rcar_dmac_chan_map {
+	dma_addr_t addr;
+	enum dma_data_direction dir;
+	struct rcar_dmac_chan_slave slave;
+};
+
+/*
  * struct rcar_dmac_chan - R-Car Gen2 DMA Controller Channel
  * @chan: base DMA channel object
  * @iomem: channel I/O memory base
@@ -152,6 +164,7 @@ struct rcar_dmac_chan {
 
 	struct rcar_dmac_chan_slave src;
 	struct rcar_dmac_chan_slave dst;
+	struct rcar_dmac_chan_map map;
 	int mid_rid;
 
 	spinlock_t lock;
@@ -1027,13 +1040,65 @@ rcar_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dma_dest,
 				      DMA_MEM_TO_MEM, flags, false);
 }
 
+static int rcar_dmac_map_slave_addr(struct dma_chan *chan,
+				    enum dma_transfer_direction dir)
+{
+	struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
+	struct rcar_dmac_chan_map *map = &rchan->map;
+	phys_addr_t dev_addr;
+	size_t dev_size;
+	enum dma_data_direction dev_dir;
+
+	if (dir == DMA_DEV_TO_MEM) {
+		dev_addr = rchan->src.slave_addr;
+		dev_size = rchan->src.xfer_size;
+		dev_dir = DMA_TO_DEVICE;
+	} else {
+		dev_addr = rchan->dst.slave_addr;
+		dev_size = rchan->dst.xfer_size;
+		dev_dir = DMA_FROM_DEVICE;
+	}
+
+	/* Reuse current map if possible. */
+	if (dev_addr == map->slave.slave_addr &&
+	    dev_size == map->slave.xfer_size &&
+	    dev_dir == map->dir)
+		return 0;
+
+	/* Remove old mapping if present. */
+	if (map->slave.xfer_size)
+		dma_unmap_resource(chan->device->dev, map->addr,
+				   map->slave.xfer_size, map->dir, NULL);
+	map->slave.xfer_size = 0;
+
+	/* Create new slave address map. */
+	map->addr = dma_map_resource(chan->device->dev, dev_addr, dev_size,
+				     dev_dir, NULL);
+
+	if (dma_mapping_error(chan->device->dev, map->addr)) {
+		dev_err(chan->device->dev,
+			"chan%u: failed to map %zx@%pap", rchan->index,
+			dev_size, &dev_addr);
+		return -EIO;
+	}
+
+	dev_dbg(chan->device->dev, "chan%u: map %zx@%pap to %pad dir: %s\n",
+		rchan->index, dev_size, &dev_addr, &map->addr,
+		dev_dir == DMA_TO_DEVICE ? "DMA_TO_DEVICE" : "DMA_FROM_DEVICE");
+
+	map->slave.slave_addr = dev_addr;
+	map->slave.xfer_size = dev_size;
+	map->dir = dev_dir;
+
+	return 0;
+}
+
 static struct dma_async_tx_descriptor *
 rcar_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			unsigned int sg_len, enum dma_transfer_direction dir,
 			unsigned long flags, void *context)
 {
 	struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
-	dma_addr_t dev_addr;
 
 	/* Someone calling slave DMA on a generic channel? */
 	if (rchan->mid_rid < 0 || !sg_len) {
@@ -1043,9 +1108,10 @@ rcar_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		return NULL;
 	}
 
-	dev_addr = dir == DMA_DEV_TO_MEM
-		 ? rchan->src.slave_addr : rchan->dst.slave_addr;
-	return rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, dev_addr,
+	if (rcar_dmac_map_slave_addr(chan, dir))
+		return NULL;
+
+	return rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, rchan->map.addr,
 				      dir, flags, false);
 }
 
@@ -1059,7 +1125,6 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
 	struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
 	struct dma_async_tx_descriptor *desc;
 	struct scatterlist *sgl;
-	dma_addr_t dev_addr;
 	unsigned int sg_len;
 	unsigned int i;
 
@@ -1071,6 +1136,9 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
 		return NULL;
 	}
 
+	if (rcar_dmac_map_slave_addr(chan, dir))
+		return NULL;
+
 	sg_len = buf_len / period_len;
 	if (sg_len > RCAR_DMAC_MAX_SG_LEN) {
 		dev_err(chan->device->dev,
@@ -1098,9 +1166,7 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
 		sg_dma_len(&sgl[i]) = period_len;
 	}
 
-	dev_addr = dir == DMA_DEV_TO_MEM
-		 ? rchan->src.slave_addr : rchan->dst.slave_addr;
-	desc = rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, dev_addr,
+	desc = rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, rchan->map.addr,
 				      dir, flags, true);
 
 	kfree(sgl);
-- 
2.8.2

