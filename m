Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:38142 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbfC2PVY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Mar 2019 11:21:24 -0400
From: Alex Kogan <alex.kogan@oracle.com>
Subject: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow path of qspinlock
Date: Fri, 29 Mar 2019 11:20:04 -0400
Message-ID: <20190329152006.110370-4-alex.kogan@oracle.com>
In-Reply-To: <20190329152006.110370-1-alex.kogan@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190329152004.rZMROKtNJ07eAVgKnfjXgqC1vlMmMV_-p2nYVVlmDHA@z>

In CNA, spinning threads are organized in two queues, a main queue for
threads running on the same node as the current lock holder, and a
secondary queue for threads running on other nodes. At the unlock time,
the lock holder scans the main queue looking for a thread running on
the same node. If found (call it thread T), all threads in the main queue
between the current lock holder and T are moved to the end of the
secondary queue, and the lock is passed to T. If such T is not found, the
lock is passed to the first node in the secondary queue. Finally, if the
secondary queue is empty, the lock is passed to the next thread in the
main queue. For more details, see https://arxiv.org/abs/1810.05600.

Note that this variant of CNA may introduce starvation by continuously
passing the lock to threads running on the same node. This issue
will be addressed later in the series.

Enabling CNA is controlled via a new configuration option
(NUMA_AWARE_SPINLOCKS), which is enabled by default if NUMA is enabled.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 arch/x86/Kconfig                      |  14 +++
 include/asm-generic/qspinlock_types.h |  13 +++
 kernel/locking/mcs_spinlock.h         |  10 ++
 kernel/locking/qspinlock.c            |  29 +++++-
 kernel/locking/qspinlock_cna.h        | 173 ++++++++++++++++++++++++++++++++++
 5 files changed, 236 insertions(+), 3 deletions(-)
 create mode 100644 kernel/locking/qspinlock_cna.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 68261430fe6e..e70c39a901f2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1554,6 +1554,20 @@ config NUMA
 
 	  Otherwise, you should say N.
 
+config NUMA_AWARE_SPINLOCKS
+	bool "Numa-aware spinlocks"
+	depends on NUMA
+	default y
+	help
+	  Introduce NUMA (Non Uniform Memory Access) awareness into
+	  the slow path of spinlocks.
+
+	  The kernel will try to keep the lock on the same node,
+	  thus reducing the number of remote cache misses, while
+	  trading some of the short term fairness for better performance.
+
+	  Say N if you want absolute first come first serve fairness.
+
 config AMD_NUMA
 	def_bool y
 	prompt "Old style AMD Opteron NUMA detection"
diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
index d10f1e7d6ba8..23368ca20d2d 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -109,4 +109,17 @@ typedef struct qspinlock {
 #define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
 #define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
 
+#ifdef CONFIG_NUMA_AWARE_SPINLOCKS
+/*
+ * Bitfields in the non-atomic node_and_count value:
+ * 0- 1: queue node index (always < 4)
+ * 2-31: numa node id
+ */
+#define _Q_IDX_OFFSET		0
+#define _Q_IDX_BITS		2
+#define _Q_IDX_MASK		_Q_SET_MASK(IDX)
+#define _Q_NODE_OFFSET		(_Q_IDX_OFFSET + _Q_IDX_BITS)
+
+#endif /* CONFIG_NUMA_AWARE_SPINLOCKS */
+
 #endif /* __ASM_GENERIC_QSPINLOCK_TYPES_H */
diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index bc6d3244e1af..71ee4b64c5d4 100644
--- a/kernel/locking/mcs_spinlock.h
+++ b/kernel/locking/mcs_spinlock.h
@@ -17,8 +17,18 @@
 
 struct mcs_spinlock {
 	struct mcs_spinlock *next;
+#ifndef CONFIG_NUMA_AWARE_SPINLOCKS
 	int locked; /* 1 if lock acquired */
 	int count;  /* nesting count, see qspinlock.c */
+#else /* CONFIG_NUMA_AWARE_SPINLOCKS */
+	uintptr_t locked; /* 1 if lock acquired, 0 if not, other values */
+			  /* represent a pointer to the secondary queue head */
+	u32 node_and_count;	/* node id on which this thread is running */
+				/* with two lower bits reserved for nesting */
+				/* count, see qspinlock.c */
+	u32 encoded_tail; /* encoding of this node as the main queue tail */
+	struct mcs_spinlock *tail;    /* points to the secondary queue tail */
+#endif /* CONFIG_NUMA_AWARE_SPINLOCKS */
 };
 
 #ifndef arch_mcs_spin_lock_contended
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 074f65b9bedc..7cc923a59716 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -85,6 +85,8 @@
  * to have more than 2 levels of slowpath nesting in actual use. We don't
  * want to penalize pvqspinlocks to optimize for a rare case in native
  * qspinlocks.
+ * Note that when CNA is used, the mcs_spinlock structure
+ * is 32 bytes in size, so two of them fit in one 64-byte cacheline.
  */
 struct qnode {
 	struct mcs_spinlock mcs;
@@ -109,7 +111,8 @@ struct qnode {
  * Per-CPU queue node structures; we can never have more than 4 nested
  * contexts: task, softirq, hardirq, nmi.
  *
- * Exactly fits one 64-byte cacheline on a 64-bit architecture.
+ * Exactly fits one 64-byte cacheline (or two, if CNA is used)
+ * on a 64-bit architecture.
  *
  * PV doubles the storage and uses the second cacheline for PV state.
  */
@@ -297,6 +300,8 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
 #define queued_spin_lock_slowpath	native_queued_spin_lock_slowpath
 #endif
 
+#ifndef CONFIG_NUMA_AWARE_SPINLOCKS
+
 static __always_inline int get_node_index(struct mcs_spinlock *node)
 {
 	return node->count++;
@@ -334,6 +339,16 @@ static __always_inline void pass_mcs_lock(struct mcs_spinlock *node,
 	arch_mcs_spin_unlock_contended(&next->locked, 1);
 }
 
+static __always_inline void cna_init_node(struct mcs_spinlock *node,
+					  int cpuid, u32 tail) { }
+
+#else /* CONFIG_NUMA_AWARE_SPINLOCKS */
+
+#define _GEN_CNA_LOCK_SLOWPATH
+#include "qspinlock_cna.h"
+
+#endif /* CONFIG_NUMA_AWARE_SPINLOCKS */
+
 #endif /* _GEN_PV_LOCK_SLOWPATH */
 
 /**
@@ -361,7 +376,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 {
 	struct mcs_spinlock *prev, *next, *node;
 	u32 old, tail;
-	int idx;
+	int idx, cpuid;
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
@@ -444,7 +459,8 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 pv_queue:
 	node = this_cpu_ptr(&qnodes[0].mcs);
 	idx = get_node_index(node);
-	tail = encode_tail(smp_processor_id(), idx);
+	cpuid = smp_processor_id();
+	tail = encode_tail(cpuid, idx);
 
 	/*
 	 * 4 nodes are allocated based on the assumption that there will
@@ -478,6 +494,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 
 	node->locked = 0;
 	node->next = NULL;
+	cna_init_node(node, cpuid, tail);
 	pv_init_node(node);
 
 	/*
@@ -527,6 +544,12 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 		next = READ_ONCE(node->next);
 		if (next)
 			prefetchw(next);
+	} else {
+		 /* In CNA, we must pass a non-zero value to successor when
+		  * we unlock. This store should be harmless performance-wise,
+		  * as we just initialized @node.
+		  */
+		node->locked = 1;
 	}
 
 	/*
diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
new file mode 100644
index 000000000000..5bc5fd9586ea
--- /dev/null
+++ b/kernel/locking/qspinlock_cna.h
@@ -0,0 +1,173 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _GEN_CNA_LOCK_SLOWPATH
+#error "do not include this file"
+#endif
+
+/*
+ * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
+ *
+ * In CNA, spinning threads are organized in two queues, a main queue for
+ * threads running on the same node as the current lock holder, and a
+ * secondary queue for threads running on other nodes. At the unlock time,
+ * the lock holder scans the main queue looking for a thread running on
+ * the same node. If found (call it thread T), all threads in the main queue
+ * between the current lock holder and T are moved to the end of the
+ * secondary queue, and the lock is passed to T. If such T is not found, the
+ * lock is passed to the first node in the secondary queue. Finally, if the
+ * secondary queue is empty, the lock is passed to the next thread in the
+ * main queue.
+ *
+ * For details, see https://arxiv.org/abs/1810.05600.
+ *
+ * Authors: Alex Kogan <alex.kogan@oracle.com>
+ *          Dave Dice <dave.dice@oracle.com>
+ */
+
+#define MCS_NODE(ptr) ((struct mcs_spinlock *)(ptr))
+
+static inline __pure int decode_numa_node(u32 node_and_count)
+{
+	int node = (node_and_count >> _Q_NODE_OFFSET) - 1;
+
+	return node;
+}
+
+static inline __pure int decode_count(u32 node_and_count)
+{
+	int count = node_and_count & _Q_IDX_MASK;
+
+	return count;
+}
+
+static inline void store_numa_node(struct mcs_spinlock *node, int numa_node)
+{
+	u32 val;
+
+	val  = (numa_node + 1) << _Q_NODE_OFFSET;
+	val |= decode_count(node->node_and_count);
+
+	node->node_and_count = val;
+}
+
+/**
+ * find_successor - Scan the main waiting queue looking for the first
+ * thread running on the same node as the lock holder. If found (call it
+ * thread T), move all threads in the main queue between the lock holder
+ * and T to the end of the secondary queue and return T; otherwise, return NULL.
+ */
+static struct mcs_spinlock *find_successor(struct mcs_spinlock *me)
+{
+	int my_node;
+	struct mcs_spinlock *head_other, *tail_other, *cur;
+	struct mcs_spinlock *next = me->next;
+
+	/* @next should be set, else we would not be calling this function. */
+	WARN_ON_ONCE(next == NULL);
+
+	/* Get node, which would not be set if we entered an empty queue. */
+	my_node = decode_numa_node(me->node_and_count);
+
+	/*
+	 * Fast path - check whether the immediate successor runs on
+	 * the same node.
+	 */
+	if (decode_numa_node(next->node_and_count) == my_node)
+		return next;
+
+	head_other = next;
+	tail_other = next;
+
+	/*
+	 * Traverse the main waiting queue starting from the successor of my
+	 * successor, and look for a thread running on the same node.
+	 */
+	cur = READ_ONCE(next->next);
+	while (cur) {
+		if (decode_numa_node(cur->node_and_count) == my_node) {
+			/*
+			 * Found a thread on the same node. Move threads
+			 * between me and that node into the secondary queue.
+			 */
+			if (me->locked > 1)
+				MCS_NODE(me->locked)->tail->next = head_other;
+			else
+				me->locked = (uintptr_t)head_other;
+			tail_other->next = NULL;
+			MCS_NODE(me->locked)->tail = tail_other;
+			return cur;
+		}
+		tail_other = cur;
+		cur = READ_ONCE(cur->next);
+	}
+	return NULL;
+}
+
+static __always_inline int get_node_index(struct mcs_spinlock *node)
+{
+	return decode_count(node->node_and_count++);
+}
+
+static __always_inline void release_mcs_node(struct mcs_spinlock *node)
+{
+	__this_cpu_dec(node->node_and_count);
+}
+
+static __always_inline void cna_init_node(struct mcs_spinlock *node, int cpuid,
+					  u32 tail)
+{
+	if (decode_numa_node(node->node_and_count) == -1)
+		store_numa_node(node, numa_cpu_node(cpuid));
+	node->encoded_tail = tail;
+}
+
+static inline bool set_locked_empty_mcs(struct qspinlock *lock, u32 val,
+					struct mcs_spinlock *node)
+{
+	/* Check whether the secondary queue is empty. */
+	if (node->locked == 1) {
+		if (atomic_try_cmpxchg_relaxed(&lock->val, &val,
+				_Q_LOCKED_VAL))
+			return true; /* No contention */
+	} else {
+		/*
+		 * Pass the lock to the first thread in the secondary
+		 * queue, but first try to update the queue's tail to
+		 * point to the last node in the secondary queue.
+		 */
+		struct mcs_spinlock *succ = MCS_NODE(node->locked);
+		u32 new = succ->tail->encoded_tail + _Q_LOCKED_VAL;
+
+		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, new)) {
+			arch_mcs_spin_unlock_contended(&succ->locked, 1);
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static inline void pass_mcs_lock(struct mcs_spinlock *node,
+				 struct mcs_spinlock *next)
+{
+	struct mcs_spinlock *succ = NULL;
+
+	succ = find_successor(node);
+
+	if (succ) {
+		arch_mcs_spin_unlock_contended(&succ->locked, node->locked);
+	} else if (node->locked > 1) {
+		/*
+		 * If the secondary queue is not empty, pass the lock
+		 * to the first node in that queue.
+		 */
+		succ = MCS_NODE(node->locked);
+		succ->tail->next = next;
+		arch_mcs_spin_unlock_contended(&succ->locked, 1);
+	} else {
+		/*
+		 * Otherwise, pass the lock to the immediate successor
+		 * in the main queue.
+		 */
+		arch_mcs_spin_unlock_contended(&next->locked, 1);
+	}
+}
-- 
2.11.0 (Apple Git-81)
