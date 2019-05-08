Return-Path: <linux-riscv-bounces+rppt=linux.ibm.com@lists.infradead.org>
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 01/14] asm-generic, x86: introduce generic pte_{alloc,
 free}_one[_kernel]
Date: Wed,  8 May 2019 09:16:58 +0300
In-Reply-To: <1557296232-15361-1-git-send-email-rppt@linux.ibm.com>
References: <1557296232-15361-1-git-send-email-rppt@linux.ibm.com>
Message-ID: <1557296232-15361-2-git-send-email-rppt@linux.ibm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+rppt=linux.ibm.com@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Palmer Dabbelt <palmer@sifive.com>, linux-mips@vger.kernel.org, linux-mm@kvack.org, Guo Ren <guoren@kernel.org>, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Matt Turner <mattst88@gmail.com>, Sam Creasey <sammy@sammy.net>, Arnd Bergmann <arnd@arndb.de>, Anshuman Khandual <anshuman.khandual@arm.com>, linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>, linux-m68k@lists.linux-m68k.org, Greentime Hu <green.hu@gmail.com>, nios2-dev@lists.rocketboards.org, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>, Paul Burton <paul.burton@mips.com>, linux-alpha@vger.kernel.org, Ley Foon Tan <lftan@altera.com>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20190508061658.lYGZg6zcS--9pPxqiAlRWDzzYDY5Ziu_U-vXEC7zOxk@z>

Most architectures have identical or very similar implementation of
pte_alloc_one_kernel(), pte_alloc_one(), pte_free_kernel() and pte_free().

Add a generic implementation that can be reused across architectures and
enable its use on x86.

The generic implementation uses

	GFP_KERNEL | __GFP_ZERO

for the kernel page tables and

	GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT

for the user page tables.

The "base" functions for PTE allocation, namely __pte_alloc_one_kernel()
and __pte_alloc_one() are intended for the architectures that require
additional actions after actual memory allocation or must use non-default
GFP flags.

x86 is switched to use generic pte_alloc_one_kernel(), pte_free_kernel() and
pte_free().

x86 still implements pte_alloc_one() to allow run-time control of GFP flags
required for "userpte" command line option.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/include/asm/pgalloc.h |  19 ++------
 arch/x86/mm/pgtable.c          |  33 ++++---------
 include/asm-generic/pgalloc.h  | 107 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 115 insertions(+), 44 deletions(-)

diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index a281e61..29aa785 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -6,6 +6,9 @@
 #include <linux/mm.h>		/* for struct page */
 #include <linux/pagemap.h>
 
+#define __HAVE_ARCH_PTE_ALLOC_ONE
+#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
+
 static inline int  __paravirt_pgd_alloc(struct mm_struct *mm) { return 0; }
 
 #ifdef CONFIG_PARAVIRT_XXL
@@ -47,24 +50,8 @@ extern gfp_t __userpte_alloc_gfp;
 extern pgd_t *pgd_alloc(struct mm_struct *);
 extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
 
-extern pte_t *pte_alloc_one_kernel(struct mm_struct *);
 extern pgtable_t pte_alloc_one(struct mm_struct *);
 
-/* Should really implement gc for free page table pages. This could be
-   done with a reference count in struct page. */
-
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-	BUG_ON((unsigned long)pte & (PAGE_SIZE-1));
-	free_page((unsigned long)pte);
-}
-
-static inline void pte_free(struct mm_struct *mm, struct page *pte)
-{
-	pgtable_page_dtor(pte);
-	__free_page(pte);
-}
-
 extern void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte);
 
 static inline void __pte_free_tlb(struct mmu_gather *tlb, struct page *pte,
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 1f67b1e..44816ff 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -13,33 +13,17 @@ phys_addr_t physical_mask __ro_after_init = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
 EXPORT_SYMBOL(physical_mask);
 #endif
 
-#define PGALLOC_GFP (GFP_KERNEL_ACCOUNT | __GFP_ZERO)
-
 #ifdef CONFIG_HIGHPTE
-#define PGALLOC_USER_GFP __GFP_HIGHMEM
+#define PGTABLE_HIGHMEM __GFP_HIGHMEM
 #else
-#define PGALLOC_USER_GFP 0
+#define PGTABLE_HIGHMEM 0
 #endif
 
-gfp_t __userpte_alloc_gfp = PGALLOC_GFP | PGALLOC_USER_GFP;
-
-pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
-{
-	return (pte_t *)__get_free_page(PGALLOC_GFP & ~__GFP_ACCOUNT);
-}
+gfp_t __userpte_alloc_gfp = GFP_PGTABLE_USER | PGTABLE_HIGHMEM;
 
 pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	struct page *pte;
-
-	pte = alloc_pages(__userpte_alloc_gfp, 0);
-	if (!pte)
-		return NULL;
-	if (!pgtable_page_ctor(pte)) {
-		__free_page(pte);
-		return NULL;
-	}
-	return pte;
+	return __pte_alloc_one(mm, __userpte_alloc_gfp);
 }
 
 static int __init setup_userpte(char *arg)
