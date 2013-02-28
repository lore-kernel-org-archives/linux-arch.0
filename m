From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 1/1] asm-generic: move cmpxchg*_local defs to cmpxchg.h
Date: Thu, 28 Feb 2013 06:54:03 +0100
Message-ID: <1362030843-25354-1-git-send-email-jonas@southpole.se>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.southpole.se ([37.247.8.11]:37845 "EHLO mail.southpole.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750723Ab3B1Fx6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 28 Feb 2013 00:53:58 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, David Howells <dhowells@redhat.com>

asm/cmpxchg.h can be included on its own and needs to be self-consistent.
The definitions for the cmpxchg*_local macros, as such, need to be part
of this file.

This fixes a build issue on OpenRISC since the system.h smashing patch
96f951edb1f1bdbbc99b0cd458f9808bb83d58ae that introdued the direct inclusion
asm/cmpxchg.h into linux/llist.h.

CC: David Howells <dhowells@redhat.com>
Signed-off-by: Jonas Bonn <jonas@southpole.se>
---
 include/asm-generic/atomic.h  |    6 ------
 include/asm-generic/cmpxchg.h |   10 ++++++++++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index 1ced641..33bd2de 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -136,12 +136,6 @@ static inline void atomic_dec(atomic_t *v)
 #define atomic_xchg(ptr, v)		(xchg(&(ptr)->counter, (v)))
 #define atomic_cmpxchg(v, old, new)	(cmpxchg(&((v)->counter), (old), (new)))
 
-#define cmpxchg_local(ptr, o, n)				  	       \
-	((__typeof__(*(ptr)))__cmpxchg_local_generic((ptr), (unsigned long)(o),\
-			(unsigned long)(n), sizeof(*(ptr))))
-
-#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
-
 static inline int __atomic_add_unless(atomic_t *v, int a, int u)
 {
   int c, old;
diff --git a/include/asm-generic/cmpxchg.h b/include/asm-generic/cmpxchg.h
index 1488302..811fb1e 100644
--- a/include/asm-generic/cmpxchg.h
+++ b/include/asm-generic/cmpxchg.h
@@ -92,6 +92,16 @@ unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
  */
 #include <asm-generic/cmpxchg-local.h>
 
+#ifndef cmpxchg_local
+#define cmpxchg_local(ptr, o, n)				  	       \
+	((__typeof__(*(ptr)))__cmpxchg_local_generic((ptr), (unsigned long)(o),\
+			(unsigned long)(n), sizeof(*(ptr))))
+#endif
+
+#ifndef cmpxchg64_local
+#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#endif
+
 #define cmpxchg(ptr, o, n)	cmpxchg_local((ptr), (o), (n))
 #define cmpxchg64(ptr, o, n)	cmpxchg64_local((ptr), (o), (n))
 
-- 
1.7.10.4
