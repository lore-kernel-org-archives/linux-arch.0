Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42928 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbeHWMQL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Aug 2018 08:16:11 -0400
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 2/2] mm: mmu_notifier fix for tlb_end_vma
Date: Thu, 23 Aug 2018 18:47:09 +1000
Message-ID: <20180823084709.19717-3-npiggin@gmail.com>
In-Reply-To: <20180823084709.19717-1-npiggin@gmail.com>
References: <20180823084709.19717-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, torvalds@linux-foundation.org, luto@kernel.org, x86@kernel.org, bp@alien8.de, will.deacon@arm.com, riel@surriel.com, jannh@google.com, ascannell@google.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, David Miller <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org
Message-ID: <20180823084709.1wgoDeY1IiwiUTkm5YzDy7wqFJlkWffKvRVFZKoW7SQ@z>

The generic tlb_end_vma does not call invalidate_range mmu notifier,
and it resets resets the mmu_gather range, which means the notifier
won't be called on part of the range in case of an unmap that spans
multiple vmas.

ARM64 seems to be the only arch I could see that has notifiers and
uses the generic tlb_end_vma. I have not actually tested it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/asm-generic/tlb.h | 17 +++++++++++++----
 mm/memory.c               | 10 ----------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index e811ef7b8350..79cb76b89c26 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -15,6 +15,7 @@
 #ifndef _ASM_GENERIC__TLB_H
 #define _ASM_GENERIC__TLB_H
 
+#include <linux/mmu_notifier.h>
 #include <linux/swap.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -138,6 +139,16 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
 	}
 }
 
+static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
+{
+	if (!tlb->end)
+		return;
+
+	tlb_flush(tlb);
+	mmu_notifier_invalidate_range(tlb->mm, tlb->start, tlb->end);
+	__tlb_reset_range(tlb);
+}
+
 static inline void tlb_remove_page_size(struct mmu_gather *tlb,
 					struct page *page, int page_size)
 {
@@ -186,10 +197,8 @@ static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
 
 #define __tlb_end_vma(tlb, vma)					\
 	do {							\
-		if (!tlb->fullmm && tlb->end) {			\
-			tlb_flush(tlb);				\
-			__tlb_reset_range(tlb);			\
-		}						\
+		if (!tlb->fullmm)				\
+			tlb_flush_mmu_tlbonly(tlb);		\
 	} while (0)
 
 #ifndef tlb_end_vma
diff --git a/mm/memory.c b/mm/memory.c
index 7c58310734eb..c4a7b6cb17c8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -238,16 +238,6 @@ void arch_tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 	__tlb_reset_range(tlb);
 }
 
-static void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
-{
-	if (!tlb->end)
-		return;
-
-	tlb_flush(tlb);
-	mmu_notifier_invalidate_range(tlb->mm, tlb->start, tlb->end);
-	__tlb_reset_range(tlb);
-}
-
 static void tlb_flush_mmu_free(struct mmu_gather *tlb)
 {
 	struct mmu_gather_batch *batch;
-- 
2.17.0
