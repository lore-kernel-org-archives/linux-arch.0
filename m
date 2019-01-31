From: Alex Kogan <alex.kogan@oracle.com>
Subject: [PATCH 2/3] locking/qspinlock: Introduce CNA into the slow path of qspinlock
Date: Wed, 30 Jan 2019 22:01:34 -0500
Message-ID: <20190131030136.56999-3-alex.kogan@oracle.com>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131030136.56999-1-alex.kogan@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
List-Id: linux-arch.vger.kernel.org

In CNA, spinning threads are organized in two queues, a main queue for
threads running on the same socket as the current lock holder, and a
secondary queue for threads running on other sockets. For details,
see https://arxiv.org/abs/1810.05600.

Note that this variant of CNA may introduce starvation by continuously
passing the lock to threads running on the same socket. This issue
will be addressed later in the series.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/asm-generic/qspinlock_types.h |  10 +++
 kernel/locking/mcs_spinlock.h         |  15 +++-
 kernel/locking/qspinlock.c            | 162 +++++++++++++++++++++++++++++-----
 3 files changed, 164 insertions(+), 23 deletions(-)

diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
index d10f1e7d6ba8..1807389ab0f9 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -109,4 +109,14 @@ typedef struct qspinlock {
 #define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
 #define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
 
+/*
+ * Bitfields in the non-atomic socket_and_count value:
+ * 0- 1: queue node index (always < 4)
+ * 2-31: socket id
+ */
+#define _Q_IDX_OFFSET		0
+#define _Q_IDX_BITS		2
+#define _Q_IDX_MASK		_Q_SET_MASK(IDX)
+#define _Q_SOCKET_OFFSET	(_Q_IDX_OFFSET + _Q_IDX_BITS)
+
 #endif /* __ASM_GENERIC_QSPINLOCK_TYPES_H */
diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index bc6d3244e1af..78a9920cf613 100644
--- a/kernel/locking/mcs_spinlock.h
+++ b/kernel/locking/mcs_spinlock.h
@@ -9,6 +9,12 @@
  * to acquire the lock spinning on a local variable.
  * It avoids expensive cache bouncings that common test-and-set spin-lock
  * implementations incur.
+ *
+ * This implementation of the MCS spin-lock is NUMA-aware. Spinning
+ * threads are organized in two queues, a main queue for threads running
+ * on the same socket as the current lock holder, and a secondary queue
+ * for threads running on other sockets.
+ * For details, see https://arxiv.org/abs/1810.05600.
  */
 #ifndef __LINUX_MCS_SPINLOCK_H
 #define __LINUX_MCS_SPINLOCK_H
@@ -17,8 +23,13 @@
 
 struct mcs_spinlock {
 	struct mcs_spinlock *next;
-	int locked; /* 1 if lock acquired */
-	int count;  /* nesting count, see qspinlock.c */
+	uintptr_t locked; /* 1 if lock acquired, 0 if not, other values */
+			  /* represent a pointer to the secondary queue head */
+	u32 socket_and_count;	/* socket id on which this thread is running */
+				/* with two lower bits reserved for nesting */
+				/* count, see qspinlock.c */
+	struct mcs_spinlock *tail;    /* points to the secondary queue tail */
+	u32 encoded_tail; /* encoding of this node as the main queue tail */
 };
 
 #ifndef arch_mcs_spin_lock_contended
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index fc88e9685bdf..6addc24f219d 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -77,14 +77,11 @@
 #define MAX_NODES	4
 
 /*
- * On 64-bit architectures, the mcs_spinlock structure will be 16 bytes in
- * size and four of them will fit nicely in one 64-byte cacheline. For
+ * On 64-bit architectures, the mcs_spinlock structure will be 32 bytes in
+ * size and two of them will fit nicely in one 64-byte cacheline. For
  * pvqspinlock, however, we need more space for extra data. To accommodate
- * that, we insert two more long words to pad it up to 32 bytes. IOW, only
- * two of them can fit in a cacheline in this case. That is OK as it is rare
- * to have more than 2 levels of slowpath nesting in actual use. We don't
- * want to penalize pvqspinlocks to optimize for a rare case in native
- * qspinlocks.
+ * that, we insert two more long words to pad it up to 40 bytes. IOW, only
+ * one of them can fit in a cacheline in this case.
  */
 struct qnode {
 	struct mcs_spinlock mcs;
@@ -109,9 +106,9 @@ struct qnode {
  * Per-CPU queue node structures; we can never have more than 4 nested
  * contexts: task, softirq, hardirq, nmi.
  *
- * Exactly fits one 64-byte cacheline on a 64-bit architecture.
+ * Exactly fits two 64-byte cachelines on a 64-bit architecture.
  *
- * PV doubles the storage and uses the second cacheline for PV state.
+ * PV adds more storage for PV state, and thus needs three cachelines.
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[MAX_NODES]);
 
@@ -124,9 +121,6 @@ static inline __pure u32 encode_tail(int cpu, int idx)
 {
 	u32 tail;
 
-#ifdef CONFIG_DEBUG_SPINLOCK
-	BUG_ON(idx > 3);
-#endif
 	tail  = (cpu + 1) << _Q_TAIL_CPU_OFFSET;
 	tail |= idx << _Q_TAIL_IDX_OFFSET; /* assume < 4 */
 
@@ -300,6 +294,81 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
 #define queued_spin_lock_slowpath	native_queued_spin_lock_slowpath
 #endif
 
+#define MCS_NODE(ptr) ((struct mcs_spinlock *)(ptr))
+
+static inline __pure int decode_socket(u32 socket_and_count)
+{
+	int socket = (socket_and_count >> _Q_SOCKET_OFFSET) - 1;
+
+	return socket;
+}
+
+static inline __pure int decode_count(u32 socket_and_count)
+{
+	int count = socket_and_count & _Q_IDX_MASK;
+
+	return count;
+}
+
+static inline void set_socket(struct mcs_spinlock *node, int socket)
+{
+	u32 val;
+
+	val  = (socket + 1) << _Q_SOCKET_OFFSET;
+	val |= decode_count(node->socket_and_count);
+
+	node->socket_and_count = val;
+}
+
+static struct mcs_spinlock *find_successor(struct mcs_spinlock *me,
+					   int my_cpuid)
+{
+	int my_socket;
+	struct mcs_spinlock *head_other, *tail_other, *cur;
+
+	struct mcs_spinlock *next = me->next;
+	/* @next should be set, else we would not be calling this function. */
+	WARN_ON_ONCE(next == NULL);
+
+	/* Get socket, which would not be set if we entered an empty queue. */
+	my_socket = decode_socket(me->socket_and_count);
+	if (my_socket == -1)
+		my_socket = numa_cpu_node(my_cpuid);
+	/*
+	 * Fast path - check whether the immediate successor runs on
+	 * the same socket.
+	 */
+	if (decode_socket(next->socket_and_count) == my_socket)
+		return next;
+
+	head_other = next;
+	tail_other = next;
+
+	/*
+	 * Traverse the main waiting queue starting from the successor of my
+	 * successor, and look for a thread running on the same socket.
+	 */
+	cur = READ_ONCE(next->next);
+	while (cur) {
+		if (decode_socket(cur->socket_and_count) == my_socket) {
+			/*
+			 * Found a thread on the same socket. Move threads
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
 #endif /* _GEN_PV_LOCK_SLOWPATH */
 
 /**
@@ -325,9 +394,9 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
  */
 void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 {
-	struct mcs_spinlock *prev, *next, *node;
-	u32 old, tail;
-	int idx;
+	struct mcs_spinlock *prev, *next, *node, *succ;
+	u32 old, tail, new;
+	int idx, cpuid;
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
@@ -409,8 +478,12 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	qstat_inc(qstat_lock_slowpath, true);
 pv_queue:
 	node = this_cpu_ptr(&qnodes[0].mcs);
-	idx = node->count++;
-	tail = encode_tail(smp_processor_id(), idx);
+#ifdef CONFIG_DEBUG_SPINLOCK
+	BUG_ON(decode_count(node->socket_and_count) >= 3);
+#endif
+	idx = decode_count(node->socket_and_count++);
+	cpuid = smp_processor_id();
+	tail = encode_tail(cpuid, idx);
 
 	node = grab_mcs_node(node, idx);
 
@@ -428,6 +501,8 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 
 	node->locked = 0;
 	node->next = NULL;
+	set_socket(node, -1);
+	node->encoded_tail = tail;
 	pv_init_node(node);
 
 	/*
@@ -462,6 +537,14 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if (old & _Q_TAIL_MASK) {
 		prev = decode_tail(old);
 
+		/*
+		 * An explicit barrier after the store to @socket
+		 * is not required as making the socket value visible is
+		 * required only for performance, not correctness, and
+		 * we rather avoid the cost of the barrier.
+		 */
+		set_socket(node, numa_cpu_node(cpuid));
+
 		/* Link @node into the waitqueue. */
 		WRITE_ONCE(prev->next, node);
 
@@ -477,6 +560,9 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 		next = READ_ONCE(node->next);
 		if (next)
 			prefetchw(next);
+	} else {
+		/* Must pass a non-zero value to successor when we unlock. */
+		node->locked = 1;
 	}
 
 	/*
@@ -528,8 +614,24 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 *       PENDING will make the uncontended transition fail.
 	 */
 	if ((val & _Q_TAIL_MASK) == tail) {
-		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
-			goto release; /* No contention */
+		/* Check whether the secondary queue is empty. */
+		if (node->locked == 1) {
+			if (atomic_try_cmpxchg_relaxed(&lock->val, &val,
+					_Q_LOCKED_VAL))
+				goto release; /* No contention */
+		} else {
+			/*
+			 * Pass the lock to the first thread in the secondary
+			 * queue, but first try to update the queue's tail to
+			 * point to the last node in the secondary queue.
+			 */
+			succ = MCS_NODE(node->locked);
+			new = succ->tail->encoded_tail + _Q_LOCKED_VAL;
+			if (atomic_try_cmpxchg_relaxed(&lock->val, &val, new)) {
+				arch_mcs_spin_unlock_contended(&succ->locked, 1);
+				goto release;
+			}
+		}
 	}
 
 	/*
@@ -545,14 +647,32 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if (!next)
 		next = smp_cond_load_relaxed(&node->next, (VAL));
 
-	arch_mcs_spin_unlock_contended(&next->locked, 1);
+	/* Try to pass the lock to a thread running on the same socket. */
+	succ = find_successor(node, cpuid);
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
 	pv_kick_node(lock, next);
 
 release:
 	/*
 	 * release the node
 	 */
-	__this_cpu_dec(qnodes[0].mcs.count);
+	__this_cpu_dec(qnodes[0].mcs.socket_and_count);
 }
 EXPORT_SYMBOL(queued_spin_lock_slowpath);
 
-- 
2.11.0 (Apple Git-81)
