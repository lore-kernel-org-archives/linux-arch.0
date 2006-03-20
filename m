Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:39905 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751193AbWCTBQb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 19 Mar 2006 20:16:31 -0500
Subject: Re: Potential problem with the page_mapping macro and
	flush_dcache_page()
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <1142812219.3240.79.camel@mulgrave.il.steeleye.com>
References: <20060319.130009.102283514.davem@davemloft.net>
	 <1142802286.3240.54.camel@mulgrave.il.steeleye.com>
	 <1142803431.3240.58.camel@mulgrave.il.steeleye.com>
	 <20060319.132603.132950779.davem@davemloft.net>
	 <1142812219.3240.79.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Date: Sun, 19 Mar 2006 19:15:47 -0600
Message-Id: <1142817348.3240.84.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2006-03-19 at 17:50 -0600, James Bottomley wrote:
> It looks like there's no other API I can use for this ... do you want me
> to construct another?  something like flush_anon_page()?

This is my proposal for such an API, with a default nop implementation
including the parisc implementation.

James

diff --git a/Documentation/cachetlb.txt b/Documentation/cachetlb.txt
index 4ae4188..2627c73 100644
Index: tmp-2.6/Documentation/cachetlb.txt
===================================================================
--- tmp-2.6.orig/Documentation/cachetlb.txt	2006-03-19 19:09:30.000000000 -0600
+++ tmp-2.6/Documentation/cachetlb.txt	2006-03-19 19:09:38.000000000 -0600
@@ -362,6 +362,12 @@
 	likely that you will need to flush the instruction cache
 	for copy_to_user_page().
 
+  void flush_anon_page(struct page *page, unsigned long vmaddr)
+	when the kernel needs to access the contents of an anonymous
+	page, it calls this function (currently only
+	get_user_pages()).  The default implementation is a nop (and
+	should remain so for all coherent architectures).
+
   void flush_icache_range(unsigned long start, unsigned long end)
   	When the kernel stores into addresses that it will execute
 	out of (eg when loading modules), this function is called.
Index: tmp-2.6/include/asm-parisc/cacheflush.h
===================================================================
--- tmp-2.6.orig/include/asm-parisc/cacheflush.h	2006-03-19 19:09:30.000000000 -0600
+++ tmp-2.6/include/asm-parisc/cacheflush.h	2006-03-19 19:13:19.000000000 -0600
@@ -184,6 +184,14 @@
 
 }
 
+static inline void
+flush_anon_page(struct page *page, unsigned long vmaddr)
+{
+	if (PageAnon(page))
+		flush_user_dcache_page(vmaddr);
+}
+#define ARCH_HAS_FLUSH_ANON_PAGE
+
 #ifdef CONFIG_DEBUG_RODATA
 void mark_rodata_ro(void);
 #endif
Index: tmp-2.6/include/linux/highmem.h
===================================================================
--- tmp-2.6.orig/include/linux/highmem.h	2006-03-19 19:09:30.000000000 -0600
+++ tmp-2.6/include/linux/highmem.h	2006-03-19 19:09:38.000000000 -0600
@@ -7,6 +7,12 @@
 
 #include <asm/cacheflush.h>
 
+#ifndef ARCH_HAS_FLUSH_ANON_PAGE
+static inline void flush_anon_page(struct page *page, unsigned long vmaddr)
+{
+}
+#endif
+
 #ifdef CONFIG_HIGHMEM
 
 #include <asm/highmem.h>
Index: tmp-2.6/mm/memory.c
===================================================================
--- tmp-2.6.orig/mm/memory.c	2006-03-19 19:09:30.000000000 -0600
+++ tmp-2.6/mm/memory.c	2006-03-19 19:09:38.000000000 -0600
@@ -1074,6 +1074,8 @@
 			}
 			if (pages) {
 				pages[i] = page;
+
+				flush_anon_page(page, start);
 				flush_dcache_page(page);
 			}
 			if (vmas)


