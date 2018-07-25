Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41935 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbeGYRFQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jul 2018 13:05:16 -0400
Received: by mail-pl0-f68.google.com with SMTP id w8-v6so3466342ply.8
        for <linux-arch@vger.kernel.org>; Wed, 25 Jul 2018 08:53:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 2/4] mm: zap_pte_range only flush under ptl if a dirty shared page was unmapped
Date: Thu, 26 Jul 2018 01:52:44 +1000
Message-Id: <20180725155246.1085-3-npiggin@gmail.com>
In-Reply-To: <20180725155246.1085-1-npiggin@gmail.com>
References: <20180725155246.1085-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org

The force_flush is used for two cases, a tlb batch full, and a shared
dirty page unmapped. Only the latter is required to flush the TLB
under the page table lock, because the problem is page_mkclean returning
when there are still writable TLB entries the page can be modified with.

We are encountering cases of soft lockups due to high TLB flush latency
with very large guests. There is probably some contetion in hypervisor
and interconnect tuning to be done, and it's actually a hash MMU guest
which has a whole other set of issues, but I'm looking for general ways
to reduce TLB fushing under locks.
---
 mm/memory.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 773d588b371d..1161ed3f1d0b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1281,6 +1281,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 {
 	struct mm_struct *mm = tlb->mm;
 	int force_flush = 0;
+	int locked_flush = 0;
 	int rss[NR_MM_COUNTERS];
 	spinlock_t *ptl;
 	pte_t *start_pte;
@@ -1322,6 +1323,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			if (!PageAnon(page)) {
 				if (pte_dirty(ptent)) {
 					force_flush = 1;
+					locked_flush = 1;
 					set_page_dirty(page);
 				}
 				if (pte_young(ptent) &&
@@ -1384,7 +1386,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	arch_leave_lazy_mmu_mode();
 
 	/* Do the actual TLB flush before dropping ptl */
-	if (force_flush)
+	if (locked_flush)
 		tlb_flush_mmu_tlbonly(tlb);
 	pte_unmap_unlock(start_pte, ptl);
 
@@ -1395,8 +1397,12 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	 * memory too. Restart if we didn't do everything.
 	 */
 	if (force_flush) {
-		force_flush = 0;
+		if (!locked_flush)
+			tlb_flush_mmu_tlbonly(tlb);
 		tlb_flush_mmu_free(tlb);
+
+		force_flush = 0;
+		locked_flush = 0;
 		if (addr != end)
 			goto again;
 	}
-- 
2.17.0
