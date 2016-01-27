Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106]:41000 "EHLO
	e06smtp10.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022AbcA0IuC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jan 2016 03:50:02 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Wed, 27 Jan 2016 08:50:00 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 1/3] mm: provide debug_pagealloc_enabled() without CONFIG_DEBUG_PAGEALLOC
Date: Wed, 27 Jan 2016 09:50:16 +0100
Message-ID: <1453884618-33852-2-git-send-email-borntraeger@de.ibm.com>
In-Reply-To: <1453884618-33852-1-git-send-email-borntraeger@de.ibm.com>
References: <1453884618-33852-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, Joonsoo Kim <iamjoonsoo.kim@lge.com>, davej@codemonkey.org.uk, Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20160127085016.ATqDqru9BrY9bXK0hSCrH0ytQZ6mv5VNaknn71po7LI@z>

We can provide debug_pagealloc_enabled() also if CONFIG_DEBUG_PAGEALLOC
is not set. It will return false in that case.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 include/linux/mm.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7783073..56cab4e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2147,13 +2147,18 @@ kernel_map_pages(struct page *page, int numpages, int enable)
 #ifdef CONFIG_HIBERNATION
 extern bool kernel_page_present(struct page *page);
 #endif /* CONFIG_HIBERNATION */
-#else
+#else  /* CONFIG_DEBUG_PAGEALLOC */
+static inline bool debug_pagealloc_enabled(void)
+{
+	return false;
+}
+
 static inline void
 kernel_map_pages(struct page *page, int numpages, int enable) {}
 #ifdef CONFIG_HIBERNATION
 static inline bool kernel_page_present(struct page *page) { return true; }
 #endif /* CONFIG_HIBERNATION */
-#endif
+#endif /* CONFIG_DEBUG_PAGEALLOC */
 
 #ifdef __HAVE_ARCH_GATE_AREA
 extern struct vm_area_struct *get_gate_vma(struct mm_struct *mm);
-- 
2.3.0

