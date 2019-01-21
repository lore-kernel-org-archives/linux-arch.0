From: Waiman Long <longman@redhat.com>
Subject: [PATCH 1/5] locking/qspinlock: Safely handle > 4 nesting levels
Date: Sun, 20 Jan 2019 21:49:50 -0500
Message-ID: <1548038994-30073-2-git-send-email-longman@redhat.com>
References: <1548038994-30073-1-git-send-email-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548038994-30073-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>, James Morse <james.morse@arm.com>, SRINIVAS <srinivas.eeda@oracle.com>, Waiman Long <longman@redhat.com>
List-Id: linux-arch.vger.kernel.org

Four queue nodes per cpu are allocated to enable up to 4 nesting levels
using the per-cpu nodes. Nested NMIs are possible in some architectures.
Still it is very unlikely that we will ever hit more than 4 nested
levels with contention in the slowpath.

When that rare condition happens, however, it is likely that the system
will hang or crash shortly after that. It is not good and we need to
handle this exception case.

On bare metal system, a new acquire_lock_no_node() function is now
added to deal with this case. The pending bit together with a new
waiting bit are overloaded to serve a special function as noted
below. The special tail value _Q_TAIL_WAITING is used as a special
flag by acquire_lock_no_node() to signal the next cpu to spin on the
waiting bit which is used as separator for the now disjointed queue.
Please see the comments in the code for the details.

On virtual machine, a new and simpler pv_acquire_lock_no_node() function
is used to directly steal the lock as lock stealing is allowed in the
PV locking path.

By doing so, we are able to support arbitrary nesting levels with no
noticeable performance degradation for the common case of <= 4 nesting
levels.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/asm-generic/qspinlock_types.h |  41 ++++++--
 kernel/locking/qspinlock.c            | 181 +++++++++++++++++++++++++++++++---
 kernel/locking/qspinlock_paravirt.h   |  30 +++++-
 3 files changed, 226 insertions(+), 26 deletions(-)

diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
index d10f1e7..50602dd 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -68,18 +68,20 @@
 /*
  * Bitfields in the atomic value:
  *
- * When NR_CPUS < 16K
+ * When NR_CPUS < 16K-1
  *  0- 7: locked byte
  *     8: pending
- *  9-15: not used
+ *  9-14: not used
+ *    15: waiting
  * 16-17: tail index
  * 18-31: tail cpu (+1)
  *
- * When NR_CPUS >= 16K
+ * When NR_CPUS >= 16K-1
  *  0- 7: locked byte
  *     8: pending
- *  9-10: tail index
- * 11-31: tail cpu (+1)
+ *     9: waiting
+ * 10-11: tail index
+ * 12-31: tail cpu (+1)
  */
 #define	_Q_SET_MASK(type)	(((1U << _Q_ ## type ## _BITS) - 1)\
 				      << _Q_ ## type ## _OFFSET)
@@ -88,14 +90,20 @@
 #define _Q_LOCKED_MASK		_Q_SET_MASK(LOCKED)
 
 #define _Q_PENDING_OFFSET	(_Q_LOCKED_OFFSET + _Q_LOCKED_BITS)
-#if CONFIG_NR_CPUS < (1U << 14)
-#define _Q_PENDING_BITS		8
+#if CONFIG_NR_CPUS < (1U << 14) - 1
+#define _Q_PENDING_BITS		7
 #else
 #define _Q_PENDING_BITS		1
 #endif
 #define _Q_PENDING_MASK		_Q_SET_MASK(PENDING)
 
