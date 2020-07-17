From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 02/11] sh/tlb: Fix PGTABLE_LEVELS > 2
Date: Fri, 17 Jul 2020 13:10:07 +0200
Message-ID: <20200717111349.475459591@infradead.org>
References: <20200717111005.024867618@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, Tony Luck <tony.luck@intel.com>, Richard Henderson <rth@twiddle.net>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Christoph Hellwig <hch@lst.de>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-arch.vger.kernel.org

Geert reported that his SH7722-based Migo-R board failed to boot after
commit:

  c5b27a889da9 ("sh/tlb: Convert SH to generic mmu_gather")

That commit fell victim to copying the wrong pattern --
__pmd_free_tlb() used to be implemented with pmd_free().

Fixes: c5b27a889da9 ("sh/tlb: Convert SH to generic mmu_gather")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -12,6 +12,7 @@ extern void pgd_free(struct mm_struct *m
 extern void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmd);
 extern pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address);
 extern void pmd_free(struct mm_struct *mm, pmd_t *pmd);
+#define __pmd_free_tlb(tlb, pmdp, addr)		pmd_free((tlb)->mm, (pmdp))
 #endif
 
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
@@ -33,13 +34,4 @@ do {							\
 	tlb_remove_page((tlb), (pte));			\
 } while (0)
 
-#if CONFIG_PGTABLE_LEVELS > 2
-#define __pmd_free_tlb(tlb, pmdp, addr)			\
-do {							\
-	struct page *page = virt_to_page(pmdp);		\
-	pgtable_pmd_page_dtor(page);			\
-	tlb_remove_page((tlb), page);			\
-} while (0);
-#endif
-
 #endif /* __ASM_SH_PGALLOC_H */
