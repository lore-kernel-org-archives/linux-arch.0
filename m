Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:2589 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966807AbcLVVTJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Dec 2016 16:19:09 -0500
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: [PATCH v2 3/4] mm: add follow_pte_pmd()
Date: Thu, 22 Dec 2016 14:18:55 -0700
Message-ID: <1482441536-14550-4-git-send-email-ross.zwisler@linux.intel.com>
In-Reply-To: <1482441536-14550-1-git-send-email-ross.zwisler@linux.intel.com>
References: <1482441536-14550-1-git-send-email-ross.zwisler@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>, Dave Chinner <david@fromorbit.com>, Dave Hansen <dave.hansen@intel.com>, Jan Kara <jack@suse.cz>, Matthew Wilcox <mawilcox@microsoft.com>, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org
Message-ID: <20161222211855.XNuoHhos_T0SGXmpp3AcgUDJ7NOf43Rk0EITrx7DZ40@z>

Similar to follow_pte(), follow_pte_pmd() allows either a PTE leaf or a
huge page PMD leaf to be found and returned.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 37 ++++++++++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4424784..ff0e1c1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1212,6 +1212,8 @@ void unmap_mapping_range(struct address_space *mapping,
 		loff_t const holebegin, loff_t const holelen, int even_cows);
 int follow_pte(struct mm_struct *mm, unsigned long address, pte_t **ptepp,
 	       spinlock_t **ptlp);
+int follow_pte_pmd(struct mm_struct *mm, unsigned long address,
+			     pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp);
 int follow_pfn(struct vm_area_struct *vma, unsigned long address,
 	unsigned long *pfn);
 int follow_phys(struct vm_area_struct *vma, unsigned long address,
diff --git a/mm/memory.c b/mm/memory.c
index 455c3e6..29edd91 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3779,8 +3779,8 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-static int __follow_pte(struct mm_struct *mm, unsigned long address,
-		pte_t **ptepp, spinlock_t **ptlp)
+static int __follow_pte_pmd(struct mm_struct *mm, unsigned long address,
+		pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp)
 {
 	pgd_t *pgd;
 	pud_t *pud;
@@ -3797,11 +3797,20 @@ static int __follow_pte(struct mm_struct *mm, unsigned long address,
 
 	pmd = pmd_offset(pud, address);
 	VM_BUG_ON(pmd_trans_huge(*pmd));
-	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
-		goto out;
 
-	/* We cannot handle huge page PFN maps. Luckily they don't exist. */
-	if (pmd_huge(*pmd))
+	if (pmd_huge(*pmd)) {
+		if (!pmdpp)
+			goto out;
+
+		*ptlp = pmd_lock(mm, pmd);
+		if (pmd_huge(*pmd)) {
+			*pmdpp = pmd;
+			return 0;
+		}
+		spin_unlock(*ptlp);
+	}
+
+	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
 		goto out;
 
 	ptep = pte_offset_map_lock(mm, pmd, address, ptlp);
@@ -3824,9 +3833,23 @@ int follow_pte(struct mm_struct *mm, unsigned long address, pte_t **ptepp,
 
 	/* (void) is needed to make gcc happy */
 	(void) __cond_lock(*ptlp,
-			   !(res = __follow_pte(mm, address, ptepp, ptlp)));
+			   !(res = __follow_pte_pmd(mm, address, ptepp, NULL,
+					   ptlp)));
+	return res;
+}
+
+int follow_pte_pmd(struct mm_struct *mm, unsigned long address,
+			     pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp)
+{
+	int res;
+
+	/* (void) is needed to make gcc happy */
+	(void) __cond_lock(*ptlp,
+			   !(res = __follow_pte_pmd(mm, address, ptepp, pmdpp,
+					   ptlp)));
 	return res;
 }
+EXPORT_SYMBOL(follow_pte_pmd);
 
 /**
  * follow_pfn - look up PFN at a user virtual address
-- 
2.7.4

