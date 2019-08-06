From: guoren@kernel.org
Subject: [PATCH V2 2/3] csky/dma: Fixup cache_op failed when cross memory ZONEs
Date: Tue,  6 Aug 2019 15:18:41 +0800
Message-ID: <1565075921-25734-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com, zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com, zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>, Christoph Hellwig <hch@infradead.org>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

If the paddr and size are cross between NORMAL_ZONE and HIGHMEM_ZONE
memory range, cache_op will panic in do_page_fault with bad_area.

Optimize the code to support the range which cross memory ZONEs.

Changes for V2:
 - Revert back to postcore_initcall

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/mm/dma-mapping.c | 71 +++++++++++++++++-----------------------------
 1 file changed, 26 insertions(+), 45 deletions(-)

diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
index 80783bb..65f531d 100644
--- a/arch/csky/mm/dma-mapping.c
+++ b/arch/csky/mm/dma-mapping.c
@@ -20,69 +20,50 @@ static int __init atomic_pool_init(void)
 }
 postcore_initcall(atomic_pool_init);
 
-void arch_dma_prep_coherent(struct page *page, size_t size)
-{
-	if (PageHighMem(page)) {
-		unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-
-		do {
-			void *ptr = kmap_atomic(page);
-			size_t _size = (size < PAGE_SIZE) ? size : PAGE_SIZE;
-
-			memset(ptr, 0, _size);
-			dma_wbinv_range((unsigned long)ptr,
-					(unsigned long)ptr + _size);
-
-			kunmap_atomic(ptr);
-
-			page++;
-			size -= PAGE_SIZE;
-			count--;
-		} while (count);
-	} else {
-		void *ptr = page_address(page);
-
-		memset(ptr, 0, size);
-		dma_wbinv_range((unsigned long)ptr, (unsigned long)ptr + size);
-	}
-}
-
 static inline void cache_op(phys_addr_t paddr, size_t size,
 			    void (*fn)(unsigned long start, unsigned long end))
 {
-	struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
-	unsigned int offset = paddr & ~PAGE_MASK;
-	size_t left = size;
-	unsigned long start;
+	struct page *page    = phys_to_page(paddr);
+	void *start          = __va(page_to_phys(page));
+	unsigned long offset = offset_in_page(paddr);
+	size_t left          = size;
 
 	do {
 		size_t len = left;
 
+		if (offset + len > PAGE_SIZE)
+			len = PAGE_SIZE - offset;
+
 		if (PageHighMem(page)) {
-			void *addr;
+			start = kmap_atomic(page);
 
-			if (offset + len > PAGE_SIZE) {
-				if (offset >= PAGE_SIZE) {
-					page += offset >> PAGE_SHIFT;
-					offset &= ~PAGE_MASK;
-				}
-				len = PAGE_SIZE - offset;
-			}
+			fn((unsigned long)start + offset,
+					(unsigned long)start + offset + len);
 
-			addr = kmap_atomic(page);
-			start = (unsigned long)(addr + offset);
-			fn(start, start + len);
-			kunmap_atomic(addr);
+			kunmap_atomic(start);
 		} else {
-			start = (unsigned long)phys_to_virt(paddr);
-			fn(start, start + size);
+			fn((unsigned long)start + offset,
+					(unsigned long)start + offset + len);
 		}
 		offset = 0;
+
 		page++;
+		start += PAGE_SIZE;
 		left -= len;
 	} while (left);
 }
 
+static void dma_wbinv_set_zero_range(unsigned long start, unsigned long end)
+{
+	memset((void *)start, 0, end - start);
+	dma_wbinv_range(start, end);
+}
+
+void arch_dma_prep_coherent(struct page *page, size_t size)
+{
+	cache_op(page_to_phys(page), size, dma_wbinv_set_zero_range);
+}
+
 void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
 			      size_t size, enum dma_data_direction dir)
 {
-- 
2.7.4
