From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 17/18] asm-generic/tlb: Remove tlb_flush_mmu_free()
Date: Wed, 26 Sep 2018 13:36:40 +0200
Message-ID: <20180926114801.417460864@infradead.org>
References: <20180926113623.863696043@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, peterz@infradead.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
List-Id: linux-arch.vger.kernel.org

As the comment notes; it is a potentially dangerous operation. Just
use tlb_flush_mmu(), that will skip the (double) TLB invalidate if
it really isn't needed anyway.

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
