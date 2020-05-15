Return-Path: <SRS0=nPx+=65=kvack.org=owner-linux-mm@kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 15/29] openrisc: use asm-generic/cacheflush.h
Date: Fri, 15 May 2020 16:36:32 +0200
Message-ID: <20200515143646.3857579-16-hch@lst.de>
In-Reply-To: <20200515143646.3857579-1-hch@lst.de>
References: <20200515143646.3857579-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200515143632.Iz1RWEvchvEdvJM2OHvTesk7aZT69HGbRcLXSpDGbwA@z>

OpenRISC needs almost no cache flushing routines of its own.  Rely on
asm-generic/cacheflush.h for the defaults.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/include/asm/cacheflush.h | 31 +++++---------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/arch/openrisc/include/asm/cacheflush.h b/arch/openrisc/inclu=
de/asm/cacheflush.h
index 79d5d7753fe4b..74d1fce4e8839 100644
--- a/arch/openrisc/include/asm/cacheflush.h
+++ b/arch/openrisc/include/asm/cacheflush.h
@@ -62,31 +62,12 @@ static inline void flush_dcache_page(struct page *pag=
e)
 	clear_bit(PG_dc_clean, &page->flags);
 }
=20
-/*
- * Other interfaces are not required since we do not have virtually
- * indexed or tagged caches. So we can use the default here.
- */
-#define flush_cache_all()				do { } while (0)
-#define flush_cache_mm(mm)				do { } while (0)
-#define flush_cache_dup_mm(mm)				do { } while (0)
-#define flush_cache_range(vma, start, end)		do { } while (0)
-#define flush_cache_page(vma, vmaddr, pfn)		do { } while (0)
-#define flush_dcache_mmap_lock(mapping)			do { } while (0)
-#define flush_dcache_mmap_unlock(mapping)		do { } while (0)
-#define flush_icache_range(start, end)			do { } while (0)
-#define flush_icache_page(vma, pg)			do { } while (0)
-#define flush_icache_user_range(vma, pg, adr, len)	do { } while (0)
-#define flush_cache_vmap(start, end)			do { } while (0)
-#define flush_cache_vunmap(start, end)			do { } while (0)
-
-#define copy_to_user_page(vma, page, vaddr, dst, src, len)           \
-	do {                                                         \
-		memcpy(dst, src, len);                               \
-		if (vma->vm_flags & VM_EXEC)                         \
-			sync_icache_dcache(page);                    \
-	} while (0)
+#define flush_icache_user_range(vma, page, addr, len)	\
+do {							\
+	if (vma->vm_flags & VM_EXEC)			\
+		sync_icache_dcache(page);		\
+} while (0)
=20
-#define copy_from_user_page(vma, page, vaddr, dst, src, len)         \
-	memcpy(dst, src, len)
+#include <asm-generic/cacheflush.h>
=20
 #endif /* __ASM_CACHEFLUSH_H */
--=20
2.26.2
