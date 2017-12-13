Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:37299 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752600AbdLMK7I (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Dec 2017 05:59:08 -0500
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 01/12] asm-generic: Provide generic_pmdp_establish()
Date: Wed, 13 Dec 2017 13:57:45 +0300
Message-ID: <20171213105756.69879-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20171213105756.69879-1-kirill.shutemov@linux.intel.com>
References: <20171213105756.69879-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@kernel.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20171213105745.wLw5-Gy2jEpQ0nMiCRq2uU3GcpmK3_43zhFmUV4h9ws@z>

This is an implementation of pmdp_establish() that is only suitable for
an architecture that doesn't have hardware dirty/accessed bits. In this
case we can't race with CPU which sets these bits and non-atomic
approach is fine.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/asm-generic/pgtable.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index b234d54f2cb6..ae83b14200b8 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -309,6 +309,21 @@ extern void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
 #endif
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+/*
+ * This is an implementation of pmdp_establish() that is only suitable for an
+ * architecture that doesn't have hardware dirty/accessed bits. In this case we
+ * can't race with CPU which sets these bits and non-atomic aproach is fine.
+ */
+static inline pmd_t generic_pmdp_establish(struct vm_area_struct *vma,
+		unsigned long address, pmd_t *pmdp, pmd_t pmd)
+{
+	pmd_t old_pmd = *pmdp;
+	set_pmd_at(vma->vm_mm, address, pmdp, pmd);
+	return old_pmd;
+}
+#endif
+
 #ifndef __HAVE_ARCH_PMDP_INVALIDATE
 extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 			    pmd_t *pmdp);
-- 
2.15.0
