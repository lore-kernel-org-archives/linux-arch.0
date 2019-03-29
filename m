Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:43818 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbfC2PVX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Mar 2019 11:21:23 -0400
From: Alex Kogan <alex.kogan@oracle.com>
Subject: [PATCH v2 2/5] locking/qspinlock: Refactor the qspinlock slow path
Date: Fri, 29 Mar 2019 11:20:03 -0400
Message-ID: <20190329152006.110370-3-alex.kogan@oracle.com>
In-Reply-To: <20190329152006.110370-1-alex.kogan@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190329152003.HGgKjQMdAuOC8Pi-SgHKimMu6G-riToIytuvp9XFcVQ@z>

Move some of the code manipulating MCS nodes into separate functions.
This would allow easier integration of alternative ways to manipulate
those nodes.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/locking/qspinlock.c | 48 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 5941ce3527ce..074f65b9bedc 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -297,6 +297,43 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
 #define queued_spin_lock_slowpath	native_queued_spin_lock_slowpath
 #endif
 
+static __always_inline int get_node_index(struct mcs_spinlock *node)
+{
+	return node->count++;
+}
+
+static __always_inline void release_mcs_node(struct mcs_spinlock *node)
+{
+	__this_cpu_dec(node->count);
+}
+
+/*
+ * set_locked_empty_mcs - Try to set the spinlock value to _Q_LOCKED_VAL,
+ * and by doing that unlock the MCS lock when its waiting queue is empty
+ * @lock: Pointer to queued spinlock structure
+ * @val: Current value of the lock
+ * @node: Pointer to the MCS node of the lock holder
+ *
+ *  *,*,* -> 0,0,1
+ */
+static __always_inline bool set_locked_empty_mcs(struct qspinlock *lock,
+						 u32 val,
+						 struct mcs_spinlock *node)
+{
+	return atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL);
+}
+
+/*
+ * pass_mcs_lock - pass the MCS lock to the next waiter
+ * @node: Pointer to the MCS node of the lock holder
+ * @next: Pointer to the MCS node of the first waiter in the MCS queue
+ */
+static __always_inline void pass_mcs_lock(struct mcs_spinlock *node,
+					  struct mcs_spinlock *next)
+{
+	arch_mcs_spin_unlock_contended(&next->locked, 1);
+}
+
 #endif /* _GEN_PV_LOCK_SLOWPATH */
 
 /**
@@ -406,7 +443,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	qstat_inc(qstat_lock_slowpath, true);
 pv_queue:
 	node = this_cpu_ptr(&qnodes[0].mcs);
-	idx = node->count++;
+	idx = get_node_index(node);
 	tail = encode_tail(smp_processor_id(), idx);
 
 	/*
@@ -541,7 +578,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 *       PENDING will make the uncontended transition fail.
 	 */
 	if ((val & _Q_TAIL_MASK) == tail) {
-		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
+		if (set_locked_empty_mcs(lock, val, node))
 			goto release; /* No contention */
 	}
 
@@ -558,14 +595,11 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if (!next)
 		next = smp_cond_load_relaxed(&node->next, (VAL));
 
-	arch_mcs_spin_unlock_contended(&next->locked, 1);
+	pass_mcs_lock(node, next);
 	pv_kick_node(lock, next);
 
 release:
-	/*
-	 * release the node
-	 */
-	__this_cpu_dec(qnodes[0].mcs.count);
+	release_mcs_node(&qnodes[0].mcs);
 }
 EXPORT_SYMBOL(queued_spin_lock_slowpath);
 
-- 
2.11.0 (Apple Git-81)
