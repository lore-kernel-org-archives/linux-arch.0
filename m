Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:50321 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754804Ab3JJSGP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Oct 2013 14:06:15 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 29/34] um: handle pgtable_page_ctor() fail
Date: Thu, 10 Oct 2013 21:05:54 +0300
Message-ID: <1381428359-14843-30-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Message-ID: <20131010180554.cZV4D2aDejxQxRe7gpvZ1_ttdTkwC7Vhi4UrpTn8iLI@z>

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
---
 arch/um/kernel/mem.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 7ddb64baf3..8636e90542 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -279,8 +279,12 @@ pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 	struct page *pte;
 
 	pte = alloc_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
-	if (pte)
-		pgtable_page_ctor(pte);
+	if (!pte)
+		return NULL;
+	if (!pgtable_page_ctor(pte)) {
+		__free_page(pte);
+		return NULL;
+	}
 	return pte;
 }
 
-- 
1.8.4.rc3

