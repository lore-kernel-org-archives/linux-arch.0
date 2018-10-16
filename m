From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 1/5] nios2: update_mmu_cache clear the old entry from the TLB
Date: Tue, 16 Oct 2018 23:13:39 +1000
Message-ID: <20181016131343.20556-2-npiggin@gmail.com>
References: <20181016131343.20556-1-npiggin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016131343.20556-1-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ley Foon Tan <ley.foon.tan@intel.com>
List-Id: linux-arch.vger.kernel.org

Fault paths like do_read_fault will install a Linux pte with the young
bit clear. The CPU will fault again because the TLB has not been
updated, this time a valid pte exists so handle_pte_fault will just
set the young bit with ptep_set_access_flags, which flushes the TLB.

The TLB is flushed so the next attempt will go to the fast TLB handler
which loads the TLB with the new Linux pte. The access then proceeds.

This design is fragile to depend on the young bit being clear after
the initial Linux fault. A proposed core mm change to immediately set
the young bit upon such a fault, results in ptep_set_access_flags not
flushing the TLB because it finds no change to the pte. The spurious
fault fix path only flushes the TLB if the access was a store. If it
was a load, then this results in an infinite loop of page faults.

This change adds a TLB flush in update_mmu_cache, which removes that
TLB entry upon the first fault. This will cause the fast TLB handler
to load the new pte and avoid the Linux page fault entirely.

Reviewed-by: Ley Foon Tan <ley.foon.tan@intel.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/nios2/mm/cacheflush.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/nios2/mm/cacheflush.c b/arch/nios2/mm/cacheflush.c
index 506f6e1c86d5..d58e7e80dc0d 100644
--- a/arch/nios2/mm/cacheflush.c
+++ b/arch/nios2/mm/cacheflush.c
@@ -204,6 +204,8 @@ void update_mmu_cache(struct vm_area_struct *vma,
 	struct page *page;
 	struct address_space *mapping;
 
+	flush_tlb_page(vma, address);
+
 	if (!pfn_valid(pfn))
 		return;
 
-- 
2.18.0
