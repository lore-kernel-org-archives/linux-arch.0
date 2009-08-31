From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 8/9] spinlock: simplify inlining
Date: Mon, 31 Aug 2009 14:43:38 +0200
Message-ID: <20090831124418.848735034@de.ibm.com>
References: <20090831124330.014480226@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162]:43633 "EHLO
	mtagate2.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbZHaMoT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 31 Aug 2009 08:44:19 -0400
Received: from d06nrmr1806.portsmouth.uk.ibm.com (d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id n7VCiL1H002350
	for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2009 12:44:21 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com [9.149.37.212])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7VCiLtv1343664
	for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2009 13:44:21 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7VCiJCT006780
	for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2009 13:44:20 +0100
Content-Disposition: inline; filename=spinlock_simplify.diff
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <be>
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnd Bergmann <arnd@arndb.de>, Nick Piggin <nickpiggin@yahoo.com.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

For !DEBUG_SPINLOCK && !PREEMPT && SMP the spin_unlock functions were
always inlined by using special defines which would call the __raw*
functions.
The out-of-line variants for these functions would be generated anyway.

Use the new per unlock/locking variant mechanism to force inlining
of the unlock functions like before. This is no functional change,
we just get rid of one additional way to force inlining.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 include/linux/spinlock.h         |   46 +++++----------------------------------
 include/linux/spinlock_api_smp.h |   12 ++++++++++
 2 files changed, 18 insertions(+), 40 deletions(-)

Index: linux-2.6/include/linux/spinlock.h
===================================================================
--- linux-2.6.orig/include/linux/spinlock.h
+++ linux-2.6/include/linux/spinlock.h
@@ -259,50 +259,16 @@ static inline void smp_mb__after_lock(vo
 
 #define spin_lock_irq(lock)		_spin_lock_irq(lock)
 #define spin_lock_bh(lock)		_spin_lock_bh(lock)
-
 #define read_lock_irq(lock)		_read_lock_irq(lock)
 #define read_lock_bh(lock)		_read_lock_bh(lock)
-
 #define write_lock_irq(lock)		_write_lock_irq(lock)
 #define write_lock_bh(lock)		_write_lock_bh(lock)
-
-/*
- * We inline the unlock functions in the nondebug case:
- */
-#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT) || \
-	!defined(CONFIG_SMP)
-# define spin_unlock(lock)		_spin_unlock(lock)
-# define read_unlock(lock)		_read_unlock(lock)
-# define write_unlock(lock)		_write_unlock(lock)
-# define spin_unlock_irq(lock)		_spin_unlock_irq(lock)
-# define read_unlock_irq(lock)		_read_unlock_irq(lock)
-# define write_unlock_irq(lock)		_write_unlock_irq(lock)
-#else
-# define spin_unlock(lock) \
-    do {__raw_spin_unlock(&(lock)->raw_lock); __release(lock); } while (0)
-# define read_unlock(lock) \
-    do {__raw_read_unlock(&(lock)->raw_lock); __release(lock); } while (0)
-# define write_unlock(lock) \
-    do {__raw_write_unlock(&(lock)->raw_lock); __release(lock); } while (0)
-# define spin_unlock_irq(lock)			\
-do {						\
-	__raw_spin_unlock(&(lock)->raw_lock);	\
-	__release(lock);			\
-	local_irq_enable();			\
-} while (0)
-# define read_unlock_irq(lock)			\
-do {						\
-	__raw_read_unlock(&(lock)->raw_lock);	\
-	__release(lock);			\
-	local_irq_enable();			\
-} while (0)
-# define write_unlock_irq(lock)			\
-do {						\
-	__raw_write_unlock(&(lock)->raw_lock);	\
-	__release(lock);			\
-	local_irq_enable();			\
-} while (0)
-#endif
+#define spin_unlock(lock)		_spin_unlock(lock)
+#define read_unlock(lock)		_read_unlock(lock)
+#define write_unlock(lock)		_write_unlock(lock)
+#define spin_unlock_irq(lock)		_spin_unlock_irq(lock)
+#define read_unlock_irq(lock)		_read_unlock_irq(lock)
+#define write_unlock_irq(lock)		_write_unlock_irq(lock)
 
 #define spin_unlock_irqrestore(lock, flags)		\
 	do {						\
Index: linux-2.6/include/linux/spinlock_api_smp.h
===================================================================
--- linux-2.6.orig/include/linux/spinlock_api_smp.h
+++ linux-2.6/include/linux/spinlock_api_smp.h
@@ -60,6 +60,18 @@ void __lockfunc _read_unlock_irqrestore(
 void __lockfunc _write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 							__releases(lock);
 
+/*
+ * We inline the unlock functions in the nondebug case:
+ */
+#if !defined(CONFIG_DEBUG_SPINLOCK) && !defined(CONFIG_PREEMPT)
+#define __always_inline__spin_unlock
+#define __always_inline__read_unlock
+#define __always_inline__write_unlock
+#define __always_inline__spin_unlock_irq
+#define __always_inline__read_unlock_irq
+#define __always_inline__write_unlock_irq
+#endif
+
 #ifndef CONFIG_DEBUG_SPINLOCK
 #ifndef CONFIG_GENERIC_LOCKBREAK
 

-- 
