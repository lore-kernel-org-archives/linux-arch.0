From: Mark Salter <msalter@redhat.com>
Subject: [PATCH 07/24] C6X: memory management
Date: Mon,  8 Aug 2011 17:44:22 -0400
Message-ID: <1312839879-13592-8-git-send-email-msalter@redhat.com>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:16422 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917Ab1HHVos (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 8 Aug 2011 17:44:48 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p78LimLl027212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Mon, 8 Aug 2011 17:44:48 -0400
Received: from deneb.redhat.com (ovpn-113-62.phx2.redhat.com [10.3.113.62])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p78LiinQ010873
	for <linux-arch@vger.kernel.org>; Mon, 8 Aug 2011 17:44:48 -0400
In-Reply-To: <1312839879-13592-1-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 arch/c6x/include/asm/dma-mapping.h |  301 +++++++++++++++++++++++++++++++++
 arch/c6x/include/asm/dma.h         |   23 +++
 arch/c6x/mm/dma-coherent.c         |  328 ++++++++++++++++++++++++++++++++++++
 arch/c6x/mm/init.c                 |  112 ++++++++++++
 4 files changed, 764 insertions(+), 0 deletions(-)
 create mode 100644 arch/c6x/include/asm/dma-mapping.h
 create mode 100644 arch/c6x/include/asm/dma.h
 create mode 100644 arch/c6x/mm/dma-coherent.c
 create mode 100644 arch/c6x/mm/init.c

diff --git a/arch/c6x/include/asm/dma-mapping.h b/arch/c6x/include/asm/dma-mapping.h
new file mode 100644
index 0000000..7821785
--- /dev/null
+++ b/arch/c6x/include/asm/dma-mapping.h
@@ -0,0 +1,301 @@
+/*
+ *  Port on Texas Instruments TMS320C6x architecture
+ *
+ *  Copyright (C) 2004, 2009, 2010, 2011 Texas Instruments Incorporated
+ *  Author: Aurelien Jacquiot <aurelien.jacquiot@ti.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ */
+#ifndef _ASM_C6X_DMA_MAPPING_H
+#define _ASM_C6X_DMA_MAPPING_H
+
+#ifdef __KERNEL__
+
+#include <linux/mm.h>
+#include <linux/mm_types.h>
+#include <linux/scatterlist.h>
+
+#include <asm/io.h>
+#include <asm/types.h>
+#include <asm-generic/dma-coherent.h>
+
+#define dma_supported(d, m)	    (1)
+
+#define __pfn_to_bus(pfn)	   ((pfn) << PAGE_SHIFT)
+#define __bus_to_pfn(paddr)	   ((paddr) >> PAGE_SHIFT)
+#define __bus_to_phys(x)	   (x)
+#define __phys_to_bus(x)	   (x)
+#define __bus_to_virt(b)	   phys_to_virt(__bus_to_phys(b))
+#define __virt_to_bus(v)	   __phys_to_bus(virt_to_phys(v))
+
+/*
+ * page_to_dma/dma_to_virt/virt_to_dma are architecture private functions
+ * used internally by the DMA-mapping API to provide DMA addresses. They
+ * must not be used by drivers.
+ */
+static inline dma_addr_t page_to_dma(struct device *dev, struct page *page)
+{
+	return (dma_addr_t)__pfn_to_bus(page_to_pfn(page));
+}
+
+static inline struct page *dma_to_page(struct device *dev, dma_addr_t addr)
+{
+	return pfn_to_page(__bus_to_pfn(addr));
+}
+
+static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
+{
+	return (void *)__bus_to_virt(addr);
+}
+
+static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
+{
+	return (dma_addr_t)__virt_to_bus(addr);
+}
+
+static inline int dma_map_sg(struct device *dev, struct scatterlist *sglist,
+			     int nents, enum dma_data_direction direction)
+{
+	struct scatterlist *sg;
+	int i;
+
+	BUG_ON(direction == DMA_NONE);
+
+	for_each_sg(sglist, sg, nents, i) {
+		BUG_ON(!sg_page(sg));
+
+		sg->dma_address = sg_phys(sg);
+	}
+
+	return nents;
+}
+
+static inline void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
+				int nhwentries,
+				enum dma_data_direction direction)
+{
+	BUG_ON(direction == DMA_NONE);
+}
+
+extern int __dma_is_coherent(struct device *dev, dma_addr_t handle);
+
+static inline int dma_is_consistent(struct device *dev, dma_addr_t handle)
+{
+	if (arch_is_coherent() || __dma_is_coherent(dev, handle))
+		return 1;
+	else
+		return 0;
+}
+
+/*
+ * DMA errors are defined by all-bits-set in the DMA address.
+ */
+static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr == ~0;
+}
+
+/**
+ * dma_alloc_coherent - allocate consistent memory for DMA
+ * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
+ * @size: required memory size
+ * @handle: bus-specific DMA address
+ *
+ * Allocate some uncached, unbuffered memory for a device for
+ * performing DMA.  This function allocates pages, and will
+ * return the CPU-viewed address, and sets @handle to be the
+ * device-viewed address.
+ */
+extern void *dma_alloc_coherent(struct device *, size_t, dma_addr_t *, gfp_t);
+
+/**
+ * dma_free_coherent - free memory allocated by dma_alloc_coherent
+ * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
+ * @size: size of memory originally requested in dma_alloc_coherent
+ * @cpu_addr: CPU-view address returned from dma_alloc_coherent
+ * @handle: device-view address returned from dma_alloc_coherent
+ *
+ * Free (and unmap) a DMA buffer previously allocated by
+ * dma_alloc_coherent().
+ *
+ * References to memory and mappings associated with cpu_addr/handle
+ * during and after this call executing are illegal.
+ */
+extern void dma_free_coherent(struct device *, size_t, void *, dma_addr_t);
+
+#define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent((d), (s), (h), (f))
+#define dma_free_noncoherent(d, s, v, h)  dma_free_coherent((d), (s), (v), (h))
+
+extern void __dma_single_cpu_to_dev(const void *kaddr, size_t size,
+				    enum dma_data_direction dir);
+
+extern void __dma_single_dev_to_cpu(const void *kaddr, size_t size,
+				    enum dma_data_direction dir);
+
+extern void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
+				  size_t size, enum dma_data_direction dir);
+
+extern void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
+				  size_t size, enum dma_data_direction dir);
+
+/**
+ * dma_map_single - map a single buffer for streaming DMA
+ * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
+ * @cpu_addr: CPU direct mapped address of buffer
+ * @size: size of buffer to map
+ * @dir: DMA transfer direction
+ *
+ * Ensure that any data held in the cache is appropriately discarded
+ * or written back.
+ *
+ * The device owns this memory once this call has completed.  The CPU
+ * can regain ownership by calling dma_unmap_single() or
+ * dma_sync_single_for_cpu().
+ */
+static inline dma_addr_t dma_map_single(struct device *dev, void *cpu_addr,
+		size_t size, enum dma_data_direction dir)
+{
+	BUG_ON(!valid_dma_direction(dir));
+
+	__dma_single_cpu_to_dev(cpu_addr, size, dir);
+
+	return virt_to_dma(dev, cpu_addr);
+}
+
+/**
+ * dma_map_page - map a portion of a page for streaming DMA
+ * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
+ * @page: page that buffer resides in
+ * @offset: offset into page for start of buffer
+ * @size: size of buffer to map
+ * @dir: DMA transfer direction
+ *
+ * Ensure that any data held in the cache is appropriately discarded
+ * or written back.
+ *
+ * The device owns this memory once this call has completed.  The CPU
+ * can regain ownership by calling dma_unmap_page().
+ */
+static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
+	     unsigned long offset, size_t size, enum dma_data_direction dir)
+{
+	BUG_ON(!valid_dma_direction(dir));
+
+	__dma_page_cpu_to_dev(page, offset, size, dir);
+
+	return page_to_dma(dev, page) + offset;
+}
+
+/**
+ * dma_unmap_single - unmap a single buffer previously mapped
+ * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
+ * @handle: DMA address of buffer
+ * @size: size of buffer (same as passed to dma_map_single)
+ * @dir: DMA transfer direction (same as passed to dma_map_single)
+ *
+ * Unmap a single streaming mode DMA translation.  The handle and size
+ * must match what was provided in the previous dma_map_single() call.
+ * All other usages are undefined.
+ *
+ * After this call, reads by the CPU to the buffer are guaranteed to see
+ * whatever the device wrote there.
+ */
+static inline void
+dma_unmap_single(struct device *dev, dma_addr_t handle,
+		 size_t size, enum dma_data_direction dir)
+{
+	__dma_single_dev_to_cpu(dma_to_virt(dev, handle), size, dir);
+}
+
+/**
+ * dma_unmap_page - unmap a buffer previously mapped through dma_map_page()
+ * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
+ * @handle: DMA address of buffer
+ * @size: size of buffer (same as passed to dma_map_page)
+ * @dir: DMA transfer direction (same as passed to dma_map_page)
+ *
+ * Unmap a page streaming mode DMA translation.  The handle and size
+ * must match what was provided in the previous dma_map_page() call.
+ * All other usages are undefined.
+ *
+ * After this call, reads by the CPU to the buffer are guaranteed to see
+ * whatever the device wrote there.
+ */
+static inline void dma_unmap_page(struct device *dev, dma_addr_t handle,
+		size_t size, enum dma_data_direction dir)
+{
+	__dma_page_dev_to_cpu(dma_to_page(dev, handle), handle & ~PAGE_MASK,
+		size, dir);
+}
+
+/**
+ * dma_sync_single_range_for_cpu
+ * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
+ * @handle: DMA address of buffer
+ * @offset: offset of region to start sync
+ * @size: size of region to sync
+ * @dir: DMA transfer direction (same as passed to dma_map_single)
+ *
+ * Make physical memory consistent for a single streaming mode DMA
+ * translation after a transfer.
+ *
+ * If you perform a dma_map_single() but wish to interrogate the
+ * buffer using the cpu, yet do not wish to teardown the PCI dma
+ * mapping, you must call this function before doing so.  At the
+ * next point you give the PCI dma address back to the card, you
+ * must first the perform a dma_sync_for_device, and then the
+ * device again owns the buffer.
+ */
+static inline void dma_sync_single_range_for_cpu(struct device *dev,
+		dma_addr_t handle, unsigned long offset, size_t size,
+		enum dma_data_direction dir)
+{
+	BUG_ON(!valid_dma_direction(dir));
+
+	__dma_single_dev_to_cpu(dma_to_virt(dev, handle) + offset, size, dir);
+}
+
+static inline void dma_sync_single_range_for_device(struct device *dev,
+		dma_addr_t handle, unsigned long offset, size_t size,
+		enum dma_data_direction dir)
+{
+	BUG_ON(!valid_dma_direction(dir));
+
+	__dma_single_cpu_to_dev(dma_to_virt(dev, handle) + offset, size, dir);
+}
+
+static inline void dma_sync_single_for_cpu(struct device *dev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir)
+{
+	dma_sync_single_range_for_cpu(dev, handle, 0, size, dir);
+}
+
+static inline void dma_sync_single_for_device(struct device *dev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir)
+{
+	dma_sync_single_range_for_device(dev, handle, 0, size, dir);
+}
+
+static inline void
+dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nents,
+		    enum dma_data_direction dir)
+{
+	BUG_ON(!valid_dma_direction(dir));
+}
+
+static inline void
+dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nents,
+		    enum dma_data_direction dir)
+{
+	BUG_ON(!valid_dma_direction(dir));
+}
+
+extern int coherent_mem_init(void);
+extern unsigned long dma_memory_start;
+extern unsigned long dma_memory_size;
+
+#endif /* __KERNEL__ */
+#endif	/* _ASM_C6X_DMA_MAPPING_H */
diff --git a/arch/c6x/include/asm/dma.h b/arch/c6x/include/asm/dma.h
new file mode 100644
index 0000000..2ac46c3
--- /dev/null
+++ b/arch/c6x/include/asm/dma.h
@@ -0,0 +1,23 @@
+/*
+ *  Port on Texas Instruments TMS320C6x architecture
+ *
+ *  Copyright (C) 2004, 2009 Texas Instruments Incorporated
+ *  Author: Aurelien Jacquiot (aurelien.jacquiot@jaluna.com)
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+#ifndef _ASM_C6X_DMA_H
+#define _ASM_C6X_DMA_H
+
+#define MAX_DMA_ADDRESS  0xFFFFFFFF
+#define MAX_DMA_CHANNELS 64
+
+/* Reserve a DMA channel */
+extern int request_dma(unsigned int dmanr, const char *device_id);
+
+/* Release it again */
+extern void free_dma(unsigned int dmanr);
+
+#endif /* _ASM_C6X_DMA_H */
diff --git a/arch/c6x/mm/dma-coherent.c b/arch/c6x/mm/dma-coherent.c
new file mode 100644
index 0000000..244a3bc
--- /dev/null
+++ b/arch/c6x/mm/dma-coherent.c
@@ -0,0 +1,328 @@
+/*
+ *  Port on Texas Instruments TMS320C6x architecture
+ *
+ *  Copyright (C) 2004, 2009, 2010 Texas Instruments Incorporated
+ *  Author: Aurelien Jacquiot <aurelien.jacquiot@ti.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  DMA uncached mapping support.
+ *
+ *  Using code pulled from ARM
+ *  Copyright (C) 2000-2004 Russell King
+ *
+ */
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
+
+#include <asm-generic/dma-coherent.h>
+
+/*
+ * DMA coherent memory management, can be redefined using the memdma=
+ * kernel command line
+ */
+
+/* none by default */
+unsigned long dma_memory_start;
+unsigned long dma_memory_size;
+
+static u32    dma_page_heap;
+static u32    dma_page_top;
+
+static DEFINE_SPINLOCK(dma_mem_lock);
+
+/*
+ * Return a DMA coherent and contiguous memory chunk from the DMA memory
+ */
+static inline u32 __dma_alloc_coherent(size_t size, gfp_t gfp)
+{
+	u32 paddr;
+
+	if ((dma_page_heap + size) > dma_page_top)
+		return -1;
+
+	paddr	       = dma_page_heap;
+	dma_page_heap += size;
+
+	return paddr;
+}
+
+/*
+ * Return a standard contigous memory chunk
+ */
+static inline u32 __dma_alloc_coherent_stdmem(size_t size, gfp_t gfp)
+{
+	void *virt;
+
+	virt = kmalloc(size, gfp);
+	if (!virt)
+		return -1;
+
+	return virt_to_phys(virt);
+}
+
+/*
+ * Allocate DMA-coherent memory space and return both the kernel remapped
+ * virtual and bus address for that space.
+ *
+ * Note that this does *not* zero the allocated area!
+ */
+void *dma_alloc_coherent(struct device *dev, size_t size,
+			 dma_addr_t *handle, gfp_t gfp)
+{
+	u32 paddr;
+	void __iomem *virt;
+
+	if (in_interrupt())
+		BUG();
+
+	/* Round up to a page */
+	size = PAGE_ALIGN(size);
+
+	spin_lock_irq(&dma_mem_lock);
+
+	/* Check if we have a DMA memory */
+	if (dma_page_heap)
+		paddr = __dma_alloc_coherent(size, gfp);
+	else
+		/* Otherwise do an allocation using standard allocator */
+		paddr = __dma_alloc_coherent_stdmem(size, gfp);
+
+	spin_unlock_irq(&dma_mem_lock);
+
+	if (paddr == -1)
+		return NULL;
+
+	if (handle)
+		*handle = __phys_to_bus(paddr);
+
+	/*
+	 * In a near future we can expect having a partial MMU with
+	 * chaching attributes
+	 */
+	virt = ioremap_nocache(paddr, size);
+	if (!virt)
+		return NULL;
+
+	/*
+	 * We need to ensure that there are no cachelines in use, or
+	 * worse dirty in this area.
+	 */
+	L2_cache_block_invalidate(paddr, paddr + size);
+
+	return (void *) virt;
+}
+EXPORT_SYMBOL(dma_alloc_coherent);
+
+/*
+ * Free a DMA coherent and contiguous memory chunk from the DMA memory
+ */
+static inline void __dma_free_coherent(size_t size, dma_addr_t dma_handle)
+{
+	/* Do nothing (we do not have real memory alloctor here) */
+}
+
+/*
+ * Free a standard contigous memory chunk
+ */
+static inline void __dma_free_coherent_stdmem(size_t size,
+					      dma_addr_t dma_handle)
+{
+	void *virt = bus_to_virt(dma_handle);
+
+	kfree(virt);
+}
+
+/*
+ * Free a page as defined by the above mapping.
+ * Must not be called with IRQs disabled.
+ */
+void dma_free_coherent(struct device *dev, size_t size, void *vaddr,
+		       dma_addr_t dma_handle)
+{
+	if (in_interrupt())
+		BUG();
+
+	/* Check if we have a DMA memory */
+	if (dma_page_heap)
+		__dma_free_coherent(size, dma_handle);
+	else
+		/* Otherwise use standard allocator */
+		__dma_free_coherent_stdmem(size, dma_handle);
+
+	iounmap(vaddr);
+}
+EXPORT_SYMBOL(dma_free_coherent);
+
+int __dma_is_coherent(struct device *dev, dma_addr_t handle)
+{
+	u32 paddr;
+
+	/* If we do not have DMA memory */
+	if (!dma_page_heap)
+		return 0;
+
+	paddr = __bus_to_phys(handle);
+
+	/*
+	 * If the address is in the DMA memory range, the memory
+	 * is coherent.
+	 */
+	if ((paddr >= dma_memory_start) &&
+	    (paddr < dma_page_top))
+		return 1;
+
+	return 0;
+}
+EXPORT_SYMBOL(__dma_is_coherent);
+
+/*
+ * Make an area consistent for devices.
+ * Note: Drivers should NOT use this function directly, as it will break
+ * platforms with CONFIG_DMABOUNCE.
+ * Use the driver DMA support - see dma-mapping.h (dma_sync_*)
+ */
+void __dma_single_cpu_to_dev(const void *kaddr, size_t size,
+			     enum dma_data_direction dir)
+{
+	unsigned long paddr;
+
+	BUG_ON(!virt_addr_valid(kaddr) || !virt_addr_valid(kaddr + size - 1));
+
+	paddr = __pa(kaddr);
+	switch (dir) {
+	case DMA_FROM_DEVICE:
+		L2_cache_block_invalidate(paddr, paddr + size);
+		break;
+	case DMA_TO_DEVICE:
+		L2_cache_block_writeback(paddr, paddr + size);
+		break;
+	case DMA_BIDIRECTIONAL:
+		L2_cache_block_writeback_invalidate(paddr, paddr + size);
+		break;
+	default:
+		break;
+	}
+}
+EXPORT_SYMBOL(__dma_single_cpu_to_dev);
+
+void __dma_single_dev_to_cpu(const void *kaddr, size_t size,
+			     enum dma_data_direction dir)
+{
+	BUG_ON(!virt_addr_valid(kaddr) || !virt_addr_valid(kaddr + size - 1));
+
+	/* don't bother invalidating if DMA to device */
+	if (dir != DMA_TO_DEVICE) {
+		unsigned long paddr = __pa(kaddr);
+		L2_cache_block_invalidate(paddr, paddr + size);
+	}
+}
+EXPORT_SYMBOL(__dma_single_dev_to_cpu);
+
+void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
+			   size_t size, enum dma_data_direction dir)
+{
+	unsigned long paddr;
+
+	paddr = page_to_phys(page) + off;
+	switch (dir) {
+	case DMA_FROM_DEVICE:
+		L2_cache_block_invalidate(paddr, paddr + size);
+		break;
+	case DMA_TO_DEVICE:
+		L2_cache_block_writeback(paddr, paddr + size);
+		break;
+	case DMA_BIDIRECTIONAL:
+		L2_cache_block_writeback_invalidate(paddr, paddr + size);
+		break;
+	default:
+		break;
+	}
+}
+EXPORT_SYMBOL(__dma_page_cpu_to_dev);
+
+void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
+			   size_t size, enum dma_data_direction dir)
+{
+	unsigned long paddr = page_to_phys(page) + off;
+
+	/* don't bother invalidating if DMA to device */
+	if (dir != DMA_TO_DEVICE)
+		L2_cache_block_invalidate(paddr, paddr + size);
+}
+EXPORT_SYMBOL(__dma_page_dev_to_cpu);
+
+/*
+ * Initialise the coherent memory and its allocator
+ */
+int coherent_mem_init(void)
+{
+	/*
+	 * Define the (DMA) coherent memory
+	 */
+	if (dma_memory_size != 0) {
+
+		/* Round it to the (upper) MAR granularity  */
+		dma_memory_size = CACHE_REGION_END(dma_memory_size);
+
+		if (!dma_memory_start) {
+			/*
+			 * Take the coherent memory from the end of the physical
+			 * memory and round it to the lower MAR. We may waste
+			 * some cacheable memory if memory_end is not aligned
+			 * on a MAR region.
+			 */
+			dma_memory_start =
+				CACHE_REGION_START(memory_end -
+						   dma_memory_size);
+
+			/* Then remove the coherent memory from the paged one */
+			memory_end = dma_memory_start;
+
+
+		} else {
+			/* Align it on MAR */
+			dma_memory_start = CACHE_REGION_START(dma_memory_start);
+
+			/*
+			 * Check if the defined coherent memory is within the
+			 * paged memory. If so remove the corresponding memory
+			 */
+			if (dma_memory_start < memory_end &&
+			    dma_memory_start > memory_start)
+				memory_end = dma_memory_start;
+		}
+
+		printk(KERN_INFO
+		       "Coherent memory (DMA) region start=0x%lx size=0x%lx\n",
+		       dma_memory_start,
+		       dma_memory_size);
+
+		/*
+		 * We need to ensure that there are no cachelines in use, or
+		 * worse dirty in this area.
+		 */
+		L2_cache_block_writeback(dma_memory_start,
+					 dma_memory_start + dma_memory_size
+					 - 1);
+
+		/* Make this memory coherent (so non-cacheable) */
+		disable_caching(dma_memory_start,
+				dma_memory_start + dma_memory_size - 1);
+
+		printk(KERN_INFO "disabling caching for 0x%lx to 0x%lx\n",
+		       dma_memory_start,
+		       dma_memory_start + dma_memory_size - 1);
+
+		/* The allocator starts here */
+		dma_page_heap = dma_memory_start;
+
+		/* And finish here */
+		dma_page_top = PAGE_ALIGN(dma_memory_start + dma_memory_size);
+	}
+
+	return 0;
+}
diff --git a/arch/c6x/mm/init.c b/arch/c6x/mm/init.c
new file mode 100644
index 0000000..6b4d396
--- /dev/null
+++ b/arch/c6x/mm/init.c
@@ -0,0 +1,112 @@
+/*
+ *  Port on Texas Instruments TMS320C6x architecture
+ *
+ *  Copyright (C) 2004, 2009, 2010, 2011 Texas Instruments Incorporated
+ *  Author: Aurelien Jacquiot (aurelien.jacquiot@jaluna.com)
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/bootmem.h>
+#ifdef CONFIG_BLK_DEV_RAM
+#include <linux/blkdev.h>
+#endif
+#include <linux/initrd.h>
+
+#include <asm/sections.h>
+
+/*
+ * ZERO_PAGE is a special page that is used for zero-initialized
+ * data and COW.
+ */
+unsigned long empty_zero_page;
+EXPORT_SYMBOL(empty_zero_page);
+
+/*
+ * paging_init() continues the virtual memory environment setup which
+ * was begun by the code in arch/head.S.
+ * The parameters are pointers to where to stick the starting and ending
+ * addresses  of available kernel virtual memory.
+ */
+void __init paging_init(void)
+{
+	struct pglist_data *pgdat = NODE_DATA(0);
+	unsigned long zones_size[MAX_NR_ZONES] = {0, };
+
+	empty_zero_page      = (unsigned long) alloc_bootmem_pages(PAGE_SIZE);
+	memset((void *)empty_zero_page, 0, PAGE_SIZE);
+
+	/*
+	 * Set up user data space
+	 */
+	set_fs(KERNEL_DS);
+
+	/*
+	 * Define zones
+	 */
+	zones_size[ZONE_NORMAL] = (memory_end - PAGE_OFFSET) >> PAGE_SHIFT;
+	pgdat->node_zones[ZONE_NORMAL].zone_start_pfn =
+		__pa(PAGE_OFFSET) >> PAGE_SHIFT;
+
+	free_area_init(zones_size);
+}
+
+void __init mem_init(void)
+{
+	int codek, datak;
+	unsigned long tmp;
+	unsigned long len = memory_end - memory_start;
+
+	high_memory = (void *)(memory_end & PAGE_MASK);
+
+	/* this will put all memory onto the freelists */
+	totalram_pages = free_all_bootmem();
+
+	codek = (_etext - _stext) >> 10;
+	datak = (_end - _sdata) >> 10;
+
+	tmp = nr_free_pages() << PAGE_SHIFT;
+	printk(KERN_INFO "Memory: %luk/%luk RAM (%dk kernel code, %dk data)\n",
+	       tmp >> 10, len >> 10, codek, datak);
+}
+
+#ifdef CONFIG_BLK_DEV_INITRD
+void __init free_initrd_mem(unsigned long start, unsigned long end)
+{
+	int pages = 0;
+	for (; start < end; start += PAGE_SIZE) {
+		ClearPageReserved(virt_to_page(start));
+		init_page_count(virt_to_page(start));
+		free_page(start);
+		totalram_pages++;
+		pages++;
+	}
+	printk(KERN_INFO "Freeing initrd memory: %luk freed\n",
+	       (pages * PAGE_SIZE) >> 10);
+}
+#endif
+
+void __init free_initmem(void)
+{
+	unsigned long addr;
+
+	/*
+	 * The following code should be cool even if these sections
+	 * are not page aligned.
+	 */
+	addr = PAGE_ALIGN((unsigned long)(__init_begin));
+
+	/* next to check that the page we free is not a partial page */
+	for (; addr + PAGE_SIZE < (unsigned long)(__init_end);
+	     addr += PAGE_SIZE) {
+		ClearPageReserved(virt_to_page(addr));
+		init_page_count(virt_to_page(addr));
+		free_page(addr);
+		totalram_pages++;
+	}
+	printk(KERN_INFO "Freeing unused kernel memory: %dK freed\n",
+	       (int) ((addr - PAGE_ALIGN((long) &__init_begin)) >> 10));
+}
-- 
1.7.6
