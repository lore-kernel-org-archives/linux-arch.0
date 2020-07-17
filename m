From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 01/11] asm-generic/tlb: Fix MMU_GATHER_TABLE_FREE
Date: Fri, 17 Jul 2020 13:10:06 +0200
Message-ID: <20200717111349.417688532@infradead.org>
References: <20200717111005.024867618@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, Tony Luck <tony.luck@intel.com>, Richard Henderson <rth@twiddle.net>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Christoph Hellwig <hch@lst.de>
List-Id: linux-arch.vger.kernel.org

The first MMU_GATHER_TABLE_FREE user showed a logic error in the
tlb_needs_table_invalidate() definition. Make sure any TABLE_FREE has
it defined.

Fixes: 0d6e24d430ef ("asm-generic/tlb: provide MMU_GATHER_TABLE_FREE")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h |   35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -172,6 +172,18 @@
  *  various ptep_get_and_clear() functions.
  */
 
+#ifndef CONFIG_MMU_GATHER_RCU_TABLE_FREE
+
+/*
+ * Only RCU table free can override this; otherwise the TLBI is needed to
+ * provide existence guarantees for software walkers.
+ */
+#ifdef tlb_needs_table_invalidate
+#error tlb_needs_table_invalidate() requires MMU_GATHER_RCU_TABLE_FREE
+#endif
+
+#endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
+
 #ifdef CONFIG_MMU_GATHER_TABLE_FREE
 
 struct mmu_table_batch {
@@ -187,17 +199,6 @@ struct mmu_table_batch {
 
 extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
 
-#else /* !CONFIG_MMU_GATHER_HAVE_TABLE_FREE */
-
-/*
- * Without MMU_GATHER_TABLE_FREE the architecture is assumed to have page based
- * page directories and we can use the normal page batching to free them.
- */
-#define tlb_remove_table(tlb, page) tlb_remove_page((tlb), (page))
-
-#endif /* CONFIG_MMU_GATHER_TABLE_FREE */
-
-#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 /*
  * This allows an architecture that does not use the linux page-tables for
  * hardware to skip the TLBI when freeing page tables.
@@ -206,13 +207,15 @@ extern void tlb_remove_table(struct mmu_
 #define tlb_needs_table_invalidate() (true)
 #endif
 
-#else
+#else /* !CONFIG_MMU_GATHER_HAVE_TABLE_FREE */
 
-#ifdef tlb_needs_table_invalidate
-#error tlb_needs_table_invalidate() requires MMU_GATHER_RCU_TABLE_FREE
-#endif
+/*
+ * Without MMU_GATHER_TABLE_FREE the architecture is assumed to have page based
+ * page directories and we can use the normal page batching to free them.
+ */
+#define tlb_remove_table(tlb, page) tlb_remove_page((tlb), (page))
 
-#endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
+#endif /* CONFIG_MMU_GATHER_TABLE_FREE */
 
 
 #ifndef CONFIG_MMU_GATHER_NO_GATHER
