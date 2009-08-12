From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 1/3] spinlock: move spinlock function bodies to header file
Date: Wed, 12 Aug 2009 20:39:35 +0200
Message-ID: <20090812184024.639180973@de.ibm.com>
References: <20090812183934.777715527@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate3.de.ibm.com ([195.212.29.152]:38547 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754805AbZHLSkg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 12 Aug 2009 14:40:36 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.14.3/8.13.8) with ESMTP id n7CIeQuc112212
	for <linux-arch@vger.kernel.org>; Wed, 12 Aug 2009 18:40:26 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com [9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7CIeQNU1314882
	for <linux-arch@vger.kernel.org>; Wed, 12 Aug 2009 20:40:26 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7CIePjU027853
	for <linux-arch@vger.kernel.org>; Wed, 12 Aug 2009 20:40:26 +0200
Content-Disposition: inline; filename=01_spinlock_move.diff
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Move spinlock function bodies to header file by creating a
static inline version of each variant.
Use the inline version on the out-of-line code. This shouldn't
make any difference besides that the spinlock code can now
be used to generate inlined spinlock code.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 include/linux/spinlock.h         |   18 +-
 include/linux/spinlock_api_smp.h |  263 +++++++++++++++++++++++++++++++++++++++
 kernel/spinlock.c                |  174 ++++---------------------
 3 files changed, 300 insertions(+), 155 deletions(-)

Index: linux-2.6/include/linux/spinlock_api_smp.h
===================================================================
--- linux-2.6.orig/include/linux/spinlock_api_smp.h
+++ linux-2.6/include/linux/spinlock_api_smp.h
@@ -60,4 +60,267 @@ void __lockfunc _read_unlock_irqrestore(
 void __lockfunc _write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 							__releases(lock);
 
+static inline int __spin_trylock(spinlock_t *lock)
+{
+	preempt_disable();
+	if (_raw_spin_trylock(lock)) {
+		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+		return 1;
+	}
+	preempt_enable();
+	return 0;
+}
+
+static inline int __read_trylock(rwlock_t *lock)
+{
+	preempt_disable();
+	if (_raw_read_trylock(lock)) {
+		rwlock_acquire_read(&lock->dep_map, 0, 1, _RET_IP_);
+		return 1;
+	}
+	preempt_enable();
+	return 0;
+}
+
+static inline int __write_trylock(rwlock_t *lock)
+{
+	preempt_disable();
+	if (_raw_write_trylock(lock)) {
+		rwlock_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+		return 1;
+	}
+	preempt_enable();
+	return 0;
+}
+
+/*
+ * If lockdep is enabled then we use the non-preemption spin-ops
+ * even on CONFIG_PREEMPT, because lockdep assumes that interrupts are
+ * not re-enabled during lock-acquire (which the preempt-spin-ops do):
+ */
+#if !defined(CONFIG_GENERIC_LOCKBREAK) || defined(CONFIG_DEBUG_LOCK_ALLOC)
+
+static inline void __read_lock(rwlock_t *lock)
+{
+	preempt_disable();
+	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
+	LOCK_CONTENDED(lock, _raw_read_trylock, _raw_read_lock);
+}
+
+static inline unsigned long __spin_lock_irqsave(spinlock_t *lock)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	preempt_disable();
+	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	/*
+	 * On lockdep we dont want the hand-coded irq-enable of
+	 * _raw_spin_lock_flags() code, because lockdep assumes
+	 * that interrupts are not re-enabled during lock-acquire:
+	 */
+#ifdef CONFIG_LOCKDEP
+	LOCK_CONTENDED(lock, _raw_spin_trylock, _raw_spin_lock);
+#else
+	_raw_spin_lock_flags(lock, &flags);
+#endif
+	return flags;
+}
+
+static inline void __spin_lock_irq(spinlock_t *lock)
+{
+	local_irq_disable();
+	preempt_disable();
+	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	LOCK_CONTENDED(lock, _raw_spin_trylock, _raw_spin_lock);
+}
+
+static inline void __spin_lock_bh(spinlock_t *lock)
+{
+	local_bh_disable();
+	preempt_disable();
+	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	LOCK_CONTENDED(lock, _raw_spin_trylock, _raw_spin_lock);
+}
+
+static inline unsigned long __read_lock_irqsave(rwlock_t *lock)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	preempt_disable();
+	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
+	LOCK_CONTENDED_FLAGS(lock, _raw_read_trylock, _raw_read_lock,
+			     _raw_read_lock_flags, &flags);
+	return flags;
+}
+
+static inline void __read_lock_irq(rwlock_t *lock)
+{
+	local_irq_disable();
+	preempt_disable();
+	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
+	LOCK_CONTENDED(lock, _raw_read_trylock, _raw_read_lock);
+}
+
+static inline void __read_lock_bh(rwlock_t *lock)
+{
+	local_bh_disable();
+	preempt_disable();
+	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
+	LOCK_CONTENDED(lock, _raw_read_trylock, _raw_read_lock);
+}
+
+static inline unsigned long __write_lock_irqsave(rwlock_t *lock)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	preempt_disable();
+	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	LOCK_CONTENDED_FLAGS(lock, _raw_write_trylock, _raw_write_lock,
+			     _raw_write_lock_flags, &flags);
+	return flags;
+}
+
+static inline void __write_lock_irq(rwlock_t *lock)
+{
+	local_irq_disable();
+	preempt_disable();
+	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	LOCK_CONTENDED(lock, _raw_write_trylock, _raw_write_lock);
+}
+
+static inline void __write_lock_bh(rwlock_t *lock)
+{
+	local_bh_disable();
+	preempt_disable();
+	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	LOCK_CONTENDED(lock, _raw_write_trylock, _raw_write_lock);
+}
+
+static inline void __spin_lock(spinlock_t *lock)
+{
+	preempt_disable();
+	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	LOCK_CONTENDED(lock, _raw_spin_trylock, _raw_spin_lock);
+}
+
+static inline void __write_lock(rwlock_t *lock)
+{
+	preempt_disable();
+	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	LOCK_CONTENDED(lock, _raw_write_trylock, _raw_write_lock);
+}
+
+#endif /* CONFIG_PREEMPT */
+
+static inline void __spin_unlock(spinlock_t *lock)
+{
+	spin_release(&lock->dep_map, 1, _RET_IP_);
+	_raw_spin_unlock(lock);
+	preempt_enable();
+}
+
+static inline void __write_unlock(rwlock_t *lock)
+{
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
+	_raw_write_unlock(lock);
+	preempt_enable();
+}
+
+static inline void __read_unlock(rwlock_t *lock)
+{
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
+	_raw_read_unlock(lock);
+	preempt_enable();
+}
+
+static inline void __spin_unlock_irqrestore(spinlock_t *lock,
+					    unsigned long flags)
+{
+	spin_release(&lock->dep_map, 1, _RET_IP_);
+	_raw_spin_unlock(lock);
+	local_irq_restore(flags);
+	preempt_enable();
+}
+
+static inline void __spin_unlock_irq(spinlock_t *lock)
+{
+	spin_release(&lock->dep_map, 1, _RET_IP_);
+	_raw_spin_unlock(lock);
+	local_irq_enable();
+	preempt_enable();
+}
+
+static inline void __spin_unlock_bh(spinlock_t *lock)
+{
+	spin_release(&lock->dep_map, 1, _RET_IP_);
+	_raw_spin_unlock(lock);
+	preempt_enable_no_resched();
+	local_bh_enable_ip((unsigned long)__builtin_return_address(0));
+}
+
+static inline void __read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
+{
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
+	_raw_read_unlock(lock);
+	local_irq_restore(flags);
+	preempt_enable();
+}
+
+static inline void __read_unlock_irq(rwlock_t *lock)
+{
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
+	_raw_read_unlock(lock);
+	local_irq_enable();
+	preempt_enable();
+}
+
+static inline void __read_unlock_bh(rwlock_t *lock)
+{
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
+	_raw_read_unlock(lock);
+	preempt_enable_no_resched();
+	local_bh_enable_ip((unsigned long)__builtin_return_address(0));
+}
+
+static inline void __write_unlock_irqrestore(rwlock_t *lock,
+					     unsigned long flags)
+{
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
+	_raw_write_unlock(lock);
+	local_irq_restore(flags);
+	preempt_enable();
+}
+
+static inline void __write_unlock_irq(rwlock_t *lock)
+{
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
+	_raw_write_unlock(lock);
+	local_irq_enable();
+	preempt_enable();
+}
+
+static inline void __write_unlock_bh(rwlock_t *lock)
+{
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
+	_raw_write_unlock(lock);
+	preempt_enable_no_resched();
+	local_bh_enable_ip((unsigned long)__builtin_return_address(0));
+}
+
+static inline int __spin_trylock_bh(spinlock_t *lock)
+{
+	local_bh_disable();
+	preempt_disable();
+	if (_raw_spin_trylock(lock)) {
+		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+		return 1;
+	}
+	preempt_enable_no_resched();
+	local_bh_enable_ip((unsigned long)__builtin_return_address(0));
+	return 0;
+}
+
 #endif /* __LINUX_SPINLOCK_API_SMP_H */
