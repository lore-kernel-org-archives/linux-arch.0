From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH 4/4] locking/qrwlock: Use direct MCS lock/unlock in slowpath
Date: Mon,  6 Jul 2015 11:43:06 -0400
Message-ID: <1436197386-58635-5-git-send-email-Waiman.Long@hp.com>
References: <1436197386-58635-1-git-send-email-Waiman.Long@hp.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g2t1383g.austin.hp.com ([15.217.136.92]:33630 "EHLO
	g2t1383g.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605AbbGFPnx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jul 2015 11:43:53 -0400
Received: from g1t5425.austin.hp.com (g1t5425.austin.hp.com [15.216.225.55])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g2t1383g.austin.hp.com (Postfix) with ESMTPS id F1CF6346B
	for <linux-arch@vger.kernel.org>; Mon,  6 Jul 2015 15:43:28 +0000 (UTC)
In-Reply-To: <1436197386-58635-1-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>, Waiman Long <Waiman.Long@hp.com>

Lock waiting in the qrwlock uses the spinlock (qspinlock for x86)
as the waiting queue. This is slower than using MCS lock directly
because of the extra level of indirection causing more atomics to
be used as well as 2 waiting threads spinning on the lock cacheline
instead of only one.

This patch change lock waiting code to use direct MCS lock/unlock for
bare metal, but keep on using spinlock in VM guest to take advantage
of the pvqspinlock and unfair lock functionality of the qspinlock code.

With that patch, we saw further improvement in reader and writer
performance on a Haswell-EX box using a locking microbenchmark.

Before patch:

        Locker          Locking Rate (Kops/s)
        ------          ---------------------
        reader              17,241,552
        writer              12,906,593

After patch:

        Locker          Locking Rate (Kops/s)
        ------          ---------------------
        reader              17,436,786
        writer              14,394,326

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/x86/include/asm/qrwlock.h      |    4 +
 include/asm-generic/qrwlock_types.h |   26 ++++++-
 kernel/locking/qrwlock.c            |  142 +++++++++++++++++++++++++++++------
 kernel/locking/qspinlock.c          |    9 +-
 4 files changed, 149 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/qrwlock.h b/arch/x86/include/asm/qrwlock.h
index ae0e241..7fab5ad 100644
--- a/arch/x86/include/asm/qrwlock.h
+++ b/arch/x86/include/asm/qrwlock.h
@@ -3,6 +3,10 @@
 
 #include <asm-generic/qrwlock_types.h>
 
+#if defined(CONFIG_HYPERVISOR_GUEST) && !defined(static_cpu_has_hypervisor)
+#define static_cpu_has_hypervisor	static_cpu_has(X86_FEATURE_HYPERVISOR)
+#endif
+
 #ifndef CONFIG_X86_PPRO_FENCE
 #define queue_write_unlock queue_write_unlock
 static inline void queue_write_unlock(struct qrwlock *lock)
diff --git a/include/asm-generic/qrwlock_types.h b/include/asm-generic/qrwlock_types.h
index 4d76f24..8efd4b9 100644
--- a/include/asm-generic/qrwlock_types.h
+++ b/include/asm-generic/qrwlock_types.h
@@ -3,19 +3,37 @@
 
 #include <linux/types.h>
 #include <asm/spinlock_types.h>
+#include <asm/byteorder.h>
 
 /*
  * The queue read/write lock data structure
  */
 
 typedef struct qrwlock {
-	atomic_t		cnts;
-	arch_spinlock_t		lock;
+	union {
+		atomic_t	cnts;
+		struct {
+#ifdef __LITTLE_ENDIAN
+			u8	wmode;		/* Writer mode   */
+			u8	rcnts[3];	/* Reader counts */
+#else
+			u8	rcnts[3];	/* Reader counts */
+			u8	wmode;		/* Writer mode   */
+#endif
+		};
+	};
+	union {
+		u32		tail;
+		arch_spinlock_t	lock;
+	};
 } arch_rwlock_t;
 
-#define	__ARCH_RW_LOCK_UNLOCKED {		\
+/*
+ * Assuming that the spinlock is also initialized to 0.
+ */
+#define __ARCH_RW_LOCK_UNLOCKED {		\
 	.cnts = ATOMIC_INIT(0),			\
-	.lock = __ARCH_SPIN_LOCK_UNLOCKED,	\
+	.tail = 0,				\
 }
 
 #endif /* __ASM_GENERIC_QRWLOCK_TYPES_H */
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index 87e2d6b..d3e40c1 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -11,7 +11,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * (C) Copyright 2013-2014 Hewlett-Packard Development Company, L.P.
+ * (C) Copyright 2013-2015 Hewlett-Packard Development Company, L.P.
  *
  * Authors: Waiman Long <waiman.long@hp.com>
  */
