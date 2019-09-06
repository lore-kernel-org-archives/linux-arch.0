Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:39686 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404187AbfIFOeY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Sep 2019 10:34:24 -0400
From: Alex Kogan <alex.kogan@oracle.com>
Subject: [PATCH v4 4/5] locking/qspinlock: Introduce starvation avoidance into CNA
Date: Fri,  6 Sep 2019 10:25:40 -0400
Message-ID: <20190906142541.34061-5-alex.kogan@oracle.com>
In-Reply-To: <20190906142541.34061-1-alex.kogan@oracle.com>
References: <20190906142541.34061-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190906142540.BL0Z1kxC3C3m7QSSe-MytLLIUtdKEovIfLMIspavJvY@z>

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
 kernel/locking/qspinlock_cna.h | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index f983debf20bb..e86182e6163b 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -4,6 +4,7 @@
 #endif
 
 #include <linux/topology.h>
+#include <linux/random.h>
 
 /*
  * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
@@ -50,6 +51,34 @@ struct cna_node {
 	struct	cna_node *tail;    /* points to the secondary queue tail */
 };
 
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
+#define INTRA_NODE_HANDOFF_PROB_ARG (16)
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
@@ -202,9 +231,11 @@ static inline void cna_pass_lock(struct mcs_spinlock *node,
 
 	/*
 	 * Try to find a successor running on the same NUMA node
-	 * as the current lock holder.
+	 * as the current lock holder. For long-term fairness,
+	 * search for such a thread with high probability rather than always.
 	 */
-	new_next = cna_try_find_next(node, next);
+	if (probably(INTRA_NODE_HANDOFF_PROB_ARG))
+		new_next = cna_try_find_next(node, next);
 
 	if (new_next) {		          /* if such successor is found */
 		next_holder = new_next;
-- 
2.11.0 (Apple Git-81)
