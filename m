Return-Path: <linux-riscv-bounces+rppt=linux.ibm.com@lists.infradead.org>
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 09/14] nds32: switch to generic version of pte allocation
Date: Wed,  8 May 2019 09:17:06 +0300
In-Reply-To: <1557296232-15361-1-git-send-email-rppt@linux.ibm.com>
References: <1557296232-15361-1-git-send-email-rppt@linux.ibm.com>
Message-ID: <1557296232-15361-10-git-send-email-rppt@linux.ibm.com>
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
Message-ID: <20190508061706.Mm74LdqPjFDyaOKlg7y_kZwiMwdsA307C9E-vkJQ_VE@z>

The nds32 implementation of pte_alloc_one_kernel() differs from the generic
in the use of __GFP_RETRY_MAYFAIL flag, which is removed after the
conversion.

The nds32 version of pte_alloc_one() missed the call to pgtable_page_ctor()
and also used __GFP_RETRY_MAYFAIL. Switching it to use generic
__pte_alloc_one() for the PTE page allocation ensures that page table
constructor is run and the user page tables are allocated with
__GFP_ACCOUNT.

The conversion to the generic version of pte_free_kernel() removes the NULL
check for pte.

The pte_free() version on nds32 is identical to the generic one and can be
simply dropped.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/nds32/include/asm/pgalloc.h | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/arch/nds32/include/asm/pgalloc.h b/arch/nds32/include/asm/pgalloc.h
index 3c5fee5..954696c 100644
--- a/arch/nds32/include/asm/pgalloc.h
+++ b/arch/nds32/include/asm/pgalloc.h
@@ -9,6 +9,9 @@
 #include <asm/tlbflush.h>
 #include <asm/proc-fns.h>
 
+#define __HAVE_ARCH_PTE_ALLOC_ONE
+#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
+
 /*
  * Since we have only two-level page tables, these are trivial
  */
@@ -22,22 +25,11 @@ extern void pgd_free(struct mm_struct *mm, pgd_t * pgd);
 
 #define check_pgt_cache()		do { } while (0)
 
-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
-{
-	pte_t *pte;
-
-	pte =
-	    (pte_t *) __get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL |
-				      __GFP_ZERO);
-
-	return pte;
-}
-
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
 	pgtable_t pte;
 
-	pte = alloc_pages(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_ZERO, 0);
+	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER);
 	if (pte)
 		cpu_dcache_wb_page((unsigned long)page_address(pte));
 
@@ -45,21 +37,6 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 }
 
 /*
- * Free one PTE table.
- */
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t * pte)
-{
-	if (pte) {
-		free_page((unsigned long)pte);
-	}
-}
-
-static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
-{
-	__free_page(pte);
-}
-
-/*
  * Populate the pmdp entry with a pointer to the pte.  This pmd is part
  * of the mm address space.
  *
-- 
2.7.4


_______________________________________________
linux-riscv mailing list
linux-riscv@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-riscv
