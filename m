From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 14/17] ia64/tlb: Fix __p*_free_tlb()
Date: Wed, 11 Dec 2019 13:07:27 +0100
Message-ID: <20191211122956.456987895@infradead.org>
References: <20191211120713.360281197@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, Tony Luck <tony.luck@intel.com>, Richard Henderson <rth@twiddle.net>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-arch.vger.kernel.org

Just like regular pages, page directories need to observe the
following order:

 1) unhook
 2) TLB invalidate
 3) free

to ensure it is safe against concurrent accesses.

Since IA64 has page based P[UM]Ds, no software walkers and IPI based
TLB invalidation, it can use the simple tlb_remove_page() based
freeer.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/ia64/include/asm/pgalloc.h |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/arch/ia64/include/asm/pgalloc.h
+++ b/arch/ia64/include/asm/pgalloc.h
@@ -50,7 +50,9 @@ static inline void pud_free(struct mm_st
 {
 	free_page((unsigned long)pud);
 }
-#define __pud_free_tlb(tlb, pud, address)	pud_free((tlb)->mm, pud)
+
+#define __pud_free_tlb(tlb, pud, address)	\
+	tlb_remove_table((tlb), virt_to_page(pud))
 #endif /* CONFIG_PGTABLE_LEVELS == 4 */
 
 static inline void
@@ -69,7 +71,8 @@ static inline void pmd_free(struct mm_st
 	free_page((unsigned long)pmd);
 }
 
-#define __pmd_free_tlb(tlb, pmd, address)	pmd_free((tlb)->mm, pmd)
+#define __pmd_free_tlb(tlb, pmd, address)	\
+	tlb_remove_table((tlb), virt_to_page(pmd)
 
 static inline void
 pmd_populate(struct mm_struct *mm, pmd_t * pmd_entry, pgtable_t pte)
@@ -84,6 +87,10 @@ pmd_populate_kernel(struct mm_struct *mm
 	pmd_val(*pmd_entry) = __pa(pte);
 }
 
-#define __pte_free_tlb(tlb, pte, address)	pte_free((tlb)->mm, pte)
+#define __pte_free_tlb(tlb, pte, address)	\
+do {						\
+	pgtable_pte_page_dtor(pte);		\
+	tlb_remove_table((tlb), (pte));		\
+} while (0)
 
 #endif				/* _ASM_IA64_PGALLOC_H */
