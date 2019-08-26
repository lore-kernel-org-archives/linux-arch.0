Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729437AbfHZG75 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Aug 2019 02:59:57 -0400
From: guoren@kernel.org
Subject: [RESEND PATCH V2] csky: Fixup 610 vipt cache flush mechanism
Date: Mon, 26 Aug 2019 14:59:33 +0800
Message-ID: <1566802773-24707-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, hch@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org, linux-mm@kvack.org, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190826065933.9BFjU4VPNV4LRwpaC1emWlvfpIPhrQFQGso7gSPxjTo@z>

From: Guo Ren <ren_guo@c-sky.com>

610 has vipt aliasing issue, so we need to finish the cache flush
apis mentioned in cachetlb.rst to avoid data corruption.

Here is the list of modified apis in the patch:

 - flush_kernel_dcache_page      (new add)
 - flush_dcache_mmap_lock        (new add)
 - flush_dcache_mmap_unlock      (new add)
 - flush_kernel_vmap_range       (new add)
 - invalidate_kernel_vmap_range  (new add)
 - flush_anon_page               (new add)
 - flush_cache_range             (new add)
 - flush_cache_vmap              (flush all)
 - flush_cache_vunmap            (flush all)
 - flush_cache_mm                (only dcache flush)
 - flush_icache_page             (just nop)
 - copy_from_user_page           (remove no need flush)
 - copy_to_user_page             (remove no need flush)

Change to V2:
 - Fixup compile error with xa_lock*(&mapping->i_pages)

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>
---
 arch/csky/abiv1/cacheflush.c         | 20 ++++++++++++++++++
 arch/csky/abiv1/inc/abi/cacheflush.h | 41 +++++++++++++++++++++++++-----------
 2 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/arch/csky/abiv1/cacheflush.c b/arch/csky/abiv1/cacheflush.c
index fee99fc..9f1fe80 100644
--- a/arch/csky/abiv1/cacheflush.c
+++ b/arch/csky/abiv1/cacheflush.c
@@ -54,3 +54,23 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
 			icache_inv_all();
 	}
 }
+
+void flush_kernel_dcache_page(struct page *page)
+{
+	struct address_space *mapping;
+
+	mapping = page_mapping_file(page);
+
+	if (!mapping || mapping_mapped(mapping))
+		dcache_wbinv_all();
+}
+EXPORT_SYMBOL(flush_kernel_dcache_page);
+
+void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
+	unsigned long end)
+{
+	dcache_wbinv_all();
+
+	if (vma->vm_flags & VM_EXEC)
+		icache_inv_all();
+}
diff --git a/arch/csky/abiv1/inc/abi/cacheflush.h b/arch/csky/abiv1/inc/abi/cacheflush.h
index fce5604..79ef9e8 100644
--- a/arch/csky/abiv1/inc/abi/cacheflush.h
+++ b/arch/csky/abiv1/inc/abi/cacheflush.h
@@ -4,26 +4,49 @@
 #ifndef __ABI_CSKY_CACHEFLUSH_H
 #define __ABI_CSKY_CACHEFLUSH_H
 
-#include <linux/compiler.h>
+#include <linux/mm.h>
 #include <asm/string.h>
 #include <asm/cache.h>
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 extern void flush_dcache_page(struct page *);
 
-#define flush_cache_mm(mm)			cache_wbinv_all()
+#define flush_cache_mm(mm)			dcache_wbinv_all()
 #define flush_cache_page(vma, page, pfn)	cache_wbinv_all()
 #define flush_cache_dup_mm(mm)			cache_wbinv_all()
 
+#define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
+extern void flush_kernel_dcache_page(struct page *);
+
+#define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
+#define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages)
+
+static inline void flush_kernel_vmap_range(void *addr, int size)
+{
+	dcache_wbinv_all();
+}
+static inline void invalidate_kernel_vmap_range(void *addr, int size)
+{
+	dcache_wbinv_all();
+}
+
+#define ARCH_HAS_FLUSH_ANON_PAGE
+static inline void flush_anon_page(struct vm_area_struct *vma,
+			 struct page *page, unsigned long vmaddr)
+{
+	if (PageAnon(page))
+		cache_wbinv_all();
+}
+
 /*
  * if (current_mm != vma->mm) cache_wbinv_range(start, end) will be broken.
  * Use cache_wbinv_all() here and need to be improved in future.
  */
-#define flush_cache_range(vma, start, end)	cache_wbinv_all()
-#define flush_cache_vmap(start, end)		cache_wbinv_range(start, end)
-#define flush_cache_vunmap(start, end)		cache_wbinv_range(start, end)
+extern void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
+#define flush_cache_vmap(start, end)		cache_wbinv_all()
+#define flush_cache_vunmap(start, end)		cache_wbinv_all()
 
-#define flush_icache_page(vma, page)		cache_wbinv_all()
+#define flush_icache_page(vma, page)		do {} while (0);
 #define flush_icache_range(start, end)		cache_wbinv_range(start, end)
 
 #define flush_icache_user_range(vma,page,addr,len) \
@@ -31,19 +54,13 @@ extern void flush_dcache_page(struct page *);
 
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
 do { \
-	cache_wbinv_all(); \
 	memcpy(dst, src, len); \
-	cache_wbinv_all(); \
 } while (0)
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
 do { \
-	cache_wbinv_all(); \
 	memcpy(dst, src, len); \
 	cache_wbinv_all(); \
 } while (0)
 
-#define flush_dcache_mmap_lock(mapping)		do {} while (0)
-#define flush_dcache_mmap_unlock(mapping)	do {} while (0)
-
 #endif /* __ABI_CSKY_CACHEFLUSH_H */
-- 
2.7.4
