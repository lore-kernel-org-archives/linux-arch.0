Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729374AbfG3MP7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Jul 2019 08:15:59 -0400
From: guoren@kernel.org
Subject: [PATCH 3/4] csky/dma: Fixup cache_op failed when cross memory ZONEs
Date: Tue, 30 Jul 2019 20:15:44 +0800
Message-ID: <1564488945-20149-3-git-send-email-guoren@kernel.org>
In-Reply-To: <1564488945-20149-1-git-send-email-guoren@kernel.org>
References: <1564488945-20149-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com, zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com, zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190730121544.EbGBO59uh5oip2MNKci4qJ77b8-KdTNfKnt8NJnvUSk@z>

From: Guo Ren <ren_guo@c-sky.com>

If the paddr and size are cross between NORMAL_ZONE and HIGHMEM_ZONE
memory range, cache_op will panic in do_page_fault with bad_area.

Optimize the code to support the range which cross memory ZONEs.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/mm/dma-mapping.c | 73 +++++++++++++++++-----------------------------
 1 file changed, 27 insertions(+), 46 deletions(-)

diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
index 80783bb..3f1ff9d 100644
--- a/arch/csky/mm/dma-mapping.c
+++ b/arch/csky/mm/dma-mapping.c
@@ -18,71 +18,52 @@ static int __init atomic_pool_init(void)
 {
 	return dma_atomic_pool_init(GFP_KERNEL, pgprot_noncached(PAGE_KERNEL));
 }
-postcore_initcall(atomic_pool_init);
-
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
+arch_initcall(atomic_pool_init);
 
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
