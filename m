Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io1-f67.google.com ([209.85.166.67]:44229 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbfGRPTW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jul 2019 11:19:22 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so51924657iob.11
        for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2019 08:19:21 -0700 (PDT)
Date: Thu, 18 Jul 2019 08:19:19 -0700 (PDT)
From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH] riscv: fix build break after macro-to-function conversion
 in generic cacheflush.h
Message-ID: <alpine.DEB.2.21.9999.1907180800440.18568@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: cai@lca.pw, arnd@arndb.de, akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190718151919.NpTDBnvaKMcQqqeT-fKriUL8PDjfaM35J3Gq48yV4BQ@z>


Commit c296d4dc13ae ("asm-generic: fix a compilation warning")
converted the various flush_*cache_* macros in
asm-generic/cacheflush.h to static inline functions.  This breaks
RISC-V builds, since RISC-V's cacheflush.h includes the generic
cacheflush.h and then undefines the macros to be overridden.

Fix by copying the subset of the no-op functions that are reused from
the generic cacheflush.h into the RISC-V cacheflush.h, and dropping
the include of the generic cacheflush.h.

Fixes: c296d4dc13ae ("asm-generic: fix a compilation warning")
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
Queued with the other arch/riscv patches for the 5.3 merge window.

 arch/riscv/include/asm/cacheflush.h | 63 +++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index ad8678f1b54a..555b20b11dc3 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -6,11 +6,66 @@
 #ifndef _ASM_RISCV_CACHEFLUSH_H
 #define _ASM_RISCV_CACHEFLUSH_H
 
-#include <asm-generic/cacheflush.h>
+#include <linux/mm.h>
 
-#undef flush_icache_range
-#undef flush_icache_user_range
-#undef flush_dcache_page
+#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
+
+/*
+ * The cache doesn't need to be flushed when TLB entries change when
+ * the cache is mapped to physical memory, not virtual memory
+ */
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
+static inline void flush_dcache_mmap_lock(struct address_space *mapping)
+{
+}
+
+static inline void flush_dcache_mmap_unlock(struct address_space *mapping)
+{
+}
+
+static inline void flush_icache_page(struct vm_area_struct *vma,
+				     struct page *page)
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
+
+#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
+	do { \
+		memcpy(dst, src, len); \
+		flush_icache_user_range(vma, page, vaddr, len); \
+	} while (0)
+#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
+	memcpy(dst, src, len)
 
 static inline void local_flush_icache_all(void)
 {
-- 
2.22.0
