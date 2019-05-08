From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 07/14] m68k: sun3: switch to generic version of pte allocation
Date: Wed,  8 May 2019 09:17:04 +0300
Message-ID: <1557296232-15361-8-git-send-email-rppt@linux.ibm.com>
References: <1557296232-15361-1-git-send-email-rppt@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1557296232-15361-1-git-send-email-rppt@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Ley Foon Tan <lftan@altera.com>, Matthew Wilcox <willy@infradead.org>, Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, Richard Kuo <rkuo@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.orgli
List-Id: linux-arch.vger.kernel.org

The sun3 MMU variant of m68k uses GFP_KERNEL to allocate a PTE page and
then memset(0) or clear_highpage() to clear it.

This is equivalent to allocating the page with GFP_KERNEL | __GFP_ZERO,
which allows replacing sun3 implementation of pte_alloc_one() and
pte_alloc_one_kernel() with the generic ones.

The pte_free() and pte_free_kernel() versions are identical to the generic
ones and can be simply dropped.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/m68k/include/asm/sun3_pgalloc.h | 41 ++----------------------------------
 1 file changed, 2 insertions(+), 39 deletions(-)

diff --git a/arch/m68k/include/asm/sun3_pgalloc.h b/arch/m68k/include/asm/sun3_pgalloc.h
index 1456c5e..1a8ddbd 100644
--- a/arch/m68k/include/asm/sun3_pgalloc.h
+++ b/arch/m68k/include/asm/sun3_pgalloc.h
@@ -13,55 +13,18 @@
 
 #include <asm/tlb.h>
 
+#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
+
 extern const char bad_pmd_string[];
 
 #define pmd_alloc_one(mm,address)       ({ BUG(); ((pmd_t *)2); })
 
-
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-        free_page((unsigned long) pte);
-}
-
-static inline void pte_free(struct mm_struct *mm, pgtable_t page)
-{
-	pgtable_page_dtor(page);
-        __free_page(page);
-}
-
 #define __pte_free_tlb(tlb,pte,addr)			\
 do {							\
 	pgtable_page_dtor(pte);				\
 	tlb_remove_page((tlb), pte);			\
 } while (0)
 
-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
-{
-	unsigned long page = __get_free_page(GFP_KERNEL);
-
-	if (!page)
-		return NULL;
-
-	memset((void *)page, 0, PAGE_SIZE);
-	return (pte_t *) (page);
-}
-
-static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
-{
-        struct page *page = alloc_pages(GFP_KERNEL, 0);
-
-	if (page == NULL)
-		return NULL;
-
-	clear_highpage(page);
-	if (!pgtable_page_ctor(page)) {
-		__free_page(page);
-		return NULL;
-	}
-	return page;
-
-}
-
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
 {
 	pmd_val(*pmd) = __pa((unsigned long)pte);
-- 
2.7.4
