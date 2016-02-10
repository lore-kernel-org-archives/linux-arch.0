From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v3 5/8] dmaengine: rcar-dmac: group slave configuration
Date: Wed, 10 Feb 2016 01:57:55 +0100
Message-ID: <1455065878-11906-6-git-send-email-niklas.soderlund+renesas@ragnatech.se>
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

Group slave address and transfer size in own structs for source and
destination. This is in preparation for hooking up the dma-mapping API
to the slave addresses.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatec=
h.se>
---
 drivers/dma/sh/rcar-dmac.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 7820d07..743873c 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -118,14 +118,21 @@ struct rcar_dmac_desc_page {
 	sizeof(struct rcar_dmac_xfer_chunk))
=20
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
- * @src_xfer_size: size (in bytes) of hardware transfers on the source=
 side
- * @dst_xfer_size: size (in bytes) of hardware transfers on the destin=
ation side
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
=20
-	unsigned int src_xfer_size;
-	unsigned int dst_xfer_size;
-	dma_addr_t src_slave_addr;
-	dma_addr_t dst_slave_addr;
+	struct rcar_dmac_chan_slave src;
+	struct rcar_dmac_chan_slave dst;
 	int mid_rid;
=20
 	spinlock_t lock;
@@ -793,13 +798,13 @@ static void rcar_dmac_chan_configure_desc(struct =
rcar_dmac_chan *chan,
 	case DMA_DEV_TO_MEM:
 		chcr =3D RCAR_DMACHCR_DM_INC | RCAR_DMACHCR_SM_FIXED
 		     | RCAR_DMACHCR_RS_DMARS;
-		xfer_size =3D chan->src_xfer_size;
+		xfer_size =3D chan->src.xfer_size;
 		break;
=20
 	case DMA_MEM_TO_DEV:
 		chcr =3D RCAR_DMACHCR_DM_FIXED | RCAR_DMACHCR_SM_INC
 		     | RCAR_DMACHCR_RS_DMARS;
-		xfer_size =3D chan->dst_xfer_size;
+		xfer_size =3D chan->dst.xfer_size;
 		break;
=20
 	case DMA_MEM_TO_MEM:
@@ -1038,7 +1043,7 @@ rcar_dmac_prep_slave_sg(struct dma_chan *chan, st=
ruct scatterlist *sgl,
 	}
=20
 	dev_addr =3D dir =3D=3D DMA_DEV_TO_MEM
-		 ? rchan->src_slave_addr : rchan->dst_slave_addr;
+		 ? rchan->src.slave_addr : rchan->dst.slave_addr;
 	return rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, dev_addr,
 				      dir, flags, false);
 }
@@ -1093,7 +1098,7 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan, =
dma_addr_t buf_addr,
 	}
=20
 	dev_addr =3D dir =3D=3D DMA_DEV_TO_MEM
-		 ? rchan->src_slave_addr : rchan->dst_slave_addr;
+		 ? rchan->src.slave_addr : rchan->dst.slave_addr;
 	desc =3D rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, dev_addr,
 				      dir, flags, true);
=20
@@ -1110,10 +1115,10 @@ static int rcar_dmac_device_config(struct dma_c=
han *chan,
 	 * We could lock this, but you shouldn't be configuring the
 	 * channel, while using it...
 	 */
-	rchan->src_slave_addr =3D cfg->src_addr;
-	rchan->dst_slave_addr =3D cfg->dst_addr;
-	rchan->src_xfer_size =3D cfg->src_addr_width;
-	rchan->dst_xfer_size =3D cfg->dst_addr_width;
+	rchan->src.slave_addr =3D cfg->src_addr;
+	rchan->dst.slave_addr =3D cfg->dst_addr;
+	rchan->src.xfer_size =3D cfg->src_addr_width;
+	rchan->dst.xfer_size =3D cfg->dst_addr_width;
=20
 	return 0;
 }
--=20
2.7.1