Index: linux-2.6/include/linux/spinlock.h
===================================================================
--- linux-2.6.orig/include/linux/spinlock.h
+++ linux-2.6/include/linux/spinlock.h
@@ -143,15 +143,6 @@ static inline void smp_mb__after_lock(vo
  */
 #define spin_unlock_wait(lock)	__raw_spin_unlock_wait(&(lock)->raw_lock)
 
-/*
- * Pull the _spin_*()/_read_*()/_write_*() functions/declarations:
- */
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-# include <linux/spinlock_api_smp.h>
-#else
-# include <linux/spinlock_api_up.h>
-#endif
-
 #ifdef CONFIG_DEBUG_SPINLOCK
  extern void _raw_spin_lock(spinlock_t *lock);
 #define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
@@ -380,4 +371,13 @@ extern int _atomic_dec_and_lock(atomic_t
  */
 #define spin_can_lock(lock)	(!spin_is_locked(lock))
 
+/*
+ * Pull the _spin_*()/_read_*()/_write_*() functions/declarations:
+ */
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+# include <linux/spinlock_api_smp.h>
+#else
+# include <linux/spinlock_api_up.h>
+#endif
+
 #endif /* __LINUX_SPINLOCK_H */
Index: linux-2.6/kernel/spinlock.c
===================================================================
--- linux-2.6.orig/kernel/spinlock.c
+++ linux-2.6/kernel/spinlock.c
@@ -23,40 +23,19 @@
 
 int __lockfunc _spin_trylock(spinlock_t *lock)
 {
-	preempt_disable();
-	if (_raw_spin_trylock(lock)) {
-		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
-		return 1;
-	}
-	
-	preempt_enable();
-	return 0;
+	return __spin_trylock(lock);
 }
 EXPORT_SYMBOL(_spin_trylock);
 
 int __lockfunc _read_trylock(rwlock_t *lock)
 {
-	preempt_disable();
-	if (_raw_read_trylock(lock)) {
-		rwlock_acquire_read(&lock->dep_map, 0, 1, _RET_IP_);
-		return 1;
-	}
-
-	preempt_enable();
-	return 0;
+	return __read_trylock(lock);
 }
 EXPORT_SYMBOL(_read_trylock);
 
 int __lockfunc _write_trylock(rwlock_t *lock)
 {
-	preempt_disable();
-	if (_raw_write_trylock(lock)) {
-		rwlock_acquire(&lock->dep_map, 0, 1, _RET_IP_);
-		return 1;
-	}
-
-	preempt_enable();
-	return 0;
+	return __write_trylock(lock);
 }
 EXPORT_SYMBOL(_write_trylock);
 
@@ -69,129 +48,74 @@ EXPORT_SYMBOL(_write_trylock);
 
 void __lockfunc _read_lock(rwlock_t *lock)
 {
-	preempt_disable();
-	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
-	LOCK_CONTENDED(lock, _raw_read_trylock, _raw_read_lock);
+	__read_lock(lock);
 }
 EXPORT_SYMBOL(_read_lock);
 
 unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
-	preempt_disable();
-	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
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
-	return flags;
+	return __spin_lock_irqsave(lock);
 }
 EXPORT_SYMBOL(_spin_lock_irqsave);
 
 void __lockfunc _spin_lock_irq(spinlock_t *lock)
 {
-	local_irq_disable();
-	preempt_disable();
-	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	LOCK_CONTENDED(lock, _raw_spin_trylock, _raw_spin_lock);
+	__spin_lock_irq(lock);
 }
 EXPORT_SYMBOL(_spin_lock_irq);
 
 void __lockfunc _spin_lock_bh(spinlock_t *lock)
 {
-	local_bh_disable();
-	preempt_disable();
-	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	LOCK_CONTENDED(lock, _raw_spin_trylock, _raw_spin_lock);
+	__spin_lock_bh(lock);
 }
 EXPORT_SYMBOL(_spin_lock_bh);
 
 unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
-	preempt_disable();
-	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
-	LOCK_CONTENDED_FLAGS(lock, _raw_read_trylock, _raw_read_lock,
-			     _raw_read_lock_flags, &flags);
-	return flags;
+	return __read_lock_irqsave(lock);
 }
 EXPORT_SYMBOL(_read_lock_irqsave);
 
 void __lockfunc _read_lock_irq(rwlock_t *lock)
 {
-	local_irq_disable();
-	preempt_disable();
-	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
-	LOCK_CONTENDED(lock, _raw_read_trylock, _raw_read_lock);
+	__read_lock_irq(lock);
 }
 EXPORT_SYMBOL(_read_lock_irq);
 
 void __lockfunc _read_lock_bh(rwlock_t *lock)
 {
-	local_bh_disable();
-	preempt_disable();
-	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
-	LOCK_CONTENDED(lock, _raw_read_trylock, _raw_read_lock);
+	__read_lock_bh(lock);
 }
 EXPORT_SYMBOL(_read_lock_bh);
 
 unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
