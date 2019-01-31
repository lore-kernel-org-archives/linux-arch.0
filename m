From: Alex Kogan <alex.kogan@oracle.com>
Subject: [PATCH 3/3] locking/qspinlock: Introduce starvation avoidance into CNA
Date: Wed, 30 Jan 2019 22:01:35 -0500
Message-ID: <20190131030136.56999-4-alex.kogan@oracle.com>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131030136.56999-1-alex.kogan@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
List-Id: linux-arch.vger.kernel.org

Choose the next lock holder among spinning threads running on the same
socket with high probability rather than always. With small probability,
hand the lock to the first thread in the secondary queue or, if that
queue is empty, to the immediate successor of the current lock holder
in the main queue.  Thus, assuming no failures while threads hold the
lock, every thread would be able to acquire the lock after a bounded
number of lock transitions, with high probability.

Note that we could make the inter-socket transition deterministic,
by sticking a counter of intra-socket transitions in the head node
of the secondary queue. At the handoff time, we could increment
the counter and check if it is below a threshold. This adds another
field to queue nodes and nearly-certain local cache miss to read and
update this counter during the handoff. While still beating stock,
this variant adds certain overhead over the probabilistic variant.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/locking/qspinlock.c | 53 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 6addc24f219d..d3caef4f84e2 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -31,6 +31,7 @@
 #include <linux/prefetch.h>
 #include <asm/byteorder.h>
 #include <asm/qspinlock.h>
+#include <linux/random.h>
 
 /*
  * Include queued spinlock statistics code
@@ -112,6 +113,18 @@ struct qnode {
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[MAX_NODES]);
 
+/* Per-CPU pseudo-random number seed */
+static DEFINE_PER_CPU(u32, seed);
+
+/*
+ * Controls the probability for intra-socket lock hand-off. It can be
+ * tuned and depend, e.g., on the number of CPUs per socket. For now,
+ * choose a value that provides reasonable long-term fairness without
+ * sacrificing performance compared to a version that does not have any
+ * fairness guarantees.
+ */
+#define INTRA_SOCKET_HANDOFF_PROB_ARG	0x10000
+
 /*
  * We must be able to distinguish between no-tail and the tail at 0:0,
  * therefore increment the cpu number by one.
@@ -369,6 +382,35 @@ static struct mcs_spinlock *find_successor(struct mcs_spinlock *me,
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
 #endif /* _GEN_PV_LOCK_SLOWPATH */
 
 /**
@@ -647,8 +689,15 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if (!next)
 		next = smp_cond_load_relaxed(&node->next, (VAL));
 
-	/* Try to pass the lock to a thread running on the same socket. */
-	succ = find_successor(node, cpuid);
+	/*
+	 * Try to pass the lock to a thread running on the same socket.
+	 * For long-term fairness, search for such a thread with high
+	 * probability rather than always.
+	 */
+	succ = NULL;
+	if (probably(INTRA_SOCKET_HANDOFF_PROB_ARG))
+		succ = find_successor(node, cpuid);
+
 	if (succ) {
 		arch_mcs_spin_unlock_contended(&succ->locked, node->locked);
 	} else if (node->locked > 1) {
-- 
2.11.0 (Apple Git-81)
