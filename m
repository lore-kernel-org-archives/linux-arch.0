From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH] arc: Implement arch-specific dma_map_ops.mmap
Date: Wed,  2 Nov 2016 15:19:43 +0300
Message-ID: <1478089183-6458-1-git-send-email-abrodkin@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

We used to use generic implementation of dma_map_ops.mmap which is
dma_common_mmap() but that only worked for simpler cached mappings when
vaddr = paddr.

If a driver requests uncached DMA buffer kernel maps it to virtual
address so that MMU gets involved and page uncached status takes into
account. In that case usage of dma_common_mmap() lead to mapping of
vaddr to vaddr for user-space which is obviously wrong. For more detals
please refer to verbose explanation here [1].

So here we implement our own version of mmap() which always deals
with dma_addr and maps underlying memory to user-space properly
(note that DMA buffer mapped to user-space is always uncached
because there's no way to properly manage cache from user-space).

[1] https://lkml.org/lkml/2016/10/26/973

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: stable@vger.kernel.org
---
 arch/arc/mm/dma.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 20afc65e22dc..034ec6a8a764 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -105,6 +105,31 @@ static void arc_dma_free(struct device *dev, size_t size, void *vaddr,
 	__free_pages(page, get_order(size));
 }
 
+static int arc_dma_mmap(struct device *dev, struct vm_area_struct *vma,
+			void *cpu_addr, dma_addr_t dma_addr, size_t size,
+			unsigned long attrs)
+{
+	unsigned long user_count = vma_pages(vma);
+	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long pfn = __phys_to_pfn(dma_addr);
+	unsigned long off = vma->vm_pgoff;
+	int ret = -ENXIO;
+
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
+		return ret;
+
+	if (off < count && user_count <= (count - off)) {
+		ret = remap_pfn_range(vma, vma->vm_start,
+				      pfn + off,
+				      user_count << PAGE_SHIFT,
+				      vma->vm_page_prot);
+	}
+
+	return ret;
+}
+
 /*
  * streaming DMA Mapping API...
  * CPU accesses page via normal paddr, thus needs to explicitly made
@@ -193,6 +218,7 @@ static int arc_dma_supported(struct device *dev, u64 dma_mask)
 struct dma_map_ops arc_dma_ops = {
 	.alloc			= arc_dma_alloc,
 	.free			= arc_dma_free,
+	.mmap			= arc_dma_mmap,
 	.map_page		= arc_dma_map_page,
 	.map_sg			= arc_dma_map_sg,
 	.sync_single_for_device	= arc_dma_sync_single_for_device,
-- 
2.7.4
