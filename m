From: Namhyung Kim <namhyung@gmail.com>
Subject: [RFC][PATCH] introduce ptr_diff()
Date: Thu, 19 Aug 2010 20:37:36 +0900
Message-ID: <1282217856-8625-1-git-send-email-namhyung@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53710 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583Ab0HSLhg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Aug 2010 07:37:36 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

When I compiled allyesconfig'ed kernel with C=1, I got 1519 lines of
following message:

 include/linux/mm.h:599:16: warning: potentially expensive pointer subtraction

which is around 10% of total warnings. this was caused by page_to_pfn() macro
so I think it's worth to remove it by calculating pointer subtraction
manually.

ptr_diff() does subtraction of two pointers as if they were integer values
and divides it by the size of their base type. Currently it does not deal
with a difference alignment requirement than the size of base type, it
would be a trivial job.

Impact: remove a _lot_ of sparse warnings
Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---

I have no idea where the right place is.
Please kindly point me to the place if here is not the one.
And any comments are greatly welcomed also.

Thanks.

 include/asm-generic/memory_model.h |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/memory_model.h b/include/asm-generic/memory_model.h
index fb2d63f..ffec625 100644
--- a/include/asm-generic/memory_model.h
+++ b/include/asm-generic/memory_model.h
@@ -22,13 +22,28 @@
 
 #endif /* CONFIG_DISCONTIGMEM */
 
+#include <linux/log2.h>
+
+#define ptr_diff(p1, p2)					\
+({	long __diff;						\
+	unsigned long  __addr1 = (unsigned long) (p1);		\
+	unsigned long  __addr2 = (unsigned long) (p2);		\
+	unsigned __size = sizeof(typeof(*p1));			\
+								\
+	if (is_power_of_2(__size))				\
+		__diff = (__addr1 - __addr2) >> ilog2(__size);	\
+	else							\
+		__diff = (__addr1 - __addr2) / __size;		\
+	__diff;							\
+})
+
 /*
  * supports 3 memory models.
  */
 #if defined(CONFIG_FLATMEM)
 
 #define __pfn_to_page(pfn)	(mem_map + ((pfn) - ARCH_PFN_OFFSET))
-#define __page_to_pfn(page)	((unsigned long)((page) - mem_map) + \
+#define __page_to_pfn(page)	((unsigned long)(ptr_diff((page), mem_map)) + \
 				 ARCH_PFN_OFFSET)
 #elif defined(CONFIG_DISCONTIGMEM)
 
@@ -41,7 +56,7 @@
 #define __page_to_pfn(pg)						\
 ({	struct page *__pg = (pg);					\
 	struct pglist_data *__pgdat = NODE_DATA(page_to_nid(__pg));	\
-	(unsigned long)(__pg - __pgdat->node_mem_map) +			\
+	(unsigned long)(ptr_diff(__pg, __pgdat->node_mem_map)) +	\
 	 __pgdat->node_start_pfn;					\
 })
 
@@ -49,7 +64,7 @@
 
 /* memmap is virtually contiguous.  */
 #define __pfn_to_page(pfn)	(vmemmap + (pfn))
-#define __page_to_pfn(page)	(unsigned long)((page) - vmemmap)
+#define __page_to_pfn(page)	(unsigned long)(ptr_diff((page), vmemmap))
 
 #elif defined(CONFIG_SPARSEMEM)
 /*
@@ -59,7 +74,7 @@
 #define __page_to_pfn(pg)					\
 ({	struct page *__pg = (pg);				\
 	int __sec = page_to_section(__pg);			\
-	(unsigned long)(__pg - __section_mem_map_addr(__nr_to_section(__sec)));	\
+	(unsigned long)(ptr_diff(__pg,  __section_mem_map_addr(__nr_to_section(__sec)))); \
 })
 
 #define __pfn_to_page(pfn)				\
-- 
1.7.0.4
