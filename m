Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:41586 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729492AbfC2PVY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Mar 2019 11:21:24 -0400
From: Alex Kogan <alex.kogan@oracle.com>
Subject: [PATCH v2 5/5] locking/qspinlock: Introduce the shuffle reduction optimization into CNA
Date: Fri, 29 Mar 2019 11:20:06 -0400
Message-ID: <20190329152006.110370-6-alex.kogan@oracle.com>
In-Reply-To: <20190329152006.110370-1-alex.kogan@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190329152006.U9vlNfWf8h4WQRRtJ-as7feRKVJe1VqUp-DBtojW0cc@z>

This optimization reduces the probability threads will be shuffled between
the main and secondary queues when the secondary queue is empty.
It is helpful when the lock is only lightly contended.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/locking/qspinlock_cna.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index 5addf6439326..29941677a6e1 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -41,6 +41,15 @@ static DEFINE_PER_CPU(u32, seed);
  */
 #define INTRA_NODE_HANDOFF_PROB_ARG 0x10000
 
+/*
+ * Controls the probability for enabling the scan of the main queue when
+ * the secondary queue is empty. The chosen value reduces the amount of
+ * unnecessary shuffling of threads between the two waiting queues when
+ * the contention is low, while responding fast enough and enabling
+ * the shuffling when the contention is high.
+ */
+#define SHUFFLE_REDUCTION_PROB_ARG  0x80
+
 static inline __pure int decode_numa_node(u32 node_and_count)
 {
 	int node = (node_and_count >> _Q_NODE_OFFSET) - 1;
@@ -197,6 +206,18 @@ static inline void pass_mcs_lock(struct mcs_spinlock *node,
 	struct mcs_spinlock *succ = NULL;
 
 	/*
+	 * Limit thread shuffling when the secondary queue is empty.
+	 * This copes with the overhead the shuffling creates when the
+	 * lock is only lightly contended, and threads do not stay
+	 * in the secondary queue long enough to reap the benefit of moving
+	 * them there.
+	 */
+	if (node->locked == 1 && probably(SHUFFLE_REDUCTION_PROB_ARG)) {
+		arch_mcs_spin_unlock_contended(&next->locked, 1);
+		return;
+	}
+
+	/*
 	 * Try to pass the lock to a thread running on the same node.
 	 * For long-term fairness, search for such a thread with high
 	 * probability rather than always.
-- 
2.11.0 (Apple Git-81)
