From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v15 16/16] unfair qspinlock: a queue based unfair lock
Date: Wed,  8 Apr 2015 14:32:19 -0400
Message-ID: <1428517939-27968-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, Waiman Long <Waiman.Long@hp.com>, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Scott J Norton <scott.norton@hp.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

For a virtual guest with the qspinlock patch, a simple unfair byte lock
will be used if PV spinlock is not configured in or the hypervisor
isn't either KVM or Xen. The byte lock works fine with small guest
of just a few vCPUs. On a much larger guest, however, byte lock can
have serious performance problem.

There are 2 major drawbacks for the unfair byte lock:
 1) The constant reading and occasionally writing to the lock word can
    put a lot of cacheline contention traffic on the affected
    cacheline.
 2) Lock starvation is a real possibility especially if the number
    of vCPUs is large.

This patch introduces a queue based unfair lock where all the vCPUs
on the queue can opportunistically steal the lock, but the frequency
of doing so decreases exponentially the further it is away from the
queue head. This can greatly reduce cacheline contention problem as
well as encouraging a more FIFO like order of getting the lock.

This patch has no impact on native qspinlock performance at all.

To measure the performance benefit of such a scheme, a linux kernel
build workload (make -j <n>) was run on a virtual KVM guest with
different configurations on a 8-socket with 4 active cores/socket
Westmere-EX server (8x4). <n> is the number of vCPUs in the guest. The
test configurations were:

 1) 32 NUMA-pinned vCPUs (8x4)
 2) 32 vCPUs (no pinning or NUMA)
 3) 60 vCPUs (overcommitted)

The kernel build times for different 4.0-rc6 based kernels were:

	Kernel		  VM1	    VM2		VM3
	------		  ---	    ---		---
     PV ticket lock	3m49.7s	  11m45.6s    15m59.3s
     PV qspinlock	3m50.4s    5m51.6s    15m33.6s
     unfair byte lock	3m50.6s   61m01.1s   122m07.7s
     unfair qspinlock	3m48.3s    5m03.1s     4m31.1s

For VM1, all the locks give essentially the same performance. In both
VM2 and VM3, the performance of byte lock was terrible whereas the
unfair qspinlock was the fastest of all. For this particular test, the
unfair qspinlock can be more than 10X faster than a simple byte lock.

VM2 also illustrated the performance benefit of qspinlock versus
ticket spinlock which got reduced in VM3 due to the overhead of
constant vCPUs halting and kicking.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/x86/include/asm/qspinlock.h  |   15 +--
 kernel/locking/qspinlock.c        |   94 +++++++++++++--
 kernel/locking/qspinlock_unfair.h |  231 +++++++++++++++++++++++++++++++++++++
 3 files changed, 319 insertions(+), 21 deletions(-)
 create mode 100644 kernel/locking/qspinlock_unfair.h

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index c8290db..8113685 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -39,17 +39,16 @@ static inline void queue_spin_unlock(struct qspinlock *lock)
 }
 #endif
 
-#define virt_queue_spin_lock virt_queue_spin_lock
+#ifndef static_cpu_has_hypervisor
+#define static_cpu_has_hypervisor	static_cpu_has(X86_FEATURE_HYPERVISOR)
+#endif
 
-static inline bool virt_queue_spin_lock(struct qspinlock *lock)
+#define queue_spin_trylock_unfair queue_spin_trylock_unfair
+static inline bool queue_spin_trylock_unfair(struct qspinlock *lock)
 {
-	if (!static_cpu_has(X86_FEATURE_HYPERVISOR))
-		return false;
-
-	while (atomic_cmpxchg(&lock->val, 0, _Q_LOCKED_VAL) != 0)
-		cpu_relax();
+	u8 *l = (u8 *)lock;
 
-	return true;
+	return !READ_ONCE(*l) && (xchg(l, _Q_LOCKED_VAL) == 0);
 }
 
 #include <asm-generic/qspinlock.h>
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index b9ba83b..5fda6d5 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -19,7 +19,11 @@
  *          Peter Zijlstra <peterz@infradead.org>
  */
 
