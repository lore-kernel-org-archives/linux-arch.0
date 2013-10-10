From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 23/34] powerpc: handle pgtable_page_ctor() fail
Date: Thu, 10 Oct 2013 21:05:48 +0300
Message-ID: <1381428359-14843-24-git-send-email-kirill.shutemov@linux.intel.com>
References: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/pgalloc-64.h | 5 ++++-
 arch/powerpc/mm/pgtable_32.c          | 5 ++++-
 arch/powerpc/mm/pgtable_64.c          | 7 ++++---
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
index f65e27b09b..16cb92d215 100644
--- a/arch/powerpc/include/asm/pgalloc-64.h
+++ b/arch/powerpc/include/asm/pgalloc-64.h
@@ -91,7 +91,10 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
 	if (!pte)
 		return NULL;
 	page = virt_to_page(pte);
-	pgtable_page_ctor(page);
+	if (!pgtable_page_ctor(page)) {
+		__free_page(page);
+		return NULL;
+	}
 	return page;
 }
 
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 6c856fb8c1..5b96017152 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -121,7 +121,10 @@ pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 	ptepage = alloc_pages(flags, 0);
 	if (!ptepage)
 		return NULL;
-	pgtable_page_ctor(ptepage);
+	if (!pgtable_page_ctor(ptepage)) {
+		__free_page(ptepage);
+		return NULL;
+	}
 	return ptepage;
 }
 
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 536eec72c0..9d95786aa8 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -378,6 +378,10 @@ static pte_t *__alloc_for_cache(struct mm_struct *mm, int kernel)
 				       __GFP_REPEAT | __GFP_ZERO);
 	if (!page)
 		return NULL;
+	if (!kernel && !pgtable_page_ctor(page)) {
+		__free_page(page);
+		return NULL;
+	}
 
 	ret = page_address(page);
 	spin_lock(&mm->page_table_lock);
@@ -392,9 +396,6 @@ static pte_t *__alloc_for_cache(struct mm_struct *mm, int kernel)
 	}
 	spin_unlock(&mm->page_table_lock);
 
-	if (!kernel)
-		pgtable_page_ctor(page);
-
 	return (pte_t *)ret;
 }
 
-- 
1.8.4.rc3

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
