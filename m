From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 05/14] csky: switch to generic version of pte allocation
Date: Wed,  8 May 2019 09:17:02 +0300
Message-ID: <1557296232-15361-6-git-send-email-rppt@linux.ibm.com>
References: <1557296232-15361-1-git-send-email-rppt@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1557296232-15361-1-git-send-email-rppt@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Ley Foon Tan <lftan@altera.com>, Matthew Wilcox <willy@infradead.org>, Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, Richard Kuo <rkuo@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.orgli
List-Id: linux-arch.vger.kernel.org

The csky implementation pte_alloc_one(), pte_free_kernel() and pte_free()
is identical to the generic except of lack of __GFP_ACCOUNT for the user
PTEs allocation.

Switch csky to use generic version of these functions.

The csky implementation of pte_alloc_one_kernel() is not replaced because
it does not clear the allocated page but rather sets each PTE in it to a
non-zero value.

The pte_free_kernel() and pte_free() versions on csky are identical to the
generic ones and can be simply dropped.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/pgalloc.h | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index d213bb4..98c571670 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -8,6 +8,9 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 
+#define __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
+#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
+
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 					pte_t *pte)
 {
@@ -39,33 +42,6 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 	return pte;
 }
 
-static inline struct page *pte_alloc_one(struct mm_struct *mm)
-{
-	struct page *pte;
-
-	pte = alloc_pages(GFP_KERNEL | __GFP_ZERO, 0);
-	if (!pte)
-		return NULL;
-
-	if (!pgtable_page_ctor(pte)) {
-		__free_page(pte);
-		return NULL;
-	}
-
-	return pte;
-}
-
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-	free_pages((unsigned long)pte, PTE_ORDER);
-}
-
-static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
-{
-	pgtable_page_dtor(pte);
-	__free_pages(pte, PTE_ORDER);
-}
-
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
 	free_pages((unsigned long)pgd, PGD_ORDER);
-- 
2.7.4
