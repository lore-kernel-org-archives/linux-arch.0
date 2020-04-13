From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 3/4] mm: HUGE_VMAP arch query functions cleanup
Date: Mon, 13 Apr 2020 22:53:02 +1000
Message-ID: <20200413125303.423864-4-npiggin@gmail.com>
References: <20200413125303.423864-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200413125303.423864-1-npiggin@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

This changes the awkward approach where architectures provide init
functions to determine which levels they can provide large mappings for,
to one where the arch is queried for each call.

This allows odd configurations to be allowed (PUD but not PMD), and will
make it easier to constant-fold dead code away if the arch inlines
unsupported levels.

This also adds a prot argument to the arch query. This is unused
currently but could help with some architectures (some powerpc
implementations can't map uncacheable memory with large pages for
example).

The name is changed from ioremap to vmap, as it will be used more
generally in the next patch.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/arm64/mm/mmu.c                      |  8 ++--
 arch/powerpc/mm/book3s64/radix_pgtable.c |  6 +--
 arch/x86/mm/ioremap.c                    |  6 +--
 include/linux/io.h                       |  3 --
 include/linux/vmalloc.h                  | 10 +++++
 lib/ioremap.c                            | 51 ++----------------------
 mm/vmalloc.c                             |  9 +++++
 7 files changed, 33 insertions(+), 60 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a374e4f51a62..b8e381c46fa1 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1244,12 +1244,12 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
 	return dt_virt;
 }
 
-int __init arch_ioremap_p4d_supported(void)
+bool arch_vmap_p4d_supported(pgprot_t prot)
 {
 	return 0;
 }
 
-int __init arch_ioremap_pud_supported(void)
+bool arch_vmap_pud_supported(pgprot_t prot)
 {
 	/*
 	 * Only 4k granule supports level 1 block mappings.
@@ -1259,9 +1259,9 @@ int __init arch_ioremap_pud_supported(void)
 	       !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
 }
 
-int __init arch_ioremap_pmd_supported(void)
+bool arch_vmap_pmd_supported(pgprot_t prot)
 {
-	/* See arch_ioremap_pud_supported() */
+	/* See arch_vmap_pud_supported() */
 	return !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
 }
 
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 8f9edf07063a..5130e7912dd4 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1091,13 +1091,13 @@ void radix__ptep_modify_prot_commit(struct vm_area_struct *vma,
 	set_pte_at(mm, addr, ptep, pte);
 }
 
-int __init arch_ioremap_pud_supported(void)
+bool arch_vmap_pud_supported(pgprot_t prot)
 {
 	/* HPT does not cope with large pages in the vmalloc area */
 	return radix_enabled();
 }
 
-int __init arch_ioremap_pmd_supported(void)
+bool arch_vmap_pmd_supported(pgprot_t prot)
 {
 	return radix_enabled();
 }
@@ -1191,7 +1191,7 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 	return 1;
 }
 
-int __init arch_ioremap_p4d_supported(void)
+bool arch_vmap_p4d_supported(pgprot_t prot)
 {
 	return 0;
 }
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 18c637c0dc6f..bb4b75c344e4 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -481,12 +481,12 @@ void iounmap(volatile void __iomem *addr)
 }
 EXPORT_SYMBOL(iounmap);
 
-int __init arch_ioremap_p4d_supported(void)
+bool arch_vmap_p4d_supported(pgprot_t prot)
 {
 	return 0;
 }
 
-int __init arch_ioremap_pud_supported(void)
+bool arch_vmap_pud_supported(pgprot_t prot)
 {
 #ifdef CONFIG_X86_64
 	return boot_cpu_has(X86_FEATURE_GBPAGES);
@@ -495,7 +495,7 @@ int __init arch_ioremap_pud_supported(void)
 #endif
 }
 
-int __init arch_ioremap_pmd_supported(void)
+bool arch_vmap_pmd_supported(pgprot_t prot)
 {
 	return boot_cpu_has(X86_FEATURE_PSE);
 }
diff --git a/include/linux/io.h b/include/linux/io.h
index 8394c56babc2..2832e051bc2e 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -33,9 +33,6 @@ static inline int ioremap_page_range(unsigned long addr, unsigned long end,
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
 void __init ioremap_huge_init(void);
-int arch_ioremap_p4d_supported(void);
-int arch_ioremap_pud_supported(void);
-int arch_ioremap_pmd_supported(void);
 #else
 static inline void ioremap_huge_init(void) { }
 #endif
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index eb8a5080e472..291313a7e663 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -84,6 +84,16 @@ struct vmap_area {
 	};
 };
 
