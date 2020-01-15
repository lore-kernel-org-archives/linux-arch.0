From: Alex Kogan <alex.kogan@oracle.com>
Subject: [PATCH v9 5/5] locking/qspinlock: Introduce the shuffle reduction optimization into CNA
Date: Tue, 14 Jan 2020 22:59:20 -0500
Message-ID: <20200115035920.54451-6-alex.kogan@oracle.com>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:48088 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbgAOEPS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jan 2020 23:15:18 -0500
In-Reply-To: <20200115035920.54451-1-alex.kogan@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com

This performance optimization reduces the probability threads will be
shuffled between the main and secondary queues when the secondary queue
is empty. It is helpful when the lock is only lightly contended.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock_cna.h | 46 ++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index a2b65f87e6f8..f0b0c15dcf9d 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -4,6 +4,7 @@
 #endif
 
 #include <linux/topology.h>
+#include <linux/random.h>
 
 /*
  * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
@@ -57,6 +58,7 @@ struct cna_node {
 enum {
 	LOCAL_WAITER_FOUND = 2,	/* 0 and 1 are reserved for @locked */
 	FLUSH_SECONDARY_QUEUE = 3,
+	PASS_LOCK_IMMEDIATELY = 4,
 	MIN_ENCODED_TAIL
 };
 
@@ -70,6 +72,34 @@ enum {
  */
 unsigned int intra_node_handoff_threshold __ro_after_init = 1 << 16;
 
+/*
+ * Controls the probability for enabling the scan of the main queue when
+ * the secondary queue is empty. The chosen value reduces the amount of
+ * unnecessary shuffling of threads between the two waiting queues when
+ * the contention is low, while responding fast enough and enabling
+ * the shuffling when the contention is high.
+ */
+#define SHUFFLE_REDUCTION_PROB_ARG  (7)
+
+/* Per-CPU pseudo-random number seed */
+static DEFINE_PER_CPU(u32, seed);
+
+/*
+ * Return false with probability 1 / 2^@num_bits.
+ * Intuitively, the larger @num_bits the less likely false is to be returned.
+ * @num_bits must be a number between 0 and 31.
+ */
+static bool probably(unsigned int num_bits)
+{
+	u32 s;
+
+	s = this_cpu_read(seed);
+	s = next_pseudo_random32(s);
+	this_cpu_write(seed, s);
+
+	return s & ((1 << num_bits) - 1);
+}
+
 static void __init cna_init_nodes_per_cpu(unsigned int cpu)
 {
 	struct mcs_spinlock *base = per_cpu_ptr(&qnodes[0].mcs, cpu);
@@ -250,8 +280,11 @@ __always_inline u32 cna_pre_scan(struct qspinlock *lock,
 	struct cna_node *cn = (struct cna_node *)node;
 
 	cn->pre_scan_result =
-		cn->intra_count == intra_node_handoff_threshold ?
-			FLUSH_SECONDARY_QUEUE : cna_scan_main_queue(node, node);
+		(node->locked <= 1 && probably(SHUFFLE_REDUCTION_PROB_ARG)) ?
+			PASS_LOCK_IMMEDIATELY :
+			cn->intra_count == intra_node_handoff_threshold ?
+				FLUSH_SECONDARY_QUEUE :
+				cna_scan_main_queue(node, node);
 
 	return 0;
 }
@@ -265,6 +298,14 @@ static inline void cna_pass_lock(struct mcs_spinlock *node,
 
 	u32 scan = cn->pre_scan_result;
 
+	/*
+	 * perf. optimization - check if we can skip the logic of triaging
+	 * through other possible values in @scan (helps under light lock
+	 * contention)
+	 */
+	if (scan == PASS_LOCK_IMMEDIATELY)
+		goto pass_lock;
+
 	/*
 	 * check if a successor from the same numa node has not been found in
 	 * pre-scan, and if so, try to find it in post-scan starting from the
@@ -293,6 +334,7 @@ static inline void cna_pass_lock(struct mcs_spinlock *node,
 		tail_2nd->next = next;
 	}
 
+pass_lock:
 	arch_mcs_pass_lock(&next_holder->locked, val);
 }
 
-- 
2.21.0 (Apple Git-122.2)
