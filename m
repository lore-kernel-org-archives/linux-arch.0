Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26345 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756332Ab3JJSGM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Oct 2013 14:06:12 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 16/34] hexagon: handle pgtable_page_ctor() fail
Date: Thu, 10 Oct 2013 21:05:41 +0300
Message-ID: <1381428359-14843-17-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Richard Kuo <rkuo@codeaurora.org>
Message-ID: <20131010180541.TCF5DM5zIULAT9tZCjZ8s7O3topJbI11IMWYUJB-Sr4@z>

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Richard Kuo <rkuo@codeaurora.org>
---
 arch/hexagon/include/asm/pgalloc.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
index 679bf6d664..4c9d382d77 100644
--- a/arch/hexagon/include/asm/pgalloc.h
+++ b/arch/hexagon/include/asm/pgalloc.h
@@ -65,10 +65,12 @@ static inline struct page *pte_alloc_one(struct mm_struct *mm,
 	struct page *pte;
 
 	pte = alloc_page(GFP_KERNEL | __GFP_REPEAT | __GFP_ZERO);
-
-	if (pte)
-		pgtable_page_ctor(pte);
-
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

