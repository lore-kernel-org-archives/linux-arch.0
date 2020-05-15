Return-Path: <SRS0=nPx+=65=kvack.org=owner-linux-mm@kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 19/29] mm: rename flush_icache_user_range to flush_icache_user_page
Date: Fri, 15 May 2020 16:36:36 +0200
Message-ID: <20200515143646.3857579-20-hch@lst.de>
In-Reply-To: <20200515143646.3857579-1-hch@lst.de>
References: <20200515143646.3857579-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200515143636.d3BZX_LRq4mToFfHupyKOpIDe9_VtWEyzu4DiYZQthc@z>

The function currently known as flush_icache_user_range only operates
on a single page.  Rename it to flush_icache_user_page as we'll need
the name flush_icache_user_range for something else soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/alpha/include/asm/cacheflush.h    | 10 +++++-----
 arch/alpha/kernel/smp.c                |  2 +-
 arch/ia64/include/asm/cacheflush.h     |  2 +-
 arch/m68k/include/asm/cacheflush_mm.h  |  4 ++--
 arch/m68k/mm/cache.c                   |  2 +-
 arch/nds32/include/asm/cacheflush.h    |  4 ++--
 arch/nds32/mm/cacheflush.c             |  2 +-
 arch/openrisc/include/asm/cacheflush.h |  2 +-
 arch/powerpc/include/asm/cacheflush.h  |  4 ++--
 arch/powerpc/mm/mem.c                  |  2 +-
 arch/riscv/include/asm/cacheflush.h    |  3 ++-
 include/asm-generic/cacheflush.h       |  6 +++---
 kernel/events/uprobes.c                |  2 +-
 13 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/arch/alpha/include/asm/cacheflush.h b/arch/alpha/include/asm=
/cacheflush.h
index 636d7ca0d05f6..9945ff483eaf7 100644
--- a/arch/alpha/include/asm/cacheflush.h
+++ b/arch/alpha/include/asm/cacheflush.h
@@ -35,7 +35,7 @@ extern void smp_imb(void);
=20
 extern void __load_new_mm_context(struct mm_struct *);
 static inline void
-flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 			unsigned long addr, int len)
 {
 	if (vma->vm_flags & VM_EXEC) {
@@ -46,16 +46,16 @@ flush_icache_user_range(struct vm_area_struct *vma, s=
truct page *page,
 			mm->context[smp_processor_id()] =3D 0;
 	}
 }
-#define flush_icache_user_range flush_icache_user_range
+#define flush_icache_user_page flush_icache_user_page
 #else /* CONFIG_SMP */
-extern void flush_icache_user_range(struct vm_area_struct *vma,
+extern void flush_icache_user_page(struct vm_area_struct *vma,
 		struct page *page, unsigned long addr, int len);
-#define flush_icache_user_range flush_icache_user_range
+#define flush_icache_user_page flush_icache_user_page
 #endif /* CONFIG_SMP */
=20
 /* This is used only in __do_fault and do_swap_page.  */
 #define flush_icache_page(vma, page) \
-	flush_icache_user_range((vma), (page), 0, 0)
+	flush_icache_user_page((vma), (page), 0, 0)
=20
 #include <asm-generic/cacheflush.h>
=20
diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 5f90df30be20a..52995bf413fea 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -740,7 +740,7 @@ ipi_flush_icache_page(void *x)
 }
=20
 void
-flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 			unsigned long addr, int len)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
diff --git a/arch/ia64/include/asm/cacheflush.h b/arch/ia64/include/asm/c=
acheflush.h
index a8f1c86ac242a..708c0fa5d975e 100644
--- a/arch/ia64/include/asm/cacheflush.h
+++ b/arch/ia64/include/asm/cacheflush.h
@@ -22,7 +22,7 @@ extern void flush_icache_range(unsigned long start, uns=
igned long end);
 #define flush_icache_range flush_icache_range
 extern void clflush_cache_range(void *addr, int size);