-	preempt_disable();
-	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	LOCK_CONTENDED_FLAGS(lock, _raw_write_trylock, _raw_write_lock,
-			     _raw_write_lock_flags, &flags);
-	return flags;
+	return __write_lock_irqsave(lock);
 }
 EXPORT_SYMBOL(_write_lock_irqsave);
 
 void __lockfunc _write_lock_irq(rwlock_t *lock)
 {
-	local_irq_disable();
-	preempt_disable();
-	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	LOCK_CONTENDED(lock, _raw_write_trylock, _raw_write_lock);
+	__write_lock_irq(lock);
 }
 EXPORT_SYMBOL(_write_lock_irq);
 
 void __lockfunc _write_lock_bh(rwlock_t *lock)
 {
-	local_bh_disable();
-	preempt_disable();
-	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	LOCK_CONTENDED(lock, _raw_write_trylock, _raw_write_lock);
+	__write_lock_bh(lock);
 }
 EXPORT_SYMBOL(_write_lock_bh);
 
 void __lockfunc _spin_lock(spinlock_t *lock)
 {
-	preempt_disable();
-	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	LOCK_CONTENDED(lock, _raw_spin_trylock, _raw_spin_lock);
+	__spin_lock(lock);
 }
-
 EXPORT_SYMBOL(_spin_lock);
 
 void __lockfunc _write_lock(rwlock_t *lock)
 {
-	preempt_disable();
-	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	LOCK_CONTENDED(lock, _raw_write_trylock, _raw_write_lock);
+	__write_lock(lock);
 }
