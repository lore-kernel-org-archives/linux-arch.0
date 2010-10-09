From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/6] asm-generic: cmpxchg does not handle non-long arguments
Date: Sat,  9 Oct 2010 21:57:48 +0200
Message-ID: <1286654272-21483-3-git-send-email-arnd@arndb.de>
References: <1286654272-21483-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1286654272-21483-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Mathieu Lacage <mathieu.lacage@sophia.inria.fr>, Mathieu Lacage <mathieu.lacage@inria.fr>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

From: Mathieu Lacage <mathieu.lacage@sophia.inria.fr>

The version of cmpxchg defined in asm-generic/system.h does not handle
correctly non-long arguments. Use the version defined in cmpxchg.h
instead.

Signed-off-by: Mathieu Lacage <mathieu.lacage@inria.fr>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/system.h |   20 +-------------------
 1 files changed, 1 insertions(+), 19 deletions(-)

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
-- 
1.7.1