@@ -21,26 +21,117 @@
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
 #include <asm/qrwlock.h>
+#include "mcs_spinlock.h"
 
 /*
- * This internal data structure is used for optimizing access to some of
- * the subfields within the atomic_t cnts.
+ * Use the internal qspinlock MCS nodes, if available
  */
-struct __qrwlock {
-	union {
-		atomic_t cnts;
-		struct {
-#ifdef __LITTLE_ENDIAN
-			u8 wmode;	/* Writer mode   */
-			u8 rcnts[3];	/* Reader counts */
+#ifdef CONFIG_QUEUED_SPINLOCKS
+extern struct mcs_spinlock _mcs_qnodes[];
 #else
-			u8 rcnts[3];	/* Reader counts */
-			u8 wmode;	/* Writer mode   */
+static DEFINE_PER_CPU_ALIGNED(struct mcs_spinlock, _mcs_qnodes[4]);
 #endif
-		};
-	};
-	arch_spinlock_t	lock;
-};
+
+#ifndef static_cpu_has_hypervisor
+#define static_cpu_has_hypervisor	false
+#endif
+
+/*
+ * The following qlock()/qunlock() functions are simplified versions of the
+ * locking code in qspinlock.c. In bare metal, the MCS locking and unlocking
+ * code will be used to minimize the performance difference between qspinlock
+ * and qwriter lock. In VM guest, however, the qspinlock functions will be
+ * called to take advantage of the pvqspinlock and unfair lock functionality
+ * present in the qspinlock code at the expense of a bit of performance.
+ */
+#define TAIL_CPU_OFFSET		2
+#define TAIL_IDX_MASK		3
+
+static inline u32 encode_tail(int cpu, int idx)
+{
+	return ((cpu + 1) << TAIL_CPU_OFFSET) | (idx & TAIL_IDX_MASK);
+}
+
+static inline struct mcs_spinlock *decode_tail(u32 tail)
+{
+	int cpu = (tail >> TAIL_CPU_OFFSET) - 1;
+	int idx = tail & TAIL_IDX_MASK;
+
+	return per_cpu_ptr(&_mcs_qnodes[idx], cpu);
+}
+
+/*
+ * Enter the MCS lock waiting queue
+ */
+static inline u32 qlock(struct qrwlock *lock, struct mcs_spinlock **nptr)
+{
+	struct mcs_spinlock *prev, *node;
+	u32 old, tail;
+	int idx;
+
+	/*
+	 * Use arch_spin_lock() if under hypervisor
+	 */
+	if (static_cpu_has_hypervisor) {
+		arch_spin_lock(&lock->lock);
+		return 0;
+	}
+
+	/*
+	 * MCS node initialization
+	 */
+	node = this_cpu_ptr(&_mcs_qnodes[0]);
+	idx = node->count++;
+	tail = encode_tail(smp_processor_id(), idx);
+	node += idx;
+	node->locked = 0;
+	node->next = NULL;
+
+	old = xchg(&lock->tail, tail);
+
+	if (old) {
+		prev = decode_tail(old);
+		WRITE_ONCE(prev->next, node);
+		arch_mcs_spin_lock_contended(&node->locked);
+	}
+
+	/* Got the lock now */
+	*nptr = node;
+	return tail;
+}
+
+/*
+ * Exit the MCS lock waiting queue
+ */
+static inline void
+qunlock(struct qrwlock *lock, struct mcs_spinlock *node, u32 tail)
+{
+	struct mcs_spinlock *next;
+
+	/*
+	 * Use arch_spin_unlock() if under hypervisor
+	 */
+	if (static_cpu_has_hypervisor) {
+		arch_spin_unlock(&lock->lock);
+		return;
+	}
+
+
+	if ((READ_ONCE(lock->tail) == tail) &&
+	    (cmpxchg(&lock->tail, tail, 0) == tail))
+		goto release;
+	/*
+	 * Contended path; wait for next, release.
+	 */
+	while (!(next = READ_ONCE(node->next)))
+		cpu_relax();
+	arch_mcs_spin_unlock_contended(&next->locked);
+release:
+	/*
+	 * Release the node
+	 */
+	this_cpu_dec(_mcs_qnodes[0].count);
+}
 
 /**
  * rspin_until_writer_unlock - inc reader count & spin until writer is gone
@@ -66,6 +157,10 @@ rspin_until_writer_unlock(struct qrwlock *lock, u32 cnts)
  */
 void queue_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
 {
+	struct mcs_spinlock *node = NULL;
+	u32 tail;
+
+
 	/*
 	 * Readers come here when they cannot get the lock without waiting
 	 */
@@ -85,7 +180,7 @@ void queue_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
 	/*
 	 * Put the reader into the wait queue
 	 */
-	arch_spin_lock(&lock->lock);
+	tail = qlock(lock, &node);
 
 	/*
 	 * At the head of the wait queue now, increment the reader count
@@ -99,7 +194,7 @@ void queue_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
 	/*
 	 * Signal the next one in queue to become queue head
 	 */
-	arch_spin_unlock(&lock->lock);
+	qunlock(lock, node, tail);
 }
 EXPORT_SYMBOL(queue_read_lock_slowpath);
 
