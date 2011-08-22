From: Mark Salter <msalter@redhat.com>
Subject: [PATCH 02/24] fixed generic page.h for non-zero PAGE_OFFSET
Date: Mon, 22 Aug 2011 16:09:23 -0400
Message-ID: <1314043785-2880-3-git-send-email-msalter@redhat.com>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25803 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753520Ab1HVULC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Aug 2011 16:11:02 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7MKB2k2012081
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Mon, 22 Aug 2011 16:11:02 -0400
In-Reply-To: <1314043785-2880-1-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Mark Salter <msalter@redhat.com>

asm-generic/page.h had several problems when used with a non-zero PAGE_OFFSET.
This patch adds a default ARCH_PFN_OFFSET and fixes the __va, __pa, and
pfn_valid macros to work with non-zero PAGE_OFFSETs.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 include/asm-generic/page.h |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
index 75fec18..f376db2 100644
--- a/include/asm-generic/page.h
+++ b/include/asm-generic/page.h
@@ -71,10 +71,14 @@ extern unsigned long memory_end;
 #define PAGE_OFFSET		(0)
 #endif
 
+#ifndef ARCH_PFN_OFFSET
+#define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
+#endif
+
 #ifndef __ASSEMBLY__
 
-#define __va(x) ((void *)((unsigned long)(x) + PAGE_OFFSET))
-#define __pa(x) ((unsigned long) (x) - PAGE_OFFSET)
+#define __va(x) ((void *)((unsigned long) (x)))
+#define __pa(x) ((unsigned long) (x))
 
 #define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
 #define pfn_to_virt(pfn)	__va((pfn) << PAGE_SHIFT)
@@ -86,7 +90,7 @@ extern unsigned long memory_end;
 #define page_to_phys(page)      ((dma_addr_t)page_to_pfn(page) << PAGE_SHIFT)
 #endif
 
-#define pfn_valid(pfn)		((pfn) < max_mapnr)
+#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
 
 #define	virt_addr_valid(kaddr)	(((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
 				((void *)(kaddr) < (void *)memory_end))
-- 
1.7.6
