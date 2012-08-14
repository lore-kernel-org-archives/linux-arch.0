From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 14/31] arm64: DMA mapping API
Date: Tue, 14 Aug 2012 18:52:15 +0100
Message-ID: <1344966752-16102-15-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55158 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756850Ab2HNRxJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Aug 2012 13:53:09 -0400
In-Reply-To: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

This patch adds support for the DMA mapping API. It uses dma_map_ops for
flexibility and it currently supports swiotlb. This patch could be
simplified further if the DMA accesses are coherent (not mandated by the
architecture) or if corresponding hooks are placed in the generic
swiotlb code to deal with cache maintenance.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/dma-mapping.h |  124 ++++++++++++++++++++
 arch/arm64/mm/dma-mapping.c          |  208 ++++++++++++++++++++++++++++++=
++++
 2 files changed, 332 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/dma-mapping.h
 create mode 100644 arch/arm64/mm/dma-mapping.c

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/=
dma-mapping.h
new file mode 100644
index 0000000..538f4b4
--- /dev/null
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -0,0 +1,124 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_DMA_MAPPING_H
+#define __ASM_DMA_MAPPING_H
+
+#ifdef __KERNEL__
+
+#include <linux/types.h>
+#include <linux/vmalloc.h>
+
+#include <asm-generic/dma-coherent.h>
+
+#define ARCH_HAS_DMA_GET_REQUIRED_MASK
+
+extern struct dma_map_ops *dma_ops;
+
+static inline struct dma_map_ops *get_dma_ops(struct device *dev)
+{
+=09if (unlikely(!dev) || !dev->archdata.dma_ops)
+=09=09return dma_ops;
+=09else
+=09=09return dev->archdata.dma_ops;
+}
+
+#include <asm-generic/dma-mapping-common.h>
+
+static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr=
)
+{
+=09return (dma_addr_t)paddr;
+}
+
+static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_a=
ddr)
+{
+=09return (phys_addr_t)dev_addr;
+}
+
+static inline int dma_mapping_error(struct device *dev, dma_addr_t dev_add=
r)
+{
+=09struct dma_map_ops *ops =3D get_dma_ops(dev);
+=09return ops->mapping_error(dev, dev_addr);
+}
+
+static inline int dma_supported(struct device *dev, u64 mask)
+{
+=09struct dma_map_ops *ops =3D get_dma_ops(dev);
+=09return ops->dma_supported(dev, mask);
+}
+
+static inline int dma_set_mask(struct device *dev, u64 mask)
+{
+=09if (!dev->dma_mask || !dma_supported(dev, mask))
+=09=09return -EIO;
+=09*dev->dma_mask =3D mask;
+
+=09return 0;
+}
+
+static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t=
 size)
