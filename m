Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:58318 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389492AbfKGRwi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Nov 2019 12:52:38 -0500
From: Alex Kogan <alex.kogan@oracle.com>
Subject: [PATCH v6 5/5] locking/qspinlock: Introduce the shuffle reduction optimization into CNA
Date: Thu,  7 Nov 2019 12:46:22 -0500
Message-ID: <20191107174622.61718-6-alex.kogan@oracle.com>
In-Reply-To: <20191107174622.61718-1-alex.kogan@oracle.com>
References: <20191107174622.61718-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20191107174622.4EpM_vqzz7_gd5QpJl0_hEkPCkv7P1f3sKJ1bwLJ6UE@z>

This optimization reduces the probability threads will be shuffled between
the main and secondary queues when the secondary queue is empty.
It is helpful when the lock is only lightly contended.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/locking/qspinlock_cna.h | 50 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index 916c9083e8ec..0549ce40dc75 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -4,6 +4,7 @@
 #endif
 
 #include <linux/topology.h>
+#include <linux/random.h>
 
 /*
  * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
@@ -50,7 +51,7 @@ struct cna_node {
 	struct mcs_spinlock	mcs;
 	int			numa_node;
 	u32			encoded_tail;
-	u32			pre_scan_result; /* 0, 1 or encoded tail */
+	u32			pre_scan_result; /* 0, 1, 2 or encoded tail */
 	u32			intra_count;
 };
 
@@ -60,6 +61,34 @@ struct cna_node {
  */
 extern int intra_node_handoff_threshold;
 
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
@@ -72,11 +101,11 @@ static void __init cna_init_nodes_per_cpu(unsigned int cpu)
 		cn->numa_node = numa_node;
 		cn->encoded_tail = encode_tail(cpu, i);
 		/*
-		 * @encoded_tail has to be larger than 1, so we do not confuse
+		 * @encoded_tail has to be larger than 2, so we do not confuse
 		 * it with other valid values for @locked or @pre_scan_result
-		 * (0 or 1)
+		 * (0, 1 or 2)
 		 */
-		WARN_ON(cn->encoded_tail <= 1);
+		WARN_ON(cn->encoded_tail <= 2);
 	}
 }
 
@@ -230,12 +259,13 @@ __always_inline u32 cna_pre_scan(struct qspinlock *lock,
 	struct cna_node *cn = (struct cna_node *)node;
 
 	/*
-	 * setting @pre_scan_result to 1 indicates that no post-scan
+	 * setting @pre_scan_result to 1 or 2 indicates that no post-scan
 	 * should be made in cna_pass_lock()
 	 */
 	cn->pre_scan_result =
-		cn->intra_count == intra_node_handoff_threshold ?
-			1 : cna_scan_main_queue(node, node);
+		(node->locked <= 1 && probably(SHUFFLE_REDUCTION_PROB_ARG)) ?
+			1 : cn->intra_count == intra_node_handoff_threshold ?
+			2 : cna_scan_main_queue(node, node);
 
 	return 0;
 }
@@ -249,12 +279,15 @@ static inline void cna_pass_lock(struct mcs_spinlock *node,
 
 	u32 scan = cn->pre_scan_result;
 
+	if (scan == 1)
+		goto pass_lock;
+
 	/*
 	 * check if a successor from the same numa node has not been found in
 	 * pre-scan, and if so, try to find it in post-scan starting from the
 	 * node where pre-scan stopped (stored in @pre_scan_result)
 	 */
-	if (scan > 1)
+	if (scan > 2)
 		scan = cna_scan_main_queue(node, decode_tail(scan));
 
 	if (!scan) { /* if found a successor from the same numa node */
@@ -277,5 +310,6 @@ static inline void cna_pass_lock(struct mcs_spinlock *node,
 		tail_2nd->next = next;
 	}
 
+pass_lock:
 	arch_mcs_pass_lock(&next_holder->locked, val);
 }
-- 
2.11.0 (Apple Git-81)
