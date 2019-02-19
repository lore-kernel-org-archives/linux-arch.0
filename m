Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:39030 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfBSKdH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Feb 2019 05:33:07 -0500
Message-ID: <20190219103233.927987010@infradead.org>
Date: Tue, 19 Feb 2019 11:32:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v6 18/18] asm-generic/tlb: Remove tlb_table_flush()
References: <20190219103148.192029670@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, peterz@infradead.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
Message-ID: <20190219103206.Dik9gMytDr-fMGPOiBcYSNkf0ufjIfxrLx3zbk088B8@z>

There are no external users of this API (nor should there be); remove it.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h |    1 -
 mm/mmu_gather.c           |   34 +++++++++++++++++-----------------
 2 files changed, 17 insertions(+), 18 deletions(-)

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -174,7 +174,6 @@ struct mmu_table_batch {
 #define MAX_TABLE_BATCH		\
 	((PAGE_SIZE - sizeof(struct mmu_table_batch)) / sizeof(void *))
 
-extern void tlb_table_flush(struct mmu_gather *tlb);
 extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
 
 #endif
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -91,22 +91,6 @@ bool __tlb_remove_page_size(struct mmu_g
 
 #endif /* HAVE_MMU_GATHER_NO_GATHER */
 
-static void tlb_flush_mmu_free(struct mmu_gather *tlb)
-{
-#ifdef CONFIG_HAVE_RCU_TABLE_FREE
-	tlb_table_flush(tlb);
-#endif
-#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
-	tlb_batch_pages_flush(tlb);
-#endif
-}
-
-void tlb_flush_mmu(struct mmu_gather *tlb)
-{
-	tlb_flush_mmu_tlbonly(tlb);
-	tlb_flush_mmu_free(tlb);
-}
-
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
 
 /*
@@ -159,7 +143,7 @@ static void tlb_remove_table_rcu(struct
 	free_page((unsigned long)batch);
 }
 
-void tlb_table_flush(struct mmu_gather *tlb)
+static void tlb_table_flush(struct mmu_gather *tlb)
 {
 	struct mmu_table_batch **batch = &tlb->batch;
 
@@ -191,6 +175,22 @@ void tlb_remove_table(struct mmu_gather
 
 #endif /* CONFIG_HAVE_RCU_TABLE_FREE */
 
+static void tlb_flush_mmu_free(struct mmu_gather *tlb)
+{
+#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+	tlb_table_flush(tlb);
+#endif
+#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+	tlb_batch_pages_flush(tlb);
+#endif
+}
+
+void tlb_flush_mmu(struct mmu_gather *tlb)
+{
+	tlb_flush_mmu_tlbonly(tlb);
+	tlb_flush_mmu_free(tlb);
+}
+
 /**
  * tlb_gather_mmu - initialize an mmu_gather structure for page-table tear-down
  * @tlb: the mmu_gather structure to initialize
