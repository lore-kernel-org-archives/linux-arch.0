Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:55586 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbfBSKdQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Feb 2019 05:33:16 -0500
Message-ID: <20190219103233.869262181@infradead.org>
Date: Tue, 19 Feb 2019 11:32:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v6 17/18] asm-generic/tlb: Remove tlb_flush_mmu_free()
References: <20190219103148.192029670@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, peterz@infradead.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
Message-ID: <20190219103205.uDzozMxBAXYbOPNMYs7eZk-I5HSefITzEMJoLzTP_jg@z>

As the comment notes; it is a potentially dangerous operation. Just
use tlb_flush_mmu(), that will skip the (double) TLB invalidate if
it really isn't needed anyway.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h |   10 +++-------
 mm/memory.c               |    2 +-
 mm/mmu_gather.c           |    2 +-
 3 files changed, 5 insertions(+), 9 deletions(-)

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -67,16 +67,13 @@
  *    call before __tlb_remove_page*() to set the current page-size; implies a
  *    possible tlb_flush_mmu() call.
  *
- *  - tlb_flush_mmu() / tlb_flush_mmu_tlbonly() / tlb_flush_mmu_free()
+ *  - tlb_flush_mmu() / tlb_flush_mmu_tlbonly()
  *
  *    tlb_flush_mmu_tlbonly() - does the TLB invalidate (and resets
  *                              related state, like the range)
  *
- *    tlb_flush_mmu_free() - frees the queued pages; make absolutely
- *			     sure no additional tlb_remove_page()
- *			     calls happen between _tlbonly() and this.
- *
- *    tlb_flush_mmu() - the above two calls.
+ *    tlb_flush_mmu() - in addition to the above TLB invalidate, also frees
+ *			whatever pages are still batched.
  *
  *  - mmu_gather::fullmm
  *
@@ -274,7 +271,6 @@ void arch_tlb_gather_mmu(struct mmu_gath
 void tlb_flush_mmu(struct mmu_gather *tlb);
 void arch_tlb_finish_mmu(struct mmu_gather *tlb,
 			 unsigned long start, unsigned long end, bool force);
-void tlb_flush_mmu_free(struct mmu_gather *tlb);
 
 static inline void __tlb_adjust_range(struct mmu_gather *tlb,
 				      unsigned long address,
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1155,7 +1155,7 @@ static unsigned long zap_pte_range(struc
 	 */
 	if (force_flush) {
 		force_flush = 0;
-		tlb_flush_mmu_free(tlb);
+		tlb_flush_mmu(tlb);
 		if (addr != end)
 			goto again;
 	}
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -91,7 +91,7 @@ bool __tlb_remove_page_size(struct mmu_g
 
 #endif /* HAVE_MMU_GATHER_NO_GATHER */
 
-void tlb_flush_mmu_free(struct mmu_gather *tlb)
+static void tlb_flush_mmu_free(struct mmu_gather *tlb)
 {
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
 	tlb_table_flush(tlb);
