From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 2/3] spinlock: allow inlined spinlocks
Date: Wed, 12 Aug 2009 20:39:36 +0200
Message-ID: <20090812184025.269813346@de.ibm.com>
References: <20090812183934.777715527@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162]:40041 "EHLO
	mtagate2.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbZHLSk0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 12 Aug 2009 14:40:26 -0400
Received: from d06nrmr1707.portsmouth.uk.ibm.com (d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id n7CIeRtU028752
	for <linux-arch@vger.kernel.org>; Wed, 12 Aug 2009 18:40:27 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com [9.149.37.228])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7CIeR651384538
	for <linux-arch@vger.kernel.org>; Wed, 12 Aug 2009 19:40:27 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7CIeQUj015341
	for <linux-arch@vger.kernel.org>; Wed, 12 Aug 2009 19:40:27 +0100
Content-Disposition: inline; filename=02_spinlock_inline.diff
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Add new config option SPINLOCK_INLINE and some defines which depend
on it in order to generate inlined spinlock code instead of out-of-line
code.
Avoiding function calls for spinlocks gives 1%-5% less cpu usage on
network benchmarks on s390.

Architectures must select HAVE_SPINLOCK_INLINE_SUPPORT to enable this
config option.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 include/linux/spinlock_api_smp.h |   35 +++++++++++++++++++++++++++++++++++
 kernel/spinlock.c                |    4 ++++
 lib/Kconfig.debug                |   14 ++++++++++++++
 3 files changed, 53 insertions(+)

Index: linux-2.6/include/linux/spinlock_api_smp.h
===================================================================
--- linux-2.6.orig/include/linux/spinlock_api_smp.h
+++ linux-2.6/include/linux/spinlock_api_smp.h
@@ -19,6 +19,8 @@ int in_lock_functions(unsigned long addr
 
 #define assert_spin_locked(x)	BUG_ON(!spin_is_locked(x))
 
+#ifndef CONFIG_SPINLOCK_INLINE
+
 void __lockfunc _spin_lock(spinlock_t *lock)		__acquires(lock);
 void __lockfunc _spin_lock_nested(spinlock_t *lock, int subclass)
 							__acquires(lock);
@@ -60,6 +62,39 @@ void __lockfunc _read_unlock_irqrestore(
 void __lockfunc _write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 							__releases(lock);
 
+#else /* CONFIG_HAVE_SPINLOCK_INLINE_SUPPORT */
+
+#define _spin_trylock(lock)	  __spin_trylock(lock)
+#define _read_trylock(lock)	  __read_trylock(lock)
+#define _write_trylock(lock)	  __write_trylock(lock)
+#define _read_lock(lock)	  __read_lock(lock)
+#define _spin_lock_irqsave(lock)  __spin_lock_irqsave(lock)
+#define _spin_lock_irq(lock)	  __spin_lock_irq(lock)
+#define _spin_lock_bh(lock)	  __spin_lock_bh(lock)
+#define _read_lock_irqsave(lock)  __read_lock_irqsave(lock)
+#define _read_lock_irq(lock)	  __read_lock_irq(lock)
+#define _read_lock_bh(lock)	  __read_lock_bh(lock)
+#define _write_lock_irqsave(lock) __write_lock_irqsave(lock)
+#define _write_lock_irq(lock)	  __write_lock_irq(lock)
+#define _write_lock_bh(lock)	  __write_lock_bh(lock)
+#define _spin_lock(lock)	  __spin_lock(lock)
+#define _write_lock(lock)	  __write_lock(lock)
+#define _spin_unlock(lock)	  __spin_unlock(lock)
+#define _write_unlock(lock)	  __write_unlock(lock)
+#define _read_unlock(lock)	  __read_unlock(lock)
+#define _spin_unlock_irq(lock)	  __spin_unlock_irq(lock)
+#define _spin_unlock_bh(lock)	  __spin_unlock_bh(lock)
+#define _read_unlock_irq(lock)	  __read_unlock_irq(lock)
+#define _read_unlock_bh(lock)	  __read_unlock_bh(lock)
+#define _write_unlock_irq(lock)	  __write_unlock_irq(lock)
+#define _write_unlock_bh(lock)	  __write_unlock_bh(lock)
+#define _spin_trylock_bh(lock)	  __spin_trylock_bh(lock)
+#define _spin_unlock_irqrestore(lock, flags)  __spin_unlock_irqrestore(lock, flags)
+#define _read_unlock_irqrestore(lock, flags)  __read_unlock_irqrestore(lock, flags)
+#define _write_unlock_irqrestore(lock, flags) __write_unlock_irqrestore(lock, flags)
+
+#endif /* CONFIG_HAVE_SPINLOCK_INLINE_SUPPORT */
+
 static inline int __spin_trylock(spinlock_t *lock)
 {
 	preempt_disable();
Index: linux-2.6/lib/Kconfig.debug
===================================================================
--- linux-2.6.orig/lib/Kconfig.debug
+++ linux-2.6/lib/Kconfig.debug
@@ -879,6 +879,20 @@ config SYSCTL_SYSCALL_CHECK
 	  to properly maintain and use. This enables checks that help
 	  you to keep things correct.
 
+config HAVE_SPINLOCK_INLINE_SUPPORT
+	bool
+
+config SPINLOCK_INLINE
+	bool "Inline spinlock code"
+	depends on HAVE_SPINLOCK_INLINE_SUPPORT
+	depends on !DEBUG_SPINLOCK
+	depends on SMP && !PREEMPT
+	help
+	  Select this option if you want to have inlined spinlock code instead
+	  of an out of line implementation.
+	  This will generate a larger kernel image. On some architectures this
+	  increases performance.
+
 source mm/Kconfig.debug
 source kernel/trace/Kconfig
 
Index: linux-2.6/kernel/spinlock.c
===================================================================
--- linux-2.6.orig/kernel/spinlock.c
+++ linux-2.6/kernel/spinlock.c
@@ -21,6 +21,8 @@
 #include <linux/debug_locks.h>
 #include <linux/module.h>
 
+#ifndef CONFIG_SPINLOCK_INLINE
+
 int __lockfunc _spin_trylock(spinlock_t *lock)
 {
 	return __spin_trylock(lock);
@@ -320,6 +322,8 @@ int __lockfunc _spin_trylock_bh(spinlock
 }
 EXPORT_SYMBOL(_spin_trylock_bh);
 
+#endif /* CONFIG_HAVE_SPINLOCK_INLINE_SUPPORT */
+
 notrace int in_lock_functions(unsigned long addr)
 {
 	/* Linker adds these: start and end of __lockfunc functions */

-- 
