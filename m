Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:24829 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755877Ab3JJSGJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Oct 2013 14:06:09 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 13/34] avr32: handle pgtable_page_ctor() fail
Date: Thu, 10 Oct 2013 21:05:38 +0300
Message-ID: <1381428359-14843-14-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>
Message-ID: <20131010180538.ss8vooDAaRjooXsEzfIi0xf4Cch8XIK73JR2iJ1ULRg@z>

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
---
 arch/avr32/include/asm/pgalloc.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/avr32/include/asm/pgalloc.h b/arch/avr32/include/asm/pgalloc.h
index bc7e8ae479..1aba19d68c 100644
--- a/arch/avr32/include/asm/pgalloc.h
+++ b/arch/avr32/include/asm/pgalloc.h
@@ -68,7 +68,10 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
 		return NULL;
 
 	page = virt_to_page(pg);
-	pgtable_page_ctor(page);
+	if (!pgtable_page_ctor(page)) {
+		quicklist_free(QUICK_PT, NULL, pg);
+		return NULL;
+	}
 
 	return page;
 }
-- 
1.8.4.rc3

