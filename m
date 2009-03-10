From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 1/2 -mmotm] debug-pagealloc: depend on CONFIG_DEBUG_KERNEL
Date: Tue, 10 Mar 2009 23:37:02 +0900
Message-ID: <20090310143701.GA3151@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:42235 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbZCJOhZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Mar 2009 10:37:25 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org

The generic debug-pagealloc should depend on CONFIG_DEBUG_KERNEL
as well as the architecture specific one.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-arch@vger.kernel.org
---
 mm/Kconfig.debug |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: 2.6-mmotm/mm/Kconfig.debug
===================================================================
--- 2.6-mmotm.orig/mm/Kconfig.debug
+++ 2.6-mmotm/mm/Kconfig.debug
@@ -3,7 +3,7 @@ config WANT_PAGE_DEBUG_FLAGS
 
 config PAGE_POISONING
 	bool "Debug page memory allocations"
-	depends on !ARCH_SUPPORTS_DEBUG_PAGEALLOC
+	depends on DEBUG_KERNEL && !ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	select DEBUG_PAGEALLOC
 	select WANT_PAGE_DEBUG_FLAGS
 	help
