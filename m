Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38225 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732623AbeHWMQF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Aug 2018 08:16:05 -0400
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 1/2] mm: move tlb_table_flush to tlb_flush_mmu_free
Date: Thu, 23 Aug 2018 18:47:08 +1000
Message-ID: <20180823084709.19717-2-npiggin@gmail.com>
In-Reply-To: <20180823084709.19717-1-npiggin@gmail.com>
References: <20180823084709.19717-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, torvalds@linux-foundation.org, luto@kernel.org, x86@kernel.org, bp@alien8.de, will.deacon@arm.com, riel@surriel.com, jannh@google.com, ascannell@google.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, David Miller <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org
Message-ID: <20180823084708.8KRlXSKP_tKR0PBH803tq-WZvEQzbMVmmpGrOYh2kfM@z>

There is no need to call this from tlb_flush_mmu_tlbonly, it
logically belongs with tlb_flush_mmu_free. This allows some
code consolidation with a subsequent fix.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 19f47d7b9b86..7c58310734eb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -245,9 +245,6 @@ static void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 
 	tlb_flush(tlb);
 	mmu_notifier_invalidate_range(tlb->mm, tlb->start, tlb->end);
-#ifdef CONFIG_HAVE_RCU_TABLE_FREE
-	tlb_table_flush(tlb);
-#endif
 	__tlb_reset_range(tlb);
 }
 
@@ -255,6 +252,9 @@ static void tlb_flush_mmu_free(struct mmu_gather *tlb)
 {
 	struct mmu_gather_batch *batch;
 
+#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+	tlb_table_flush(tlb);
+#endif
 	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
 		free_pages_and_swap_cache(batch->pages, batch->nr);
 		batch->nr = 0;
-- 
2.17.0
