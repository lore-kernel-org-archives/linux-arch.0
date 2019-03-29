Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:41594 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729509AbfC2PVY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Mar 2019 11:21:24 -0400
From: Alex Kogan <alex.kogan@oracle.com>
Subject: [PATCH v2 4/5] locking/qspinlock: Introduce starvation avoidance into CNA
Date: Fri, 29 Mar 2019 11:20:05 -0400
Message-ID: <20190329152006.110370-5-alex.kogan@oracle.com>
In-Reply-To: <20190329152006.110370-1-alex.kogan@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190329152005.tmzDLFBn_I9pjYAYXN8uBZzPweMcVtyBmhPycxKazts@z>

Choose the next lock holder among spinning threads running on the same
node with high probability rather than always. With small probability,
hand the lock to the first thread in the secondary queue or, if that
queue is empty, to the immediate successor of the current lock holder
in the main queue.  Thus, assuming no failures while threads hold the
lock, every thread would be able to acquire the lock after a bounded
number of lock transitions, with high probability.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/locking/qspinlock_cna.h | 55 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index 5bc5fd9586ea..5addf6439326 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -3,6 +3,8 @@
 #error "do not include this file"
 #endif
 
+#include <linux/random.h>
+
 /*
  * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
  *
@@ -15,7 +17,9 @@
  * secondary queue, and the lock is passed to T. If such T is not found, the
  * lock is passed to the first node in the secondary queue. Finally, if the
  * secondary queue is empty, the lock is passed to the next thread in the
- * main queue.
+ * main queue. To avoid starvation of threads in the secondary queue,
+ * those threads are moved back to the head of the main queue
+ * after a certain expected number of intra-node lock hand-offs.
  *
  * For details, see https://arxiv.org/abs/1810.05600.
  *
@@ -25,6 +29,18 @@
 
 #define MCS_NODE(ptr) ((struct mcs_spinlock *)(ptr))
 
+/* Per-CPU pseudo-random number seed */
+static DEFINE_PER_CPU(u32, seed);
+
+/*
+ * Controls the probability for intra-node lock hand-off. It can be
+ * tuned and depend, e.g., on the number of CPUs per node. For now,
+ * choose a value that provides reasonable long-term fairness without
+ * sacrificing performance compared to a version that does not have any
+ * fairness guarantees.
+ */
+#define INTRA_NODE_HANDOFF_PROB_ARG 0x10000
+
 static inline __pure int decode_numa_node(u32 node_and_count)
 {
 	int node = (node_and_count >> _Q_NODE_OFFSET) - 1;
@@ -102,6 +118,35 @@ static struct mcs_spinlock *find_successor(struct mcs_spinlock *me)
 	return NULL;
 }
 
+/*
+ * xorshift function for generating pseudo-random numbers:
+ * https://en.wikipedia.org/wiki/Xorshift
+ */
+static inline u32 xor_random(void)
+{
+	u32 v;
+
+	v = this_cpu_read(seed);
+	if (v == 0)
+		get_random_bytes(&v, sizeof(u32));
+
+	v ^= v << 6;
+	v ^= v >> 21;
+	v ^= v << 7;
+	this_cpu_write(seed, v);
+
+	return v;
+}
+
+/*
+ * Return false with probability 1 / @range.
+ * @range must be a power of 2.
+ */
+static bool probably(unsigned int range)
+{
+	return xor_random() & (range - 1);
+}
+
 static __always_inline int get_node_index(struct mcs_spinlock *node)
 {
 	return decode_count(node->node_and_count++);
@@ -151,7 +196,13 @@ static inline void pass_mcs_lock(struct mcs_spinlock *node,
 {
 	struct mcs_spinlock *succ = NULL;
 
-	succ = find_successor(node);
+	/*
+	 * Try to pass the lock to a thread running on the same node.
+	 * For long-term fairness, search for such a thread with high
+	 * probability rather than always.
+	 */
+	if (probably(INTRA_NODE_HANDOFF_PROB_ARG))
+		succ = find_successor(node);
 
 	if (succ) {
 		arch_mcs_spin_unlock_contended(&succ->locked, node->locked);
-- 
2.11.0 (Apple Git-81)
