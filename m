Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:22408 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932530AbdCFUps (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 6 Mar 2017 15:45:48 -0500
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 7/7] mm: introduce __p4d_alloc()
Date: Mon,  6 Mar 2017 23:45:14 +0300
Message-ID: <20170306204514.1852-8-kirill.shutemov@linux.intel.com>
In-Reply-To: <20170306204514.1852-1-kirill.shutemov@linux.intel.com>
References: <20170306204514.1852-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20170306204514.D_mJ_YfRDjQp4xMk0qV6hq6RbglDBQuEkhtRjygWHUM@z>

For full 5-level paging we need a helper to allocate p4d page table.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/memory.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 7f1c2163b3ce..235ba51b2fbf 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3906,6 +3906,29 @@ int handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 }
 EXPORT_SYMBOL_GPL(handle_mm_fault);
 
+#ifndef __PAGETABLE_P4D_FOLDED
+/*
+ * Allocate p4d page table.
+ * We've already handled the fast-path in-line.
+ */
+int __p4d_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
+{
+	p4d_t *new = p4d_alloc_one(mm, address);
+	if (!new)
+		return -ENOMEM;
+
+	smp_wmb(); /* See comment in __pte_alloc */
+
+	spin_lock(&mm->page_table_lock);
+	if (pgd_present(*pgd))		/* Another has populated it */
+		p4d_free(mm, new);
+	else
+		pgd_populate(mm, pgd, new);
+	spin_unlock(&mm->page_table_lock);
+	return 0;
+}
+#endif /* __PAGETABLE_P4D_FOLDED */
+
 #ifndef __PAGETABLE_PUD_FOLDED
 /*
  * Allocate page upper directory.
-- 
2.11.0
