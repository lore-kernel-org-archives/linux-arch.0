From: Mathieu Lacage <mathieu.lacage@sophia.inria.fr>
Subject: [PATCH: asm-generic] atomic_add_unless macro does not handle
 arguments which use a local variable named c
Date: Sun, 27 Jun 2010 12:26:06 +0200
Message-ID: <1277634366.2845.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail4-relais-sop.national.inria.fr ([192.134.164.105]:45881
	"EHLO mail4-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754686Ab0F0K0J (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 27 Jun 2010 06:26:09 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

atomic_add_unless is a macro so, bad things happen if the caller defines
a local variable named c, just like like the local variable c defined by
the macro. Thus, convert atomic_add_unless to a function. (bug triggered
by net/ipv4/netfilter/ipt_CLUSTERIP.c: clusterip_config_find_get calls
atomic_inc_not_zero)

Signed-off-by: Mathieu Lacage <mathieu.lacage@inria.fr>

diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index 058129e..2fadcdb 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -119,14 +119,23 @@ static inline void atomic_dec(atomic_t *v)
 #define atomic_dec_and_test(v)		(atomic_sub_return(1, (v)) == 0)
 #define atomic_inc_and_test(v)		(atomic_add_return(1, (v)) == 0)
 
-#define atomic_add_unless(v, a, u)				\
-({								\
-	int c, old;						\
-	c = atomic_read(v);					\
-	while (c != (u) && (old = atomic_cmpxchg((v), c, c + (a))) != c) \
-		c = old;					\
-	c != (u);						\
-})
+#define atomic_xchg(ptr, v)		(xchg(&(ptr)->counter, (v)))
+#define atomic_cmpxchg(v, old, new)	(cmpxchg(&((v)->counter), (old), (new)))
+
+#define cmpxchg_local(ptr, o, n)				  	       \
+	((__typeof__(*(ptr)))__cmpxchg_local_generic((ptr), (unsigned long)(o),\
+			(unsigned long)(n), sizeof(*(ptr))))
+
+#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+
+static inline int atomic_add_unless(atomic_t *v, int a, int u)
+{
+  int c, old;
+  c = atomic_read(v);
+  while (c != u && (old = atomic_cmpxchg(v, c, c + a)) != c)
+    c = old;
+  return c != u;
+}
 
 #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
 
@@ -140,15 +149,6 @@ static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
 	local_irq_restore(flags);
 }
 
-#define atomic_xchg(ptr, v)		(xchg(&(ptr)->counter, (v)))
-#define atomic_cmpxchg(v, old, new)	(cmpxchg(&((v)->counter), (old), (new)))
-
-#define cmpxchg_local(ptr, o, n)				  	       \
-	((__typeof__(*(ptr)))__cmpxchg_local_generic((ptr), (unsigned long)(o),\
-			(unsigned long)(n), sizeof(*(ptr))))
-
-#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
-
 /* Assume that atomic operations are already serializing */
 #define smp_mb__before_atomic_dec()	barrier()
 #define smp_mb__after_atomic_dec()	barrier()

-- 
Mathieu Lacage <mathieu.lacage@sophia.inria.fr>
Tel: +33 4 9238 5056
