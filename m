Return-Path: <SRS0=nPx+=65=kvack.org=owner-linux-mm@kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 16/29] powerpc: use asm-generic/cacheflush.h
Date: Fri, 15 May 2020 16:36:33 +0200
Message-ID: <20200515143646.3857579-17-hch@lst.de>
In-Reply-To: <20200515143646.3857579-1-hch@lst.de>
References: <20200515143646.3857579-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200515143633.TVAg-YtA2qPyZayJDCnkaz2Glsq7LaaonUQRb3wUSIs@z>

Power needs almost no cache flushing routines of its own.  Rely on
asm-generic/cacheflush.h for the defaults.

Also remove the pointless __KERNEL__ ifdef while we're at it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/cacheflush.h | 42 +++++++--------------------
 1 file changed, 10 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include=
/asm/cacheflush.h
index e92191b390f31..e682c8e10e903 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -4,23 +4,9 @@
 #ifndef _ASM_POWERPC_CACHEFLUSH_H
 #define _ASM_POWERPC_CACHEFLUSH_H
=20
-#ifdef __KERNEL__
-
 #include <linux/mm.h>
 #include <asm/cputable.h>
=20
-/*
- * No cache flushing is required when address mappings are changed,
- * because the caches on PowerPCs are physically addressed.
- */
-#define flush_cache_all()			do { } while (0)
-#define flush_cache_mm(mm)			do { } while (0)
-#define flush_cache_dup_mm(mm)			do { } while (0)
-#define flush_cache_range(vma, start, end)	do { } while (0)
-#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
-#define flush_icache_page(vma, page)		do { } while (0)
-#define flush_cache_vunmap(start, end)		do { } while (0)
-
 #ifdef CONFIG_PPC_BOOK3S_64
 /*
  * Book3s has no ptesync after setting a pte, so without this ptesync it=
's
@@ -33,20 +19,20 @@ static inline void flush_cache_vmap(unsigned long sta=
rt, unsigned long end)
 {
 	asm volatile("ptesync" ::: "memory");
 }
-#else
-static inline void flush_cache_vmap(unsigned long start, unsigned long e=
nd) { }
-#endif
+#define flush_cache_vmap flush_cache_vmap
+#endif /* CONFIG_PPC_BOOK3S_64 */
=20
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 extern void flush_dcache_page(struct page *page);
-#define flush_dcache_mmap_lock(mapping)		do { } while (0)
-#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
=20
 void flush_icache_range(unsigned long start, unsigned long stop);
-extern void flush_icache_user_range(struct vm_area_struct *vma,
-				    struct page *page, unsigned long addr,
-				    int len);
-extern void flush_dcache_icache_page(struct page *page);
+#define flush_icache_range flush_icache_range
+
+void flush_icache_user_range(struct vm_area_struct *vma, struct page *pa=
ge,
+		unsigned long addr, int len);
+#define flush_icache_user_range flush_icache_user_range
+
+void flush_dcache_icache_page(struct page *page);
 void __flush_dcache_icache(void *page);
=20
 /**
@@ -111,14 +97,6 @@ static inline void invalidate_dcache_range(unsigned l=
ong start,
 	mb();	/* sync */
 }
=20
-#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
-	do { \
-		memcpy(dst, src, len); \
-		flush_icache_user_range(vma, page, vaddr, len); \
-	} while (0)
-#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
-
-#endif /* __KERNEL__ */
+#include <asm-generic/cacheflush.h>
=20
 #endif /* _ASM_POWERPC_CACHEFLUSH_H */
--=20
2.26.2
