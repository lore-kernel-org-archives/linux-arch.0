Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40912 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfFYUQM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jun 2019 16:16:12 -0400
Received: by mail-qk1-f196.google.com with SMTP id c70so13714042qkg.7
        for <linux-arch@vger.kernel.org>; Tue, 25 Jun 2019 13:16:11 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
Subject: [PATCH] asm-generic: fix a compilation warning
Date: Tue, 25 Jun 2019 16:15:53 -0400
Message-ID: <1561493753-3860-1-git-send-email-cai@lca.pw>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Message-ID: <20190625201553.CaincOrlklvtRHE5EinSrN9qxUAFVn5ErKCMILd1Jg0@z>

Fix this compilation warning on x86 by making flush_cache_vmap() inline.

lib/ioremap.c: In function 'ioremap_page_range':
lib/ioremap.c:214:16: warning: variable 'start' set but not used
[-Wunused-but-set-variable]
  unsigned long start;
                ^~~~~

While at it, convert all other similar functions to inline for
consistency.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/asm-generic/cacheflush.h | 74 ++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index 0dd47a6db2cf..a950a22c4890 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -5,24 +5,70 @@
 /* Keep includes the same across arches.  */
 #include <linux/mm.h>
 
+#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
+
 /*
  * The cache doesn't need to be flushed when TLB entries change when
  * the cache is mapped to physical memory, not virtual memory
  */
-#define flush_cache_all()			do { } while (0)
-#define flush_cache_mm(mm)			do { } while (0)
-#define flush_cache_dup_mm(mm)			do { } while (0)
-#define flush_cache_range(vma, start, end)	do { } while (0)
-#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
-#define flush_dcache_page(page)			do { } while (0)
-#define flush_dcache_mmap_lock(mapping)		do { } while (0)
-#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
-#define flush_icache_range(start, end)		do { } while (0)
-#define flush_icache_page(vma,pg)		do { } while (0)
-#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
-#define flush_cache_vmap(start, end)		do { } while (0)
-#define flush_cache_vunmap(start, end)		do { } while (0)
+static inline void flush_cache_all(void)
+{
+}
+
+static inline void flush_cache_mm(struct mm_struct *mm)
+{
+}
+
+static inline void flush_cache_dup_mm(struct mm_struct *mm)
+{
+}
+
+static inline void flush_cache_range(struct vm_area_struct *vma,
+				     unsigned long start,
+				     unsigned long end)
+{
+}
+
+static inline void flush_cache_page(struct vm_area_struct *vma,
+				    unsigned long vmaddr,
+				    unsigned long pfn)
+{
+}
+
+static inline void flush_dcache_page(struct page *page)
+{
+}
+
+static inline void flush_dcache_mmap_lock(struct address_space *mapping)
+{
+}
+
+static inline void flush_dcache_mmap_unlock(struct address_space *mapping)
+{
+}
+
+static inline void flush_icache_range(unsigned long start, unsigned long end)
+{
+}
+
+static inline void flush_icache_page(struct vm_area_struct *vma,
+				     struct page *page)
+{
+}
+
+static inline void flush_icache_user_range(struct vm_area_struct *vma,
+					   struct page *page,
+					   unsigned long addr, int len)
+{
+}
+
+static inline void flush_cache_vmap(unsigned long start, unsigned long end)
+{
+}
+
+static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
+{
+}
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
 	do { \
-- 
1.8.3.1
