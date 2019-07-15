Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:38650 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730584AbfGOT1Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jul 2019 15:27:16 -0400
From: Alex Kogan <alex.kogan@oracle.com>
Subject: [PATCH v3 4/5] locking/qspinlock: Introduce starvation avoidance into CNA
Date: Mon, 15 Jul 2019 15:25:35 -0400
Message-ID: <20190715192536.104548-5-alex.kogan@oracle.com>
In-Reply-To: <20190715192536.104548-1-alex.kogan@oracle.com>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190715192535.fGnv8y-cYwxrYlftDLzgRHUykPFQpIBq-z0GNU-ttTk@z>

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
 kernel/locking/qspinlock_cna.h | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index efb9b12b2f9b..3de5be813a46 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -4,6 +4,7 @@
 #endif
 
 #include <linux/topology.h>
+#include <linux/random.h>
 
 /*
  * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
@@ -36,6 +37,33 @@ struct cna_node {
 
 #define CNA_NODE(ptr) ((struct cna_node *)(ptr))
 
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
+/*
+ * Return false with probability 1 / @range.
+ * @range must be a power of 2.
+ */
+static bool probably(unsigned int range)
+{
+	u32 s;
+
+	s = this_cpu_read(seed);
+	s = next_pseudo_random32(s);
+	this_cpu_write(seed, s);
+
+	return s & (range - 1);
+}
+
 static void cna_init_node(struct mcs_spinlock *node)
 {
 	struct cna_node *cn = CNA_NODE(node);
@@ -140,7 +168,13 @@ static inline void cna_pass_mcs_lock(struct mcs_spinlock *node,
 	u64 *var = &next->locked;
 	u64 val = 1;
 
-	succ = find_successor(node);
+	/*
+	 * Try to pass the lock to a thread running on the same node.
+	 * For long-term fairness, search for such a thread with high
+	 * probability rather than always.
+	 */
+	if (probably(INTRA_NODE_HANDOFF_PROB_ARG))
+		succ = find_successor(node);
 
 	if (succ) {
 		var = &succ->mcs.locked;
-- 
2.11.0 (Apple Git-81)
