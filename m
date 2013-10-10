From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 20/34] metag: handle pgtable_page_ctor() fail
Date: Thu, 10 Oct 2013 21:05:45 +0300
Message-ID: <1381428359-14843-21-git-send-email-kirill.shutemov@linux.intel.com>
References: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:50321 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756591Ab3JJSGO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Oct 2013 14:06:14 -0400
In-Reply-To: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, James Hogan <james.hogan@imgtec.com>

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: James Hogan <james.hogan@imgtec.com>
---
 arch/metag/include/asm/pgalloc.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/metag/include/asm/pgalloc.h b/arch/metag/include/asm/pgalloc.h
index 275d928514..3104df0a48 100644
--- a/arch/metag/include/asm/pgalloc.h
+++ b/arch/metag/include/asm/pgalloc.h
@@ -52,8 +52,12 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
 {
 	struct page *pte;
 	pte = alloc_pages(GFP_KERNEL | __GFP_REPEAT | __GFP_ZERO, 0);
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
