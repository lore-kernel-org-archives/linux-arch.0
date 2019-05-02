From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 04/15] arm64: switch to generic version of pte allocation
Date: Thu,  2 May 2019 18:28:31 +0300
Message-ID: <1556810922-20248-5-git-send-email-rppt@linux.ibm.com>
References: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Ley Foon Tan <lftan@altera.com>, Matthew Wilcox <willy@infradead.org>, Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, Richard Kuo <rkuo@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hexag
List-Id: linux-arch.vger.kernel.org

The PTE allocations in arm64 are identical to the generic ones modulo the
GFP flags.

Using the generic pte_alloc_one() functions ensures that the user page
tables are allocated with __GFP_ACCOUNT set.

The arm64 definition of PGALLOC_GFP is removed and replaced with
GFP_PGTABLE_USER for p[gum]d_alloc_one() and for KVM memory cache.

The mappings created with create_pgd_mapping() are now using
GFP_PGTABLE_KERNEL.

The conversion to the generic version of pte_free_kernel() removes the NULL
check for pte.

The pte_free() version on arm64 is identical to the generic one and
can be simply dropped.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/include/asm/pgalloc.h | 43 ++++------------------------------------
 arch/arm64/mm/mmu.c              |  2 +-
 arch/arm64/mm/pgd.c              |  4 ++--
 virt/kvm/arm/mmu.c               |  2 +-
 4 files changed, 8 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 52fa47c..3293b8b 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -24,16 +24,17 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
+#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
+
 #define check_pgt_cache()		do { } while (0)
 
-#define PGALLOC_GFP	(GFP_KERNEL | __GFP_ZERO)
 #define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
 
 #if CONFIG_PGTABLE_LEVELS > 2
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return (pmd_t *)__get_free_page(PGALLOC_GFP);
+	return (pmd_t *)__get_free_page(GFP_PGTABLE_USER);
 }
 
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmdp)
@@ -62,7 +63,7 @@ static inline void __pud_populate(pud_t *pudp, phys_addr_t pmdp, pudval_t prot)
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return (pud_t *)__get_free_page(PGALLOC_GFP);
+	return (pud_t *)__get_free_page(GFP_PGTABLE_USER);
 }
 
 static inline void pud_free(struct mm_struct *mm, pud_t *pudp)
@@ -90,42 +91,6 @@ static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t pudp, pgdval_t prot)
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 extern void pgd_free(struct mm_struct *mm, pgd_t *pgdp);
 
-static inline pte_t *
-pte_alloc_one_kernel(struct mm_struct *mm)
-{
-	return (pte_t *)__get_free_page(PGALLOC_GFP);
-}
-
-static inline pgtable_t
-pte_alloc_one(struct mm_struct *mm)
-{
-	struct page *pte;
-
-	pte = alloc_pages(PGALLOC_GFP, 0);
-	if (!pte)
-		return NULL;
-	if (!pgtable_page_ctor(pte)) {
-		__free_page(pte);
-		return NULL;
-	}
-	return pte;
-}
-
-/*
- * Free a PTE table.
- */
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *ptep)
-{
-	if (ptep)
-		free_page((unsigned long)ptep);
-}
-
-static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
-{
-	pgtable_page_dtor(pte);
-	__free_page(pte);
-}
-
 static inline void __pmd_populate(pmd_t *pmdp, phys_addr_t ptep,
 				  pmdval_t prot)
 {
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e97f018..d5178c5 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -373,7 +373,7 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 
 static phys_addr_t pgd_pgtable_alloc(void)
 {
-	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
+	void *ptr = (void *)__get_free_page(GFP_PGTABLE_KERNEL);
 	if (!ptr || !pgtable_page_ctor(virt_to_page(ptr)))
 		BUG();
 
diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
index 289f911..2ef1a53 100644
--- a/arch/arm64/mm/pgd.c
+++ b/arch/arm64/mm/pgd.c
@@ -31,9 +31,9 @@ static struct kmem_cache *pgd_cache __ro_after_init;
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	if (PGD_SIZE == PAGE_SIZE)
-		return (pgd_t *)__get_free_page(PGALLOC_GFP);
+		return (pgd_t *)__get_free_page(GFP_PGTABLE_USER);
 	else
-		return kmem_cache_alloc(pgd_cache, PGALLOC_GFP);
+		return kmem_cache_alloc(pgd_cache, GFP_PGTABLE_USER);
 }
 
 void pgd_free(struct mm_struct *mm, pgd_t *pgd)
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 27c9583..9f6f638 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -141,7 +141,7 @@ static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
 	if (cache->nobjs >= min)
 		return 0;
 	while (cache->nobjs < max) {
-		page = (void *)__get_free_page(PGALLOC_GFP);
+		page = (void *)__get_free_page(GFP_PGTABLE_USER);
 		if (!page)
 			return -ENOMEM;
 		cache->objects[cache->nobjs++] = page;
-- 
2.7.4
