From: Alex Kogan <alex.kogan@oracle.com>
Subject: [PATCH v10 4/5] locking/qspinlock: Introduce starvation avoidance into CNA
Date: Fri,  3 Apr 2020 16:59:29 -0400
Message-ID: <20200403205930.1707-5-alex.kogan@oracle.com>
References: <20200403205930.1707-1-alex.kogan@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200403205930.1707-1-alex.kogan@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com
List-Id: linux-arch.vger.kernel.org

Keep track of the number of intra-node lock handoffs, and force
inter-node handoff once this number reaches a preset threshold.
The default value for the threshold can be overridden with
the new kernel boot command-line option "numa_spinlock_threshold".

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 .../admin-guide/kernel-parameters.txt         |  8 +++
 kernel/locking/qspinlock.c                    |  3 +
 kernel/locking/qspinlock_cna.h                | 55 ++++++++++++++++---
 3 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cf3ede858e01..c23bbf49024b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3249,6 +3249,14 @@
 			Not specifying this option is equivalent to
 			numa_spinlock=auto.
 
+	numa_spinlock_threshold=	[NUMA, PV_OPS]
+			Set the threshold for the number of intra-node
+			lock hand-offs before the NUMA-aware spinlock
+			is forced to be passed to a thread on another NUMA node.
+			Valid values are in the [0..31] range. Smaller values
+			result in a more fair, but less performant spinlock, and
+			vice versa. The default value is 16.
+
 	cpu0_hotplug	[X86] Turn on CPU0 hotplug feature when
 			CONFIG_BOOTPARAM_HOTPLUG_CPU0 is off.
 			Some features depend on CPU0. Known dependencies are:
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 5b01ab0cc944..29e480235cce 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -598,6 +598,9 @@ EXPORT_SYMBOL(queued_spin_lock_slowpath);
 #if !defined(_GEN_CNA_LOCK_SLOWPATH) && defined(CONFIG_NUMA_AWARE_SPINLOCKS)
 #define _GEN_CNA_LOCK_SLOWPATH
 
+#undef pv_init_node
+#define pv_init_node			cna_init_node
+
 #undef pv_wait_head_or_lock
 #define pv_wait_head_or_lock		cna_wait_head_or_lock
 
diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index 619883f3dfd3..e3180f6f5cdc 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -38,7 +38,9 @@
  * when unlocking the MCS lock (post-scan), starting at the node where pre-scan
  * stopped. If both scans fail to find such T, the MCS lock is passed to the
  * first thread in the secondary queue. If the secondary queue is empty, the
- * lock is passed to the next thread in the primary queue.
+ * lock is passed to the next thread in the primary queue. To avoid starvation
+ * of threads in the secondary queue, those threads are moved back to the head
+ * of the primary queue after a certain number of intra-node lock hand-offs.
  *
  * For more details, see https://arxiv.org/abs/1810.05600.
  *
@@ -51,13 +53,23 @@ struct cna_node {
 	int			numa_node;
 	u32			encoded_tail;	/* self */
 	u32			partial_order;	/* encoded tail or enum val */
+	u32			intra_count;
 };
 
 enum {
 	LOCAL_WAITER_FOUND = 2,	/* 0 and 1 are reserved for @locked */
+	FLUSH_SECONDARY_QUEUE = 3,
 	MIN_ENCODED_TAIL
 };
 
+/*
+ * Controls the threshold for the number of intra-node lock hand-offs before
+ * the NUMA-aware variant of spinlock is forced to be passed to a thread on
+ * another NUMA node. The default setting can be changed with the
+ * "numa_spinlock_threshold" boot option.
+ */
+unsigned int intra_node_handoff_threshold __ro_after_init = 1 << 16;
+
 static void __init cna_init_nodes_per_cpu(unsigned int cpu)
 {
 	struct mcs_spinlock *base = per_cpu_ptr(&qnodes[0].mcs, cpu);
@@ -96,6 +108,11 @@ static int __init cna_init_nodes(void)
 	return 0;
 }
 
+static __always_inline void cna_init_node(struct mcs_spinlock *node)
+{
+	((struct cna_node *)node)->intra_count = 0;
+}
+
 /*
  * cna_splice_head -- splice the entire secondary queue onto the head of the
  * primary queue.
@@ -250,11 +267,15 @@ static __always_inline u32 cna_wait_head_or_lock(struct qspinlock *lock,
 {
 	struct cna_node *cn = (struct cna_node *)node;
 
-	/*
-	 * Try and put the time otherwise spent spin waiting on
-	 * _Q_LOCKED_PENDING_MASK to use by sorting our lists.
-	 */
-	cn->partial_order = cna_order_queue(node, node);
+	if (cn->intra_count < intra_node_handoff_threshold) {
+		/*
+		 * Try and put the time otherwise spent spin waiting on
+		 * _Q_LOCKED_PENDING_MASK to use by sorting our lists.
+		 */
+		cn->partial_order = cna_order_queue(node, node);
+	} else {
+		cn->partial_order = FLUSH_SECONDARY_QUEUE;
+	}
 
 	return 0; /* we lied; we didn't wait, go do so now */
 }
@@ -281,8 +302,11 @@ static inline void cna_lock_handoff(struct mcs_spinlock *node,
 		 * cna_order_queue() above.
 		 */
 		next = node->next;
-		if (node->locked > 1)
+		if (node->locked > 1) {
 			val = node->locked;	/* preseve secondary queue */
+			((struct cna_node *)next)->intra_count =
+				cn->intra_count + 1;
+		}
 	} else if (node->locked > 1) {
 		/*
 		 * When there are no local waiters on the primary queue, splice
@@ -342,3 +366,20 @@ void __init cna_configure_spin_lock_slowpath(void)
 
 	pr_info("Enabling CNA spinlock\n");
 }
+
+static int __init numa_spinlock_threshold_setup(char *str)
+{
+	int new_threshold_param;
+
+	if (get_option(&str, &new_threshold_param)) {
+		/* valid value is between 0 and 31 */
+		if (new_threshold_param < 0 || new_threshold_param > 31)
+			return 0;
+
+		intra_node_handoff_threshold = 1 << new_threshold_param;
+		return 1;
+	}
+
+	return 0;
+}
+__setup("numa_spinlock_threshold=", numa_spinlock_threshold_setup);
-- 
2.21.1 (Apple Git-122.3)