-
 EXPORT_SYMBOL(_write_lock);
 
 #else /* CONFIG_PREEMPT: */
@@ -320,121 +244,79 @@ EXPORT_SYMBOL(_spin_lock_nest_lock);
 
 void __lockfunc _spin_unlock(spinlock_t *lock)
 {
-	spin_release(&lock->dep_map, 1, _RET_IP_);
-	_raw_spin_unlock(lock);
-	preempt_enable();
+	__spin_unlock(lock);
 }
 EXPORT_SYMBOL(_spin_unlock);
 
 void __lockfunc _write_unlock(rwlock_t *lock)
 {
-	rwlock_release(&lock->dep_map, 1, _RET_IP_);
-	_raw_write_unlock(lock);
-	preempt_enable();
+	__write_unlock(lock);
 }
 EXPORT_SYMBOL(_write_unlock);
 
 void __lockfunc _read_unlock(rwlock_t *lock)
 {
-	rwlock_release(&lock->dep_map, 1, _RET_IP_);
-	_raw_read_unlock(lock);
-	preempt_enable();
+	__read_unlock(lock);
 }
 EXPORT_SYMBOL(_read_unlock);
 
 void __lockfunc _spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
 {
-	spin_release(&lock->dep_map, 1, _RET_IP_);
-	_raw_spin_unlock(lock);
-	local_irq_restore(flags);
-	preempt_enable();
+	__spin_unlock_irqrestore(lock, flags);
 }
 EXPORT_SYMBOL(_spin_unlock_irqrestore);
 
 void __lockfunc _spin_unlock_irq(spinlock_t *lock)
 {
-	spin_release(&lock->dep_map, 1, _RET_IP_);
-	_raw_spin_unlock(lock);
-	local_irq_enable();
-	preempt_enable();
+	__spin_unlock_irq(lock);
 }
 EXPORT_SYMBOL(_spin_unlock_irq);
 
 void __lockfunc _spin_unlock_bh(spinlock_t *lock)
 {
-	spin_release(&lock->dep_map, 1, _RET_IP_);
-	_raw_spin_unlock(lock);
-	preempt_enable_no_resched();
-	local_bh_enable_ip((unsigned long)__builtin_return_address(0));
+	__spin_unlock_bh(lock);
 }
 EXPORT_SYMBOL(_spin_unlock_bh);
 
 void __lockfunc _read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 {
-	rwlock_release(&lock->dep_map, 1, _RET_IP_);
-	_raw_read_unlock(lock);
-	local_irq_restore(flags);
-	preempt_enable();
+	__read_unlock_irqrestore(lock, flags);
 }
 EXPORT_SYMBOL(_read_unlock_irqrestore);
 
 void __lockfunc _read_unlock_irq(rwlock_t *lock)
 {
-	rwlock_release(&lock->dep_map, 1, _RET_IP_);
-	_raw_read_unlock(lock);
-	local_irq_enable();
-	preempt_enable();
+	__read_unlock_irq(lock);
 }
 EXPORT_SYMBOL(_read_unlock_irq);
 
 void __lockfunc _read_unlock_bh(rwlock_t *lock)
 {
-	rwlock_release(&lock->dep_map, 1, _RET_IP_);
-	_raw_read_unlock(lock);
-	preempt_enable_no_resched();
-	local_bh_enable_ip((unsigned long)__builtin_return_address(0));
+	__read_unlock_bh(lock);
 }
 EXPORT_SYMBOL(_read_unlock_bh);
 
 void __lockfunc _write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 {
-	rwlock_release(&lock->dep_map, 1, _RET_IP_);
-	_raw_write_unlock(lock);
-	local_irq_restore(flags);
-	preempt_enable();
+	__write_unlock_irqrestore(lock, flags);
 }
 EXPORT_SYMBOL(_write_unlock_irqrestore);
 
 void __lockfunc _write_unlock_irq(rwlock_t *lock)
 {
-	rwlock_release(&lock->dep_map, 1, _RET_IP_);
-	_raw_write_unlock(lock);
-	local_irq_enable();
-	preempt_enable();
+	__write_unlock_irq(lock);
 }
 EXPORT_SYMBOL(_write_unlock_irq);
 
 void __lockfunc _write_unlock_bh(rwlock_t *lock)
 {
-	rwlock_release(&lock->dep_map, 1, _RET_IP_);
-	_raw_write_unlock(lock);
-	preempt_enable_no_resched();
-	local_bh_enable_ip((unsigned long)__builtin_return_address(0));
+	__write_unlock_bh(lock);
 }
 EXPORT_SYMBOL(_write_unlock_bh);
 
 int __lockfunc _spin_trylock_bh(spinlock_t *lock)
 {
-	local_bh_disable();
-	preempt_disable();
-	if (_raw_spin_trylock(lock)) {
-		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
-		return 1;
-	}
-
-	preempt_enable_no_resched();
-	local_bh_enable_ip((unsigned long)__builtin_return_address(0));
-	return 0;
+	return __spin_trylock_bh(lock);
 }
 EXPORT_SYMBOL(_spin_trylock_bh);
 

-- 
