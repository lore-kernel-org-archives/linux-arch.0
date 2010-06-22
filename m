From: Mathieu Lacage <mathieu.lacage@sophia.inria.fr>
Subject: [PATCH] asm-generic: cmpxchg does not handle non-long arguments
Date: Tue, 22 Jun 2010 10:30:15 +0200
Message-ID: <1277195415.23874.51.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:11941
	"EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758282Ab0FVIaT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 22 Jun 2010 04:30:19 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>

The version of cmpxchg defined in asm-generic/system.h does not handle
correctly non-long arguments. Use the version defined in cmpxchg.h
instead.

Signed-off-by: Mathieu Lacage <mathieu.lacage@inria.fr

diff --git a/include/asm-generic/system.h b/include/asm-generic/system.h
index efa403b..4b0b9cb 100644
--- a/include/asm-generic/system.h
+++ b/include/asm-generic/system.h
@@ -21,6 +21,7 @@
 #include <linux/irqflags.h>
 
 #include <asm/cmpxchg-local.h>
+#include <asm/cmpxchg.h>
 
 struct task_struct;
 
@@ -136,25 +137,6 @@ unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
 #define xchg(ptr, x) \
 	((__typeof__(*(ptr))) __xchg((unsigned long)(x), (ptr), sizeof(*(ptr))))
 
-static inline unsigned long __cmpxchg(volatile unsigned long *m,
-				      unsigned long old, unsigned long new)
-{
-	unsigned long retval;
-	unsigned long flags;
-
-	local_irq_save(flags);
-	retval = *m;
-	if (retval == old)
-		*m = new;
-	local_irq_restore(flags);
-	return retval;
-}
-
-#define cmpxchg(ptr, o, n)					\
-	((__typeof__(*(ptr))) __cmpxchg((unsigned long *)(ptr), \
-					(unsigned long)(o),	\
-					(unsigned long)(n)))
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
