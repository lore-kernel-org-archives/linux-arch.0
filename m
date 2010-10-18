From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 10/20] s390: preemptible mmu_gather
Date: Mon, 18 Oct 2010 13:24:43 +0200
Message-ID: <20101018112950.798606061@chello.nl>
References: <20101018112433.556591568@chello.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=martin-mm-preempt-tlb-gather-s390.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-fou
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Adapt the stand-alone s390 mmu_gather implementation to the new
preemptible mmu_gather interface.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 arch/s390/include/asm/tlb.h |   43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

Index: linux-2.6/arch/s390/include/asm/tlb.h
===================================================================
--- linux-2.6.orig/arch/s390/include/asm/tlb.h
+++ linux-2.6/arch/s390/include/asm/tlb.h
@@ -28,44 +28,50 @@
 #include <asm/smp.h>
 #include <asm/tlbflush.h>
 
-#ifndef CONFIG_SMP
-#define TLB_NR_PTRS	1
-#else
-#define TLB_NR_PTRS	508
-#endif
-
 struct mmu_gather {
 	struct mm_struct *mm;
 	unsigned int fullmm;
 	unsigned int nr_ptes;
 	unsigned int nr_pxds;
-	void *array[TLB_NR_PTRS];
+	unsigned int max;
+	void **array;
+	void *local[8];
 };
 
-DECLARE_PER_CPU(struct mmu_gather, mmu_gathers);
-
-static inline struct mmu_gather *tlb_gather_mmu(struct mm_struct *mm,
-						unsigned int full_mm_flush)
+static inline void __tlb_alloc_pages(struct mmu_gather *tlb)
 {
-	struct mmu_gather *tlb = &get_cpu_var(mmu_gathers);
+	unsigned long addr = __get_free_pages(GFP_ATOMIC, 0);
+
+	if (addr) {
+		tlb->array = (void *) addr;
+		tlb->max = PAGE_SIZE / sizeof(void *);
+	}
+}
 
+static inline void tlb_gather_mmu(struct mmu_gather *tlb,
+				  struct mm_struct *mm,
+				  unsigned int full_mm_flush)
+{
 	tlb->mm = mm;
+	tlb->max = ARRAY_SIZE(tlb->local);
+	tlb->array = tlb->local;
 	tlb->fullmm = full_mm_flush;
-	tlb->nr_ptes = 0;
-	tlb->nr_pxds = TLB_NR_PTRS;
 	if (tlb->fullmm)
 		__tlb_flush_mm(mm);
-	return tlb;
+	else
+		__tlb_alloc_pages(tlb);
+	tlb->nr_ptes = 0;
+	tlb->nr_pxds = tlb->max;
 }
 
 static inline void tlb_flush_mmu(struct mmu_gather *tlb,
 				 unsigned long start, unsigned long end)
 {
-	if (!tlb->fullmm && (tlb->nr_ptes > 0 || tlb->nr_pxds < TLB_NR_PTRS))
+	if (!tlb->fullmm && (tlb->nr_ptes > 0 || tlb->nr_pxds < tlb->max))
 		__tlb_flush_mm(tlb->mm);
 	while (tlb->nr_ptes > 0)
 		pte_free(tlb->mm, tlb->array[--tlb->nr_ptes]);
-	while (tlb->nr_pxds < TLB_NR_PTRS)
+	while (tlb->nr_pxds < tlb->max)
 		/* pgd_free frees the pointer as region or segment table */
 		pgd_free(tlb->mm, tlb->array[tlb->nr_pxds++]);
 }
@@ -78,7 +84,8 @@ static inline void tlb_finish_mmu(struct
 	/* keep the page table cache within bounds */
 	check_pgt_cache();
 
-	put_cpu_var(mmu_gathers);
+	if (tlb->array != tlb->local)
+		free_pages((unsigned long) tlb->array, 0);
 }
 
 /*