-#define _Q_TAIL_IDX_OFFSET	(_Q_PENDING_OFFSET + _Q_PENDING_BITS)
+#define _Q_WAITING_OFFSET	(_Q_PENDING_OFFSET + _Q_PENDING_BITS)
+#define _Q_WAITING_BITS		1
+#define _Q_WAITING_MASK		_Q_SET_MASK(WAITING)
+
+#define _Q_WAIT_PEND_MASK	(_Q_PENDING_MASK | _Q_WAITING_MASK)
+
+#define _Q_TAIL_IDX_OFFSET	(_Q_WAITING_OFFSET + _Q_WAITING_BITS)
 #define _Q_TAIL_IDX_BITS	2
 #define _Q_TAIL_IDX_MASK	_Q_SET_MASK(TAIL_IDX)
 
@@ -109,4 +117,21 @@
 #define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
 #define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
 
+/*
+ * The special _Q_WAITING_VAL bit is set to indicate to the next CPU
+ * that it should spin on the waiting bit. It also tells the CPUs
+ * before to ignore the _Q_PENDING_VAL.
+ */
+#define _Q_WAITING_VAL		(1U << _Q_WAITING_OFFSET)
+#define _Q_WAIT_PEND_VAL	(_Q_WAITING_VAL | _Q_PENDING_VAL)
+
+/*
+ * The special _Q_TAIL_WAITING value in tail is used to indicate that
+ * the lock waiter who sees this should spin on the waiting bit instead
+ * and will become queue head once that bit is cleared. This also means
+ * one less cpu is supported in the max NR_CPUS for the more efficient
+ * qspinlock code.
+ */
+#define _Q_TAIL_WAITING	_Q_TAIL_MASK
+
 #endif /* __ASM_GENERIC_QSPINLOCK_TYPES_H */
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 8a8c3c2..5bb06df 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -56,13 +56,16 @@
  *
  * Since a spinlock disables recursion of its own context and there is a limit
  * to the contexts that can nest; namely: task, softirq, hardirq, nmi. As there
- * are at most 4 nesting levels, it can be encoded by a 2-bit number. Now
+ * should be at most 4 nesting levels, it can be encoded by a 2-bit number. Now
  * we can encode the tail by combining the 2-bit nesting level with the cpu
  * number. With one byte for the lock value and 3 bytes for the tail, only a
  * 32-bit word is now needed. Even though we only need 1 bit for the lock,
  * we extend it to a full byte to achieve better performance for architectures
  * that support atomic byte write.
  *
+ * If nmi nesting can happen, there are special code to handle more than
+ * 4 nesting levels.
+ *
  * We also change the first spinner to spin on the lock bit instead of its
  * node; whereby avoiding the need to carry a node from lock to unlock, and
  * preserving existing lock API. This also makes the unlock code simpler and
