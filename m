From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v3 3/9] asm-generic/tlb: Avoid potential double flush
Date: Tue, 14 Jan 2020 15:31:39 +0530
Message-ID: <20200114100145.365527-4-aneesh.kumar@linux.ibm.com>
References: <20200114100145.365527-1-aneesh.kumar@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20200114100145.365527-1-aneesh.kumar@linux.ibm.com>
Sender: owner-linux-mm@kvack.org
To: akpm@linux-foundation.org, peterz@infradead.org, will@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Aneesh reported that:

	tlb_flush_mmu()
	  tlb_flush_mmu_tlbonly()
	    tlb_flush()			<-- #1
	  tlb_flush_mmu_free()
	    tlb_table_flush()
	      tlb_table_invalidate()
		tlb_flush_mmu_tlbonly()
		  tlb_flush()		<-- #2

does two TLBIs when tlb->fullmm, because __tlb_reset_range() will not
clear tlb->end in that case.

Observe that any caller to __tlb_adjust_range() also sets at least one
of the tlb->freed_tables || tlb->cleared_p* bits, and those are
unconditionally cleared by __tlb_reset_range().

Change the condition for actually issuing TLBI to having one of those
bits set, as opposed to having tlb->end !=3D 0.

Reported-by: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/asm-generic/tlb.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 9e22ac369d1d..b36b3bef5661 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -402,7 +402,12 @@ tlb_update_vma_flags(struct mmu_gather *tlb, struct =
vm_area_struct *vma) { }
=20
 static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 {
-	if (!tlb->end)
+	/*
+	 * Anything calling __tlb_adjust_range() also sets at least one of
+	 * these bits.
+	 */
+	if (!(tlb->freed_tables || tlb->cleared_ptes || tlb->cleared_pmds ||
+	      tlb->cleared_puds || tlb->cleared_p4ds))
 		return;
=20
 	tlb_flush(tlb);
--=20
2.24.1
