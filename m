Return-Path: <SRS0=y3dn=6Y=kvack.org=owner-linux-mm@kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 13/31] hexagon: use asm-generic/cacheflush.h
Date: Sun, 10 May 2020 09:54:52 +0200
Message-ID: <20200510075510.987823-14-hch@lst.de>
In-Reply-To: <20200510075510.987823-1-hch@lst.de>
References: <20200510075510.987823-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200510075452.Ta96Cw_0svMYncpZTcftH53zyYyVht8GJOmKeWRkXxw@z>

Hexagon needs almost no cache flushing routines of its own.  Rely on
asm-generic/cacheflush.h for the defaults.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/hexagon/include/asm/cacheflush.h | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/hexagon/include/asm/cacheflush.h b/arch/hexagon/include=
/asm/cacheflush.h
index fb447de45d54c..6eff0730e6efd 100644
--- a/arch/hexagon/include/asm/cacheflush.h
+++ b/arch/hexagon/include/asm/cacheflush.h
@@ -25,29 +25,17 @@
 #define LINESIZE	32
 #define LINEBITS	5
=20
-#define flush_cache_all()			do { } while (0)
-#define flush_cache_mm(mm)			do { } while (0)
-#define flush_cache_dup_mm(mm)			do { } while (0)
-#define flush_cache_range(vma, start, end)	do { } while (0)
-#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
-#define flush_dcache_page(page)			do { } while (0)
-#define flush_dcache_mmap_lock(mapping)		do { } while (0)
-#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
-#define flush_icache_page(vma, pg)		do { } while (0)
-#define flush_icache_user_range(vma, pg, adr, len)	do { } while (0)
-#define flush_cache_vmap(start, end)		do { } while (0)
-#define flush_cache_vunmap(start, end)		do { } while (0)
-
 /*
  * Flush Dcache range through current map.
  */
 extern void flush_dcache_range(unsigned long start, unsigned long end);
+#define flush_dcache_range flush_dcache_range
=20
 /*
  * Flush Icache range through current map.
  */
 extern void flush_icache_range(unsigned long start, unsigned long end);
+#define flush_icache_range flush_icache_range
=20
 /*
  * Memory-management related flushes are there to ensure in non-physical=
ly
@@ -78,6 +66,7 @@ static inline void update_mmu_cache(struct vm_area_stru=
ct *vma,
=20
 void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
 		       unsigned long vaddr, void *dst, void *src, int len);
+#define copy_to_user_page copy_to_user_page
=20
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
 	memcpy(dst, src, len)
@@ -85,4 +74,6 @@ void copy_to_user_page(struct vm_area_struct *vma, stru=
ct page *page,
 extern void hexagon_inv_dcache_range(unsigned long start, unsigned long =
end);
 extern void hexagon_clean_dcache_range(unsigned long start, unsigned lon=
g end);
=20
+#include <asm-generic/cacheflush.h>
+
 #endif
--=20
2.26.2