=20
-#define flush_icache_user_range(vma, page, user_addr, len)					\
+#define flush_icache_user_page(vma, page, user_addr, len)					\
 do {												\
 	unsigned long _addr =3D (unsigned long) page_address(page) + ((user_add=
r) & ~PAGE_MASK);	\
 	flush_icache_range(_addr, _addr + (len));						\
diff --git a/arch/m68k/include/asm/cacheflush_mm.h b/arch/m68k/include/as=
m/cacheflush_mm.h
index 1e2544ecaf88c..95376bf84faa5 100644
--- a/arch/m68k/include/asm/cacheflush_mm.h
+++ b/arch/m68k/include/asm/cacheflush_mm.h
@@ -254,7 +254,7 @@ static inline void __flush_page_to_ram(void *vaddr)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 #define flush_icache_page(vma, page)	__flush_page_to_ram(page_address(pa=
ge))
=20
-extern void flush_icache_user_range(struct vm_area_struct *vma, struct p=
age *page,
+extern void flush_icache_user_page(struct vm_area_struct *vma, struct pa=
ge *page,
 				    unsigned long addr, int len);
 extern void flush_icache_range(unsigned long address, unsigned long enda=
ddr);
=20
@@ -264,7 +264,7 @@ static inline void copy_to_user_page(struct vm_area_s=
truct *vma,
 {
 	flush_cache_page(vma, vaddr, page_to_pfn(page));
 	memcpy(dst, src, len);
-	flush_icache_user_range(vma, page, vaddr, len);
+	flush_icache_user_page(vma, page, vaddr, len);
 }
 static inline void copy_from_user_page(struct vm_area_struct *vma,
 				       struct page *page, unsigned long vaddr,
diff --git a/arch/m68k/mm/cache.c b/arch/m68k/mm/cache.c
index 079e64898e6a5..99057cd5ff7f1 100644
--- a/arch/m68k/mm/cache.c
+++ b/arch/m68k/mm/cache.c
@@ -106,7 +106,7 @@ void flush_icache_range(unsigned long address, unsign=
ed long endaddr)
 }
 EXPORT_SYMBOL(flush_icache_range);
=20
-void flush_icache_user_range(struct vm_area_struct *vma, struct page *pa=
ge,
+void flush_icache_user_page(struct vm_area_struct *vma, struct page *pag=
e,
 			     unsigned long addr, int len)
 {
 	if (CPU_IS_COLDFIRE) {
diff --git a/arch/nds32/include/asm/cacheflush.h b/arch/nds32/include/asm=
/cacheflush.h
index caddded56e77f..7d6824f7c0e8d 100644
--- a/arch/nds32/include/asm/cacheflush.h
+++ b/arch/nds32/include/asm/cacheflush.h
@@ -44,9 +44,9 @@ void invalidate_kernel_vmap_range(void *addr, int size)=
;
 #define flush_dcache_mmap_unlock(mapping) xa_unlock_irq(&(mapping)->i_pa=
ges)
=20
 #else
-void flush_icache_user_range(struct vm_area_struct *vma, struct page *pa=
ge,
+void flush_icache_user_page(struct vm_area_struct *vma, struct page *pag=
e,
 	                     unsigned long addr, int len);
-#define flush_icache_user_range flush_icache_user_range
+#define flush_icache_user_page flush_icache_user_page
=20
 #include <asm-generic/cacheflush.h>
 #endif
diff --git a/arch/nds32/mm/cacheflush.c b/arch/nds32/mm/cacheflush.c
index 8f168b33065fa..6eb98a7ad27d2 100644
--- a/arch/nds32/mm/cacheflush.c
+++ b/arch/nds32/mm/cacheflush.c
@@ -36,7 +36,7 @@ void flush_icache_page(struct vm_area_struct *vma, stru=
ct page *page)
 	local_irq_restore(flags);
 }
=20
-void flush_icache_user_range(struct vm_area_struct *vma, struct page *pa=
ge,
+void flush_icache_user_page(struct vm_area_struct *vma, struct page *pag=
e,
 	                     unsigned long addr, int len)
 {
 	unsigned long kaddr;
diff --git a/arch/openrisc/include/asm/cacheflush.h b/arch/openrisc/inclu=
de/asm/cacheflush.h
index 74d1fce4e8839..eeac40d4a8547 100644
--- a/arch/openrisc/include/asm/cacheflush.h
+++ b/arch/openrisc/include/asm/cacheflush.h
@@ -62,7 +62,7 @@ static inline void flush_dcache_page(struct page *page)
 	clear_bit(PG_dc_clean, &page->flags);
 }
=20
-#define flush_icache_user_range(vma, page, addr, len)	\
+#define flush_icache_user_page(vma, page, addr, len)	\
 do {							\
 	if (vma->vm_flags & VM_EXEC)			\
 		sync_icache_dcache(page);		\
diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include=
/asm/cacheflush.h
index e682c8e10e903..de600b915a3c5 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -28,9 +28,9 @@ extern void flush_dcache_page(struct page *page);
 void flush_icache_range(unsigned long start, unsigned long stop);
 #define flush_icache_range flush_icache_range
=20
-void flush_icache_user_range(struct vm_area_struct *vma, struct page *pa=
ge,
+void flush_icache_user_page(struct vm_area_struct *vma, struct page *pag=
e,
 		unsigned long addr, int len);
-#define flush_icache_user_range flush_icache_user_range
+#define flush_icache_user_page flush_icache_user_page
=20
 void flush_dcache_icache_page(struct page *page);
 void __flush_dcache_icache(void *page);
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index f0d1bf0a8e14f..d1ad0b9b19281 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -578,7 +578,7 @@ void copy_user_page(void *vto, void *vfrom, unsigned =
long vaddr,
 	flush_dcache_page(pg);
 }
=20
-void flush_icache_user_range(struct vm_area_struct *vma, struct page *pa=
ge,
+void flush_icache_user_page(struct vm_area_struct *vma, struct page *pag=
e,
 			     unsigned long addr, int len)
 {
 	unsigned long maddr;
diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm=
/cacheflush.h
index a167b4fbdf007..23ff703509926 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -27,7 +27,8 @@ static inline void flush_dcache_page(struct page *page)
  * so instead we just flush the whole thing.
  */
 #define flush_icache_range(start, end) flush_icache_all()
-#define flush_icache_user_range(vma, pg, addr, len) flush_icache_mm(vma-=
>vm_mm, 0)
+#define flush_icache_user_page(vma, pg, addr, len) \
+	flush_icache_mm(vma->vm_mm, 0)
=20
 #ifndef CONFIG_SMP
=20
diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cache=
flush.h
index bbbb4d4ef6516..2c9686fefb715 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -73,8 +73,8 @@ static inline void flush_icache_page(struct vm_area_str=
uct *vma,
 }
 #endif
=20
-#ifndef flush_icache_user_range
-static inline void flush_icache_user_range(struct vm_area_struct *vma,
+#ifndef flush_icache_user_page
+static inline void flush_icache_user_page(struct vm_area_struct *vma,
 					   struct page *page,
 					   unsigned long addr, int len)
 {
@@ -97,7 +97,7 @@ static inline void flush_cache_vunmap(unsigned long sta=
rt, unsigned long end)
 #define copy_to_user_page(vma, page, vaddr, dst, src, len)	\
 	do { \
 		memcpy(dst, src, len); \
-		flush_icache_user_range(vma, page, vaddr, len); \
+		flush_icache_user_page(vma, page, vaddr, len); \
 	} while (0)
 #endif
=20
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ece7e13f6e4ac..2e5effbda86b0 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1674,7 +1674,7 @@ void __weak arch_uprobe_copy_ixol(struct page *page=
, unsigned long vaddr,
 	copy_to_page(page, vaddr, src, len);
=20
 	/*
-	 * We probably need flush_icache_user_range() but it needs vma.
+	 * We probably need flush_icache_user_page() but it needs vma.
 	 * This should work on most of architectures by default. If
 	 * architecture needs to do something different it can define
 	 * its own version of the function.
--=20
2.26.2