@@ -109,8 +204,9 @@ EXPORT_SYMBOL(queue_read_lock_slowpath);
  */
 void queue_write_lock_slowpath(struct qrwlock *lock)
 {
+	struct mcs_spinlock *node = NULL;
 	/* Put the writer into the wait queue */
-	arch_spin_lock(&lock->lock);
+	u32 tail = qlock(lock, &node);
 
 	/* Try to acquire the lock directly if no reader is present */
 	for (;;) {
@@ -131,10 +227,8 @@ void queue_write_lock_slowpath(struct qrwlock *lock)
 	 * or wait for a previous writer to go away.
 	 */
 	for (;;) {
-		struct __qrwlock *l = (struct __qrwlock *)lock;
-
-		if (!READ_ONCE(l->wmode) &&
-		   (cmpxchg(&l->wmode, 0, _QW_WAITING) == 0))
+		if (!READ_ONCE(lock->wmode) &&
+		   (cmpxchg(&lock->wmode, 0, _QW_WAITING) == 0))
 			break;
 
 		cpu_relax_lowlatency();
@@ -150,6 +244,6 @@ void queue_write_lock_slowpath(struct qrwlock *lock)
 		cpu_relax_lowlatency();
 	}
 unlock:
-	arch_spin_unlock(&lock->lock);
+	qunlock(lock, node, tail);
 }
 EXPORT_SYMBOL(queue_write_lock_slowpath);
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 38c4920..3812498 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -81,8 +81,9 @@
  * Exactly fits one 64-byte cacheline on a 64-bit architecture.
  *
  * PV doubles the storage and uses the second cacheline for PV state.
+ * The MCS nodes are also shared with qrwlock.
  */
-static DEFINE_PER_CPU_ALIGNED(struct mcs_spinlock, mcs_nodes[MAX_NODES]);
+DEFINE_PER_CPU_ALIGNED(struct mcs_spinlock, _mcs_qnodes[MAX_NODES]);
 
 /*
  * We must be able to distinguish between no-tail and the tail at 0:0,
@@ -107,7 +108,7 @@ static inline struct mcs_spinlock *decode_tail(u32 tail)
 	int cpu = (tail >> _Q_TAIL_CPU_OFFSET) - 1;
 	int idx = (tail &  _Q_TAIL_IDX_MASK) >> _Q_TAIL_IDX_OFFSET;
 
-	return per_cpu_ptr(&mcs_nodes[idx], cpu);
+	return per_cpu_ptr(&_mcs_qnodes[idx], cpu);
 }
 
 #define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
@@ -358,7 +359,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * queuing.
 	 */
 queue:
-	node = this_cpu_ptr(&mcs_nodes[0]);
+	node = this_cpu_ptr(&_mcs_qnodes[0]);
 	idx = node->count++;
 	tail = encode_tail(smp_processor_id(), idx);
 
@@ -446,7 +447,7 @@ release:
 	/*
 	 * release the node
 	 */
-	this_cpu_dec(mcs_nodes[0].count);
+	this_cpu_dec(_mcs_qnodes[0].count);
 }
 EXPORT_SYMBOL(queued_spin_lock_slowpath);
 
-- 
1.7.1
