From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v3 4/8] arm: dma-mapping: add {map,unmap}_resource for iommu ops
Date: Wed, 10 Feb 2016 01:57:54 +0100
Message-ID: <1455065878-11906-5-git-send-email-niklas.soderlund+renesas@ragnatech.se>
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

Add methods to map/unmap device resources addresses for dma_map_ops tha=
t
are IOMMU aware. This is needed to map a device MMIO register from a
physical address.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatec=
h.se>
---
 arch/arm/mm/dma-mapping.c | 63 +++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 0eca381..ae2b175 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1814,6 +1814,63 @@ static void arm_iommu_unmap_page(struct device *=
dev, dma_addr_t handle,
 	__free_iova(mapping, iova, len);
 }
=20
+/**
+ * arm_iommu_map_resource - map a device resource for DMA
+ * @dev: valid struct device pointer
+ * @phys_addr: physical address of resource
+ * @size: size of resource to map
+ * @dir: DMA transfer direction
+ */
+static dma_addr_t arm_iommu_map_resource(struct device *dev,
+		phys_addr_t phys_addr, size_t size,
+		enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	struct dma_iommu_mapping *mapping =3D to_dma_iommu_mapping(dev);
+	dma_addr_t dma_addr;
+	int ret, prot;
+	phys_addr_t addr =3D phys_addr & PAGE_MASK;
+	int offset =3D phys_addr & ~PAGE_MASK;
+	int len =3D PAGE_ALIGN(size + offset);
+
+	dma_addr =3D __alloc_iova(mapping, size);
+	if (dma_addr =3D=3D DMA_ERROR_CODE)
+		return dma_addr;
+
+	prot =3D __dma_direction_to_prot(dir) | IOMMU_MMIO;
+
+	ret =3D iommu_map(mapping->domain, dma_addr, addr, len, prot);
+	if (ret < 0)
+		goto fail;
+
+	return dma_addr + offset;
+fail:
+	__free_iova(mapping, dma_addr, size);
+	return DMA_ERROR_CODE;
+}
+
+/**
+ * arm_iommu_unmap_resource - unmap a device DMA resource
+ * @dev: valid struct device pointer
+ * @dma_handle: DMA address to resource
+ * @size: size of resource to map
+ * @dir: DMA transfer direction
+ */
+static void arm_iommu_unmap_resource(struct device *dev, dma_addr_t dm=
a_handle,
+		size_t size, enum dma_data_direction dir,
+		struct dma_attrs *attrs)
+{
+	struct dma_iommu_mapping *mapping =3D to_dma_iommu_mapping(dev);
+	dma_addr_t iova =3D dma_handle & PAGE_MASK;
+	int offset =3D dma_handle & ~PAGE_MASK;
+	int len =3D PAGE_ALIGN(size + offset);
+
+	if (!iova)
+		return;
+
+	iommu_unmap(mapping->domain, iova, len);
+	__free_iova(mapping, iova, len);
+}
+
 static void arm_iommu_sync_single_for_cpu(struct device *dev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
@@ -1858,6 +1915,9 @@ struct dma_map_ops iommu_ops =3D {
 	.sync_sg_for_cpu	=3D arm_iommu_sync_sg_for_cpu,
 	.sync_sg_for_device	=3D arm_iommu_sync_sg_for_device,
=20
+	.map_resource		=3D arm_iommu_map_resource,
+	.unmap_resource		=3D arm_iommu_unmap_resource,
+
 	.set_dma_mask		=3D arm_dma_set_mask,
 };
=20
@@ -1873,6 +1933,9 @@ struct dma_map_ops iommu_coherent_ops =3D {
 	.map_sg		=3D arm_coherent_iommu_map_sg,
 	.unmap_sg	=3D arm_coherent_iommu_unmap_sg,
=20
+	.map_resource	=3D arm_iommu_map_resource,
+	.unmap_resource	=3D arm_iommu_unmap_resource,
+
 	.set_dma_mask	=3D arm_dma_set_mask,
 };
=20
--=20
2.7.1
