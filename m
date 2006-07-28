Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:22412 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751985AbWG1Ot1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 28 Jul 2006 10:49:27 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id k6SEnQY17333
	for <linux-arch@vger.kernel.org>; Fri, 28 Jul 2006 10:49:26 -0400
Subject: Proposed update to the kernel kmap/kunmap API [patch]
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <1154097354.9447.24.camel@mulgrave.il.steeleye.com>
References: <1154097354.9447.24.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 09:49:25 -0500
Message-Id: <1154098166.9447.31.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

The simple part of the proposal is to give non-highmem architectures
access to the kmap API for the purposes of overriding (this is what the
attached patch does).

The more controversial part of the proposal is that we should now
require all architectures with coherence issues to manage data coherence
via the kmap/kunmap API.  Thus driver writers never have to write code
like

kmap(page)
modify data in page
flush_kernel_dcache_page(page)
kunmap(page)

instead, kmap/kunmap will manage the coherence and driver (and
filesystem) writers don't need to worry about how to flush between kmap
and kunmap.   For most architectures, the page only needs to be flushed
if it was actually written to *and* there are user mappings of it, so
the best implementation looks to be:  clear the page dirty pte bit in
the kernel page tables on kmap and on kunmap, check page->mappings for
user maps, and then the dirty bit, and only flush if it both has user
mappings and is dirty.

James

Index: linux-2.6/include/linux/highmem.h
===================================================================
--- linux-2.6.orig/include/linux/highmem.h	2006-07-26 17:51:09.000000000 -0700
+++ linux-2.6/include/linux/highmem.h	2006-07-26 17:51:18.000000000 -0700
@@ -29,6 +29,7 @@
 
 static inline unsigned int nr_free_highpages(void) { return 0; }
 
+#ifndef ARCH_HAS_KMAP
 static inline void *kmap(struct page *page)
 {
 	might_sleep();
@@ -41,6 +42,7 @@
 #define kunmap_atomic(addr, idx)	do { } while (0)
 #define kmap_atomic_pfn(pfn, idx)	page_address(pfn_to_page(pfn))
 #define kmap_atomic_to_page(ptr)	virt_to_page(ptr)
+#endif
 
 #endif /* CONFIG_HIGHMEM */
 


