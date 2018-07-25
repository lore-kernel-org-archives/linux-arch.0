From: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 3/4] mm: allow arch to have tlb_flush caled on an empty
 TLB range
Date: Thu, 26 Jul 2018 00:06:40 +1000
Message-ID: <20180725140641.30372-4-npiggin@gmail.com>
References: <20180725140641.30372-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180725140641.30372-1-npiggin@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Nicholas Piggin <npiggin@gmail.com>
List-Id: linux-arch.vger.kernel.org

powerpc wants to de-couple page table caching structure flushes
from TLB flushes, which will make it possible to have mmu_gather
with freed page table pages but no TLB range. These must be sent
to tlb_flush, so allow the arch to specify when mmu_gather with
empty ranges should have tlb_flush called.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/asm-generic/tlb.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index b3353e21f3b3..b320c0cc8996 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -139,14 +139,27 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
 	}
 }
 
+/*
+ * arch_tlb_mustflush specifies if tlb_flush is to be called even if the
+ * TLB range is empty (this can be the case for freeing page table pages
+ * if the arch does not adjust TLB range to cover them).
+ */
+#ifndef arch_tlb_mustflush
+#define arch_tlb_mustflush(tlb) false
+#endif
+
 static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 {
-	if (!tlb->end)
+	unsigned long start = tlb->start;
+	unsigned long end = tlb->end;
+
+	if (!(end || arch_tlb_mustflush(tlb)))
 		return;
 
 	tlb_flush(tlb);
-	mmu_notifier_invalidate_range(tlb->mm, tlb->start, tlb->end);
 	__tlb_reset_range(tlb);
+	if (end)
+		mmu_notifier_invalidate_range(tlb->mm, start, end);
 }
 
 static inline void tlb_remove_page_size(struct mmu_gather *tlb,
-- 
2.17.0
