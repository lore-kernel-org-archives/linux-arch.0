From: Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] locking/qspinlock: Store lock holder cpu in lock if feasible
Date: Sat, 11 Jul 2020 14:21:27 -0400
Message-ID: <20200711182128.29130-2-longman@redhat.com>
References: <20200711182128.29130-1-longman@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55447 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728746AbgGKSXA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Jul 2020 14:23:00 -0400
In-Reply-To: <20200711182128.29130-1-longman@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, Waiman Long <longman@redhat.com>

When doing crash dump analysis with lock, it is cumbersome to find
out who the lock holder is. One have to look at the call traces of all
the cpus to figure that out. It will be helpful if the lock itself can
provide some clue about the lock holder cpu.

The locking state is determined by whether the locked byte is set or not
(1 or 0). There is another special value for PV qspinlock (3). The whole
byte is used because of performance reason. So there is space to store
additional information such as the lock holder cpu as long as the cpu
number is small enough to fit into a little less than a byte which is
true for most typical 1 or 2-socket systems.

There may be a slight performance overhead in encoding the lock holder
cpu number especially in the fastpath. Doing it in the slowpath, however,
should be essentially free.

This patch modifies the slowpath code to add the encoded cpu number
(cpu_nr + 2) to the locked byte as long as it is less than 253.
A locked byte value of 1 means the lock holder cpu is not known. It
is set in the fast path or when the cpu number is just too large. The
special locked byte value of 255 is reserved for PV qspinlock.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/asm-generic/qspinlock_types.h |  5 +++
 kernel/locking/qspinlock.c            | 47 +++++++++++++++++----------
 2 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
index 56d1309d32f8..11f0a3001daf 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -71,6 +71,11 @@ typedef struct qspinlock {
  *     8: pending
  *  9-10: tail index
  * 11-31: tail cpu (+1)
+ *
+ * Lock acquired via the fastpath will have a locked byte value of 1. Lock
+ * acquired via the slowpath may have a locked byte value of (cpu_nr + 2)
+ * if cpu_nr < 253. For cpu number beyond that range, a value of 1 will
+ * always be used.
  */
 #define	_Q_SET_MASK(type)	(((1U << _Q_ ## type ## _BITS) - 1)\
 				      << _Q_ ## type ## _OFFSET)
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index b9515fcc9b29..13feefa85db4 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -106,6 +106,7 @@ struct qnode {
  * PV doubles the storage and uses the second cacheline for PV state.
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[MAX_NODES]);
+static DEFINE_PER_CPU_READ_MOSTLY(u8, pcpu_lockval) = _Q_LOCKED_VAL;
 
 /*
  * We must be able to distinguish between no-tail and the tail at 0:0,
@@ -138,6 +139,19 @@ struct mcs_spinlock *grab_mcs_node(struct mcs_spinlock *base, int idx)
 
 #define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
 
+static __init int __init_pcpu_lockval(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		u8 lockval = (cpu + 2 < _Q_LOCKED_MASK - 1) ? cpu + 2
+							    : _Q_LOCKED_VAL;
+		per_cpu(pcpu_lockval, cpu) = lockval;
+	}
+	return 0;
+}
+early_initcall(__init_pcpu_lockval);
+
 #if _Q_PENDING_BITS == 8
 /**
  * clear_pending - clear the pending bit.
@@ -158,9 +172,9 @@ static __always_inline void clear_pending(struct qspinlock *lock)
  *
  * Lock stealing is not allowed if this function is used.
  */
-static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
+static __always_inline void clear_pending_set_locked(struct qspinlock *lock, u8 lockval)
 {
-	WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
+	WRITE_ONCE(lock->locked_pending, lockval);
 }
 
 /*
@@ -202,9 +216,9 @@ static __always_inline void clear_pending(struct qspinlock *lock)
  *
  * *,1,0 -> *,0,1
  */
-static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
+static __always_inline void clear_pending_set_locked(struct qspinlock *lock, u8 lockval)
 {
-	atomic_add(-_Q_PENDING_VAL + _Q_LOCKED_VAL, &lock->val);
+	atomic_add(-_Q_PENDING_VAL + lockval, &lock->val);
 }
 
 /**
@@ -258,9 +272,9 @@ static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lo
  *
  * *,*,0 -> *,0,1
  */
-static __always_inline void set_locked(struct qspinlock *lock)
+static __always_inline void set_locked(struct qspinlock *lock, u8 lockval)
 {
-	WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
+	WRITE_ONCE(lock->locked, lockval);
 }
 
 
@@ -317,6 +331,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	struct mcs_spinlock *prev, *next, *node;
 	u32 old, tail;
 	int idx;
+	u8 lockval = this_cpu_read(pcpu_lockval);
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
@@ -386,7 +401,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 *
 	 * 0,1,0 -> 0,0,1
 	 */
-	clear_pending_set_locked(lock);
+	clear_pending_set_locked(lock, lockval);
 	lockevent_inc(lock_pending);
 	return;
 
@@ -501,16 +516,14 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * been designated yet, there is no way for the locked value to become
 	 * _Q_SLOW_VAL. So both the set_locked() and the
 	 * atomic_cmpxchg_relaxed() calls will be safe.
-	 *
-	 * If PV isn't active, 0 will be returned instead.
-	 *
 	 */
-	if ((val = pv_wait_head_or_lock(lock, node)))
-		goto locked;
-
-	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
+	if (pv_enabled()) {
+		val = pv_wait_head_or_lock(lock, node);
+		lockval = val & _Q_LOCKED_MASK;
+	} else {
+		val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
+	}
 
-locked:
 	/*
 	 * claim the lock:
 	 *
@@ -533,7 +546,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 *       PENDING will make the uncontended transition fail.
 	 */
 	if ((val & _Q_TAIL_MASK) == tail) {
-		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
+		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, lockval))
 			goto release; /* No contention */
 	}
 
@@ -542,7 +555,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * which will then detect the remaining tail and queue behind us
 	 * ensuring we'll see a @next.
 	 */
-	set_locked(lock);
+	set_locked(lock, lockval);
 
 	/*
 	 * contended path; wait for next if not observed yet, release.
-- 
2.18.1
