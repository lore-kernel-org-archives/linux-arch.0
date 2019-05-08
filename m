Return-Path: <linux-riscv-bounces+rppt=linux.ibm.com@lists.infradead.org>
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 08/14] mips: switch to generic version of pte allocation
Date: Wed,  8 May 2019 09:17:05 +0300
In-Reply-To: <1557296232-15361-1-git-send-email-rppt@linux.ibm.com>
References: <1557296232-15361-1-git-send-email-rppt@linux.ibm.com>
Message-ID: <1557296232-15361-9-git-send-email-rppt@linux.ibm.com>
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
Message-ID: <20190508061705.3cGxgXV_IWTayBH8EymVF1Mjx7KBQoaTWbatMebzw40@z>

MIPS allocates kernel PTE pages with

	__get_free_pages(GFP_KERNEL | __GFP_ZERO, PTE_ORDER)

and user PTE pages with

	pte = alloc_pages(GFP_KERNEL, PTE_ORDER)

and then uses clear_highpage(pte) to zero out the allocated page for the
user page tables.

The PTE_ORDER is hardwired to zero, which makes MIPS implementation almost
identical to the generic one.

Switch MIPS to the generic version that does exactly the same thing for the
kernel page tables and adds __GFP_ACCOUNT for the user PTEs.

The pte_free_kernel() and pte_free() versions on mips are identical to the
generic ones and can be simply dropped.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Paul Burton <paul.burton@mips.com>
---
 arch/mips/include/asm/pgalloc.h | 33 ++-------------------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 27808d9..aa16b85 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -13,6 +13,8 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 
+#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
+
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 	pte_t *pte)
 {
@@ -50,37 +52,6 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 	free_pages((unsigned long)pgd, PGD_ORDER);
 }
 
-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
-{
-	return (pte_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, PTE_ORDER);
-}
-
-static inline struct page *pte_alloc_one(struct mm_struct *mm)
-{
-	struct page *pte;
-
-	pte = alloc_pages(GFP_KERNEL, PTE_ORDER);
-	if (!pte)
-		return NULL;
-	clear_highpage(pte);
-	if (!pgtable_page_ctor(pte)) {
-		__free_page(pte);
-		return NULL;
-	}
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
 #define __pte_free_tlb(tlb,pte,address)			\
 do {							\
 	pgtable_page_dtor(pte);				\
-- 
2.7.4


_______________________________________________
linux-riscv mailing list
linux-riscv@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-riscv
