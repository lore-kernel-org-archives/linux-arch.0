Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate6.de.ibm.com ([195.212.29.155]:38754 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbXGQNyn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Jul 2007 09:54:43 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6HDsQWC700926
	for <linux-arch@vger.kernel.org>; Tue, 17 Jul 2007 13:54:26 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6HDsQFT2076750
	for <linux-arch@vger.kernel.org>; Tue, 17 Jul 2007 15:54:26 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6HDsKVe006294
	for <linux-arch@vger.kernel.org>; Tue, 17 Jul 2007 15:54:20 +0200
Subject: Re: + sparc64-rename-tlb_flush_mmu.patch added to -mm tree
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20070717010324.833fee7e.akpm@linux-foundation.org>
References: <200707170748.l6H7m1so005969@imap1.linux-foundation.org>
	 <20070717005551.cdb9504e.akpm@linux-foundation.org>
	 <20070717010324.833fee7e.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 15:56:23 +0200
Message-Id: <1184680583.21357.67.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org
Cc: davem@davemloft.net, hugh@veritas.com
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2007-07-17 at 01:03 -0700, Andrew Morton wrote:
> OK, I don't understand how this patch works - from a quick glance it
> appears to be forgetting to flush stuff altogether on arm and arm26 at
> least and I see no sign that Russell, Tony and Ian have even seen it.

Added linux-arch so that affected arch-maintainers can comment.

> And it should have been loudly pointed out to various arch maintainers so
> they have an opportunity to implement the optimisation which it offers.

The idea behind the optimization of this patch is that for a full mm
flush (tlb_gather_mmu called with full_mm_flush==1) a single
flush_tlb_mm is enough to remove all TLBs of the mm. New ones cannot be
created since full_mm_flush==1 only for exit_mmap. The same is true for
a normal unmap if there is only one user of the mm and the mm is the
currently active mm.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.

---
Subject: [PATCH] avoid tlb gather restarts.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

If need_resched() is false in the inner loop of unmap_vmas it is
unnecessary to do a full blown tlb_finish_mmu / tlb_gather_mmu for
each ZAP_BLOCK_SIZE ptes. Do a tlb_flush_mmu() instead. That gives
architectures with a non-generic tlb flush implementation room for
optimization. The tlb_flush_mmu primitive is a available with the
generic tlb flush code, the ia64_tlb_flush_mm needs to be renamed
and a dummy function is added to arm and arm26.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-arm/tlb.h     |    5 +++++
 include/asm-arm26/tlb.h   |    5 +++++
 include/asm-ia64/tlb.h    |    6 +++---
 include/asm-sparc64/tlb.h |    6 +++---
 mm/memory.c               |   16 ++++++----------
 5 files changed, 22 insertions(+), 16 deletions(-)

diff -urpN linux-2.6/include/asm-arm/tlb.h linux-2.6-patched/include/asm-arm/tlb.h
--- linux-2.6/include/asm-arm/tlb.h	2006-11-08 10:45:43.000000000 +0100
+++ linux-2.6-patched/include/asm-arm/tlb.h	2007-07-17 15:18:02.000000000 +0200
@@ -52,6 +52,11 @@ tlb_gather_mmu(struct mm_struct *mm, uns
 }
 
 static inline void
+tlb_flush_mmu(struct mmu_gather *tlb, unsigned long start, unsigned long end)
+{
+}
+
+static inline void
 tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start, unsigned long end)
 {
 	if (tlb->fullmm)
diff -urpN linux-2.6/include/asm-arm26/tlb.h linux-2.6-patched/include/asm-arm26/tlb.h
--- linux-2.6/include/asm-arm26/tlb.h	2006-11-08 10:45:43.000000000 +0100
+++ linux-2.6-patched/include/asm-arm26/tlb.h	2007-07-17 15:18:02.000000000 +0200
@@ -29,6 +29,11 @@ tlb_gather_mmu(struct mm_struct *mm, uns
 }
 
 static inline void
+tlb_flush_mmu(struct mmu_gather *tlb, unsigned long start, unsigned long end)
+{
+}
+
+static inline void
 tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start, unsigned long end)
 {
         if (tlb->need_flush)
diff -urpN linux-2.6/include/asm-ia64/tlb.h linux-2.6-patched/include/asm-ia64/tlb.h
--- linux-2.6/include/asm-ia64/tlb.h	2006-11-08 10:45:45.000000000 +0100
+++ linux-2.6-patched/include/asm-ia64/tlb.h	2007-07-17 15:18:02.000000000 +0200
@@ -72,7 +72,7 @@ DECLARE_PER_CPU(struct mmu_gather, mmu_g
  * freed pages that where gathered up to this point.
  */
 static inline void
-ia64_tlb_flush_mmu (struct mmu_gather *tlb, unsigned long start, unsigned long end)
+tlb_flush_mmu (struct mmu_gather *tlb, unsigned long start, unsigned long end)
 {
 	unsigned int nr;
 
@@ -160,7 +160,7 @@ tlb_finish_mmu (struct mmu_gather *tlb, 
 	 * Note: tlb->nr may be 0 at this point, so we can't rely on tlb->start_addr and
 	 * tlb->end_addr.
 	 */
-	ia64_tlb_flush_mmu(tlb, start, end);
+	tlb_flush_mmu(tlb, start, end);
 
 	/* keep the page table cache within bounds */
 	check_pgt_cache();
@@ -184,7 +184,7 @@ tlb_remove_page (struct mmu_gather *tlb,
 	}
 	tlb->pages[tlb->nr++] = page;
 	if (tlb->nr >= FREE_PTE_NR)
-		ia64_tlb_flush_mmu(tlb, tlb->start_addr, tlb->end_addr);
+		tlb_flush_mmu(tlb, tlb->start_addr, tlb->end_addr);
 }
 
 /*
diff -urpN linux-2.6/include/asm-sparc64/tlb.h linux-2.6-patched/include/asm-sparc64/tlb.h
--- linux-2.6/include/asm-sparc64/tlb.h	2007-07-02 08:45:46.000000000 +0200
+++ linux-2.6-patched/include/asm-sparc64/tlb.h	2007-07-17 15:18:02.000000000 +0200
@@ -55,7 +55,7 @@ static inline struct mmu_gather *tlb_gat
 }
 
 
-static inline void tlb_flush_mmu(struct mmu_gather *mp)
+static inline void tlb_flush_mmu(struct mmu_gather *mp, unsigned long start, unsigned long end)
 {
 	if (mp->need_flush) {
 		free_pages_and_swap_cache(mp->pages, mp->pages_nr);
@@ -74,7 +74,7 @@ extern void smp_flush_tlb_mm(struct mm_s
 
 static inline void tlb_finish_mmu(struct mmu_gather *mp, unsigned long start, unsigned long end)
 {
-	tlb_flush_mmu(mp);
+	tlb_flush_mmu(mp, start, end);
 
 	if (mp->fullmm)
 		mp->fullmm = 0;
@@ -96,7 +96,7 @@ static inline void tlb_remove_page(struc
 	mp->need_flush = 1;
 	mp->pages[mp->pages_nr++] = page;
 	if (mp->pages_nr >= FREE_PTE_NR)
-		tlb_flush_mmu(mp);
+		tlb_flush_mmu(mp, 0, 0);
 }
 
 #define tlb_remove_tlb_entry(mp,ptep,addr) do { } while (0)
diff -urpN linux-2.6/mm/memory.c linux-2.6-patched/mm/memory.c
--- linux-2.6/mm/memory.c	2007-07-17 12:12:30.000000000 +0200
+++ linux-2.6-patched/mm/memory.c	2007-07-17 15:18:02.000000000 +0200
@@ -851,18 +851,15 @@ unsigned long unmap_vmas(struct mmu_gath
 				break;
 			}
 
-			tlb_finish_mmu(*tlbp, tlb_start, start);
-
 			if (need_resched() ||
 				(i_mmap_lock && need_lockbreak(i_mmap_lock))) {
-				if (i_mmap_lock) {
-					*tlbp = NULL;
+				if (i_mmap_lock)
 					goto out;
-				}
+				tlb_finish_mmu(*tlbp, tlb_start, start);
 				cond_resched();
-			}
-
-			*tlbp = tlb_gather_mmu(vma->vm_mm, fullmm);
+				*tlbp = tlb_gather_mmu(vma->vm_mm, fullmm);
+			} else
+				tlb_flush_mmu(*tlbp, tlb_start, start);
 			tlb_start_valid = 0;
 			zap_work = ZAP_BLOCK_SIZE;
 		}
@@ -890,8 +887,7 @@ unsigned long zap_page_range(struct vm_a
 	tlb = tlb_gather_mmu(mm, 0);
 	update_hiwater_rss(mm);
 	end = unmap_vmas(&tlb, vma, address, end, &nr_accounted, details);
-	if (tlb)
-		tlb_finish_mmu(tlb, address, end);
+	tlb_finish_mmu(tlb, address, end);
 	return end;
 }
 


