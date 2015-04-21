From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] kexec: allocate the kexec control page with KEXEC_CONTROL_MEMORY_GFP
Date: Tue, 21 Apr 2015 14:06:32 +0200
Message-ID: <1429617992-31686-2-git-send-email-schwidefsky@de.ibm.com>
References: <1429617992-31686-1-git-send-email-schwidefsky@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e18.ny.us.ibm.com ([129.33.205.208]:48775 "EHLO
	e18.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933153AbbHISnT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 9 Aug 2015 14:43:19 -0400
Received: from /spool/local
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
	Sun, 9 Aug 2015 14:43:18 -0400
In-Reply-To: <1429617992-31686-1-git-send-email-schwidefsky@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>

Introduce KEXEC_CONTROL_MEMORY_GFP to allow the architecture code
to override the gfp flags of the allocation for the kexec control
page. The loop in kimage_alloc_normal_control_pages allocates pages
with GFP_KERNEL until a page is found that happens to have an
address smaller than the KEXEC_CONTROL_MEMORY_LIMIT. On systems
with a large memory size but a small KEXEC_CONTROL_MEMORY_LIMIT
the loop will keep allocating memory until the oom killer steps in.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/kexec.h | 3 +++
 include/linux/kexec.h         | 4 ++++
 kernel/kexec.c                | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
index 694bcd6..2f924bc 100644
--- a/arch/s390/include/asm/kexec.h
+++ b/arch/s390/include/asm/kexec.h
@@ -26,6 +26,9 @@
 /* Not more than 2GB */
 #define KEXEC_CONTROL_MEMORY_LIMIT (1UL<<31)
 
+/* Allocate control page with GFP_DMA */
+#define KEXEC_CONTROL_MEMORY_GFP GFP_DMA
+
 /* Maximum address we can use for the crash control pages */
 #define KEXEC_CRASH_CONTROL_MEMORY_LIMIT (-1UL)
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index e60a745..e804306 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -40,6 +40,10 @@
 #error KEXEC_CONTROL_MEMORY_LIMIT not defined
 #endif
 
+#ifndef KEXEC_CONTROL_MEMORY_GFP
+#define KEXEC_CONTROL_MEMORY_GFP GFP_KERNEL
+#endif
+
 #ifndef KEXEC_CONTROL_PAGE_SIZE
 #error KEXEC_CONTROL_PAGE_SIZE not defined
 #endif
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 38c25b1..7a36fdc 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -707,7 +707,7 @@ static struct page *kimage_alloc_normal_control_pages(struct kimage *image,
 	do {
 		unsigned long pfn, epfn, addr, eaddr;
 
-		pages = kimage_alloc_pages(GFP_KERNEL, order);
+		pages = kimage_alloc_pages(KEXEC_CONTROL_MEMORY_GFP, order);
 		if (!pages)
 			break;
 		pfn   = page_to_pfn(pages);
-- 
1.9.1
