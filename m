Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110]:55479 "EHLO
	e06smtp14.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933112AbcAZJSG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jan 2016 04:18:06 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Tue, 26 Jan 2016 09:18:04 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 1/3] mm: provide debug_pagealloc_enabled() without CONFIG_DEBUG_PAGEALLOC
Date: Tue, 26 Jan 2016 10:18:23 +0100
Message-ID: <1453799905-10941-2-git-send-email-borntraeger@de.ibm.com>
In-Reply-To: <1453799905-10941-1-git-send-email-borntraeger@de.ibm.com>
References: <1453799905-10941-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20160126091823.lQzG8KOzbEQDiQjvmSodClRtEu7j5a72VNojD_jonSc@z>

We can provide debug_pagealloc_enabled() also if CONFIG_DEBUG_PAGEALLOC
is not set. It will return false in that case.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/linux/mm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7783073..fbc5354 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2148,6 +2148,10 @@ kernel_map_pages(struct page *page, int numpages, int enable)
 extern bool kernel_page_present(struct page *page);
 #endif /* CONFIG_HIBERNATION */
 #else
+static inline bool debug_pagealloc_enabled(void)
+{
+	return false;
+}
 static inline void
 kernel_map_pages(struct page *page, int numpages, int enable) {}
 #ifdef CONFIG_HIBERNATION
-- 
2.3.0

