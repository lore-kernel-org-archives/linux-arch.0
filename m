From: Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2] riscv: Use flush_icache_mm for flush_icache_user_range
Date: Mon, 27 Jan 2020 22:50:08 +0800
Message-ID: <20200127145008.2850-1-guoren@linux.alibaba.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:61426 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726635AbgA0Ou2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Jan 2020 09:50:28 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paul.walmsley@sifive.com, andrew@sifive.com, palmer@dabbelt.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>, Albert Ou <aou@eecs.berkeley.edu>

The patch is the fixup for the commit 08f051eda33b by Andrew.

For copy_to_user_page, the only call path is:
__access_remote_vm -> copy_to_user_page -> flush_icache_user_range

Seems it's ok to use flush_icache_mm instead of flush_icache_all and
it could reduce flush_icache_all called on other harts.

Add (vma->vm_flags & VM_EXEC) condition to flush icache only for
executable vma area.

ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE is used in a lot of fs/block codes.
We need it to make their pages dirty and defer sync i/dcache in
update_mmu_cache().

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Andrew Waterman <andrew@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>

---
Changelog V2:
 - Add VM_EXEC condition.
 - Remove flush_icache_user_range definition.
 - define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
---
 arch/riscv/include/asm/cacheflush.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index b69aecbb36d3..ae57d6ce63a9 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -8,7 +8,7 @@
 
 #include <linux/mm.h>
 
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
+#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 
 /*
  * The cache doesn't need to be flushed when TLB entries change when
@@ -62,7 +62,8 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
 	do { \
 		memcpy(dst, src, len); \
-		flush_icache_user_range(vma, page, vaddr, len); \
+		if (vma->vm_flags & VM_EXEC) \
+			flush_icache_mm(vma->vm_mm, 0); \
 	} while (0)
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
 	memcpy(dst, src, len)
@@ -85,7 +86,6 @@ static inline void flush_dcache_page(struct page *page)
  * so instead we just flush the whole thing.
  */
 #define flush_icache_range(start, end) flush_icache_all()
-#define flush_icache_user_range(vma, pg, addr, len) flush_icache_all()
 
 void dma_wbinv_range(unsigned long start, unsigned long end);
 void dma_wb_range(unsigned long start, unsigned long end);
-- 
2.17.0
