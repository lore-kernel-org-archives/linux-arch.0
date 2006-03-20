Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:61316 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S964837AbWCTQ7o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 20 Mar 2006 11:59:44 -0500
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id k2KGxg227934
	for <linux-arch@vger.kernel.org>; Mon, 20 Mar 2006 11:59:42 -0500
Subject: [PATCH] add flush_kernel_dcache_page() API
From: James Bottomley <James.Bottomley@steeleye.com>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 10:59:41 -0600
Message-Id: <1142873981.3283.33.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

We have a problem with a lot of emulated storage in that the driver takes a page
from get_user_pages() and does something like

kmap_atomic(page)
modify page
kunmap_atomic(page)

However, nothing has flushed the kernel cache view of the page before
the kunmap.  We need a lightweight API to do this, so this new API
would specifically be for flushing the kernel cache view of a user
page which the kernel has modified.  The driver would need to add
flush_kernel_dcache_page(page) before the final kunmap.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

Index: BUILD-2.6/Documentation/cachetlb.txt
===================================================================
--- BUILD-2.6.orig/Documentation/cachetlb.txt	2006-03-20 10:52:55.000000000 -0600
+++ BUILD-2.6/Documentation/cachetlb.txt	2006-03-20 10:53:03.000000000 -0600
@@ -368,6 +368,15 @@
 	get_user_pages()).  The default implementation is a nop (and
 	should remain so for all coherent architectures).
 
+  void flush_kernel_dcache_page(struct page *page)
+	When the kernel needs to modify a user page is has obtained
+	with kmap, it calls this function after all modifications are
+	complete (but before kunmapping it) to bring the underlying
+	page up to date.  It is assumed here that the user has no
+	incoherent cached copies (i.e. the original page was obtained
+	from a mechanism like get_user_pages())
+
+
   void flush_icache_range(unsigned long start, unsigned long end)
   	When the kernel stores into addresses that it will execute
 	out of (eg when loading modules), this function is called.
Index: BUILD-2.6/include/linux/highmem.h
===================================================================
--- BUILD-2.6.orig/include/linux/highmem.h	2006-03-20 10:52:55.000000000 -0600
+++ BUILD-2.6/include/linux/highmem.h	2006-03-20 10:53:03.000000000 -0600
@@ -13,6 +13,12 @@
 }
 #endif
 
+#ifndef ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
+static inline void flush_kernel_dcache_page(struct page *page)
+{
+}
+#endif
+
 #ifdef CONFIG_HIGHMEM
 
 #include <asm/highmem.h>


