Return-Path: <SRS0=nPx+=65=kvack.org=owner-linux-mm@kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/29] c6x: use asm-generic/cacheflush.h
Date: Fri, 15 May 2020 16:36:27 +0200
Message-ID: <20200515143646.3857579-11-hch@lst.de>
In-Reply-To: <20200515143646.3857579-1-hch@lst.de>
References: <20200515143646.3857579-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200515143627.gHyZFo7UnKTVGQp-98-c_6C-psnDFsyS5I-gpHatnJ8@z>

C6x needs almost no cache flushing routines of its own.  Rely on
asm-generic/cacheflush.h for the defaults.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/c6x/include/asm/cacheflush.h | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/c6x/include/asm/cacheflush.h b/arch/c6x/include/asm/cac=
heflush.h
index 4540b40475e6c..10922d528de6d 100644
--- a/arch/c6x/include/asm/cacheflush.h
+++ b/arch/c6x/include/asm/cacheflush.h
@@ -16,21 +16,6 @@
 #include <asm/page.h>
 #include <asm/string.h>
=20
-/*
- * virtually-indexed cache management (our cache is physically indexed)
- */
-#define flush_cache_all()			do {} while (0)
-#define flush_cache_mm(mm)			do {} while (0)
-#define flush_cache_dup_mm(mm)			do {} while (0)
-#define flush_cache_range(mm, start, end)	do {} while (0)
-#define flush_cache_page(vma, vmaddr, pfn)	do {} while (0)
-#define flush_cache_vmap(start, end)		do {} while (0)
-#define flush_cache_vunmap(start, end)		do {} while (0)
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
-#define flush_dcache_page(page)			do {} while (0)
-#define flush_dcache_mmap_lock(mapping)		do {} while (0)
-#define flush_dcache_mmap_unlock(mapping)	do {} while (0)
-
 /*
  * physically-indexed cache management
  */
@@ -49,14 +34,12 @@ do {								  \
 			(unsigned long) page_address(page) + PAGE_SIZE)); \
 } while (0)
=20
-
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
 do {						     \
 	memcpy(dst, src, len);			     \
 	flush_icache_range((unsigned) (dst), (unsigned) (dst) + (len)); \
 } while (0)
=20
-#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
+#include <asm-generic/cacheflush.h>
=20
 #endif /* _ASM_C6X_CACHEFLUSH_H */
--=20
2.26.2
