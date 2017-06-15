From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 2/3] mm: Do not loose dirty and access bits in pmdp_invalidate()
Date: Thu, 15 Jun 2017 17:52:23 +0300
Message-ID: <20170615145224.66200-3-kirill.shutemov@linux.intel.com>
References: <20170615145224.66200-1-kirill.shutemov@linux.intel.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:1605 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751673AbdFOOwi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Jun 2017 10:52:38 -0400
In-Reply-To: <20170615145224.66200-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Vlastimil noted that pmdp_invalidate() is not atomic and we can loose
dirty and access bits if CPU sets them after pmdp dereference, but
before set_pmd_at().

The bug doesn't lead to user-visible misbehaviour in current kernel.

Loosing access bit can lead to sub-optimal reclaim behaviour for THP,
but nothing destructive.

Loosing dirty bit is not a big deal too: we would make page dirty
unconditionally on splitting huge page.

The fix is critical for future work on THP: both huge-ext4 and THP swap
out rely on proper dirty tracking.

The patch change pmdp_invalidate() to make the entry non-present atomically and
return previous value of the entry. This value can be used to check if
CPU set dirty/accessed bits under us.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/asm-generic/pgtable.h | 2 +-
 mm/pgtable-generic.c          | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 7dfa767dc680..ece5e399567a 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -309,7 +309,7 @@ extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
 #endif
 
 #ifndef __HAVE_ARCH_PMDP_INVALIDATE
-extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
+extern pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 			    pmd_t *pmdp);
 #endif
 
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index c99d9512a45b..148fe36f61a7 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -179,12 +179,13 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 #endif
 
 #ifndef __HAVE_ARCH_PMDP_INVALIDATE
-void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
+pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 		     pmd_t *pmdp)
 {
-	pmd_t entry = *pmdp;
-	set_pmd_at(vma->vm_mm, address, pmdp, pmd_mknotpresent(entry));
-	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+	pmd_t old = pmdp_establish(pmdp, pmd_mknotpresent(*pmdp));
+	if (pmd_present(old))
+		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+	return old;
 }
 #endif
 
-- 
2.11.0
