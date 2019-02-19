Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:55578 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbfBSKdQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Feb 2019 05:33:16 -0500
Message-ID: <20190219103233.148854086@infradead.org>
Date: Tue, 19 Feb 2019 11:31:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v6 05/18] asm-generic/tlb: Provide generic tlb_flush() based on flush_tlb_mm()
References: <20190219103148.192029670@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, peterz@infradead.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
Message-ID: <20190219103153.XaGHxufszQFGRbRkiryE-Q65R5Idq2D2N1xWFCshh-Q@z>

When an architecture does not have (an efficient) flush_tlb_range(),
but instead always uses full TLB invalidates, the current generic
tlb_flush() is sub-optimal, for it will generate extra flushes in
order to keep the range small.

But if we cannot do range flushes, that is a moot concern. Optionally
provide this simplified default.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h |   41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -114,7 +114,8 @@
  *    returns the smallest TLB entry size unmapped in this range.
  *
  * If an architecture does not provide tlb_flush() a default implementation
- * based on flush_tlb_range() will be used.
+ * based on flush_tlb_range() will be used, unless MMU_GATHER_NO_RANGE is
+ * specified, in which case we'll default to flush_tlb_mm().
  *
  * Additionally there are a few opt-in features:
  *
@@ -140,6 +141,9 @@
  *  the page-table pages. Required if you use HAVE_RCU_TABLE_FREE and your
  *  architecture uses the Linux page-tables natively.
  *
+ *  MMU_GATHER_NO_RANGE
+ *
+ *  Use this if your architecture lacks an efficient flush_tlb_range().
  */
 #define HAVE_GENERIC_MMU_GATHER
 
@@ -302,12 +306,45 @@ static inline void __tlb_reset_range(str
 	 */
 }
 
+#ifdef CONFIG_MMU_GATHER_NO_RANGE
+
+#if defined(tlb_flush) || defined(tlb_start_vma) || defined(tlb_end_vma)
+#error MMU_GATHER_NO_RANGE relies on default tlb_flush(), tlb_start_vma() and tlb_end_vma()
+#endif
+
+/*
+ * When an architecture does not have efficient means of range flushing TLBs
+ * there is no point in doing intermediate flushes on tlb_end_vma() to keep the
+ * range small. We equally don't have to worry about page granularity or other
+ * things.
+ *
+ * All we need to do is issue a full flush for any !0 range.
+ */
+static inline void tlb_flush(struct mmu_gather *tlb)
+{
+	if (tlb->end)
+		flush_tlb_mm(tlb->mm);
+}
+
+static inline void
+tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
+
+#define tlb_end_vma tlb_end_vma
+static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
+
+#else /* CONFIG_MMU_GATHER_NO_RANGE */
+
 #ifndef tlb_flush
 
 #if defined(tlb_start_vma) || defined(tlb_end_vma)
 #error Default tlb_flush() relies on default tlb_start_vma() and tlb_end_vma()
 #endif
 
+/*
+ * When an architecture does not provide its own tlb_flush() implementation
+ * but does have a reasonably efficient flush_vma_range() implementation
+ * use that.
+ */
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 	if (tlb->fullmm || tlb->need_flush_all) {
@@ -348,6 +385,8 @@ tlb_update_vma_flags(struct mmu_gather *
 
 #endif
 
+#endif /* CONFIG_MMU_GATHER_NO_RANGE */
+
 static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 {
 	if (!tlb->end)
