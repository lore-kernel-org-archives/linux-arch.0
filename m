Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:10074 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756139Ab3JJSGL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Oct 2013 14:06:11 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 19/34] m68k: handle pgtable_page_ctor() fail
Date: Thu, 10 Oct 2013 21:05:44 +0300
Message-ID: <1381428359-14843-20-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <20131010180544.x3FkUr5_AISGM1uYcZ2rGh9aVgRqbjYOIvnnBxE7Dz4@z>

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/include/asm/motorola_pgalloc.h | 5 ++++-
 arch/m68k/include/asm/sun3_pgalloc.h     | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/include/asm/motorola_pgalloc.h b/arch/m68k/include/asm/motorola_pgalloc.h
index 2f02f264e6..dd254eeb03 100644
--- a/arch/m68k/include/asm/motorola_pgalloc.h
+++ b/arch/m68k/include/asm/motorola_pgalloc.h
@@ -40,7 +40,10 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addres
 	flush_tlb_kernel_page(pte);
 	nocache_page(pte);
 	kunmap(page);
-	pgtable_page_ctor(page);
+	if (!pgtable_page_ctor(page)) {
+		__free_page(page);
+		return NULL;
+	}
 	return page;
 }
 
diff --git a/arch/m68k/include/asm/sun3_pgalloc.h b/arch/m68k/include/asm/sun3_pgalloc.h
index 48d80d5a66..f868506e33 100644
--- a/arch/m68k/include/asm/sun3_pgalloc.h
+++ b/arch/m68k/include/asm/sun3_pgalloc.h
@@ -59,7 +59,10 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
 		return NULL;
 
 	clear_highpage(page);
-	pgtable_page_ctor(page);
+	if (!pgtable_page_ctor(page)) {
+		__free_page(page);
+		return NULL;
+	}
 	return page;
 
 }
-- 
1.8.4.rc3

