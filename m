Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:56451 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752971AbdLMK7m (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Dec 2017 05:59:42 -0500
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 07/12] s390/mm: Modify pmdp_invalidate to return old value.
Date: Wed, 13 Dec 2017 13:57:51 +0300
Message-ID: <20171213105756.69879-8-kirill.shutemov@linux.intel.com>
In-Reply-To: <20171213105756.69879-1-kirill.shutemov@linux.intel.com>
References: <20171213105756.69879-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@kernel.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20171213105751.bwJBJX7tr_XW-x75sYYebFrZ6Jl0Vl572GlcE_8j1QA@z>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

It's required to avoid losing dirty and accessed bits.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/s390/include/asm/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 57d7bc92e0b8..4c72c55828c1 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1511,12 +1511,12 @@ static inline pmd_t pmdp_huge_clear_flush(struct vm_area_struct *vma,
 }
 
 #define __HAVE_ARCH_PMDP_INVALIDATE
-static inline void pmdp_invalidate(struct vm_area_struct *vma,
+static inline pmd_t pmdp_invalidate(struct vm_area_struct *vma,
 				   unsigned long addr, pmd_t *pmdp)
 {
 	pmd_t pmd = __pmd(pmd_val(*pmdp) | _SEGMENT_ENTRY_INVALID);
 
-	pmdp_xchg_direct(vma->vm_mm, addr, pmdp, pmd);
+	return pmdp_xchg_direct(vma->vm_mm, addr, pmdp, pmd);
 }
 
 #define __HAVE_ARCH_PMDP_SET_WRPROTECT
-- 
2.15.0
