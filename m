Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:21052 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933023Ab2EQNQA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 May 2012 09:16:00 -0400
Received: from euspt2 (mailout2.w1.samsung.com [210.118.77.12])
 by mailout2.w1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0M46009M94UEFB@mailout2.w1.samsung.com> for
 linux-arch@vger.kernel.org; Thu, 17 May 2012 14:15:50 +0100 (BST)
Received: from ubuntu.arm.acom ([106.210.236.191])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0M46005864TPC2@spt2.w1.samsung.com> for
 linux-arch@vger.kernel.org; Thu, 17 May 2012 14:15:56 +0100 (BST)
Date: Thu, 17 May 2012 15:13:51 +0200
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCHv10 01/11] common: add dma_mmap_from_coherent() function
In-reply-to: <1337260441-8121-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1337260441-8121-2-git-send-email-m.szyprowski@samsung.com>
MIME-version: 1.0
Content-type: TEXT/PLAIN
Content-transfer-encoding: 7BIT
References: <1337260441-8121-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chunsang Jeong <chunsang.jeong@linaro.org>, Krishna Reddy <vdumpa@nvidia.com>, KyongHo Cho <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Hiroshi Doyu <hdoyu@nvidia.com>, Subash Patel <subashrp@gmail.com>
Message-ID: <20120517131351.1NQ5FG2tVeQ8XQ25UOIYl-hP-XwANpRxAlIH7nHCCzY@z>

Add a common helper for dma-mapping core for mapping a coherent buffer
to userspace.

Reported-by: Subash Patel <subashrp@gmail.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Tested-By: Subash Patel <subash.ramaswamy@linaro.org>
---
 drivers/base/dma-coherent.c        |   42 ++++++++++++++++++++++++++++++++++++
 include/asm-generic/dma-coherent.h |    4 +++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
index bb0025c..1b85949 100644
--- a/drivers/base/dma-coherent.c
+++ b/drivers/base/dma-coherent.c
@@ -10,6 +10,7 @@
 struct dma_coherent_mem {
 	void		*virt_base;
 	dma_addr_t	device_base;
+	phys_addr_t	pfn_base;
 	int		size;
 	int		flags;
 	unsigned long	*bitmap;
@@ -44,6 +45,7 @@ int dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
 
 	dev->dma_mem->virt_base = mem_base;
 	dev->dma_mem->device_base = device_addr;
+	dev->dma_mem->pfn_base = PFN_DOWN(bus_addr);
 	dev->dma_mem->size = pages;
 	dev->dma_mem->flags = flags;
 
@@ -176,3 +178,43 @@ int dma_release_from_coherent(struct device *dev, int order, void *vaddr)
 	return 0;
 }
 EXPORT_SYMBOL(dma_release_from_coherent);
+
+/**
+ * dma_mmap_from_coherent() - try to mmap the memory allocated from
+ * per-device coherent memory pool to userspace
+ * @dev:	device from which the memory was allocated
+ * @vma:	vm_area for the userspace memory
+ * @vaddr:	cpu address returned by dma_alloc_from_coherent
+ * @size:	size of the memory buffer allocated by dma_alloc_from_coherent
+ *
+ * This checks whether the memory was allocated from the per-device
+ * coherent memory pool and if so, maps that memory to the provided vma.
+ *
+ * Returns 1 if we correctly mapped the memory, or 0 if
+ * dma_release_coherent() should proceed with mapping memory from
+ * generic pools.
+ */
+int dma_mmap_from_coherent(struct device *dev, struct vm_area_struct *vma,
+			   void *vaddr, size_t size, int *ret)
+{
+	struct dma_coherent_mem *mem = dev ? dev->dma_mem : NULL;
+
+	if (mem && vaddr >= mem->virt_base && vaddr + size <=
+		   (mem->virt_base + (mem->size << PAGE_SHIFT))) {
+		unsigned long off = vma->vm_pgoff;
+		int start = (vaddr - mem->virt_base) >> PAGE_SHIFT;
+		int user_count = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+		int count = size >> PAGE_SHIFT;
+
+		*ret = -ENXIO;
+		if (off < count && user_count <= count - off) {
+			unsigned pfn = mem->pfn_base + start + off;
+			*ret = remap_pfn_range(vma, vma->vm_start, pfn,
+					       user_count << PAGE_SHIFT,
+					       vma->vm_page_prot);
+		}
+		return 1;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(dma_mmap_from_coherent);
diff --git a/include/asm-generic/dma-coherent.h b/include/asm-generic/dma-coherent.h
index 85a3ffa..abfb268 100644
--- a/include/asm-generic/dma-coherent.h
+++ b/include/asm-generic/dma-coherent.h
@@ -3,13 +3,15 @@
 
 #ifdef CONFIG_HAVE_GENERIC_DMA_COHERENT
 /*
- * These two functions are only for dma allocator.
+ * These three functions are only for dma allocator.
  * Don't use them in device drivers.
  */
 int dma_alloc_from_coherent(struct device *dev, ssize_t size,
 				       dma_addr_t *dma_handle, void **ret);
 int dma_release_from_coherent(struct device *dev, int order, void *vaddr);
 
+int dma_mmap_from_coherent(struct device *dev, struct vm_area_struct *vma,
+			    void *cpu_addr, size_t size, int *ret);
 /*
  * Standard interface
  */
-- 
1.7.10.1

