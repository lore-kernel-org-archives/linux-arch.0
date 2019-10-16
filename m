Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:34124 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389479AbfJPEci (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 00:32:38 -0400
From: Alex Kogan <alex.kogan@oracle.com>
Subject: [PATCH v5 2/5] locking/qspinlock: Refactor the qspinlock slow path
Date: Wed, 16 Oct 2019 00:29:00 -0400
Message-ID: <20191016042903.61081-3-alex.kogan@oracle.com>
In-Reply-To: <20191016042903.61081-1-alex.kogan@oracle.com>
References: <20191016042903.61081-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20191016042900.EKMwPieu8ugIPf8R6QuRgF6-PVwaooHYEyGLlbDJXeU@z>

Move some of the code manipulating the spin lock into separate functions.
This would allow easier integration of alternative ways to manipulate
that lock.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/locking/qspinlock.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 804c0fbd6328..c06d1e8075d9 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -288,6 +288,34 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
 #define queued_spin_lock_slowpath	native_queued_spin_lock_slowpath
 #endif
 
+/*
+ * __try_clear_tail - try to clear tail by setting the lock value to
+ * _Q_LOCKED_VAL.
+ * @lock: Pointer to the queued spinlock structure
+ * @val: Current value of the lock
+ * @node: Pointer to the MCS node of the lock holder
+ */
+static __always_inline bool __try_clear_tail(struct qspinlock *lock,
+						   u32 val,
+						   struct mcs_spinlock *node)
+{
+	return atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL);
+}
+
+/*
+ * __mcs_pass_lock - pass the MCS lock to the next waiter
+ * @node: Pointer to the MCS node of the lock holder
+ * @next: Pointer to the MCS node of the first waiter in the MCS queue
+ */
+static __always_inline void __mcs_pass_lock(struct mcs_spinlock *node,
+					    struct mcs_spinlock *next)
+{
+	arch_mcs_pass_lock(&next->locked, 1);
+}
+
+#define try_clear_tail	__try_clear_tail
+#define mcs_pass_lock		__mcs_pass_lock
+
 #endif /* _GEN_PV_LOCK_SLOWPATH */
 
 /**
@@ -532,7 +560,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 *       PENDING will make the uncontended transition fail.
 	 */
 	if ((val & _Q_TAIL_MASK) == tail) {
-		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
+		if (try_clear_tail(lock, val, node))
 			goto release; /* No contention */
 	}
 
@@ -549,7 +577,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if (!next)
 		next = smp_cond_load_relaxed(&node->next, (VAL));
 
-	arch_mcs_pass_lock(&next->locked, 1);
+	mcs_pass_lock(node, next);
 	pv_kick_node(lock, next);
 
 release:
@@ -574,6 +602,12 @@ EXPORT_SYMBOL(queued_spin_lock_slowpath);
 #undef pv_kick_node
 #undef pv_wait_head_or_lock
 
+#undef try_clear_tail
+#define try_clear_tail		__try_clear_tail
+
+#undef mcs_pass_lock
+#define mcs_pass_lock			__mcs_pass_lock
+
 #undef  queued_spin_lock_slowpath
 #define queued_spin_lock_slowpath	__pv_queued_spin_lock_slowpath
 
-- 
2.11.0 (Apple Git-81)
