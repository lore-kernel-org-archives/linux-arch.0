From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 05/11] parisc/tlb: Fix __p*_free_tlb()
Date: Fri, 17 Jul 2020 13:10:10 +0200
Message-ID: <20200717111349.650029395@infradead.org>
References: <20200717111005.024867618@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, Tony Luck <tony.luck@intel.com>, Richard Henderson <rth@twiddle.net>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Christoph Hellwig <hch@lst.de>
List-Id: linux-arch.vger.kernel.org

Just like regular pages, page directories need to observe the
following order:

 1) unhook
 2) TLB invalidate
 3) free

to ensure it is safe against concurrent accesses.

Because PARISC has non-page-size PMDs, use a custom table freeer.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/parisc/Kconfig               |    1 +
 arch/parisc/include/asm/pgalloc.h |   23 ++++++++++++++++++++---
 arch/parisc/include/asm/tlb.h     |    9 +++++----
 3 files changed, 26 insertions(+), 7 deletions(-)

--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -63,6 +63,7 @@ config PARISC
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_COPY_THREAD_TLS
+	select MMU_GATHER_TABLE_FREE if PGTABLE_LEVELS >= 3
 
 	help
 	  The PA-RISC microprocessor is designed by Hewlett-Packard and used
--- a/arch/parisc/include/asm/pgalloc.h
+++ b/arch/parisc/include/asm/pgalloc.h
@@ -73,7 +73,7 @@ static inline pmd_t *pmd_alloc_one(struc
 	return pmd;
 }
 
-static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
+static inline bool __pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
 	if (pmd_flag(*pmd) & PxD_FLAG_ATTACHED) {
 		/*
@@ -83,11 +83,28 @@ static inline void pmd_free(struct mm_st
 		 * done by generic mm code.
 		 */
 		mm_inc_nr_pmds(mm);
-		return;
+		return false;
 	}
-	free_pages((unsigned long)pmd, PMD_ORDER);
+	return true;
+}
+
+static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
+{
+	if (__pmd_free(mm, pmd))
+		free_pages((unsigned long)pmd, PMD_ORDER);
 }
 
+static inline void __tlb_remove_table(void *table)
+{
+	free_pages((unsigned long)table, PMD_ORDER);
+}
+
+#define __pmd_free_tlb(tlb, pmd, addr)		\
+do {						\
+	if (__pmd_free((tlb)->mm, (pmd)))	\
+		tlb_remove_table((tlb), (pmd));	\
+} while (0)
+
 #endif
 
 static inline void
--- a/arch/parisc/include/asm/tlb.h
+++ b/arch/parisc/include/asm/tlb.h
@@ -4,9 +4,10 @@
 
 #include <asm-generic/tlb.h>
 
-#if CONFIG_PGTABLE_LEVELS == 3
-#define __pmd_free_tlb(tlb, pmd, addr)	pmd_free((tlb)->mm, pmd)
-#endif
-#define __pte_free_tlb(tlb, pte, addr)	pte_free((tlb)->mm, pte)
+#define __pte_free_tlb(tlb,pte,addr)			\
+do {							\
+	pgtable_pte_page_dtor(pte);			\
+	tlb_remove_page((tlb), (pte));			\
+} while (0)
 
 #endif
