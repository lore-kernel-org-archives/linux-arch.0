Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:50954 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbfLKMbX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 07:31:23 -0500
Message-ID: <20191211122956.342306385@infradead.org>
Date: Wed, 11 Dec 2019 13:07:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 12/17] m68k/tlb: Fix __p*_free_tlb()
References: <20191211120713.360281197@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, Tony Luck <tony.luck@intel.com>, Richard Henderson <rth@twiddle.net>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <20191211120725.v-pLyKtsj1oemjSqVRstq1s5ufHnjrRk-X293ZcCTjk@z>

Just like regular pages, page directories need to observe the
following order:

 1) unhook
 2) TLB invalidate
 3) free

to ensure it is safe against concurrent accesses.

The Motorola MMU has funny PMD stuff, so use a custom table freeer.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/m68k/Kconfig                        |    1 +
 arch/m68k/include/asm/mcf_pgalloc.h      |   11 +++++------
 arch/m68k/include/asm/motorola_pgalloc.h |   22 ++++++++++------------
 3 files changed, 16 insertions(+), 18 deletions(-)

--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -31,6 +31,7 @@ config M68K
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
 	select MMU_GATHER_NO_RANGE if MMU
+	select MMU_GATHER_TABLE_FREE if MMU_MOTOROLA
 
 config CPU_BIG_ENDIAN
 	def_bool y
--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -38,12 +38,11 @@ extern inline pmd_t *pmd_alloc_kernel(pg
 
 #define pmd_pgtable(pmd) pmd_page(pmd)
 
-static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t page,
-				  unsigned long address)
-{
-	pgtable_pte_page_dtor(page);
-	__free_page(page);
-}
+#define __pte_free_tlb(tlb, pte, address)	\
+do {						\
+	pgtable_pte_page_dtor(pte);		\
+	tlb_remove_page((tlb), (pte));		\
+} while (0)
 
 #define __pmd_free_tlb(tlb, pmd, address) do { } while (0)
 
--- a/arch/m68k/include/asm/motorola_pgalloc.h
+++ b/arch/m68k/include/asm/motorola_pgalloc.h
@@ -57,15 +57,13 @@ static inline void pte_free(struct mm_st
 	__free_page(page);
 }
 
-static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t page,
-				  unsigned long address)
-{
-	pgtable_pte_page_dtor(page);
-	cache_page(kmap(page));
-	kunmap(page);
-	__free_page(page);
-}
-
+#define __pte_free_tlb(tlb, pte, address)		\
+do {							\
+	pgtable_pte_page_dtor(pte);			\
+	cache_page(kmap(pte));				\
+	kunmap(pte);					\
+	tlb_remove_page((tlb), (pte));			\
+} while (0)
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
@@ -77,12 +75,12 @@ static inline int pmd_free(struct mm_str
 	return free_pointer_table(pmd);
 }
 
-static inline int __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
-				 unsigned long address)
+static inline void __tlb_remove_table(void *table)
 {
-	return free_pointer_table(pmd);
+	free_pointer_table(table);
 }
 
+#define __pmd_free_tlb(tlb, pmd, address) tlb_remove_table((tlb), (pmd))
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
