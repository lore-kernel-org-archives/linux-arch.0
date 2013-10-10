Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26345 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756529Ab3JJSGM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Oct 2013 14:06:12 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 18/34] m32r: handle pgtable_page_ctor() fail
Date: Thu, 10 Oct 2013 21:05:43 +0300
Message-ID: <1381428359-14843-19-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Hirokazu Takata <takata@linux-m32r.org>
Message-ID: <20131010180543.T-mHNDFhs2A3HbJNBAJ6T-ESA6oC96TA6x94axBQaEI@z>

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Hirokazu Takata <takata@linux-m32r.org>
---
 arch/m32r/include/asm/pgalloc.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/m32r/include/asm/pgalloc.h b/arch/m32r/include/asm/pgalloc.h
index ac4208bcc5..2d55a064cc 100644
--- a/arch/m32r/include/asm/pgalloc.h
+++ b/arch/m32r/include/asm/pgalloc.h
@@ -45,7 +45,10 @@ static __inline__ pgtable_t pte_alloc_one(struct mm_struct *mm,
 
 	if (!pte)
 		return NULL;
-	pgtable_page_ctor(pte);
+	if (!pgtable_page_ctor(pte)) {
+		__free_page(pte);
+		return NULL;
+	}
 	return pte;
 }
 
-- 
1.8.4.rc3

