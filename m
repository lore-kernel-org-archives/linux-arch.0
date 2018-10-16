From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 4/5] mm/cow: optimise pte dirty bit handling in fork
Date: Tue, 16 Oct 2018 23:13:42 +1000
Message-ID: <20181016131343.20556-5-npiggin@gmail.com>
References: <20181016131343.20556-1-npiggin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016131343.20556-1-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ley Foon Tan <ley.foon.tan@intel.com>
List-Id: linux-arch.vger.kernel.org

fork clears dirty/accessed bits from new ptes in the child. This logic
has existed since mapped page reclaim was done by scanning ptes when
it may have been quite important. Today with physical based pte
scanning, there is less reason to clear these bits, so this patch
avoids clearing the dirty bit in the child.

Dirty bits are all tested and cleared together, and any dirty bit is
the same as many dirty bits, so from a correctness and writeback
bandwidth point-of-view it does not matter if the child gets a dirty
bit.

Dirty ptes are more costly to unmap because they require flushing
under the page table lock, but it is pretty rare to have a shared
dirty mapping that is copied on fork, so just simplify the code and
avoid this dirty clearing logic.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/memory.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0387ee1e3582..9e314339a0bd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1028,11 +1028,12 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	}
 
 	/*
-	 * If it's a shared mapping, mark it clean in
-	 * the child
+	 * Child inherits dirty and young bits from parent. There is no
+	 * point clearing them because any cleaning or aging has to walk
+	 * all ptes anyway, and it will notice the bits set in the parent.
+	 * Leaving them set avoids stalls and even page faults on CPUs that
+	 * handle these bits in software.
 	 */
-	if (vm_flags & VM_SHARED)
-		pte = pte_mkclean(pte);
 
 	page = vm_normal_page(vma, addr, pte);
 	if (page) {
-- 
2.18.0