+{
+=09if (!dev->dma_mask)
+=09=09return 0;
+
+=09return addr + size - 1 <=3D *dev->dma_mask;
+}
+
+static inline void dma_mark_clean(void *addr, size_t size)
+{
+}
+
+static inline void *dma_alloc_coherent(struct device *dev, size_t size,
+=09=09=09=09       dma_addr_t *dma_handle, gfp_t flags)
+{
+=09struct dma_map_ops *ops =3D get_dma_ops(dev);
+=09void *vaddr;
+
+=09if (dma_alloc_from_coherent(dev, size, dma_handle, &vaddr))
+=09=09return vaddr;
+
+=09vaddr =3D ops->alloc(dev, size, dma_handle, flags, NULL);
+=09debug_dma_alloc_coherent(dev, size, *dma_handle, vaddr);
+=09return vaddr;
+}
+
+static inline void dma_free_coherent(struct device *dev, size_t size,
+=09=09=09=09     void *vaddr, dma_addr_t dev_addr)
+{
+=09struct dma_map_ops *ops =3D get_dma_ops(dev);
+
+=09if (dma_release_from_coherent(dev, get_order(size), vaddr))
+=09=09return;
+
+=09debug_dma_free_coherent(dev, size, vaddr, dev_addr);
+=09ops->free(dev, size, vaddr, dev_addr, NULL);
+}
+
+/*
+ * There is no dma_cache_sync() implementation, so just return NULL here.
+ */
+static inline void *dma_alloc_noncoherent(struct device *dev, size_t size,
+=09=09=09=09=09  dma_addr_t *handle, gfp_t flags)
+{
+=09return NULL;
+}
+
+static inline void dma_free_noncoherent(struct device *dev, size_t size,
+=09=09=09=09=09void *cpu_addr, dma_addr_t handle)
+{
+}
+
+#endif=09/* __KERNEL__ */
+#endif=09/* __ASM_DMA_MAPPING_H */
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
new file mode 100644
index 0000000..4e5871d
--- /dev/null
+++ b/arch/arm64/mm/dma-mapping.c
@@ -0,0 +1,208 @@
+/*
+ * SWIOTLB-based DMA API implementation
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ * Author: Catalin Marinas <catalin.marinas@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/gfp.h>
+#include <linux/export.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include <linux/vmalloc.h>
+#include <linux/swiotlb.h>
+
+#include <asm/cacheflush.h>
+
+struct dma_map_ops *dma_ops;
+EXPORT_SYMBOL(dma_ops);
+
+static void *arm64_swiotlb_alloc_coherent(struct device *dev, size_t size,
+=09=09=09=09=09  dma_addr_t *dma_handle, gfp_t flags,
+=09=09=09=09=09  struct dma_attrs *attrs)
+{
+=09struct page *page, **map;
+=09void *ptr;
+=09int order =3D get_order(size);
+=09int i;
+
+=09if (dev->coherent_dma_mask !=3D DMA_BIT_MASK(64))
+=09=09flags |=3D GFP_DMA;
+
+=09ptr =3D swiotlb_alloc_coherent(dev, size, dma_handle, flags);
+=09if (!ptr)
+=09=09goto no_mem;
+=09map =3D kmalloc(sizeof(struct page *) << order, flags & ~GFP_DMA);
+=09if (!map)
+=09=09goto no_map;
+
+=09/* remove any dirty cache lines on the kernel alias */
+=09dmac_flush_range(ptr, ptr + size);
+
+=09/* create a coherent mapping */
+=09page =3D virt_to_page(ptr);
+=09for (i =3D 0; i < (size >> PAGE_SHIFT); i++)
+=09=09map[i] =3D page + i;
+=09ptr =3D vmap(map, size >> PAGE_SHIFT, VM_MAP,
+=09=09   pgprot_dmacoherent(pgprot_default)); kfree(map);
+=09if (!ptr)
+=09=09goto no_map;
+
+=09return ptr;
+
+no_map:
+=09swiotlb_free_coherent(dev, size, ptr, *dma_handle);
+no_mem:
+=09*dma_handle =3D ~0;
+=09return NULL;
+}
+
+static void arm64_swiotlb_free_coherent(struct device *dev, size_t size,
+=09=09=09=09=09void *vaddr, dma_addr_t dma_handle,
+=09=09=09=09=09struct dma_attrs *attrs)
+{
+=09vunmap(vaddr);
+=09swiotlb_free_coherent(dev, size, vaddr, dma_handle);
+}
+
+static dma_addr_t arm64_swiotlb_map_page(struct device *dev,
+=09=09=09=09=09 struct page *page,
+=09=09=09=09=09 unsigned long offset, size_t size,
+=09=09=09=09=09 enum dma_data_direction dir,
+=09=09=09=09=09 struct dma_attrs *attrs)
+{
+=09dma_addr_t dev_addr;
+
+=09dev_addr =3D swiotlb_map_page(dev, page, offset, size, dir, attrs);
+=09dmac_map_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
+
+=09return dev_addr;
+}
+
+
+static void arm64_swiotlb_unmap_page(struct device *dev, dma_addr_t dev_ad=
dr,
+=09=09=09=09     size_t size, enum dma_data_direction dir,
+=09=09=09=09     struct dma_attrs *attrs)
+{
+=09dmac_unmap_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
+=09swiotlb_unmap_page(dev, dev_addr, size, dir, attrs);
+}
+
+static int arm64_swiotlb_map_sg_attrs(struct device *dev,
+=09=09=09=09      struct scatterlist *sgl, int nelems,
+=09=09=09=09      enum dma_data_direction dir,
+=09=09=09=09      struct dma_attrs *attrs)
+{
+=09struct scatterlist *sg;
+=09int i, ret;
+
+=09ret =3D swiotlb_map_sg_attrs(dev, sgl, nelems, dir, attrs);
+=09for_each_sg(sgl, sg, ret, i)
+=09=09dmac_map_area(phys_to_virt(dma_to_phys(dev, sg->dma_address)),
+=09=09=09      sg->length, dir);
+
+=09return ret;
+}
+
+static void arm64_swiotlb_unmap_sg_attrs(struct device *dev,
+=09=09=09=09=09 struct scatterlist *sgl, int nelems,
+=09=09=09=09=09 enum dma_data_direction dir,
+=09=09=09=09=09 struct dma_attrs *attrs)
+{
+=09struct scatterlist *sg;
+=09int i;
+
+=09for_each_sg(sgl, sg, nelems, i)
+=09=09dmac_unmap_area(phys_to_virt(dma_to_phys(dev, sg->dma_address)),
+=09=09=09=09sg->length, dir);
+=09swiotlb_unmap_sg_attrs(dev, sgl, nelems, dir, attrs);
+}
+
+static void arm64_swiotlb_sync_single_for_cpu(struct device *dev,
+=09=09=09=09=09      dma_addr_t dev_addr,
+=09=09=09=09=09      size_t size,
+=09=09=09=09=09      enum dma_data_direction dir)
+{
+=09dmac_unmap_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
+=09swiotlb_sync_single_for_cpu(dev, dev_addr, size, dir);
+}
+
+static void arm64_swiotlb_sync_single_for_device(struct device *dev,
+=09=09=09=09=09=09 dma_addr_t dev_addr,
+=09=09=09=09=09=09 size_t size,
+=09=09=09=09=09=09 enum dma_data_direction dir)
+{
+=09swiotlb_sync_single_for_device(dev, dev_addr, size, dir);
+=09dmac_map_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
+}
+
+static void arm64_swiotlb_sync_sg_for_cpu(struct device *dev,
+=09=09=09=09=09  struct scatterlist *sgl, int nelems,
+=09=09=09=09=09  enum dma_data_direction dir)
+{
+=09struct scatterlist *sg;
+=09int i;
+
+=09for_each_sg(sgl, sg, nelems, i)
+=09=09dmac_unmap_area(phys_to_virt(dma_to_phys(dev, sg->dma_address)),
+=09=09=09=09sg->length, dir);
+=09swiotlb_sync_sg_for_cpu(dev, sgl, nelems, dir);
+}
+
+static void arm64_swiotlb_sync_sg_for_device(struct device *dev,
+=09=09=09=09=09     struct scatterlist *sgl,
+=09=09=09=09=09     int nelems,
+=09=09=09=09=09     enum dma_data_direction dir)
+{
+=09struct scatterlist *sg;
+=09int i;
+
+=09swiotlb_sync_sg_for_device(dev, sgl, nelems, dir);
+=09for_each_sg(sgl, sg, nelems, i)
+=09=09dmac_map_area(phys_to_virt(dma_to_phys(dev, sg->dma_address)),
+=09=09=09      sg->length, dir);
+}
+
+static struct dma_map_ops arm64_swiotlb_dma_ops =3D {
+=09.alloc =3D arm64_swiotlb_alloc_coherent,
+=09.free =3D arm64_swiotlb_free_coherent,
+=09.map_page =3D arm64_swiotlb_map_page,
+=09.unmap_page =3D arm64_swiotlb_unmap_page,
+=09.map_sg =3D arm64_swiotlb_map_sg_attrs,
+=09.unmap_sg =3D arm64_swiotlb_unmap_sg_attrs,
+=09.sync_single_for_cpu =3D arm64_swiotlb_sync_single_for_cpu,
+=09.sync_single_for_device =3D arm64_swiotlb_sync_single_for_device,
+=09.sync_sg_for_cpu =3D arm64_swiotlb_sync_sg_for_cpu,
+=09.sync_sg_for_device =3D arm64_swiotlb_sync_sg_for_device,
+=09.dma_supported =3D swiotlb_dma_supported,
+=09.mapping_error =3D swiotlb_dma_mapping_error,
+};
+
+void __init swiotlb_init_with_default_size(size_t default_size, int verbos=
e);
+
+void __init arm64_swiotlb_init(size_t max_size)
+{
+=09dma_ops =3D &arm64_swiotlb_dma_ops;
+=09swiotlb_init_with_default_size(min((size_t)SZ_64M, max_size), 1);
+}
+
+#define PREALLOC_DMA_DEBUG_ENTRIES=094096
+
+static int __init dma_debug_do_init(void)
+{
+=09dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
+=09return 0;
+}
+fs_initcall(dma_debug_do_init);
