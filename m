Return-Path: <linux-riscv-bounces+rppt=linux.ibm.com@lists.infradead.org>
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 13/14] um: switch to generic version of pte allocation
Date: Wed,  8 May 2019 09:17:10 +0300
In-Reply-To: <1557296232-15361-1-git-send-email-rppt@linux.ibm.com>
References: <1557296232-15361-1-git-send-email-rppt@linux.ibm.com>
Message-ID: <1557296232-15361-14-git-send-email-rppt@linux.ibm.com>
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
Message-ID: <20190508061710.Pjc-51aNZqOH6sHRhtvGSLoFxIxZLi8EeSqYzjAh6q8@z>

um allocates PTE pages with __get_free_page() and uses
GFP_KERNEL | __GFP_ZERO for the allocations.

Switch it to the generic version that does exactly the same thing for the
kernel page tables and adds __GFP_ACCOUNT for the user PTEs.

The pte_free() and pte_free_kernel() versions are identical to the generic
ones and can be simply dropped.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/include/asm/pgalloc.h | 16 ++--------------
 arch/um/kernel/mem.c          | 22 ----------------------
 2 files changed, 2 insertions(+), 36 deletions(-)

diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index 99eb568..d7b282e 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -10,6 +10,8 @@
 
 #include <linux/mm.h>
 
+#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
+
 #define pmd_populate_kernel(mm, pmd, pte) \
 	set_pmd(pmd, __pmd(_PAGE_TABLE + (unsigned long) __pa(pte)))
 
@@ -25,20 +27,6 @@
 extern pgd_t *pgd_alloc(struct mm_struct *);
 extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
 
-extern pte_t *pte_alloc_one_kernel(struct mm_struct *);
-extern pgtable_t pte_alloc_one(struct mm_struct *);
-
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-	free_page((unsigned long) pte);
-}
-
-static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
-{
-	pgtable_page_dtor(pte);
-	__free_page(pte);
-}
-
 #define __pte_free_tlb(tlb,pte, address)		\
 do {							\
 	pgtable_page_dtor(pte);				\
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 99aa11b..2280374 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -215,28 +215,6 @@ void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 	free_page((unsigned long) pgd);
 }
 
-pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
-{
-	pte_t *pte;
-
-	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
-	return pte;
-}
-
-pgtable_t pte_alloc_one(struct mm_struct *mm)
-{
-	struct page *pte;
-
-	pte = alloc_page(GFP_KERNEL|__GFP_ZERO);
-	if (!pte)
-		return NULL;
-	if (!pgtable_page_ctor(pte)) {
-		__free_page(pte);
-		return NULL;
-	}
-	return pte;
-}
-
 #ifdef CONFIG_3_LEVEL_PGTABLES
 pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-- 
2.7.4


_______________________________________________
linux-riscv mailing list
linux-riscv@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-riscv
