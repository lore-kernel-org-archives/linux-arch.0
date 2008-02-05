Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36362 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751136AbYBEGmJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 5 Feb 2008 01:42:09 -0500
Message-Id: <200802050628.m156SvCC006865@imap1.linux-foundation.org>
Subject: [patch 115/265] arch_rebalance_pgtables call
From: akpm@linux-foundation.org
Date: Mon, 04 Feb 2008 22:29:16 -0800
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, schwidefsky@de.ibm.com, benh@kernel.crashing.org, linux-arch@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

In order to change the layout of the page tables after an mmap has crossed the
adress space limit of the current page table layout a architecture hook in
get_unmapped_area is needed.  The arguments are the address of the new mapping
and the length of it.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: <linux-arch@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/mmap.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff -puN mm/mmap.c~arch_rebalance_pgtables-call mm/mmap.c
--- a/mm/mmap.c~arch_rebalance_pgtables-call
+++ a/mm/mmap.c
@@ -36,6 +36,10 @@
 #define arch_mmap_check(addr, len, flags)	(0)
 #endif
 
+#ifndef arch_rebalance_pgtables
+#define arch_rebalance_pgtables(addr, len)		(addr)
+#endif
+
 static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long start, unsigned long end);
@@ -1424,7 +1428,7 @@ get_unmapped_area(struct file *file, uns
 	if (addr & ~PAGE_MASK)
 		return -EINVAL;
 
-	return addr;
+	return arch_rebalance_pgtables(addr, len);
 }
 
 EXPORT_SYMBOL(get_unmapped_area);
_
