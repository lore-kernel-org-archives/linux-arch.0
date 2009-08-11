From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 2/4] spinlock: add macro to generate out-of-line variants
Date: Tue, 11 Aug 2009 14:47:58 +0200
Message-ID: <20090811124912.494596235@de.ibm.com>
References: <20090811124756.873490673@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate1.uk.ibm.com ([194.196.100.161]:50447 "EHLO
	mtagate1.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532AbZHKMtP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 11 Aug 2009 08:49:15 -0400
Received: from d06nrmr1707.portsmouth.uk.ibm.com (d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id n7BCnDb4019356
	for <linux-arch@vger.kernel.org>; Tue, 11 Aug 2009 12:49:13 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com [9.149.37.213])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7BCnDmu1569020
	for <linux-arch@vger.kernel.org>; Tue, 11 Aug 2009 13:49:13 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7BCnC2n020100
	for <linux-arch@vger.kernel.org>; Tue, 11 Aug 2009 13:49:13 +0100
Content-Disposition: inline; filename=02_spinlock_macros.diff
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>
Cc: linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Since the bodies of the spinlock functions are in a header
file most functions in spinlock.c look like this:

int __lockfunc _spin_trylock(spinlock_t *lock)
{
	return __spin_trylock(lock);
}
EXPORT_SYMBOL(_spin_trylock);

That's just a simple wrapper. Its the same for spin-,
read- and write-lock. So add an extra macro and generate
all versions automatically like it is already done for
the preemption friendly locks.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 kernel/spinlock.c |  233 +++++++++++++++---------------------------------------
 1 file changed, 68 insertions(+), 165 deletions(-)

Index: linux-2.6/kernel/spinlock.c
===================================================================
--- linux-2.6.orig/kernel/spinlock.c
+++ linux-2.6/kernel/spinlock.c
@@ -21,23 +21,37 @@
 #include <linux/debug_locks.h>
 #include <linux/module.h>
 
-int __lockfunc _spin_trylock(spinlock_t *lock)
-{
-	return __spin_trylock(lock);
-}
-EXPORT_SYMBOL(_spin_trylock);
-
-int __lockfunc _read_trylock(rwlock_t *lock)
-{
-	return __read_trylock(lock);
-}
-EXPORT_SYMBOL(_read_trylock);
-
-int __lockfunc _write_trylock(rwlock_t *lock)
-{
-	return __write_trylock(lock);
-}
-EXPORT_SYMBOL(_write_trylock);
+#define BUILD_LOCK_OPS_COMMON(op, locktype)				\
+int __lockfunc _##op##_trylock(locktype##_t *lock)			\
+{									\
+	return __##op##_trylock(lock);					\
+}									\
+EXPORT_SYMBOL(_##op##_trylock);						\
+									\
+void __lockfunc _##op##_unlock(locktype##_t *lock)			\
+{									\
+	__##op##_unlock(lock);						\
+}									\
+EXPORT_SYMBOL(_##op##_unlock);						\
+									\
+void __lockfunc _##op##_unlock_irq(locktype##_t *lock)			\
+{									\
+	__##op##_unlock_irq(lock);					\
+}									\
+EXPORT_SYMBOL(_##op##_unlock_irq);					\
+									\
+void __lockfunc _##op##_unlock_bh(locktype##_t *lock)			\
+{									\
+	__##op##_unlock_bh(lock);					\
+}									\
+EXPORT_SYMBOL(_##op##_unlock_bh);					\
+									\
+void __lockfunc _##op##_unlock_irqrestore(locktype##_t *lock,		\
+					  unsigned long flags)		\
+{									\
+	__##op##_unlock_irqrestore(lock, flags);			\
+}									\
+EXPORT_SYMBOL(_##op##_unlock_irqrestore)
 
 /*
  * If lockdep is enabled then we use the non-preemption spin-ops
@@ -46,77 +60,30 @@ EXPORT_SYMBOL(_write_trylock);
  */
 #if !defined(CONFIG_GENERIC_LOCKBREAK) || defined(CONFIG_DEBUG_LOCK_ALLOC)
 
-void __lockfunc _read_lock(rwlock_t *lock)
-{
-	__read_lock(lock);
-}
-EXPORT_SYMBOL(_read_lock);
-
-unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)
-{
-	return __spin_lock_irqsave(lock);
-}
-EXPORT_SYMBOL(_spin_lock_irqsave);
-
-void __lockfunc _spin_lock_irq(spinlock_t *lock)
-{
-	__spin_lock_irq(lock);
-}
-EXPORT_SYMBOL(_spin_lock_irq);
-
-void __lockfunc _spin_lock_bh(spinlock_t *lock)
-{
-	__spin_lock_bh(lock);
-}
-EXPORT_SYMBOL(_spin_lock_bh);
-
-unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock)
-{
-	return __read_lock_irqsave(lock);
-}
-EXPORT_SYMBOL(_read_lock_irqsave);
-
-void __lockfunc _read_lock_irq(rwlock_t *lock)
-{
-	__read_lock_irq(lock);
-}
-EXPORT_SYMBOL(_read_lock_irq);
-
-void __lockfunc _read_lock_bh(rwlock_t *lock)
-{
-	__read_lock_bh(lock);
-}
-EXPORT_SYMBOL(_read_lock_bh);
-
-unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock)
-{
-	return __write_lock_irqsave(lock);
-}
-EXPORT_SYMBOL(_write_lock_irqsave);
-
-void __lockfunc _write_lock_irq(rwlock_t *lock)
-{
-	__write_lock_irq(lock);
-}
-EXPORT_SYMBOL(_write_lock_irq);
-
-void __lockfunc _write_lock_bh(rwlock_t *lock)
-{
-	__write_lock_bh(lock);
-}
-EXPORT_SYMBOL(_write_lock_bh);
-
-void __lockfunc _spin_lock(spinlock_t *lock)
-{
-	__spin_lock(lock);
-}
-EXPORT_SYMBOL(_spin_lock);
-
-void __lockfunc _write_lock(rwlock_t *lock)
-{
-	__write_lock(lock);
-}
-EXPORT_SYMBOL(_write_lock);
+#define BUILD_LOCK_OPS_DEP(op, locktype)				\
+void __lockfunc _##op##_lock(locktype##_t *lock)			\
+{									\
+	__##op##_lock(lock);						\
+}									\
+EXPORT_SYMBOL(_##op##_lock);						\
+									\
+unsigned long __lockfunc _##op##_lock_irqsave(locktype##_t *lock)	\
+{									\
+	return __##op##_lock_irqsave(lock);				\
+}									\
+EXPORT_SYMBOL(_##op##_lock_irqsave);					\
+									\
+void __lockfunc _##op##_lock_irq(locktype##_t *lock)			\
+{									\
+	__##op##_lock_irq(lock);					\
+}									\
+EXPORT_SYMBOL(_##op##_lock_irq);					\
+									\
+void __lockfunc _##op##_lock_bh(locktype##_t *lock)			\
+{									\
+	__##op##_lock_bh(lock);						\
+}									\
+EXPORT_SYMBOL(_##op##_lock_bh)
 
 #else /* CONFIG_PREEMPT: */
 
@@ -128,7 +95,7 @@ EXPORT_SYMBOL(_write_lock);
  * (We do this in a function because inlining it would be excessive.)
  */
 
-#define BUILD_LOCK_OPS(op, locktype)					\
+#define BUILD_LOCK_OPS_DEP(op, locktype)				\
 void __lockfunc _##op##_lock(locktype##_t *lock)			\
 {									\
 	for (;;) {							\
@@ -193,21 +160,29 @@ void __lockfunc _##op##_lock_bh(locktype
 									\
 EXPORT_SYMBOL(_##op##_lock_bh)
 
+#endif /* CONFIG_PREEMPT */
+
+#define BUILD_LOCK_OPS(op, locktype)		\
+	BUILD_LOCK_OPS_COMMON(op, locktype);	\
+	BUILD_LOCK_OPS_DEP(op, locktype);
+
 /*
- * Build preemption-friendly versions of the following
- * lock-spinning functions:
+ * Build versions of the following lock-spinning functions:
  *
  *         _[spin|read|write]_lock()
  *         _[spin|read|write]_lock_irq()
  *         _[spin|read|write]_lock_irqsave()
  *         _[spin|read|write]_lock_bh()
+ *         _[spin|read|write]_trylock()
+ *         _[spin|read|write]_unlock()
+ *         _[spin|read|write]_unlock_irq()
+ *         _[spin|read|write]_unlock_irqrestore()
+ *         _[spin|read|write]_unlock_bh()
  */
 BUILD_LOCK_OPS(spin, spinlock);
 BUILD_LOCK_OPS(read, rwlock);
 BUILD_LOCK_OPS(write, rwlock);
 
-#endif /* CONFIG_PREEMPT */
-
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
 void __lockfunc _spin_lock_nested(spinlock_t *lock, int subclass)
@@ -242,78 +217,6 @@ EXPORT_SYMBOL(_spin_lock_nest_lock);
 
 #endif
 
-void __lockfunc _spin_unlock(spinlock_t *lock)
-{
-	__spin_unlock(lock);
-}
-EXPORT_SYMBOL(_spin_unlock);
-
-void __lockfunc _write_unlock(rwlock_t *lock)
-{
-	__write_unlock(lock);
-}
-EXPORT_SYMBOL(_write_unlock);
-
-void __lockfunc _read_unlock(rwlock_t *lock)
-{
-	__read_unlock(lock);
-}
-EXPORT_SYMBOL(_read_unlock);
-
-void __lockfunc _spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
-{
-	__spin_unlock_irqrestore(lock, flags);
-}
-EXPORT_SYMBOL(_spin_unlock_irqrestore);
-
-void __lockfunc _spin_unlock_irq(spinlock_t *lock)
-{
-	__spin_unlock_irq(lock);
-}
-EXPORT_SYMBOL(_spin_unlock_irq);
-
-void __lockfunc _spin_unlock_bh(spinlock_t *lock)
-{
-	__spin_unlock_bh(lock);
-}
-EXPORT_SYMBOL(_spin_unlock_bh);
-
-void __lockfunc _read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
-{
-	__read_unlock_irqrestore(lock, flags);
-}
-EXPORT_SYMBOL(_read_unlock_irqrestore);
-
-void __lockfunc _read_unlock_irq(rwlock_t *lock)
-{
-	__read_unlock_irq(lock);
-}
-EXPORT_SYMBOL(_read_unlock_irq);
-
-void __lockfunc _read_unlock_bh(rwlock_t *lock)
-{
-	__read_unlock_bh(lock);
-}
-EXPORT_SYMBOL(_read_unlock_bh);
-
-void __lockfunc _write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
-{
-	__write_unlock_irqrestore(lock, flags);
-}
-EXPORT_SYMBOL(_write_unlock_irqrestore);
-
-void __lockfunc _write_unlock_irq(rwlock_t *lock)
-{
-	__write_unlock_irq(lock);
-}
-EXPORT_SYMBOL(_write_unlock_irq);
-
-void __lockfunc _write_unlock_bh(rwlock_t *lock)
-{
-	__write_unlock_bh(lock);
-}
-EXPORT_SYMBOL(_write_unlock_bh);
-
 int __lockfunc _spin_trylock_bh(spinlock_t *lock)
 {
 	return __spin_trylock_bh(lock);

-- 