@@ -235,7 +219,7 @@ static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
 {
 	int i;
 	bool failed = false;
-	gfp_t gfp = PGALLOC_GFP;
+	gfp_t gfp = GFP_PGTABLE_USER;
 
 	if (mm == &init_mm)
 		gfp &= ~__GFP_ACCOUNT;
@@ -399,14 +383,14 @@ static inline pgd_t *_pgd_alloc(void)
 	 * We allocate one page for pgd.
 	 */
 	if (!SHARED_KERNEL_PMD)
-		return (pgd_t *)__get_free_pages(PGALLOC_GFP,
+		return (pgd_t *)__get_free_pages(GFP_PGTABLE_USER,
 						 PGD_ALLOCATION_ORDER);
 
 	/*
 	 * Now PAE kernel is not running as a Xen domain. We can allocate
 	 * a 32-byte slab for pgd to save memory space.
 	 */
-	return kmem_cache_alloc(pgd_cache, PGALLOC_GFP);
+	return kmem_cache_alloc(pgd_cache, GFP_PGTABLE_USER);
 }
 
 static inline void _pgd_free(pgd_t *pgd)
@@ -424,7 +408,8 @@ void __init pgd_cache_init(void)
 
 static inline pgd_t *_pgd_alloc(void)
 {
-	return (pgd_t *)__get_free_pages(PGALLOC_GFP, PGD_ALLOCATION_ORDER);
+	return (pgd_t *)__get_free_pages(GFP_PGTABLE_USER,
+					 PGD_ALLOCATION_ORDER);
 }
 
 static inline void _pgd_free(pgd_t *pgd)
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 948714c..8476175 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -1,13 +1,112 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_GENERIC_PGALLOC_H
 #define __ASM_GENERIC_PGALLOC_H
-/*
- * an empty file is enough for a nommu architecture
- */
+
 #ifdef CONFIG_MMU
-#error need to implement an architecture specific asm/pgalloc.h
+
+#define GFP_PGTABLE_KERNEL	(GFP_KERNEL | __GFP_ZERO)
+#define GFP_PGTABLE_USER	(GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)
+
+/**
+ * __pte_alloc_one_kernel - allocate a page for PTE-level kernel page table
+ * @mm: the mm_struct of the current context
+ *
+ * This function is intended for architectures that need
+ * anything beyond simple page allocation.
+ *
+ * Return: pointer to the allocated memory or %NULL on error
+ */
+static inline pte_t *__pte_alloc_one_kernel(struct mm_struct *mm)
+{
+	return (pte_t *)__get_free_page(GFP_PGTABLE_KERNEL);
+}
+
+#ifndef __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
+/**
+ * pte_alloc_one_kernel - allocate a page for PTE-level kernel page table
+ * @mm: the mm_struct of the current context
+ *
+ * Return: pointer to the allocated memory or %NULL on error
+ */
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
+{
+	return __pte_alloc_one_kernel(mm);
+}
+#endif
+
+/**
+ * pte_free_kernel - free PTE-level kernel page table page
+ * @mm: the mm_struct of the current context
+ * @pte: pointer to the memory containing the page table
+ */
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
+{
+	free_page((unsigned long)pte);
+}
+
+/**
+ * __pte_alloc_one - allocate a page for PTE-level user page table
+ * @mm: the mm_struct of the current context
+ * @gfp: GFP flags to use for the allocation
+ *
+ * Allocates a page and runs the pgtable_page_ctor().
+ *
+ * This function is intended for architectures that need
+ * anything beyond simple page allocation or must have custom GFP flags.
+ *
+ * Return: `struct page` initialized as page table or %NULL on error
+ */
+static inline pgtable_t __pte_alloc_one(struct mm_struct *mm, gfp_t gfp)
+{
+	struct page *pte;
+
+	pte = alloc_page(gfp);
+	if (!pte)
+		return NULL;
+	if (!pgtable_page_ctor(pte)) {
+		__free_page(pte);
+		return NULL;
+	}
+
+	return pte;
+}
+
+#ifndef __HAVE_ARCH_PTE_ALLOC_ONE
+/**
+ * pte_alloc_one - allocate a page for PTE-level user page table
+ * @mm: the mm_struct of the current context
+ *
+ * Allocates a page and runs the pgtable_page_ctor().
+ *
+ * Return: `struct page` initialized as page table or %NULL on error
+ */
+static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
+{
+	return __pte_alloc_one(mm, GFP_PGTABLE_USER);
+}
 #endif
 
+/*
+ * Should really implement gc for free page table pages. This could be
+ * done with a reference count in struct page.
+ */
+
+/**
+ * pte_free - free PTE-level user page table page
+ * @mm: the mm_struct of the current context
+ * @pte_page: the `struct page` representing the page table
+ */
+static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
+{
+	pgtable_page_dtor(pte_page);
+	__free_page(pte_page);
+}
+
+#else /* CONFIG_MMU */
+
+/* This is enough for a nommu architecture */
 #define check_pgt_cache()          do { } while (0)
 
+#endif /* CONFIG_MMU */
+
 #endif /* __ASM_GENERIC_PGALLOC_H */
-- 
2.7.4


_______________________________________________
linux-riscv mailing list
linux-riscv@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-riscv
