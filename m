From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCHv6 3/8] dma-mapping: add dma_{map,unmap}_resource
Date: Mon,  9 May 2016 18:44:02 +0200
Message-ID: <1462812247-3414-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1462812247-3414-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1462812247-3414-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: vinod.koul@intel.com, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, hch@infradead.org
Cc: robin.murphy@arm.com, laurent.pinchart@ideasonboard.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: linux-arch.vger.kernel.org

Map/Unmap a device MMIO resource from a physical address. If no dma_map=
_ops
method is available the operation is a no-op.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatec=
h.se>
---
 Documentation/DMA-API.txt   | 22 +++++++++++++++++-----
 include/linux/dma-mapping.h | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 45ef3f2..c7e5f99 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -277,14 +277,26 @@ and <size> parameters are provided to do partial =
page mapping, it is
 recommended that you never use these unless you really know what the
 cache width is.
=20
+dma_addr_t
+dma_map_resource(struct device *dev, phys_addr_t phys_addr, size_t siz=
e,
+		 enum dma_data_direction dir, struct dma_attrs *attrs)
+
+void
+dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
+		   enum dma_data_direction dir, struct dma_attrs *attrs)
+
+API for mapping and unmapping for MMIO resources. All the notes and
+warnings for the other mapping APIs apply here. The API should only be
+used to map device MMIO resources, mapping of RAM is not permitted.
+
 int
 dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
=20
-In some circumstances dma_map_single() and dma_map_page() will fail to=
 create
-a mapping. A driver can check for these errors by testing the returned
-DMA address with dma_mapping_error(). A non-zero return value means th=
e mapping
-could not be created and the driver should take appropriate action (e.=
g.
-reduce current DMA mapping usage or delay and try again later).
+In some circumstances dma_map_single(), dma_map_page() and dma_map_res=
ource()
+will fail to create a mapping. A driver can check for these errors by =
testing
+the returned DMA address with dma_mapping_error(). A non-zero return v=
alue
+means the mapping could not be created and the driver should take appr=
opriate
+action (e.g. reduce current DMA mapping usage or delay and try again l=
ater).
=20
 	int
 	dma_map_sg(struct device *dev, struct scatterlist *sg,
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 8617fa1..dd228ce 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -218,6 +218,42 @@ static inline void dma_unmap_page(struct device *d=
ev, dma_addr_t addr,
 	debug_dma_unmap_page(dev, addr, size, dir, false);
 }
=20
+static inline dma_addr_t dma_map_resource(struct device *dev,
+					  phys_addr_t phys_addr,
+					  size_t size,
+					  enum dma_data_direction dir,
+					  struct dma_attrs *attrs)
+{
+	struct dma_map_ops *ops =3D get_dma_ops(dev);
+	unsigned long pfn =3D __phys_to_pfn(phys_addr);
+	dma_addr_t addr;
+
+	BUG_ON(!valid_dma_direction(dir));
+
+	/* Don't allow RAM to be mapped */
+	BUG_ON(pfn_valid(pfn));
+
+	addr =3D phys_addr;
+	if (ops->map_resource)
+		addr =3D ops->map_resource(dev, phys_addr, size, dir, attrs);
+
+	debug_dma_map_resource(dev, phys_addr, size, dir, addr);
+
+	return addr;
+}
+
+static inline void dma_unmap_resource(struct device *dev, dma_addr_t a=
ddr,
+				      size_t size, enum dma_data_direction dir,
+				      struct dma_attrs *attrs)
+{
+	struct dma_map_ops *ops =3D get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (ops->unmap_resource)
+		ops->unmap_resource(dev, addr, size, dir, attrs);
+	debug_dma_unmap_resource(dev, addr, size, dir);
+}
+
 static inline void dma_sync_single_for_cpu(struct device *dev, dma_add=
r_t addr,
 					   size_t size,
 					   enum dma_data_direction dir)
--=20
2.8.2