@@ -106,12 +109,15 @@ struct qnode {
 #endif
 
 /*
- * Per-CPU queue node structures; we can never have more than 4 nested
+ * Per-CPU queue node structures; we should not have more than 4 nested
  * contexts: task, softirq, hardirq, nmi.
  *
  * Exactly fits one 64-byte cacheline on a 64-bit architecture.
  *
  * PV doubles the storage and uses the second cacheline for PV state.
+ *
+ * In the rare case that more than 4 nesting levels are needed, special
+ * code is used to handle that without using any percpu queue node.
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[MAX_NODES]);
 
@@ -147,9 +153,16 @@ struct mcs_spinlock *grab_mcs_node(struct mcs_spinlock *base, int idx)
 	return &((struct qnode *)base + idx)->mcs;
 }
 
-#define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
+#define _Q_LOCKED_WAIT_PEND_MASK (_Q_LOCKED_MASK | _Q_WAIT_PEND_MASK)
+
+#if _Q_PENDING_BITS > 1
+/*
+ * Note: Both clear_pending() and clear_pending_set_locked() here have
+ * the side effect of clearing the waiting bit. However, both functions
+ * are used by the pending locker only which will not interact with a
+ * waiting waiter and so they shouldn't cause any problem.
+ */
 
-#if _Q_PENDING_BITS == 8
 /**
  * clear_pending - clear the pending bit.
  * @lock: Pointer to queued spinlock structure
@@ -194,7 +207,7 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
 }
 
-#else /* _Q_PENDING_BITS == 8 */
+#else /* _Q_PENDING_BITS > 1 */
 
 /**
  * clear_pending - clear the pending bit.
@@ -208,7 +221,7 @@ static __always_inline void clear_pending(struct qspinlock *lock)
 }
 
 /**
- * clear_pending_set_locked - take ownership and clear the pending bit.
+ * clear_pending_set_locked - take ownership and clear waiting/pending bit.
  * @lock: Pointer to queued spinlock structure
  *
  * *,1,0 -> *,0,1
@@ -233,7 +246,7 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 	u32 old, new, val = atomic_read(&lock->val);
 
 	for (;;) {
-		new = (val & _Q_LOCKED_PENDING_MASK) | tail;
+		new = (val & _Q_LOCKED_WAIT_PEND_MASK) | tail;
 		/*
 		 * We can use relaxed semantics since the caller ensures that
 		 * the MCS node is properly initialized before updating the
@@ -247,7 +260,7 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 	}
 	return old;
 }
-#endif /* _Q_PENDING_BITS == 8 */
+#endif /* _Q_PENDING_BITS > 1 */
 
 /**
  * queued_fetch_set_pending_acquire - fetch the whole lock value and set pending
@@ -274,6 +287,119 @@ static __always_inline void set_locked(struct qspinlock *lock)
 	WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
 }
 
+/**
+ *  acquire_lock_no_node - acquire lock without MCS node
+ *  @lock: Pointer to queued spinlock structure
+ *
+ *  It is extremely unlikely that this function will ever be called.
+ *  Marking it as noinline to not mess with the slowpath code. This
+ *  function is for native qspinlock only. The PV qspinlock code has
+ *  its own simpler version.
+ *
+ *  -----          -----  |   ----      -----          -----
+ * |Tail2| <- ... |Head2| |  |Node| <- |Tail1| <- ... |Head1|
+ *  -----          -----  |   ----      -----          -----
+ *                   |                                   |
+ *                   V                                   V
+ *             Spin on waiting                     Spin on locked
+ *
+ * The waiting and the pending bits will be acquired first which are now
+ * used as a separator for the disjointed queue shown above.
+ *
+ * The current CPU will then be inserted into queue by placing a special
+ * _Q_TAIL_WAITING value into the tail and makes the current tail
+ * point to its own local node. The next incoming CPU will see the special
+ * tail, but it has no way to find the node. Instead, it will spin on the
+ * waiting bit. When that bit is cleared, it means that all the the
+ * previous CPUs in the queue are gone and current CPU is the new lock
+ * holder. That will signal the next CPU (head2) to become the new queue
+ * head and spin on the locked flag.
+ *
+ * This will cause more lock cacheline contention, but performance is
+ * not a concern in this rarely used function.
+ *
+ * The handshake between waiting waiter CPU and the one that sets
+ * waiting bit is as follows:
+ *
+ *  setting CPU                          waiting CPU
+ *  -----------                          -----------
+ *  Set both pending & waiting
+ *  Push _Q_TAIL_WAITING to tail
+ *                                       Get _Q_TAIL_WAITING
+ *                                       Spin on waiting
+ *  If (lock free)
+ *    Set locked=1 && clear waiting
+ *                                       Observe !waiting
+ *                                       Clear pending
+ *                                       Become queue head
+ *
+ * Another no-node CPU can come now in to repeat the cycle again.
+ */
+static noinline void acquire_lock_no_node(struct qspinlock *lock)
+{
+	u32 old, new;
+
+	/*
+	 * Acquire both pending and waiting bits first to synchronize
+	 * with both a pending locker and a waiting waiter.
+	 */
+	for (;;) {
+		old = atomic_cond_read_relaxed(&lock->val,
+					      !(VAL & _Q_PENDING_VAL));
+		new = old | _Q_WAIT_PEND_VAL;
+		if (atomic_cmpxchg_acquire(&lock->val, old, new) == old)
+			break;
+	}
+
+	/*
+	 * Put _Q_TAIL_WAITING into tail. The next lock waiter that
+	 * sees it will observe the waiting bit and will wait until the
+	 * waiting bit is cleared before proceeding as the new queue head.
+	 */
+	old = xchg_tail(lock, _Q_TAIL_WAITING);
+	if (old & _Q_TAIL_MASK) {
+		struct mcs_spinlock node, *prev;
+
+		WARN_ON_ONCE((old & _Q_TAIL_MASK) == _Q_TAIL_WAITING);
+		node.locked = 0;
+		prev = decode_tail(old);
+		/*
+		 * Node data needed to be initialized before making
+		 * previous node point to it.
+		 */
+		smp_store_release(&prev->next, &node);
+		arch_mcs_spin_lock_contended(&node.locked);
+	}
+
+
+	/*
+	 * Acquire the lock, clear the tail (if applicable) and
+	 * the pending bits.
+	 */
+	old = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_MASK));
+	WARN_ON_ONCE(!(old & _Q_PENDING_MASK));
+
+	if (((old & _Q_TAIL_MASK) == _Q_TAIL_WAITING) &&
+	     atomic_try_cmpxchg_relaxed(&lock->val, &old, _Q_LOCKED_VAL))
+		return;	/* Clear both pending & waiting if no one sees it */
+	smp_mb__after_atomic();
+
+	/*
+	 * Set locked and clear waiting bit only
+	 */
+	atomic_add(_Q_LOCKED_VAL - _Q_WAITING_VAL, &lock->val);
+}
+
+/*
+ * Spin on the waiting bit until it is cleared.
+ */
+static noinline void spin_on_waiting(struct qspinlock *lock)
+{
+	atomic_cond_read_relaxed(&lock->val, !(VAL & _Q_WAITING_VAL));
+
+	/* Clear the pending bit now */
+	atomic_andnot(_Q_PENDING_VAL, &lock->val);
+}
 
 /*
  * Generate the native code for queued_spin_unlock_slowpath(); provide NOPs for
@@ -412,6 +538,19 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	idx = node->count++;
 	tail = encode_tail(smp_processor_id(), idx);
 
+	/*
+	 * 4 nodes are allocated based on the assumption that there will
+	 * not be nested NMIs taking spinlocks. That may not be true in
+	 * some architectures even though the chance of needing more than
+	 * 4 nodes will still be extremely unlikely. When that happens,
+	 * call the special acquire_lock_no_node() function to acquire
+	 * the lock without using any MCS node.
+	 */
+	if (unlikely(idx >= MAX_NODES)) {
+		acquire_lock_no_node(lock);
+		goto release;
+	}
+
 	node = grab_mcs_node(node, idx);
 
 	/*
@@ -460,6 +599,11 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * head of the waitqueue.
 	 */
 	if (old & _Q_TAIL_MASK) {
+		if (unlikely((old & _Q_TAIL_MASK) == _Q_TAIL_WAITING)) {
+			spin_on_waiting(lock);
+			goto wait_head;
+		}
+
 		prev = decode_tail(old);
 
 		/* Link @node into the waitqueue. */
@@ -500,10 +644,17 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * If PV isn't active, 0 will be returned instead.
 	 *
 	 */
+wait_head:
 	if ((val = pv_wait_head_or_lock(lock, node)))
 		goto locked;
 
-	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
+	/*
+	 * If both _Q_PENDING_VAL and _Q_WAITING_VAL are set, we can
+	 * ignore _Q_PENDING_VAL.
+	 */
+	val = atomic_cond_read_acquire(&lock->val,
+			!(VAL & _Q_LOCKED_MASK) &&
+			((VAL & _Q_WAIT_PEND_MASK) != _Q_PENDING_VAL));
 
 locked:
 	/*
@@ -521,14 +672,16 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * In the PV case we might already have _Q_LOCKED_VAL set, because
 	 * of lock stealing; therefore we must also allow:
 	 *
-	 * n,0,1 -> 0,0,1
+	 * n,*,1 -> 0,*,1
 	 *
-	 * Note: at this point: (val & _Q_PENDING_MASK) == 0, because of the
-	 *       above wait condition, therefore any concurrent setting of
-	 *       PENDING will make the uncontended transition fail.
+	 * If the tail hasn't been changed, either the pending and waiting
+	 * bits are both set or both cleared. We need to perserve their
+	 * bit setting.
 	 */
 	if ((val & _Q_TAIL_MASK) == tail) {
-		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
+		u32 new = _Q_LOCKED_VAL | (val & _Q_WAIT_PEND_MASK);
+
+		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, new))
 			goto release; /* No contention */
 	}
 
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 8f36c27..5600690 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -87,7 +87,7 @@ static inline bool pv_hybrid_queued_unfair_trylock(struct qspinlock *lock)
 	for (;;) {
 		int val = atomic_read(&lock->val);
 
-		if (!(val & _Q_LOCKED_PENDING_MASK) &&
+		if (!(val & _Q_LOCKED_WAIT_PEND_MASK) &&
 		   (cmpxchg_acquire(&lock->locked, 0, _Q_LOCKED_VAL) == 0)) {
 			qstat_inc(qstat_pv_lock_stealing, true);
 			return true;
@@ -105,7 +105,7 @@ static inline bool pv_hybrid_queued_unfair_trylock(struct qspinlock *lock)
  * The pending bit is used by the queue head vCPU to indicate that it
  * is actively spinning on the lock and no lock stealing is allowed.
  */
-#if _Q_PENDING_BITS == 8
+#if _Q_PENDING_BITS > 1
 static __always_inline void set_pending(struct qspinlock *lock)
 {
 	WRITE_ONCE(lock->pending, 1);
@@ -122,7 +122,7 @@ static __always_inline int trylock_clear_pending(struct qspinlock *lock)
 	       (cmpxchg_acquire(&lock->locked_pending, _Q_PENDING_VAL,
 				_Q_LOCKED_VAL) == _Q_PENDING_VAL);
 }
-#else /* _Q_PENDING_BITS == 8 */
+#else /* _Q_PENDING_BITS > 1 */
 static __always_inline void set_pending(struct qspinlock *lock)
 {
 	atomic_or(_Q_PENDING_VAL, &lock->val);
@@ -150,7 +150,7 @@ static __always_inline int trylock_clear_pending(struct qspinlock *lock)
 	}
 	return 0;
 }
-#endif /* _Q_PENDING_BITS == 8 */
+#endif /* _Q_PENDING_BITS > 1 */
 
 /*
  * Lock and MCS node addresses hash table for fast lookup
@@ -485,6 +485,28 @@ static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 }
 
 /*
+ * Call to set_locked() isn't needed for the PV locking path.
+ */
+#define set_locked(lock)	pv_set_locked(lock)
+static __always_inline void pv_set_locked(struct qspinlock *lock) { }
+
+/*
+ * We don't need to deal with the pending and pending-ignore bit for the
+ * PV locking path as lock stealing is supported. We can simply steal
+ * the lock here without even considering the pending bit and move forward.
+ */
+#define acquire_lock_no_node(lock)	pv_acquire_lock_no_node(lock)
+static noinline void pv_acquire_lock_no_node(struct qspinlock *lock)
+{
+	u8 val;
+
+	do {
+		atomic_cond_read_relaxed(&lock->val, !(VAL & _Q_LOCKED_MASK));
+		val = cmpxchg_acquire(&lock->locked, 0, _Q_LOCKED_VAL);
+	} while (!val);
+}
+
+/*
  * PV versions of the unlock fastpath and slowpath functions to be used
  * instead of queued_spin_unlock().
  */
-- 
1.8.3.1
