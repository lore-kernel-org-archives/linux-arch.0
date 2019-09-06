Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:38192 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731943AbfIFOhc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Sep 2019 10:37:32 -0400
From: Alex Kogan <alex.kogan@oracle.com>
Subject: [PATCH v4 5/5] locking/qspinlock: Introduce the shuffle reduction optimization into CNA
Date: Fri,  6 Sep 2019 10:25:41 -0400
Message-ID: <20190906142541.34061-6-alex.kogan@oracle.com>
In-Reply-To: <20190906142541.34061-1-alex.kogan@oracle.com>
References: <20190906142541.34061-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190906142541.ubkAtuTIGFWs38L1XawFGSmfTVgiqf6xGHE3qwtO5m0@z>

This optimization reduces the probability threads will be shuffled between
the main and secondary queues when the secondary queue is empty.
It is helpful when the lock is only lightly contended.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/locking/qspinlock_cna.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index e86182e6163b..1c3a8905b2ca 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -64,6 +64,15 @@ static DEFINE_PER_CPU(u32, seed);
 #define INTRA_NODE_HANDOFF_PROB_ARG (16)
 
 /*
+ * Controls the probability for enabling the scan of the main queue when
+ * the secondary queue is empty. The chosen value reduces the amount of
+ * unnecessary shuffling of threads between the two waiting queues when
+ * the contention is low, while responding fast enough and enabling
+ * the shuffling when the contention is high.
+ */
+#define SHUFFLE_REDUCTION_PROB_ARG  (7)
+
+/*
  * Return false with probability 1 / 2^@num_bits.
  * Intuitively, the larger @num_bits the less likely false is to be returned.
  * @num_bits must be a number between 0 and 31.
@@ -230,6 +239,16 @@ static inline void cna_pass_lock(struct mcs_spinlock *node,
 	u32 val = 1;
 
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
 	 * Try to find a successor running on the same NUMA node
 	 * as the current lock holder. For long-term fairness,
 	 * search for such a thread with high probability rather than always.
@@ -252,5 +271,6 @@ static inline void cna_pass_lock(struct mcs_spinlock *node,
 		((struct cna_node *)next_holder)->tail->mcs.next = next;
 	}
 
+pass_lock:
 	arch_mcs_pass_lock(&next_holder->locked, val);
 }
-- 
2.11.0 (Apple Git-81)
