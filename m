From: akpm@linux-foundation.org
Subject: [patch 1/3] Factor out #ifdefs from kernel/spinlock.c to LOCK_CONTENDED_FLAGS
Date: Thu, 02 Apr 2009 15:20:33 -0700
Message-ID: <200904022220.n32MKX4b026291@imap1.linux-foundation.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49973 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762411AbZDBWZT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Apr 2009 18:25:19 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@elte.hu
Cc: akpm@linux-foundation.org, holt@sgi.com, a.p.zijlstra@chello.nl, linux-arch@vger.kernel.org, ptesarik@suse.cz, tony.luck@intel.com

From: Robin Holt <holt@sgi.com>

SGI has observed that on large systems, interrupts are not serviced for a
long period of time when waiting for a rwlock.  The following patch series
re-enables irqs while waiting for the lock, resembling the code which is
already there for spinlocks.

I only made the ia64 version, because the patch adds some overhead to the
fast path.  I assume there is currently no demand to have this for other
architectures, because the systems are not so large.  Of course, the
possibility to implement raw_{read|write}_lock_flags for any architecture
is still there.


This patch:

The new macro LOCK_CONTENDED_FLAGS expands to the correct implementation
depending on the config options, so that IRQ's are re-enabled when
possible, but they remain disabled if CONFIG_LOCKDEP is set.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
Signed-off-by: Robin Holt <holt@sgi.com>
Cc: <linux-arch@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: "Luck, Tony" <tony.luck@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/lockdep.h |   17 +++++++++++++++++
 kernel/spinlock.c       |   12 ++----------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff -puN include/linux/lockdep.h~factor-out-ifdefs-from-kernel-spinlockc-to-lock_contended_flags include/linux/lockdep.h
--- a/include/linux/lockdep.h~factor-out-ifdefs-from-kernel-spinlockc-to-lock_contended_flags
+++ a/include/linux/lockdep.h
@@ -364,6 +364,23 @@ do {								\
 
 #endif /* CONFIG_LOCK_STAT */
 
+#ifdef CONFIG_LOCKDEP
+
+/*
+ * On lockdep we dont want the hand-coded irq-enable of
+ * _raw_*_lock_flags() code, because lockdep assumes
+ * that interrupts are not re-enabled during lock-acquire:
+ */
+#define LOCK_CONTENDED_FLAGS(_lock, try, lock, lockfl, flags) \
+	LOCK_CONTENDED((_lock), (try), (lock))
+
+#else /* CONFIG_LOCKDEP */
+
+#define LOCK_CONTENDED_FLAGS(_lock, try, lock, lockfl, flags) \
+	lockfl((_lock), (flags))
+
+#endif /* CONFIG_LOCKDEP */
+
 #ifdef CONFIG_GENERIC_HARDIRQS
 extern void early_init_irq_lock_class(void);
 #else
diff -puN kernel/spinlock.c~factor-out-ifdefs-from-kernel-spinlockc-to-lock_contended_flags kernel/spinlock.c
--- a/kernel/spinlock.c~factor-out-ifdefs-from-kernel-spinlockc-to-lock_contended_flags
+++ a/kernel/spinlock.c
@@ -299,16 +299,8 @@ unsigned long __lockfunc _spin_lock_irqs
 	local_irq_save(flags);
 	preempt_disable();
 	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
-	/*
-	 * On lockdep we dont want the hand-coded irq-enable of
-	 * _raw_spin_lock_flags() code, because lockdep assumes
-	 * that interrupts are not re-enabled during lock-acquire:
-	 */
-#ifdef CONFIG_LOCKDEP
-	LOCK_CONTENDED(lock, _raw_spin_trylock, _raw_spin_lock);
-#else
-	_raw_spin_lock_flags(lock, &flags);
-#endif
+	LOCK_CONTENDED_FLAGS(lock, _raw_spin_trylock, _raw_spin_lock,
+				_raw_spin_lock_flags, &flags);
 	return flags;
 }
 EXPORT_SYMBOL(_spin_lock_irqsave_nested);
_