-#ifndef _GEN_PV_LOCK_SLOWPATH
+#if defined(_GEN_PV_LOCK_SLOWPATH) || defined(_GEN_UNFAIR_LOCK_SLOWPATH)
+#define	_GEN_LOCK_SLOWPATH
+#endif
+
+#ifndef _GEN_LOCK_SLOWPATH
 
 #include <linux/smp.h>
 #include <linux/bug.h>
@@ -68,12 +72,6 @@
 
 #include "mcs_spinlock.h"
 
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
-#define MAX_NODES	8
-#else
-#define MAX_NODES	4
-#endif
-
 /*
  * Per-CPU queue node structures; we can never have more than 4 nested
  * contexts: task, softirq, hardirq, nmi.
@@ -81,7 +79,9 @@
  * Exactly fits one 64-byte cacheline on a 64-bit architecture.
  *
  * PV doubles the storage and uses the second cacheline for PV state.
+ * Unfair lock (mutually exclusive to PV) also uses the second cacheline.
  */
+#define MAX_NODES	8
 static DEFINE_PER_CPU_ALIGNED(struct mcs_spinlock, mcs_nodes[MAX_NODES]);
 
 /*
@@ -234,7 +234,7 @@ static __always_inline void set_locked(struct qspinlock *lock)
 
 /*
  * Generate the native code for queue_spin_unlock_slowpath(); provide NOPs for
- * all the PV callbacks.
+ * all the PV and unfair callbacks.
  */
 
 static __always_inline void __pv_init_node(struct mcs_spinlock *node) { }
