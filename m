From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 2/3] mm: Do not loose dirty and access bits in pmdp_invalidate()
Date: Wed, 14 Jun 2017 16:51:42 +0300
Message-ID: <20170614135143.25068-3-kirill.shutemov@linux.intel.com>
References: <20170614135143.25068-1-kirill.shutemov@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170614135143.25068-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

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

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/pgtable-generic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index c99d9512a45b..68094fa190d1 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -182,8 +182,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 		     pmd_t *pmdp)
 {
-	pmd_t entry = *pmdp;
-	set_pmd_at(vma->vm_mm, address, pmdp, pmd_mknotpresent(entry));
+	pmdp_mknotpresent(pmdp);
 	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 }
 #endif
-- 
2.11.0
