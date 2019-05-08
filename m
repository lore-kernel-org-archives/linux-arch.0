Return-Path: <linux-riscv-bounces+rppt=linux.ibm.com@lists.infradead.org>
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 11/14] parisc: switch to generic version of pte allocation
Date: Wed,  8 May 2019 09:17:08 +0300
In-Reply-To: <1557296232-15361-1-git-send-email-rppt@linux.ibm.com>
References: <1557296232-15361-1-git-send-email-rppt@linux.ibm.com>
Message-ID: <1557296232-15361-12-git-send-email-rppt@linux.ibm.com>
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
Message-ID: <20190508061708.Y2-r7SqcC0O3oBw2IKANIieKBIL-BIA5Aj1wdYvvsI4@z>

parisc allocates PTE pages with __get_free_page() and uses
GFP_KERNEL | __GFP_ZERO for the allocations.

Switch it to the generic version that does exactly the same thing for the
kernel page tables and adds __GFP_ACCOUNT for the user PTEs.

The pte_free_kernel() and pte_free() versions on are identical to the
generic ones and can be simply dropped.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/parisc/include/asm/pgalloc.h | 33 ++-------------------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/arch/parisc/include/asm/pgalloc.h b/arch/parisc/include/asm/pgalloc.h
index ea75cc9..4f2059a 100644
--- a/arch/parisc/include/asm/pgalloc.h
+++ b/arch/parisc/include/asm/pgalloc.h
@@ -10,6 +10,8 @@
 
 #include <asm/cache.h>
 
+#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
+
 /* Allocate the top level pgd (page directory)
  *
  * Here (for 64 bit kernels) we implement a Hybrid L2/L3 scheme: we
@@ -122,37 +124,6 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
 	pmd_populate_kernel(mm, pmd, page_address(pte_page))
 #define pmd_pgtable(pmd) pmd_page(pmd)
 
-static inline pgtable_t
-pte_alloc_one(struct mm_struct *mm)
-{
-	struct page *page = alloc_page(GFP_KERNEL|__GFP_ZERO);
-	if (!page)
-		return NULL;
-	if (!pgtable_page_ctor(page)) {
-		__free_page(page);
-		return NULL;
-	}
-	return page;
-}
-
-static inline pte_t *
-pte_alloc_one_kernel(struct mm_struct *mm)
-{
-	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
-	return pte;
-}
-
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-	free_page((unsigned long)pte);
-}
-
-static inline void pte_free(struct mm_struct *mm, struct page *pte)
-{
-	pgtable_page_dtor(pte);
-	pte_free_kernel(mm, page_address(pte));
-}
-
 #define check_pgt_cache()	do { } while (0)
 
 #endif
-- 
2.7.4


_______________________________________________
linux-riscv mailing list
linux-riscv@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-riscv
