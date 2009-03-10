From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 2/2 -mmotm] debug-pagealloc: cannot depend on hibernation
Date: Tue, 10 Mar 2009 23:38:57 +0900
Message-ID: <20090310143857.GB3151@localhost.localdomain>
References: <20090310143701.GA3151@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:5169 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754619AbZCJOjR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Mar 2009 10:39:17 -0400
Content-Disposition: inline
In-Reply-To: <20090310143701.GA3151@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org

The generic debug-pagealloc generates wrong messages for the page corruption
after hibernation. Because the free pages are not saved to the suspend image.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: <linux-arch@vger.kernel.org>
---
 mm/Kconfig.debug |    5 +++++
 1 file changed, 5 insertions(+)

Index: 2.6-mmotm/mm/Kconfig.debug
===================================================================
--- 2.6-mmotm.orig/mm/Kconfig.debug
+++ 2.6-mmotm/mm/Kconfig.debug
@@ -4,9 +4,14 @@ config WANT_PAGE_DEBUG_FLAGS
 config PAGE_POISONING
 	bool "Debug page memory allocations"
 	depends on DEBUG_KERNEL && !ARCH_SUPPORTS_DEBUG_PAGEALLOC
+	depends on !HIBERNATION
 	select DEBUG_PAGEALLOC
 	select WANT_PAGE_DEBUG_FLAGS
 	help
 	   Fill the pages with poison patterns after free_pages() and verify
 	   the patterns before alloc_pages(). This results in a large slowdown,
 	   but helps to find certain types of memory corruptions.
+
+	   This option cannot enalbe with hibernation. Otherwise, it will get
+	   wrong messages for memory corruption because the free pages are not
+	   saved to the suspend image.
