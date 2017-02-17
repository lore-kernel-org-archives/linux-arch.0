Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:41693 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934212AbdBQONx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Feb 2017 09:13:53 -0500
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 07/33] mm: introduce __p4d_alloc()
Date: Fri, 17 Feb 2017 17:13:02 +0300
Message-ID: <20170217141328.164563-8-kirill.shutemov@linux.intel.com>
In-Reply-To: <20170217141328.164563-1-kirill.shutemov@linux.intel.com>
References: <20170217141328.164563-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20170217141302.l8zplaK_2HLiUviOo0wtaYv3wcMCoDO-RXQxCVZR_nc@z>

For full 5-level paging we need a helper to allocate p4d page table.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/memory.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index e4a37c340a56..c1e3706dc597 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3844,6 +3844,29 @@ int handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
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
