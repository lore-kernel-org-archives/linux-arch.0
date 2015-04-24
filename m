From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v16 14/14] pvqspinlock: Collect slowpath lock
	statistics
Date: Fri, 24 Apr 2015 14:56:43 -0400
Message-ID: <1429901803-29771-15-git-send-email-Waiman.Long@hp.com>
References: <1429901803-29771-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1429901803-29771-1-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, Waiman Long <Waiman.Long@hp.com>, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Daniel J Blueman <daniel@numascale.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Scott J Norton <scott.norton@hp.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

This patch enables the accumulation of PV qspinlock statistics
when either one of the following three sets of CONFIG parameters
are enabled:

 1) CONFIG_LOCK_STAT && CONFIG_DEBUG_FS
 2) CONFIG_KVM_DEBUG_FS
 3) CONFIG_XEN_DEBUG_FS

The accumulated lock statistics will be reported in debugfs under the
pv-qspinlock directory.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 kernel/locking/qspinlock_paravirt.h |  100 ++++++++++++++++++++++++++++++++++-
 1 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 41ee033..d512d9b 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -43,6 +43,86 @@ struct pv_node {
 	u8			mayhalt;
 };
 
+#if defined(CONFIG_KVM_DEBUG_FS) || defined(CONFIG_XEN_DEBUG_FS) ||\
+   (defined(CONFIG_LOCK_STAT) && defined(CONFIG_DEBUG_FS))
+#define PV_QSPINLOCK_STAT
+#endif
+
+/*
+ * PV qspinlock statistics
+ */
+enum pv_qlock_stat {
+	pv_stat_wait_head,
+	pv_stat_wait_node,
+	pv_stat_wait_hash,
+	pv_stat_kick_cpu,
+	pv_stat_no_kick,
+	pv_stat_spurious,
+	pv_stat_hash,
+	pv_stat_hops,
+	pv_stat_num	/* Total number of statistics counts */
+};
+
+#ifdef PV_QSPINLOCK_STAT
+
+#include <linux/debugfs.h>
+
+static const char * const stat_fsnames[pv_stat_num] = {
+	[pv_stat_wait_head] = "wait_head_count",
+	[pv_stat_wait_node] = "wait_node_count",
+	[pv_stat_wait_hash] = "wait_hash_count",
+	[pv_stat_kick_cpu]  = "kick_cpu_count",
+	[pv_stat_no_kick]   = "no_kick_count",
+	[pv_stat_spurious]  = "spurious_wakeup",
+	[pv_stat_hash]	    = "hash_count",
+	[pv_stat_hops]	    = "hash_hops_count",
+};
+
+static atomic_t pv_stats[pv_stat_num];
+
+/*
+ * Initialize debugfs for the PV qspinlock statistics
+ */
+static int __init pv_qspinlock_debugfs(void)
+{
+	struct dentry *d_pvqlock = debugfs_create_dir("pv-qspinlock", NULL);
+	int i;
+
+	if (!d_pvqlock)
+		printk(KERN_WARNING
+		       "Could not create 'pv-qspinlock' debugfs directory\n");
+
+	for (i = 0; i < pv_stat_num; i++)
+		debugfs_create_u32(stat_fsnames[i], 0444, d_pvqlock,
+				  (u32 *)&pv_stats[i]);
+	return 0;
+}
+fs_initcall(pv_qspinlock_debugfs);
+
+/*
+ * Increment the PV qspinlock statistics counts
+ */
+static inline void pvstat_inc(enum pv_qlock_stat stat)
+{
+	atomic_inc(&pv_stats[stat]);
+}
+
+/*
+ * PV hash hop count
+ */
+static inline void pvstat_hop(int hopcnt)
+{
+	atomic_inc(&pv_stats[pv_stat_hash]);
+	atomic_add(hopcnt, &pv_stats[pv_stat_hops]);
+}
+
+#else /* PV_QSPINLOCK_STAT */
+
+static inline void pvstat_inc(enum pv_qlock_stat stat)	{ }
+static inline void pvstat_hop(int hopcnt)		{ }
+
+#endif /* PV_QSPINLOCK_STAT */
+
 /*
  * Lock and MCS node addresses hash table for fast lookup
  *
@@ -102,11 +182,13 @@ pv_hash(struct qspinlock *lock, struct pv_node *node)
 {
 	unsigned long init_hash, hash = hash_ptr(lock, pv_lock_hash_bits);
 	struct pv_hash_entry *he, *end;
+	int hopcnt = 0;
 
 	init_hash = hash;
 	for (;;) {
 		he = pv_lock_hash[hash].ent;
 		for (end = he + PV_HE_PER_LINE; he < end; he++) {
+			hopcnt++;
 			if (!cmpxchg(&he->lock, NULL, lock)) {
 				/*
 				 * We haven't set the _Q_SLOW_VAL yet. So
@@ -122,6 +204,7 @@ pv_hash(struct qspinlock *lock, struct pv_node *node)
 	}
 
 done:
+	pvstat_hop(hopcnt);
 	return &he->lock;
 }
 
@@ -177,8 +260,12 @@ __visible void __pv_queue_spin_unlock(struct qspinlock *lock)
 	 * At this point the memory pointed at by lock can be freed/reused,
 	 * however we can still use the PV node to kick the CPU.
 	 */
-	if (READ_ONCE(node->state) != vcpu_running)
+	if (READ_ONCE(node->state) != vcpu_running) {
+		pvstat_inc(pv_stat_kick_cpu);
 		pv_kick(node->cpu);
+	} else {
+		pvstat_inc(pv_stat_no_kick);
+	}
 }
 /*
  * Include the architecture specific callee-save thunk of the
@@ -241,8 +328,10 @@ static void pv_wait_node(struct mcs_spinlock *node)
 		 */
 		(void)xchg(&pn->state, vcpu_halted);
 
-		if (!READ_ONCE(node->locked))
+		if (!READ_ONCE(node->locked)) {
+			pvstat_inc(pv_stat_wait_node);
 			pv_wait(&pn->state, vcpu_halted);
+		}
 
 		pn->mayhalt = false;
 		/*
@@ -250,6 +339,8 @@ static void pv_wait_node(struct mcs_spinlock *node)
 		 */
 		(void)cmpxchg(&pn->state, vcpu_halted, vcpu_running);
 
+		if (READ_ONCE(node->locked))
+			break;
 		/*
 		 * If the locked flag is still not set after wakeup, it is a
 		 * spurious wakeup and the vCPU should wait again. However,
@@ -257,6 +348,7 @@ static void pv_wait_node(struct mcs_spinlock *node)
 		 * So it is better to spin for a while in the hope that the
 		 * MCS lock will be released soon.
 		 */
+		pvstat_inc(pv_stat_spurious);
 	}
 
 	/*
@@ -352,9 +444,13 @@ static void pv_wait_head(struct qspinlock *lock, struct mcs_spinlock *node)
 	 * so the vCPU should wait again after spinning for a while.
 	 */
 wait_now:
+	pvstat_inc((pn->state == vcpu_hashed) ? pv_stat_wait_hash
+					      : pv_stat_wait_head);
 	for (;;) {
 		pv_wait(&l->locked, _Q_SLOW_VAL);
 		WRITE_ONCE(pn->state, vcpu_running);
+		if (READ_ONCE(l->locked))
+			pvstat_inc(pv_stat_spurious);
 		for (loop = SPIN_THRESHOLD; loop; loop--) {
 			if (!READ_ONCE(l->locked))
 				return;
-- 
1.7.1
