From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 32/34] xtensa: handle pgtable_page_ctor() fail
Date: Thu, 10 Oct 2013 21:05:57 +0300
Message-ID: <1381428359-14843-33-git-send-email-kirill.shutemov@linux.intel.com>
References: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/pgalloc.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/include/asm/pgalloc.h b/arch/xtensa/include/asm/pgalloc.h
index 037671a655..b8774f1e21 100644
--- a/arch/xtensa/include/asm/pgalloc.h
+++ b/arch/xtensa/include/asm/pgalloc.h
@@ -58,7 +58,10 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
 	if (!pte)
 		return NULL;
 	page = virt_to_page(pte);
-	pgtable_page_ctor(page);
+	if (!pgtable_page_ctor(page)) {
+		kmem_cache_free(pgtable_cache, pte);
+		return NULL;
+	}
 	return page;
 }
 
-- 
1.8.4.rc3
