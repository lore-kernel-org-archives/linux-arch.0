Return-Path: <SRS0=vo9y=3E=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:34196 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbgAOEPQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jan 2020 23:15:16 -0500
From: Alex Kogan <alex.kogan@oracle.com>
Subject: [PATCH v9 4/5] locking/qspinlock: Introduce starvation avoidance into CNA
Date: Tue, 14 Jan 2020 22:59:19 -0500
Message-ID: <20200115035920.54451-5-alex.kogan@oracle.com>
In-Reply-To: <20200115035920.54451-1-alex.kogan@oracle.com>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com
Message-ID: <20200115035919.ai_gHU_THRlFcdkBEbPu2qpzFAUeeOKexom8gx5bAQo@z>

Keep track of the number of intra-node lock handoffs, and force
inter-node handoff once this number reaches a preset threshold.
The default value for the threshold can be overridden with
the new kernel boot command-line option "numa_spinlock_threshold".

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 .../admin-guide/kernel-parameters.txt         |  8 ++++
 kernel/locking/qspinlock.c                    |  3 ++
 kernel/locking/qspinlock_cna.h                | 41 ++++++++++++++++++-
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b68cb80e477f..30d79819a3b0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3200,6 +3200,14 @@
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
index 609980a53841..e382d8946ccc 100644
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
index 8000231f3d51..a2b65f87e6f8 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -51,13 +51,25 @@ struct cna_node {
 	int			numa_node;
 	u32			encoded_tail;
 	u32			pre_scan_result; /* encoded tail or enum val */
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
+ * another NUMA node. By default, the chosen value provides reasonable
+ * long-term fairness without sacrificing performance compared to a lock
+ * that does not have any fairness guarantees. The default setting can
+ * be changed with the "numa_spinlock_threshold" boot option.
+ */
+unsigned int intra_node_handoff_threshold __ro_after_init = 1 << 16;
+
 static void __init cna_init_nodes_per_cpu(unsigned int cpu)
 {
 	struct mcs_spinlock *base = per_cpu_ptr(&qnodes[0].mcs, cpu);
@@ -97,6 +109,11 @@ static int __init cna_init_nodes(void)
 }
 early_initcall(cna_init_nodes);
 
+static __always_inline void cna_init_node(struct mcs_spinlock *node)
+{
+	((struct cna_node *)node)->intra_count = 0;
+}
+
 /* this function is called only when the primary queue is empty */
 static inline bool cna_try_change_tail(struct qspinlock *lock, u32 val,
 				       struct mcs_spinlock *node)
@@ -232,7 +249,9 @@ __always_inline u32 cna_pre_scan(struct qspinlock *lock,
 {
 	struct cna_node *cn = (struct cna_node *)node;
 
-	cn->pre_scan_result = cna_scan_main_queue(node, node);
+	cn->pre_scan_result =
+		cn->intra_count == intra_node_handoff_threshold ?
+			FLUSH_SECONDARY_QUEUE : cna_scan_main_queue(node, node);
 
 	return 0;
 }
@@ -262,6 +281,9 @@ static inline void cna_pass_lock(struct mcs_spinlock *node,
 		 * if we acquired the MCS lock when its queue was empty
 		 */
 		val = node->locked ? node->locked : 1;
+		/* inc @intra_count if the secondary queue is not empty */
+		((struct cna_node *)next_holder)->intra_count =
+			cn->intra_count + (node->locked > 1);
 	} else if (node->locked > 1) {	  /* if secondary queue is not empty */
 		/* next holder will be the first node in the secondary queue */
 		tail_2nd = decode_tail(node->locked);
@@ -316,3 +338,20 @@ void __init cna_configure_spin_lock_slowpath(void)
 		pr_info("Enabling CNA spinlock\n");
 	}
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
2.21.0 (Apple Git-122.2)
