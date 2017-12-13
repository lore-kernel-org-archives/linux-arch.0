Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:65370 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752728AbdLMK6P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Dec 2017 05:58:15 -0500
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 10/12] mm: Do not lose dirty and access bits in pmdp_invalidate()
Date: Wed, 13 Dec 2017 13:57:54 +0300
Message-ID: <20171213105756.69879-11-kirill.shutemov@linux.intel.com>
In-Reply-To: <20171213105756.69879-1-kirill.shutemov@linux.intel.com>
References: <20171213105756.69879-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@kernel.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Hugh Dickins <hughd@google.com>
Message-ID: <20171213105754.w0EWBS5xl7qgbIwXHp1WLH02heTNe95VxCjHkOX-Qqo@z>

Vlastimil noted that pmdp_invalidate() is not atomic and we can lose
dirty and access bits if CPU sets them after pmdp dereference, but
before set_pmd_at().

The patch change pmdp_invalidate() to make the entry non-present atomically and
return previous value of the entry. This value can be used to check if
CPU set dirty/accessed bits under us.

The race window is very small and I haven't seen any reports that can be
attributed to the bug. For this reason, I don't think backporting to
stable trees needed.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Hugh Dickins <hughd@google.com>
---
 include/asm-generic/pgtable.h | 2 +-
 mm/pgtable-generic.c          | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index ae83b14200b8..f449c71cbdc0 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -325,7 +325,7 @@ static inline pmd_t generic_pmdp_establish(struct vm_area_struct *vma,
 #endif
 
 #ifndef __HAVE_ARCH_PMDP_INVALIDATE
-extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
+extern pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 			    pmd_t *pmdp);
 #endif
 
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 1e4ee763c190..cf2af04b34b9 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -181,12 +181,12 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 #endif
 
 #ifndef __HAVE_ARCH_PMDP_INVALIDATE
-void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
+pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 		     pmd_t *pmdp)
 {
-	pmd_t entry = *pmdp;
-	set_pmd_at(vma->vm_mm, address, pmdp, pmd_mknotpresent(entry));
+	pmd_t old = pmdp_establish(vma, address, pmdp, pmd_mknotpresent(*pmdp));
 	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+	return old;
 }
 #endif
 
-- 
2.15.0
