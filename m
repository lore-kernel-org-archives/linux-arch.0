Return-Path: <SRS0=84jE=65=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727943AbgEOOh5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 10:37:57 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 17/29] riscv: use asm-generic/cacheflush.h
Date: Fri, 15 May 2020 16:36:34 +0200
Message-ID: <20200515143646.3857579-18-hch@lst.de>
In-Reply-To: <20200515143646.3857579-1-hch@lst.de>
References: <20200515143646.3857579-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org, Palmer Dabbelt <palmerdabbelt@google.com>
Message-ID: <20200515143634.p_SWcDWs6ErpC5CKQBAdkg0M38-lm2pb8GTQoLlmY70@z>

RISC-V needs almost no cache flushing routines of its own.  Rely on
asm-generic/cacheflush.h for the defaults.

Also remove the pointless __KERNEL__ ifdef while we're at it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/cacheflush.h | 62 ++---------------------------
 1 file changed, 3 insertions(+), 59 deletions(-)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index c8677c75f82cb..a167b4fbdf007 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -8,65 +8,6 @@
 
 #include <linux/mm.h>
 
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
-
-/*
- * The cache doesn't need to be flushed when TLB entries change when
- * the cache is mapped to physical memory, not virtual memory
- */
-static inline void flush_cache_all(void)
-{
-}
-
-static inline void flush_cache_mm(struct mm_struct *mm)
-{
-}
-
-static inline void flush_cache_dup_mm(struct mm_struct *mm)
-{
-}
-
-static inline void flush_cache_range(struct vm_area_struct *vma,
-				     unsigned long start,
-				     unsigned long end)
-{
-}
-
-static inline void flush_cache_page(struct vm_area_struct *vma,
-				    unsigned long vmaddr,
-				    unsigned long pfn)
-{
-}
-
-static inline void flush_dcache_mmap_lock(struct address_space *mapping)
-{
-}
-
-static inline void flush_dcache_mmap_unlock(struct address_space *mapping)
-{
-}
-
-static inline void flush_icache_page(struct vm_area_struct *vma,
-				     struct page *page)
-{
-}
-
-static inline void flush_cache_vmap(unsigned long start, unsigned long end)
-{
-}
-
-static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
-{
-}
-
-#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
-	do { \
-		memcpy(dst, src, len); \
-		flush_icache_user_range(vma, page, vaddr, len); \
-	} while (0)
-#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
-
 static inline void local_flush_icache_all(void)
 {
 	asm volatile ("fence.i" ::: "memory");
@@ -79,6 +20,7 @@ static inline void flush_dcache_page(struct page *page)
 	if (test_bit(PG_dcache_clean, &page->flags))
 		clear_bit(PG_dcache_clean, &page->flags);
 }
+#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 
 /*
  * RISC-V doesn't have an instruction to flush parts of the instruction cache,
@@ -105,4 +47,6 @@ void flush_icache_mm(struct mm_struct *mm, bool local);
 #define SYS_RISCV_FLUSH_ICACHE_LOCAL 1UL
 #define SYS_RISCV_FLUSH_ICACHE_ALL   (SYS_RISCV_FLUSH_ICACHE_LOCAL)
 
+#include <asm-generic/cacheflush.h>
+
 #endif /* _ASM_RISCV_CACHEFLUSH_H */
-- 
2.26.2
