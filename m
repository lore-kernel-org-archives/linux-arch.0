From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v3 6/8] dmaengine: rcar-dmac: add iommu support for slave transfers
Date: Wed, 10 Feb 2016 01:57:56 +0100
Message-ID: <1455065878-11906-7-git-send-email-niklas.soderlund+renesas@ragnatech.se>
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

Enable slave transfers to devices behind IPMMU:s by mapping the slave
addresses using the dma-mapping API.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatec=
h.se>
---
 drivers/dma/sh/rcar-dmac.c | 57 ++++++++++++++++++++++++++++++++++++++=
++++----
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 743873c..268407c 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1106,21 +1106,68 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan=
, dma_addr_t buf_addr,
 	return desc;
 }
=20
+static int rcar_dmac_set_slave_addr(struct dma_chan *chan,
+				     struct rcar_dmac_chan_slave *slave,
+				     phys_addr_t addr, size_t size)
+{
+	struct dma_attrs attrs;
+	enum dma_data_direction dir;
+
+	init_dma_attrs(&attrs);
+	dma_set_attr(DMA_ATTR_NO_KERNEL_MAPPING, &attrs);
+	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
+
+	/*
+	 * We can't know the direction at this time, see documentation for
+	 * 'direction' in struct dma_slave_config.
+	 */
+	dir =3D DMA_BIDIRECTIONAL;
+
+	if (slave->xfer_size) {
+		dma_unmap_resource(chan->device->dev, slave->slave_addr,
+				slave->xfer_size, dir, &attrs);
+		slave->slave_addr =3D 0;
+		slave->xfer_size =3D 0;
+	}
+
+	if (size) {
+		slave->slave_addr =3D dma_map_resource(chan->device->dev, addr,
+				size, dir, &attrs);
+
+		if (dma_mapping_error(chan->device->dev, slave->slave_addr)) {
+			struct rcar_dmac_chan *rchan =3D to_rcar_dmac_chan(chan);
+
+			dev_err(chan->device->dev,
+					"chan%u: failed to map %zx@%pap",
+					rchan->index, size, &addr);
+			return -EIO;
+		}
+
+		slave->xfer_size =3D size;
+	}
+
+	return 0;
+}
+
 static int rcar_dmac_device_config(struct dma_chan *chan,
 				   struct dma_slave_config *cfg)
 {
 	struct rcar_dmac_chan *rchan =3D to_rcar_dmac_chan(chan);
+	int ret;
=20
 	/*
 	 * We could lock this, but you shouldn't be configuring the
 	 * channel, while using it...
 	 */
-	rchan->src.slave_addr =3D cfg->src_addr;
-	rchan->dst.slave_addr =3D cfg->dst_addr;
-	rchan->src.xfer_size =3D cfg->src_addr_width;
-	rchan->dst.xfer_size =3D cfg->dst_addr_width;
=20
-	return 0;
+	ret =3D rcar_dmac_set_slave_addr(chan, &rchan->src, cfg->src_addr,
+			cfg->src_addr_width);
+	if (ret)
+		return ret;
+
+	ret =3D rcar_dmac_set_slave_addr(chan, &rchan->dst, cfg->dst_addr,
+			cfg->dst_addr_width);
+	return ret;
 }
=20
 static int rcar_dmac_chan_terminate_all(struct dma_chan *chan)
--=20
2.7.1
