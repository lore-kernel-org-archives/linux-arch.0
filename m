Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15491 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755691Ab3JJSGI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Oct 2013 14:06:08 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 06/34] microblaze: add missing pgtable_page_ctor/dtor calls
Date: Thu, 10 Oct 2013 21:05:31 +0300
Message-ID: <1381428359-14843-7-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Michal Simek <monstr@monstr.eu>
Message-ID: <20131010180531.GQ49Lh9Evvat57dWNZnOU1713iOHSNk7PkK7zxlm0xk@z>

It will fix NR_PAGETABLE accounting. It's also required if the arch is
going ever support split ptl.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/include/asm/pgalloc.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/microblaze/include/asm/pgalloc.h b/arch/microblaze/include/asm/pgalloc.h
index ebd3579248..7fdf7fabc7 100644
--- a/arch/microblaze/include/asm/pgalloc.h
+++ b/arch/microblaze/include/asm/pgalloc.h
@@ -122,8 +122,13 @@ static inline struct page *pte_alloc_one(struct mm_struct *mm,
 #endif
 
 	ptepage = alloc_pages(flags, 0);
-	if (ptepage)
-		clear_highpage(ptepage);
+	if (!ptepage)
+		return NULL;
+	clear_highpage(ptepage);
+	if (!pgtable_page_ctor(ptepage)) {
+		__free_page(ptepage);
+		return NULL;
+	}
 	return ptepage;
 }
 
@@ -158,8 +163,9 @@ extern inline void pte_free_slow(struct page *ptepage)
 	__free_page(ptepage);
 }
 
-extern inline void pte_free(struct mm_struct *mm, struct page *ptepage)
+static inline void pte_free(struct mm_struct *mm, struct page *ptepage)
 {
+	pgtable_page_dtor(ptepage);
 	__free_page(ptepage);
 }
 
-- 
1.8.4.rc3