@@ -244,19 +244,36 @@ static __always_inline void __pv_scan_next(struct qspinlock *lock,
 static __always_inline void __pv_wait_head(struct qspinlock *lock,
 					   struct mcs_spinlock *node) { }
 
+static __always_inline void __unfair_init_node(struct mcs_spinlock *node) { }
+static __always_inline bool __unfair_wait_node(struct qspinlock *lock,
+					       struct mcs_spinlock *node,
+					       struct mcs_spinlock *prev,
+					       u32 my_tail, u32 prev_tail)
+					       { return false; }
+static __always_inline bool __unfair_wait_head(struct qspinlock *lock,
+					       struct mcs_spinlock *node,
+					       u32 tail)
+					       { return false; }
+
 #define pv_enabled()		false
+#define unfair_enabled()	false
 
 #define pv_init_node		__pv_init_node
 #define pv_wait_node		__pv_wait_node
 #define pv_scan_next		__pv_scan_next
-
 #define pv_wait_head		__pv_wait_head
 
+#define unfair_init_node	__unfair_init_node
+#define unfair_wait_node	__unfair_wait_node
+#define unfair_wait_head	__unfair_wait_head
+
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 #define queue_spin_lock_slowpath	native_queue_spin_lock_slowpath
 #endif
 
-#endif /* _GEN_PV_LOCK_SLOWPATH */
+void queue_spin_lock_slowpath_unfair(struct qspinlock *lock, u32 val);
+
+#endif /* _GEN_LOCK_SLOWPATH */
 
 /**
  * queue_spin_lock_slowpath - acquire the queue spinlock
@@ -287,11 +304,13 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
-	if (pv_enabled())
+	if (pv_enabled() || unfair_enabled())
 		goto queue;
 
-	if (virt_queue_spin_lock(lock))
+	if (static_cpu_has_hypervisor) {
+		queue_spin_lock_slowpath_unfair(lock, val);
 		return;
+	}
 
 	/*
 	 * wait for in-progress pending->locked hand-overs
@@ -367,6 +386,7 @@ queue:
 	node->locked = 0;
 	node->next = NULL;
 	pv_init_node(node);
+	unfair_init_node(node);
 
 	/*
 	 * We touched a (possibly) cold cacheline in the per-cpu queue node;
@@ -393,6 +413,8 @@ queue:
 		WRITE_ONCE(prev->next, node);
 
 		pv_wait_node(node);
+		if (unfair_wait_node(lock, node, prev, tail, old))
+			goto release;
 		arch_mcs_spin_lock_contended(&node->locked);
 	}
 
@@ -409,6 +431,8 @@ queue:
 	 *
 	 */
 	pv_wait_head(lock, node);
+	if (unfair_wait_head(lock, node, tail))
+		goto release;
 	while ((val = smp_load_acquire(&lock->val.counter)) & _Q_LOCKED_PENDING_MASK)
 		cpu_relax();
 
@@ -454,7 +478,7 @@ EXPORT_SYMBOL(queue_spin_lock_slowpath);
 /*
  * Generate the paravirt code for queue_spin_unlock_slowpath().
  */
-#if !defined(_GEN_PV_LOCK_SLOWPATH) && defined(CONFIG_PARAVIRT_SPINLOCKS)
+#if !defined(_GEN_LOCK_SLOWPATH) && defined(CONFIG_PARAVIRT_SPINLOCKS)
 #define _GEN_PV_LOCK_SLOWPATH
 
 #undef  pv_enabled
@@ -471,4 +495,48 @@ EXPORT_SYMBOL(queue_spin_lock_slowpath);
 #include "qspinlock_paravirt.h"
 #include "qspinlock.c"
 
+#undef _GEN_PV_LOCK_SLOWPATH
+
+#define pv_init_node	__pv_init_node
+#define pv_wait_node	__pv_wait_node
+#define pv_scan_next	__pv_scan_next
+#define pv_wait_head	__pv_wait_head
+
+#endif
+
+/*
+ * Generate the unfair lock code for queue_spin_unlock_slowpath().
+ */
+#if !defined(_GEN_LOCK_SLOWPATH)
+#define _GEN_UNFAIR_LOCK_SLOWPATH
+
+#undef  unfair_enabled
+#define unfair_enabled()	true
+
+#undef unfair_init_node
+#undef unfair_wait_node
+#undef unfair_wait_head
+
+#ifdef queue_spin_lock_slowpath
+#undef queue_spin_lock_slowpath
+#endif
+#define queue_spin_lock_slowpath	queue_spin_lock_slowpath_unfair
+
+#ifdef queue_spin_trylock
+#undef queue_spin_trylock
+#endif
+#define queue_spin_trylock		queue_spin_trylock_unfair
+
+#undef  EXPORT_SYMBOL
+#define EXPORT_SYMBOL(x)
+
+#include "qspinlock_unfair.h"
+#include "qspinlock.c"
+
+#undef _GEN_UNFAIR_LOCK_SLOWPATH
+
+#endif
+
+#ifdef _GEN_LOCK_SLOWPATH
+#undef _GEN_LOCK_SLOWPATH
 #endif
diff --git a/kernel/locking/qspinlock_unfair.h b/kernel/locking/qspinlock_unfair.h
new file mode 100644
index 0000000..c86335e
--- /dev/null
+++ b/kernel/locking/qspinlock_unfair.h
@@ -0,0 +1,231 @@
+#ifndef _GEN_UNFAIR_LOCK_SLOWPATH
+#error "do not include this file"
+#endif
+
+/*
+ * Unfair lock support in a virtualized guest
+ *
+ * An unfair lock can be implemented using a simple test-and-set lock like
+ * what is being done in a read-write lock. This simple scheme has 2 major
+ * problems:
+ *  1) It needs constant reading and occasionally writing to the lock word
+ *     thus putting a lot of cacheline contention traffic on the affected
+ *     cacheline.
+ *  2) Lock starvation is a real possibility especially if the number of
+ *     virtual CPUs is large.
+ *
+ * To reduce the undesirable side effects of an unfair lock, the queue
+ * unfair spinlock implements a more elaborate scheme.
+ *
+ * Even in the wait queue, the task can still attempt to steal the lock
+ * periodically at a frequency about inversely and logarithmically
+ * proportional to its distance from the queue head. In other word, the
+ * closer it is to the queue head, the higher the chance it has of stealing
+ * the lock. This scheme reduces the load on the lock cacheline while trying
+ * to maintain a somewhat FIFO order of getting the lock so as to reduce
+ * the chance of lock starvation.
+ */
+#define LSTEAL_MIN		(1 << 3)
+#define LSTEAL_MAX		(1 << 10)
+
+struct uf_node {
+	struct mcs_spinlock	mcs;
+	struct mcs_spinlock	__res[3];
+
+	struct uf_node		*prev;		/* Previous node address   */
+	int			lsteal_period;	/* Lock stealing period    */
+	u32			prev_tail;	/* Previous node tail code */
+};
+
+/**
+ * cmpxchg_tail - Put in the new tail code if it matches the old one
+ * @lock : Pointer to queue spinlock structure
+ * @old  : The old tail code value
+ * @new  : The new tail code value
+ * Return: true if operation succeeds, false otherwise
+ *
+ * It is assumed that the caller has grabbed the lock before calling it and
+ * pending bit isn't being used.
+ */
+static __always_inline int
+cmpxchg_tail(struct qspinlock *lock, u32 old, u32 new)
+{
+	old |= _Q_LOCKED_VAL;
+	new |= _Q_LOCKED_VAL;
+	return atomic_cmpxchg(&lock->val, old, new) == old;
+}
+
+/**
+ * Initialize the unfair part of the mcs_spinlock node.
+ * @node: Pointer to mcs_spinlock structure
+ */
+static inline void unfair_init_node(struct mcs_spinlock *node)
+{
+	struct uf_node *pn = (struct uf_node *)node;
+
+	BUILD_BUG_ON(sizeof(struct uf_node) > 5*sizeof(struct mcs_spinlock));
+
+	pn->prev	  = NULL;
+	pn->prev_tail	  = 0;
+	pn->lsteal_period = LSTEAL_MIN >> 1;
+}
+
+/**
+ * Wait for node->locked to become true or the lock was stolen.
+ * @lock     : Pointer to queue spinlock structure
+ * @node     : Pointer to mcs_spinlock structure of current node
+ * @prev     : Pointer to mcs_spinlock structure of previous node
+ * @my_tail  : Tail code of current node
+ * @prev_tail: Tail code of previous node
+ *
+ * Return: true if lock stolen, false if becoming queue head
+ */
+static inline bool unfair_wait_node(struct qspinlock *lock,
+				    struct mcs_spinlock *node,
+				    struct mcs_spinlock *prev,
+				    u32 my_tail, u32 prev_tail)
+{
+	struct uf_node *next, *pn = (struct uf_node *)node;
+	int  loop;
+	bool isqhead;
+
+	pn->prev      = (struct uf_node *)prev;
+	pn->prev_tail = prev_tail;
+	/*
+	 * Make sure that the other nodes see the prev & prev_tail value
+	 * before proceeding.
+	 */
+	smp_wmb();
+
+	for (;;) {
+		/*
+		 * This node will spin double the number of times of the
+		 * previous node before attempting to steal the lock until
+		 * it reaches a maximum.
+		 */
+		pn->lsteal_period = (READ_ONCE(pn->prev->lsteal_period) << 1);
+		if (pn->lsteal_period > LSTEAL_MAX)
+			pn->lsteal_period = LSTEAL_MAX;
+		for (loop = pn->lsteal_period; loop; loop--) {
+			/*
+			 * The caller will do a load-acquire for us.
+			 */
+			if (READ_ONCE(node->locked))
+				return false;
+			cpu_relax();
+		}
+
+		/*
+		 * Attempt to steal the lock
+		 */
+		if (queue_spin_trylock_unfair(lock))
+			break;	/* Got the lock */
+	}
+
+	/*
+	 * Have stolen the lock, need to remove itself from the wait queue.
+	 * There are 3 steps that need to be done:
+	 * 1) If it is at the end of the queue, change the tail code in the
+	 *    lock to the one before it. If the current node has become the
+	 *    queue head, the previous tail code is 0.
+	 * 2) Change the next pointer in the previous queue node to point
+	 *    to the next one in queue or NULL if it is at the end of queue.
+	 * 3) If a next node is present, copy the prev_tail and prev values
+	 *    to the next node.
+	 *
+	 * Note that no forward progress is possible in other nodes as the
+	 * lock has just been acquired.
+	 */
+	isqhead   = READ_ONCE(pn->mcs.locked);
+	prev_tail = isqhead ? 0 : pn->prev_tail;
+
+	if (isqhead)
+		pn->lsteal_period = LSTEAL_MIN >> 1;
+
+	/* Step 1 */
+	if ((atomic_read(&lock->val) == (my_tail | _Q_LOCKED_VAL)) &&
+	     cmpxchg_tail(lock, my_tail, prev_tail)) {
+		/*
+		 * Successfully change the tail code back to the
+		 * previous one. Now need to clear the next pointer
+		 * in the previous node only if it contains my queue
+		 * node address and is not the queue head.
+		 *
+		 * The cmpxchg() call below may fail if a new task
+		 * comes along and put its node address into the next
+		 * pointer. Whether the operation succeeds or fails
+		 * doesn't really matter.
+		 */
+		/* Step 2 */
+		if (!isqhead)
+			(void)cmpxchg(&pn->prev->mcs.next, &pn->mcs, NULL);
+		pn->mcs.next = NULL;
+		return true;
+	}
+
+	/*
+	 * Step 3
+	 * A next node has to be present if the lock has a different
+	 * tail code. So wait until the next pointer is set.
+	 */
+	while (!(next = (struct uf_node *)READ_ONCE(node->next)))
+		cpu_relax();
+	if (isqhead) {
+		struct mcs_spinlock *nxt = (struct mcs_spinlock *)next;
+
+		arch_mcs_spin_unlock_contended(&nxt->locked);
+		return true;	/* Done for queue head */
+	}
+
+	WRITE_ONCE(pn->prev->mcs.next, (struct mcs_spinlock *)next);
+
+	/*
+	 * Need to make sure that prev and prev_tail of the next node
+	 * are set up before modifying them.
+	 */
+	while (!READ_ONCE(next->prev) || !READ_ONCE(next->prev_tail))
+		cpu_relax();
+	WRITE_ONCE(next->prev	  , pn->prev);
+	WRITE_ONCE(next->prev_tail, pn->prev_tail);
+
+	/*
+	 * Make sure all the new node information are visible before
+	 * proceeding.
+	 */
+	smp_wmb();
+	return true;
+}
+
+/**
+ * As queue head, attempt to acquire the lock in a normal spin loop.
+ * @lock: Pointer to queue spinlock structure
+ * @node: Pointer to mcs_spinlock structure of current node
+ * @tail: Tail code of current node
+ *
+ * Return: true is always returned
+ */
+static inline bool
+unfair_wait_head(struct qspinlock *lock, struct mcs_spinlock *node, u32 tail)
+{
+	struct uf_node *pn = (struct uf_node *)node;
+	struct mcs_spinlock *next;
+
+	pn->lsteal_period = LSTEAL_MIN >> 1;
+	while (!queue_spin_trylock_unfair(lock))
+		cpu_relax();
+
+	/*
+	 * Remove tail code in the lock if it is the only one in the queue
+	 */
+	if ((atomic_read(&lock->val) == (tail | _Q_LOCKED_VAL)) &&
+	     cmpxchg_tail(lock, tail, 0))
+		goto release;
+
+	while (!(next = READ_ONCE(node->next)))
+		cpu_relax();
+
+	arch_mcs_spin_unlock_contended(&next->locked);
+
+release:
+	return true;
+}
-- 
1.7.1
