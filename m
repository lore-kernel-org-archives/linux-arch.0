From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH] cris: use asm-generic/cacheflush.h
Date: Thu, 20 Jan 2011 20:32:16 +0900
Message-ID: <1295523136-4277-4-git-send-email-akinobu.mita@gmail.com>
References: <1295523136-4277-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1295523136-4277-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-cris-kernel@axis.com
List-Id: linux-arch.vger.kernel.org

The implementation of the cache flushing interfaces on the cris
is identical with the default implementation in asm-generic.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: linux-cris-kernel@axis.com
---
 arch/cris/include/asm/cacheflush.h |   23 +----------------------
 1 files changed, 1 insertions(+), 22 deletions(-)

diff --git a/arch/cris/include/asm/cacheflush.h b/arch/cris/include/asm/cacheflush.h
index 36795bc..fa698e7 100644
--- a/arch/cris/include/asm/cacheflush.h
+++ b/arch/cris/include/asm/cacheflush.h
@@ -1,31 +1,10 @@
 #ifndef _CRIS_CACHEFLUSH_H
 #define _CRIS_CACHEFLUSH_H
 
-/* Keep includes the same across arches.  */
-#include <linux/mm.h>
-
 /* The cache doesn't need to be flushed when TLB entries change because 
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
-
-#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
-#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
+#include <asm-generic/cacheflush.h>
 
 int change_page_attr(struct page *page, int numpages, pgprot_t prot);
 
-- 
1.7.3.4
