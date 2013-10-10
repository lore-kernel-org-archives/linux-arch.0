From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 28/34] tile: handle pgtable_page_ctor() fail
Date: Thu, 10 Oct 2013 21:05:53 +0300
Message-ID: <1381428359-14843-29-git-send-email-kirill.shutemov@linux.intel.com>
References: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Chris Metcalf <cmetcalf@tilera.com>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Chris Metcalf <cmetcalf@tilera.com>
---
 arch/tile/mm/pgtable.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/tile/mm/pgtable.c b/arch/tile/mm/pgtable.c
index 4fd9ec0b58..5e86eac4bf 100644
--- a/arch/tile/mm/pgtable.c
+++ b/arch/tile/mm/pgtable.c
@@ -241,6 +241,11 @@ struct page *pgtable_alloc_one(struct mm_struct *mm, unsigned long address,
 	if (p == NULL)
 		return NULL;
 
+	if (!pgtable_page_ctor(p)) {
+		__free_pages(p, L2_USER_PGTABLE_ORDER);
+		return NULL;
+	}
+
 	/*
 	 * Make every page have a page_count() of one, not just the first.
 	 * We don't use __GFP_COMP since it doesn't look like it works
@@ -251,7 +256,6 @@ struct page *pgtable_alloc_one(struct mm_struct *mm, unsigned long address,
 		inc_zone_page_state(p+i, NR_PAGETABLE);
 	}
 
-	pgtable_page_ctor(p);
 	return p;
 }
 
-- 
1.8.4.rc3
