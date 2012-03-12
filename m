Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:16561 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932190Ab2CLXj1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 12 Mar 2012 19:39:27 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 19/35] Move the asm-generic/system.h xchg() implementation to
 asm-generic/cmpxchg.h [ver #2]
Date: Mon, 12 Mar 2012 23:39:17 +0000
Message-ID: <20120312233916.13888.17108.stgit@warthog.procyon.org.uk>
In-Reply-To: <20120312233602.13888.27659.stgit@warthog.procyon.org.uk>
References: <20120312233602.13888.27659.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paul.gortmaker@windriver.com, hpa@zytor.com
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, David Howells <dhowells@redhat.com>Arnd Bergmann <arnd@arndb.de>
Message-ID: <20120312233917.i9Fi6v-DpzB7MOxQqeWaR_UpVKkKI3vqLub-JJiXDlU@z>

Move the asm-generic/system.h xchg() implementation to asm-generic/cmpxchg.h
to simplify disintegration of asm/system.h.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Arnd Bergmann <arnd@arndb.de>
---

 include/asm-generic/cmpxchg.h |   87 ++++++++++++++++++++++++++++++++++++++---
 include/asm-generic/system.h  |   70 ---------------------------------
 2 files changed, 80 insertions(+), 77 deletions(-)

diff --git a/include/asm-generic/cmpxchg.h b/include/asm-generic/cmpxchg.h
index e0449af..8a36183 100644
--- a/include/asm-generic/cmpxchg.h
+++ b/include/asm-generic/cmpxchg.h
@@ -1,16 +1,87 @@
+/*
+ * Generic UP xchg and cmpxchg using interrupt disablement.  Does not
+ * support SMP.
+ */
+
 #ifndef __ASM_GENERIC_CMPXCHG_H
 #define __ASM_GENERIC_CMPXCHG_H
 
-/*
- * Generic cmpxchg
- *
- * Uses the local cmpxchg. Does not support SMP.
- */
 #ifdef CONFIG_SMP
 #error "Cannot use generic cmpxchg on SMP"
 #endif
 
-#include <asm-generic/cmpxchg-local.h>
+#include <linux/irqflags.h>
+
+#ifndef xchg
+
+/*
+ * This function doesn't exist, so you'll get a linker error if
+ * something tries to do an invalidly-sized xchg().
+ */
+extern void __xchg_called_with_bad_pointer(void);
+
+static inline
+unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
+{
+	unsigned long ret, flags;
+
+	switch (size) {
+	case 1:
+#ifdef __xchg_u8
+		return __xchg_u8(x, ptr);
+#else
+		local_irq_save(flags);
+		ret = *(volatile u8 *)ptr;
+		*(volatile u8 *)ptr = x;
+		local_irq_restore(flags);
+		return ret;
+#endif /* __xchg_u8 */
+
+	case 2:
+#ifdef __xchg_u16
+		return __xchg_u16(x, ptr);
+#else
+		local_irq_save(flags);
+		ret = *(volatile u16 *)ptr;
+		*(volatile u16 *)ptr = x;
+		local_irq_restore(flags);
+		return ret;
+#endif /* __xchg_u16 */
+
+	case 4:
+#ifdef __xchg_u32
+		return __xchg_u32(x, ptr);
+#else
+		local_irq_save(flags);
+		ret = *(volatile u32 *)ptr;
+		*(volatile u32 *)ptr = x;
+		local_irq_restore(flags);
+		return ret;
+#endif /* __xchg_u32 */
+
+#ifdef CONFIG_64BIT
+	case 8:
+#ifdef __xchg_u64
+		return __xchg_u64(x, ptr);
+#else
+		local_irq_save(flags);
+		ret = *(volatile u64 *)ptr;
+		*(volatile u64 *)ptr = x;
+		local_irq_restore(flags);
+		return ret;
+#endif /* __xchg_u64 */
+#endif /* CONFIG_64BIT */
+
+	default:
+		__xchg_called_with_bad_pointer();
+		return x;
+	}
+}
+
+#define xchg(ptr, x) \
+	((__typeof__(*(ptr))) __xchg((unsigned long)(x), (ptr), sizeof(*(ptr))))
+
+#endif /* xchg */
 
 /*
  * Atomic compare and exchange.
@@ -18,7 +89,9 @@
  * Do not define __HAVE_ARCH_CMPXCHG because we want to use it to check whether
  * a cmpxchg primitive faster than repeated local irq save/restore exists.
  */
+#include <asm-generic/cmpxchg-local.h>
+
 #define cmpxchg(ptr, o, n)	cmpxchg_local((ptr), (o), (n))
 #define cmpxchg64(ptr, o, n)	cmpxchg64_local((ptr), (o), (n))
 
-#endif
+#endif /* __ASM_GENERIC_CMPXCHG_H */
diff --git a/include/asm-generic/system.h b/include/asm-generic/system.h
index f98f693..54cd124 100644
--- a/include/asm-generic/system.h
+++ b/include/asm-generic/system.h
@@ -17,7 +17,6 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/types.h>
-#include <linux/irqflags.h>
 
 #include <asm/barrier.h>
 #include <asm/cmpxchg.h>
@@ -34,75 +33,6 @@ extern struct task_struct *__switch_to(struct task_struct *,
 
 #define arch_align_stack(x) (x)
 
-/*
- * we make sure local_irq_enable() doesn't cause priority inversion
- */
-
-/* This function doesn't exist, so you'll get a linker error
- *    if something tries to do an invalid xchg().  */
-extern void __xchg_called_with_bad_pointer(void);
-
-static inline
-unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
-{
-	unsigned long ret, flags;
-
-	switch (size) {
-	case 1:
-#ifdef __xchg_u8
-		return __xchg_u8(x, ptr);
-#else
-		local_irq_save(flags);
-		ret = *(volatile u8 *)ptr;
-		*(volatile u8 *)ptr = x;
-		local_irq_restore(flags);
-		return ret;
-#endif /* __xchg_u8 */
-
-	case 2:
-#ifdef __xchg_u16
-		return __xchg_u16(x, ptr);
-#else
-		local_irq_save(flags);
-		ret = *(volatile u16 *)ptr;
-		*(volatile u16 *)ptr = x;
-		local_irq_restore(flags);
-		return ret;
-#endif /* __xchg_u16 */
-
-	case 4:
-#ifdef __xchg_u32
-		return __xchg_u32(x, ptr);
-#else
-		local_irq_save(flags);
-		ret = *(volatile u32 *)ptr;
-		*(volatile u32 *)ptr = x;
-		local_irq_restore(flags);
-		return ret;
-#endif /* __xchg_u32 */
-
-#ifdef CONFIG_64BIT
-	case 8:
-#ifdef __xchg_u64
-		return __xchg_u64(x, ptr);
-#else
-		local_irq_save(flags);
-		ret = *(volatile u64 *)ptr;
-		*(volatile u64 *)ptr = x;
-		local_irq_restore(flags);
-		return ret;
-#endif /* __xchg_u64 */
-#endif /* CONFIG_64BIT */
-
-	default:
-		__xchg_called_with_bad_pointer();
-		return x;
-	}
-}
-
-#define xchg(ptr, x) \
-	((__typeof__(*(ptr))) __xchg((unsigned long)(x), (ptr), sizeof(*(ptr))))
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_GENERIC_SYSTEM_H */

