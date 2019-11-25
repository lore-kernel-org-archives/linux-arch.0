From: Alex Kogan <alex.kogan@oracle.com>
Subject: [PATCH v7 4/5] locking/qspinlock: Introduce starvation avoidance into CNA
Date: Mon, 25 Nov 2019 16:07:08 -0500
Message-ID: <20191125210709.10293-5-alex.kogan@oracle.com>
References: <20191125210709.10293-1-alex.kogan@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191125210709.10293-1-alex.kogan@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
List-Id: linux-arch.vger.kernel.org

Keep track of the number of intra-node lock handoffs, and force
inter-node handoff once this number reaches a preset threshold.
The default value for the threshold can be overridden with
the new kernel boot command-line option "numa_spinlock_threshold".

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 .../admin-guide/kernel-parameters.txt         |  8 ++++++
 arch/x86/kernel/alternative.c                 | 27 +++++++++++++++++++
 kernel/locking/qspinlock.c                    |  3 +++
 kernel/locking/qspinlock_cna.h                | 27 ++++++++++++++++---
 4 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 904cb32f592d..887fbfce701d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3185,6 +3185,14 @@
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
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 6a4ccbf4e09c..28552e0491b5 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -723,6 +723,33 @@ static int __init numa_spinlock_setup(char *str)
 
 __setup("numa_spinlock=", numa_spinlock_setup);
 
+/*
+ * Controls the threshold for the number of intra-node lock hand-offs before
+ * the NUMA-aware variant of spinlock is forced to be passed to a thread on
+ * another NUMA node. By default, the chosen value provides reasonable
+ * long-term fairness without sacrificing performance compared to a lock
+ * that does not have any fairness guarantees.
+ */
+int intra_node_handoff_threshold = 1 << 16;
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
+
+__setup("numa_spinlock_threshold=", numa_spinlock_threshold_setup);
+
 #endif
 
 void __init alternative_instructions(void)
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 6d8c4a52e44e..1d0d884308ef 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -597,6 +597,9 @@ EXPORT_SYMBOL(queued_spin_lock_slowpath);
 #if !defined(_GEN_CNA_LOCK_SLOWPATH) && defined(CONFIG_NUMA_AWARE_SPINLOCKS)
 #define _GEN_CNA_LOCK_SLOWPATH
 
+#undef pv_init_node
+#define pv_init_node			cna_init_node
+
 #undef pv_wait_head_or_lock
 #define pv_wait_head_or_lock		cna_pre_scan
 
diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index a638336f9560..dcb2bcfd2d94 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -50,9 +50,16 @@ struct cna_node {
 	struct mcs_spinlock	mcs;
 	int			numa_node;
 	u32			encoded_tail;
-	u32			pre_scan_result; /* 0 or encoded tail */
+	u32			pre_scan_result; /* 0, 1 or encoded tail */
+	u32			intra_count;
 };
 
+/*
+ * Controls the threshold for the number of intra-node lock hand-offs.
+ * See arch/x86/kernel/alternative.c for details.
+ */
+extern int intra_node_handoff_threshold;
+
 static void __init cna_init_nodes_per_cpu(unsigned int cpu)
 {
 	struct mcs_spinlock *base = per_cpu_ptr(&qnodes[0].mcs, cpu);
@@ -92,6 +99,11 @@ static int __init cna_init_nodes(void)
 }
 early_initcall(cna_init_nodes);
 
+static __always_inline void cna_init_node(struct mcs_spinlock *node)
+{
+	((struct cna_node *)node)->intra_count = 0;
+}
+
 static inline bool cna_try_change_tail(struct qspinlock *lock, u32 val,
 				       struct mcs_spinlock *node)
 {
@@ -221,7 +233,13 @@ __always_inline u32 cna_pre_scan(struct qspinlock *lock,
 {
 	struct cna_node *cn = (struct cna_node *)node;
 
-	cn->pre_scan_result = cna_scan_main_queue(node, node);
+	/*
+	 * setting @pre_scan_result to 1 indicates that no post-scan
+	 * should be made in cna_pass_lock()
+	 */
+	cn->pre_scan_result =
+		cn->intra_count == intra_node_handoff_threshold ?
+			1 : cna_scan_main_queue(node, node);
 
 	return 0;
 }
@@ -240,7 +258,7 @@ static inline void cna_pass_lock(struct mcs_spinlock *node,
 	 * pre-scan, and if so, try to find it in post-scan starting from the
 	 * node where pre-scan stopped (stored in @pre_scan_result)
 	 */
-	if (scan > 0)
+	if (scan > 1)
 		scan = cna_scan_main_queue(node, decode_tail(scan));
 
 	if (!scan) { /* if found a successor from the same numa node */
@@ -251,6 +269,9 @@ static inline void cna_pass_lock(struct mcs_spinlock *node,
 		 * if we acquired the MCS lock when its queue was empty
 		 */
 		val = node->locked ? node->locked : 1;
+		/* inc @intra_count if the secondary queue is not empty */
+		((struct cna_node *)next_holder)->intra_count =
+			cn->intra_count + (node->locked > 1);
 	} else if (node->locked > 1) {	  /* if secondary queue is not empty */
 		/* next holder will be the first node in the secondary queue */
 		tail_2nd = decode_tail(node->locked);
-- 
2.21.0 (Apple Git-122.2)
