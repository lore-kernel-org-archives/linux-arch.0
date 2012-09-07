Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34408 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab2IGQ1y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 12:27:54 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 14/31] arm64: DMA mapping API
Date: Fri,  7 Sep 2012 17:26:49 +0100
Message-ID: <1347035226-18649-15-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20120907162649.Bi8tmc-OkBIoaNJd_K3-cOUI4Q4HUPhm8CurH2XG7eA@z>

This patch adds support for the DMA mapping API. It uses dma_map_ops for
flexibility and it currently supports swiotlb. This patch could be
simplified further if the DMA accesses are coherent (not mandated by the
architecture) or if corresponding hooks are placed in the generic
swiotlb code to deal with cache maintenance.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm64/include/asm/dma-mapping.h |  124 ++++++++++++++++++++++++++++++=
++++
 arch/arm64/mm/dma-mapping.c          |   79 +++++++++++++++++++++
 2 files changed, 203 insertions(+), 0 deletions(-)
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
index 0000000..5eb2444
--- /dev/null
+++ b/arch/arm64/mm/dma-mapping.c
@@ -0,0 +1,79 @@
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
+=09if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
+=09    dev->coherent_dma_mask <=3D DMA_BIT_MASK(32))
+=09=09flags |=3D GFP_DMA32;
+=09return swiotlb_alloc_coherent(dev, size, dma_handle, flags);
+}
+
+static void arm64_swiotlb_free_coherent(struct device *dev, size_t size,
+=09=09=09=09=09void *vaddr, dma_addr_t dma_handle,
+=09=09=09=09=09struct dma_attrs *attrs)
+{
+=09swiotlb_free_coherent(dev, size, vaddr, dma_handle);
+}
+
+static struct dma_map_ops arm64_swiotlb_dma_ops =3D {
+=09.alloc =3D arm64_swiotlb_alloc_coherent,
+=09.free =3D arm64_swiotlb_free_coherent,
+=09.map_page =3D swiotlb_map_page,
+=09.unmap_page =3D swiotlb_unmap_page,
+=09.map_sg =3D swiotlb_map_sg_attrs,
+=09.unmap_sg =3D swiotlb_unmap_sg_attrs,
+=09.sync_single_for_cpu =3D swiotlb_sync_single_for_cpu,
+=09.sync_single_for_device =3D swiotlb_sync_single_for_device,
+=09.sync_sg_for_cpu =3D swiotlb_sync_sg_for_cpu,
+=09.sync_sg_for_device =3D swiotlb_sync_sg_for_device,
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

