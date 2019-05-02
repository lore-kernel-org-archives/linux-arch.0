From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 12/15] powerpc/nohash/64: switch to generic version of pte allocation
Date: Thu,  2 May 2019 18:28:39 +0300
Message-ID: <1556810922-20248-13-git-send-email-rppt@linux.ibm.com>
References: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Ley Foon Tan <lftan@altera.com>, Matthew Wilcox <willy@infradead.org>, Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, Richard Kuo <rkuo@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hexag
List-Id: linux-arch.vger.kernel.org

The 64-bit book-E powerpc implements pte_alloc_one(),
pte_alloc_one_kernel(), pte_free_kernel() and pte_free() the same way as
the generic version.

Switch it to the generic version that does exactly the same thing.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/powerpc/include/asm/nohash/64/pgalloc.h | 35 ++--------------------------
 1 file changed, 2 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
index 66d086f..bfb53a0 100644
--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
@@ -11,6 +11,8 @@
 #include <linux/cpumask.h>
 #include <linux/percpu.h>
 
+#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
+
 struct vmemmap_backing {
 	struct vmemmap_backing *list;
 	unsigned long phys;
@@ -92,39 +94,6 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 	kmem_cache_free(PGT_CACHE(PMD_CACHE_INDEX), pmd);
 }
 
-
-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
-{
-	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
-}
-
-static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
-{
-	struct page *page;
-	pte_t *pte;
-
-	pte = (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT);
-	if (!pte)
-		return NULL;
-	page = virt_to_page(pte);
-	if (!pgtable_page_ctor(page)) {
-		__free_page(page);
-		return NULL;
-	}
-	return page;
-}
-
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-	free_page((unsigned long)pte);
-}
-
-static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
-{
-	pgtable_page_dtor(ptepage);
-	__free_page(ptepage);
-}
-
 static inline void pgtable_free(void *table, int shift)
 {
 	if (!shift) {
-- 
2.7.4
