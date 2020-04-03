From: Alex Kogan <alex.kogan@oracle.com>
Subject: [PATCH v10 5/5] locking/qspinlock: Avoid moving certain threads between waiting queues in CNA
Date: Fri,  3 Apr 2020 16:59:30 -0400
Message-ID: <20200403205930.1707-6-alex.kogan@oracle.com>
References: <20200403205930.1707-1-alex.kogan@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200403205930.1707-1-alex.kogan@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com
List-Id: linux-arch.vger.kernel.org

Prohibit moving certain threads (e.g., in irq and nmi contexts)
to the secondary queue. Those prioritized threads will always stay
in the primary queue, and so will have a shorter wait time for the lock.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock_cna.h | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index e3180f6f5cdc..b004ce6882b6 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -4,6 +4,7 @@
 #endif
 
 #include <linux/topology.h>
+#include <linux/sched/rt.h>
 
 /*
  * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
@@ -41,6 +42,9 @@
  * lock is passed to the next thread in the primary queue. To avoid starvation
  * of threads in the secondary queue, those threads are moved back to the head
  * of the primary queue after a certain number of intra-node lock hand-offs.
+ * Lastly, certain threads (e.g., in irq and nmi contexts) are given
+ * preferential treatment -- the scan stops when such a thread is found,
+ * effectively never moving those threads into the secondary queue.
  *
  * For more details, see https://arxiv.org/abs/1810.05600.
  *
@@ -50,7 +54,7 @@
 
 struct cna_node {
 	struct mcs_spinlock	mcs;
-	int			numa_node;
+	int			numa_node;	/* use LSB for priority */
 	u32			encoded_tail;	/* self */
 	u32			partial_order;	/* encoded tail or enum val */
 	u32			intra_count;
@@ -79,7 +83,7 @@ static void __init cna_init_nodes_per_cpu(unsigned int cpu)
 	for (i = 0; i < MAX_NODES; i++) {
 		struct cna_node *cn = (struct cna_node *)grab_mcs_node(base, i);
 
-		cn->numa_node = numa_node;
+		cn->numa_node = numa_node << 1;
 		cn->encoded_tail = encode_tail(cpu, i);
 		/*
 		 * make sure @encoded_tail is not confused with other valid
@@ -110,6 +114,14 @@ static int __init cna_init_nodes(void)
 
 static __always_inline void cna_init_node(struct mcs_spinlock *node)
 {
+	/*
+	 * Set the priority bit in @numa_node for threads that should not
+	 * be moved to the secondary queue.
+	 */
+	bool priority = !in_task() || irqs_disabled() || rt_task(current);
+	((struct cna_node *)node)->numa_node =
+		(((struct cna_node *)node)->numa_node & ~1) | priority;
+
 	((struct cna_node *)node)->intra_count = 0;
 }
 
@@ -243,12 +255,16 @@ static u32 cna_order_queue(struct mcs_spinlock *node,
 {
 	struct cna_node *cni = (struct cna_node *)READ_ONCE(iter->next);
 	struct cna_node *cn = (struct cna_node *)node;
-	int nid = cn->numa_node;
+	int nid = cn->numa_node >> 1;
 	struct cna_node *last;
 
 	/* find any next waiter on 'our' NUMA node */
 	for (last = cn;
-	     cni && cni->numa_node != nid;
+		 /*
+		  * iterate as long as the current node is not priorizied and
+		  * does not run on 'our' NUMA node
+		  */
+	     cni && !(cni->numa_node & 0x1) && (cni->numa_node >> 1) != nid;
 	     last = cni, cni = (struct cna_node *)READ_ONCE(cni->mcs.next))
 		;
 
@@ -258,6 +274,12 @@ static u32 cna_order_queue(struct mcs_spinlock *node,
 	if (last != cn)	/* did we skip any waiters? */
 		cna_splice_tail(node, node->next, (struct mcs_spinlock *)last);
 
+	/*
+	 * We return LOCAL_WAITER_FOUND here even if we stopped the scan because
+	 * of a prioritized waiter. That waiter will get the lock next even if
+	 * it runs on a different NUMA node, but this is what we wanted when we
+	 * prioritized it.
+	 */
 	return LOCAL_WAITER_FOUND;
 }
 
-- 
2.21.1 (Apple Git-122.3)