+#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
+bool arch_vmap_p4d_supported(pgprot_t prot);
+bool arch_vmap_pud_supported(pgprot_t prot);
+bool arch_vmap_pmd_supported(pgprot_t prot);
+#else
+static inline bool arch_vmap_p4d_supported(pgprot_t prot) { return false; }
+static inline bool arch_vmap_pud_supported(pgprot_t prot) { return false; }
+static inline bool arch_vmap_pmd_supported(prprot_t prot) { return false; }
+#endif
+
 /*
  *	Highlevel APIs for driver use
  */
diff --git a/lib/ioremap.c b/lib/ioremap.c
index 7e383bdc51ad..0a1ddf1a1286 100644
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -14,10 +14,9 @@
 #include <asm/cacheflush.h>
 #include <asm/pgtable.h>
 
+static unsigned int __read_mostly max_page_shift = PAGE_SHIFT;
+
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
-static int __read_mostly ioremap_p4d_capable;
-static int __read_mostly ioremap_pud_capable;
-static int __read_mostly ioremap_pmd_capable;
 static int __read_mostly ioremap_huge_disabled;
 
 static int __init set_nohugeiomap(char *str)
@@ -29,56 +28,14 @@ early_param("nohugeiomap", set_nohugeiomap);
 
 void __init ioremap_huge_init(void)
 {
-	if (!ioremap_huge_disabled) {
-		if (arch_ioremap_p4d_supported())
-			ioremap_p4d_capable = 1;
-		if (arch_ioremap_pud_supported())
-			ioremap_pud_capable = 1;
-		if (arch_ioremap_pmd_supported())
-			ioremap_pmd_capable = 1;
-	}
-}
-
-static inline int ioremap_p4d_enabled(void)
-{
-	return ioremap_p4d_capable;
-}
-
-static inline int ioremap_pud_enabled(void)
-{
-	return ioremap_pud_capable;
+	if (!ioremap_huge_disabled)
+		max_page_shift = P4D_SHIFT;
 }
-
-static inline int ioremap_pmd_enabled(void)
-{
-	return ioremap_pmd_capable;
-}
-
-#else	/* !CONFIG_HAVE_ARCH_HUGE_VMAP */
-static inline int ioremap_p4d_enabled(void) { return 0; }
-static inline int ioremap_pud_enabled(void) { return 0; }
-static inline int ioremap_pmd_enabled(void) { return 0; }
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
 
 int ioremap_page_range(unsigned long addr,
 		       unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
 {
-	unsigned int max_page_shift = PAGE_SHIFT;
-
-	/*
-	 * Due to the max_page_shift parameter to vmap_range, platforms must
-	 * enable all smaller sizes to take advantage of a given size,
-	 * otherwise fall back to small pages.
-	 */
-	if (ioremap_pmd_enabled()) {
-		max_page_shift = PMD_SHIFT;
-		if (ioremap_pud_enabled()) {
-			max_page_shift = PUD_SHIFT;
-			if (ioremap_p4d_enabled())
-				max_page_shift = P4D_SHIFT;
-		}
-	}
-
 	return vmap_range(addr, end, phys_addr, prot, max_page_shift);
 }
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b1bc2fcae4e0..c898d16ddd25 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -171,6 +171,9 @@ static int vmap_try_huge_pmd(pmd_t *pmd, unsigned long addr, unsigned long end,
 	if (max_page_shift < PMD_SHIFT)
 		return 0;
 
+	if (!arch_vmap_pmd_supported(prot))
+		return 0;
+
 	if ((end - addr) != PMD_SIZE)
 		return 0;
 
@@ -219,6 +222,9 @@ static int vmap_try_huge_pud(pud_t *pud, unsigned long addr,
 	if (max_page_shift < PUD_SHIFT)
 		return 0;
 
+	if (!arch_vmap_pud_supported(prot))
+		return 0;
+
 	if ((end - addr) != PUD_SIZE)
 		return 0;
 
@@ -268,6 +274,9 @@ static int vmap_try_huge_p4d(p4d_t *p4d, unsigned long addr,
 	if (max_page_shift < P4D_SHIFT)
 		return 0;
 
+	if (!arch_vmap_p4d_supported(prot))
+		return 0;
+
 	if ((end - addr) != P4D_SIZE)
 		return 0;
 
-- 
2.23.0
