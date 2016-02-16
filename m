Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-3.sys.kth.se ([130.237.48.192]:58083 "EHLO
	smtp-3.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209AbcBPUkQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Feb 2016 15:40:16 -0500
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v4 6/8] dmaengine: rcar-dmac: add iommu support for slave transfers
Date: Tue, 16 Feb 2016 21:39:42 +0100
Message-ID: <1455655184-14478-7-git-send-email-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <1455655184-14478-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1455655184-14478-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: vinod.koul@intel.com, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: robin.murphy@arm.com, laurent.pinchart@ideasonboard.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Message-ID: <20160216203942.Pv7SQR6aWV-NpUvSNLDph7OFB29-b-MdTUgEJd9AJjM@z>

Enable slave transfers to devices behind IPMMU:s by mapping the slave
addresses using the dma-mapping API.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/dma/sh/rcar-dmac.c | 52 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 743873c..6a24847 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1106,21 +1106,63 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
 	return desc;
 }
 
+static int rcar_dmac_set_slave_addr(struct dma_chan *chan,
+				     struct rcar_dmac_chan_slave *slave,
+				     phys_addr_t addr, size_t size)
+{
+	enum dma_data_direction dir;
+
+	/*
+	 * We can't know the direction at this time, see documentation for
+	 * 'direction' in struct dma_slave_config.
+	 */
+	dir = DMA_BIDIRECTIONAL;
+
+	if (slave->xfer_size) {
+		dma_unmap_resource(chan->device->dev, slave->slave_addr,
+				   slave->xfer_size, dir, NULL);
+		slave->slave_addr = 0;
+		slave->xfer_size = 0;
+	}
+
+	if (size) {
+		slave->slave_addr = dma_map_resource(chan->device->dev, addr,
+				size, dir, NULL);
+
+		if (dma_mapping_error(chan->device->dev, slave->slave_addr)) {
+			struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
+
+			dev_err(chan->device->dev,
+				"chan%u: failed to map %zx@%pap", rchan->index,
+				size, &addr);
+			return -EIO;
+		}
+
+		slave->xfer_size = size;
+	}
+
+	return 0;
+}
+
 static int rcar_dmac_device_config(struct dma_chan *chan,
 				   struct dma_slave_config *cfg)
 {
 	struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
+	int ret;
 
 	/*
 	 * We could lock this, but you shouldn't be configuring the
 	 * channel, while using it...
 	 */
-	rchan->src.slave_addr = cfg->src_addr;
-	rchan->dst.slave_addr = cfg->dst_addr;
-	rchan->src.xfer_size = cfg->src_addr_width;
-	rchan->dst.xfer_size = cfg->dst_addr_width;
 
-	return 0;
+	ret = rcar_dmac_set_slave_addr(chan, &rchan->src, cfg->src_addr,
+				       cfg->src_addr_width);
+	if (ret)
+		return ret;
+
+	ret = rcar_dmac_set_slave_addr(chan, &rchan->dst, cfg->dst_addr,
+				       cfg->dst_addr_width);
+	return ret;
 }
 
 static int rcar_dmac_chan_terminate_all(struct dma_chan *chan)
-- 
2.7.1

