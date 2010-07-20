From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 3/5] ARM: Introduce __sync_icache_dcache() for VIPT caches
Date: Tue, 20 Jul 2010 18:12:18 +0100
Message-ID: <20100720171218.19582.39177.stgit@e102109-lin.cambridge.arm.com>
References: <20100720171201.19582.85920.stgit@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:38912 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754814Ab0GTRM1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Jul 2010 13:12:27 -0400
In-Reply-To: <20100720171201.19582.85920.stgit@e102109-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Rabin Vincent <rabin.vincent@stericsson.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>

On SMP systems, there is a small chance of a PTE becoming visible to a
different CPU before the current cache maintenance operations in
update_mmu_cache(). To avoid this, cache maintenance must be handled in
set_pte_at() (similar to IA-64 and PowerPC).

This patch provides a unified VIPT cache handling mechanism and
implements the __sync_icache_dcache() function for ARMv6 onwards
architectures. It is called from set_pte_at() and replaces the
update_mmu_cache(). The latter is still used on VIVT hardware where a
vm_area_struct is required.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Rabin Vincent <rabin.vincent@stericsson.com>
Cc: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/pgtable.h  |   26 +++++++++++++++++++++++---
 arch/arm/include/asm/tlbflush.h |   10 +++++++++-
 arch/arm/mm/fault-armv.c        |    4 ++--
 arch/arm/mm/flush.c             |   30 ++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index ab68cf1..42e694f 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -278,9 +278,24 @@ extern struct page *empty_zero_page;
 
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
 
-#define set_pte_at(mm,addr,ptep,pteval) do { \
-	set_pte_ext(ptep, pteval, (addr) >= TASK_SIZE ? 0 : PTE_EXT_NG); \
- } while (0)
+#if __LINUX_ARM_ARCH__ < 6
+static inline void __sync_icache_dcache(pte_t pteval)
+{
+}
+#else
+extern void __sync_icache_dcache(pte_t pteval);
+#endif
+
+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pteval)
+{
+	if (addr >= TASK_SIZE)
+		set_pte_ext(ptep, pteval, 0);
+	else {
+		__sync_icache_dcache(pteval);
+		set_pte_ext(ptep, pteval, PTE_EXT_NG);
+	}
+}
 
 /*
  * The following only work if pte_present() is true.
@@ -290,8 +305,13 @@ extern struct page *empty_zero_page;
 #define pte_write(pte)		(pte_val(pte) & L_PTE_WRITE)
 #define pte_dirty(pte)		(pte_val(pte) & L_PTE_DIRTY)
 #define pte_young(pte)		(pte_val(pte) & L_PTE_YOUNG)
+#define pte_exec(pte)		(pte_val(pte) & L_PTE_EXEC)
 #define pte_special(pte)	(0)
 
+#define pte_present_user(pte) \
+	((pte_val(pte) & (L_PTE_PRESENT | L_PTE_USER)) == \
+	 (L_PTE_PRESENT | L_PTE_USER))
+
 #define PTE_BIT_FUNC(fn,op) \
 static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
 
diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 40a7092..8ec4775 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -554,10 +554,18 @@ extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 /*
  * If PG_dcache_clean is not set for the page, we need to ensure that any
  * cache entries for the kernels virtual memory range are written
- * back to the page.
+ * back to the page. On ARMv6 and later, the cache coherency is handled via
+ * the set_pte_at() function.
  */
+#if __LINUX_ARM_ARCH__ < 6
 extern void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
 	pte_t *ptep);
+#else
+static inline void update_mmu_cache(struct vm_area_struct *vma,
+				    unsigned long addr, pte_t *ptep)
+{
+}
+#endif
 
 #endif
 
diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 58846cb..8440d95 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -28,6 +28,7 @@
 
 static unsigned long shared_pte_mask = L_PTE_MT_BUFFERABLE;
 
+#if __LINUX_ARM_ARCH__ < 6
 /*
  * We take the easy way out of this problem - we make the
  * PTE uncacheable.  However, we leave the write buffer on.
@@ -168,10 +169,8 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
 		return;
 
 	mapping = page_mapping(page);
-#ifndef CONFIG_SMP
 	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
 		__flush_dcache_page(mapping, page);
-#endif
 	if (mapping) {
 		if (cache_is_vivt())
 			make_coherent(mapping, vma, addr, ptep, pfn);
@@ -179,6 +178,7 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
 			__flush_icache_all();
 	}
 }
+#endif	/* __LINUX_ARM_ARCH__ < 6 */
 
 /*
  * Check whether the write buffer has physical address aliasing
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index b4efce9..dd5b012 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -215,6 +215,36 @@ static void __flush_dcache_aliases(struct address_space *mapping, struct page *p
 	flush_dcache_mmap_unlock(mapping);
 }
 
+#if __LINUX_ARM_ARCH__ >= 6
+void __sync_icache_dcache(pte_t pteval)
+{
+	unsigned long pfn;
+	struct page *page;
+	struct address_space *mapping;
+
+	if (!pte_present_user(pteval))
+		return;
+	if (cache_is_vipt_nonaliasing() && !pte_exec(pteval))
+		/* only flush non-aliasing VIPT caches for exec mappings */
+		return;
+	pfn = pte_pfn(pteval);
+	if (!pfn_valid(pfn))
+		return;
+
+	page = pfn_to_page(pfn);
+	if (cache_is_vipt_aliasing())
+		mapping = page_mapping(page);
+	else
+		mapping = NULL;
+
+	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
+		__flush_dcache_page(mapping, page);
+	/* pte_exec() already checked above for non-aliasing VIPT cache */
+	if (cache_is_vipt_nonaliasing() || pte_exec(pteval))
+		__flush_icache_all();
+}
+#endif
+
 /*
  * Ensure cache coherency between kernel mapping and userspace mapping
  * of this page.
