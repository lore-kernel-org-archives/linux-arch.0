From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Subject: [PATCH] asm-generic/cmpxchg: use BUILD_BUG() when detect unfit, {cmp}xchg
 size
Date: Tue, 23 Feb 2016 16:40:23 +0800
Message-ID: <56CC1AF7.5090300@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:54719 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932717AbcBWImd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Feb 2016 03:42:33 -0500
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <xinhui@linux.vnet.ibm.com>;
	Tue, 23 Feb 2016 18:42:30 +1000
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>

From: pan xinhui <xinhui.pan@linux.vnet.ibm.com>

__xchg_called_with_bad_pointer/wrong_size_cmpxchg can't tell us what
codes use {cmp}xchg in incorrect way.  And no error will be reported
until the link stage. To fix such kinds of issues in a easy way, We
use BUILD_BUG().

Signed-off-by: pan xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 include/asm-generic/cmpxchg-local.h | 8 +++-----
 include/asm-generic/cmpxchg.h       | 9 ++-------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/asm-generic/cmpxchg-local.h b/include/asm-generic/cmpxchg-local.h
index 70bef78..6d78291 100644
--- a/include/asm-generic/cmpxchg-local.h
+++ b/include/asm-generic/cmpxchg-local.h
@@ -3,9 +3,7 @@
 
 #include <linux/types.h>
 #include <linux/irqflags.h>
-
-extern unsigned long wrong_size_cmpxchg(volatile void *ptr)
-	__noreturn;
+#include <linux/bug.h>
 
 /*
  * Generic version of __cmpxchg_local (disables interrupts). Takes an unsigned
@@ -20,7 +18,7 @@ static inline unsigned long __cmpxchg_local_generic(volatile void *ptr,
 	 * Sanity checking, compile-time.
 	 */
 	if (size == 8 && sizeof(unsigned long) != 8)
-		wrong_size_cmpxchg(ptr);
+		BUILD_BUG();
 
 	raw_local_irq_save(flags);
 	switch (size) {
@@ -41,7 +39,7 @@ static inline unsigned long __cmpxchg_local_generic(volatile void *ptr,
 			*(u64 *)ptr = (u64)new;
 		break;
 	default:
-		wrong_size_cmpxchg(ptr);
+		BUILD_BUG();
 	}
 	raw_local_irq_restore(flags);
 	return prev;
diff --git a/include/asm-generic/cmpxchg.h b/include/asm-generic/cmpxchg.h
index e5f9080..ffaa4ce 100644
--- a/include/asm-generic/cmpxchg.h
+++ b/include/asm-generic/cmpxchg.h
@@ -12,15 +12,10 @@
 
 #include <linux/types.h>
 #include <linux/irqflags.h>
+#include <linux/bug.h>
 
 #ifndef xchg
 
-/*
- * This function doesn't exist, so you'll get a linker error if
- * something tries to do an invalidly-sized xchg().
- */
-extern void __xchg_called_with_bad_pointer(void);
-
 static inline
 unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
 {
@@ -74,7 +69,7 @@ unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
 #endif /* CONFIG_64BIT */
 
 	default:
-		__xchg_called_with_bad_pointer();
+		BUILD_BUG();
 		return x;
 	}
 }
-- 
2.5.0
