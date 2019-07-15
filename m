Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:40592 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfGOT2t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jul 2019 15:28:49 -0400
From: Alex Kogan <alex.kogan@oracle.com>
Subject: [PATCH v3 5/5] locking/qspinlock: Introduce the shuffle reduction optimization into CNA
Date: Mon, 15 Jul 2019 15:25:36 -0400
Message-ID: <20190715192536.104548-6-alex.kogan@oracle.com>
In-Reply-To: <20190715192536.104548-1-alex.kogan@oracle.com>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190715192536.lzwdtxZ5UCr4WrFOcgnWjGqLl-_q12MmNIE1fhkUvEI@z>

This optimization reduces the probability threads will be shuffled between
the main and secondary queues when the secondary queue is empty.
It is helpful when the lock is only lightly contended.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/locking/qspinlock_cna.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index 3de5be813a46..9e6bd9e6d82b 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -50,6 +50,15 @@ static DEFINE_PER_CPU(u32, seed);
 #define INTRA_NODE_HANDOFF_PROB_ARG 0x10000
 
 /*
+ * Controls the probability for enabling the scan of the main queue when
+ * the secondary queue is empty. The chosen value reduces the amount of
+ * unnecessary shuffling of threads between the two waiting queues when
+ * the contention is low, while responding fast enough and enabling
+ * the shuffling when the contention is high.
+ */
+#define SHUFFLE_REDUCTION_PROB_ARG  0x80
+
+/*
  * Return false with probability 1 / @range.
  * @range must be a power of 2.
  */
@@ -169,6 +178,16 @@ static inline void cna_pass_mcs_lock(struct mcs_spinlock *node,
 	u64 val = 1;
 
 	/*
+	 * Limit thread shuffling when the secondary queue is empty.
+	 * This copes with the overhead the shuffling creates when the
+	 * lock is only lightly contended, and threads do not stay
+	 * in the secondary queue long enough to reap the benefit of moving
+	 * them there.
+	 */
+	if (node->locked <= 1 && probably(SHUFFLE_REDUCTION_PROB_ARG))
+		goto pass_lock;
+
+	/*
 	 * Try to pass the lock to a thread running on the same node.
 	 * For long-term fairness, search for such a thread with high
 	 * probability rather than always.
@@ -194,5 +213,6 @@ static inline void cna_pass_mcs_lock(struct mcs_spinlock *node,
 		 * in the main queue.
 		 */
 
+pass_lock:
 	arch_mcs_spin_unlock_contended(var, val);
 }
-- 
2.11.0 (Apple Git-81)
