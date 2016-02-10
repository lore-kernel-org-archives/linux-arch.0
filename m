Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-3.sys.kth.se ([130.237.48.192]:33523 "EHLO
	smtp-3.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955AbcBJBFV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Feb 2016 20:05:21 -0500
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v3 5/8] dmaengine: rcar-dmac: group slave configuration
Date: Wed, 10 Feb 2016 01:57:55 +0100
Message-ID: <1455065878-11906-6-git-send-email-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: robin.murphy@arm.com, vinod.koul@intel.com, laurent.pinchart@ideasonboard.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Message-ID: <20160210005755.LtvVpICB7Y4IYqazNwA82v8ULA_cKejMgEFi1Fl_dFI@z>

Group slave address and transfer size in own structs for source and
destination. This is in preparation for hooking up the dma-mapping API
to the slave addresses.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/dma/sh/rcar-dmac.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 7820d07..743873c 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -118,14 +118,21 @@ struct rcar_dmac_desc_page {
 	sizeof(struct rcar_dmac_xfer_chunk))
 
 /*
+ * @slave_addr: slave memory address
+ * @xfer_size: size (in bytes) of hardware transfers
+ */
+struct rcar_dmac_chan_slave {
+	dma_addr_t slave_addr;
+	unsigned int xfer_size;
+};
+
+/*
  * struct rcar_dmac_chan - R-Car Gen2 DMA Controller Channel
  * @chan: base DMA channel object
  * @iomem: channel I/O memory base
  * @index: index of this channel in the controller
- * @src_xfer_size: size (in bytes) of hardware transfers on the source side
- * @dst_xfer_size: size (in bytes) of hardware transfers on the destination side
- * @src_slave_addr: slave source memory address
- * @dst_slave_addr: slave destination memory address
+ * @src: slave memory address and size on the source side
+ * @dst: slave memory address and size on the destination side
  * @mid_rid: hardware MID/RID for the DMA client using this channel
  * @lock: protects the channel CHCR register and the desc members
  * @desc.free: list of free descriptors
@@ -142,10 +149,8 @@ struct rcar_dmac_chan {
 	void __iomem *iomem;
 	unsigned int index;
 
-	unsigned int src_xfer_size;
-	unsigned int dst_xfer_size;
-	dma_addr_t src_slave_addr;
-	dma_addr_t dst_slave_addr;
+	struct rcar_dmac_chan_slave src;
+	struct rcar_dmac_chan_slave dst;
 	int mid_rid;
 
 	spinlock_t lock;
@@ -793,13 +798,13 @@ static void rcar_dmac_chan_configure_desc(struct rcar_dmac_chan *chan,
 	case DMA_DEV_TO_MEM:
 		chcr = RCAR_DMACHCR_DM_INC | RCAR_DMACHCR_SM_FIXED
 		     | RCAR_DMACHCR_RS_DMARS;
-		xfer_size = chan->src_xfer_size;
+		xfer_size = chan->src.xfer_size;
 		break;
 
 	case DMA_MEM_TO_DEV:
 		chcr = RCAR_DMACHCR_DM_FIXED | RCAR_DMACHCR_SM_INC
 		     | RCAR_DMACHCR_RS_DMARS;
-		xfer_size = chan->dst_xfer_size;
+		xfer_size = chan->dst.xfer_size;
 		break;
 
 	case DMA_MEM_TO_MEM:
@@ -1038,7 +1043,7 @@ rcar_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	}
 
 	dev_addr = dir == DMA_DEV_TO_MEM
-		 ? rchan->src_slave_addr : rchan->dst_slave_addr;
+		 ? rchan->src.slave_addr : rchan->dst.slave_addr;
 	return rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, dev_addr,
 				      dir, flags, false);
 }
@@ -1093,7 +1098,7 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
 	}
 
 	dev_addr = dir == DMA_DEV_TO_MEM
-		 ? rchan->src_slave_addr : rchan->dst_slave_addr;
+		 ? rchan->src.slave_addr : rchan->dst.slave_addr;
 	desc = rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, dev_addr,
 				      dir, flags, true);
 
@@ -1110,10 +1115,10 @@ static int rcar_dmac_device_config(struct dma_chan *chan,
 	 * We could lock this, but you shouldn't be configuring the
 	 * channel, while using it...
 	 */
-	rchan->src_slave_addr = cfg->src_addr;
-	rchan->dst_slave_addr = cfg->dst_addr;
-	rchan->src_xfer_size = cfg->src_addr_width;
-	rchan->dst_xfer_size = cfg->dst_addr_width;
+	rchan->src.slave_addr = cfg->src_addr;
+	rchan->dst.slave_addr = cfg->dst_addr;
+	rchan->src.xfer_size = cfg->src_addr_width;
+	rchan->dst.xfer_size = cfg->dst_addr_width;
 
 	return 0;
 }
-- 
2.7.1

