From: Waiman Long <longman@redhat.com>
Subject: [PATCH 2/5] locking/qspinlock_stat: Track the no MCS node available case
Date: Sun, 20 Jan 2019 21:49:51 -0500
Message-ID: <1548038994-30073-3-git-send-email-longman@redhat.com>
References: <1548038994-30073-1-git-send-email-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548038994-30073-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>, James Morse <james.morse@arm.com>, SRINIVAS <srinivas.eeda@oracle.com>, Waiman Long <longman@redhat.com>
List-Id: linux-arch.vger.kernel.org

Track the number of slowpath locking operations that are being done
without any MCS node available as well renaming lock_index[123] to make
them more descriptive.

Using these stat counters is one way to find out if a code path is
being exercised.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock.c      |  4 +++-
 kernel/locking/qspinlock_stat.h | 24 ++++++++++++++++++------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 5bb06df..8163633 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -395,6 +395,7 @@ static noinline void acquire_lock_no_node(struct qspinlock *lock)
  */
 static noinline void spin_on_waiting(struct qspinlock *lock)
 {
+	qstat_inc(qstat_lock_waiting, true);
 	atomic_cond_read_relaxed(&lock->val, !(VAL & _Q_WAITING_VAL));
 
 	/* Clear the pending bit now */
@@ -548,6 +549,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 */
 	if (unlikely(idx >= MAX_NODES)) {
 		acquire_lock_no_node(lock);
+		qstat_inc(qstat_lock_no_node, true);
 		goto release;
 	}
 
@@ -556,7 +558,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	/*
 	 * Keep counts of non-zero index values:
 	 */
-	qstat_inc(qstat_lock_idx1 + idx - 1, idx);
+	qstat_inc(qstat_lock_use_node2 + idx - 1, idx);
 
 	/*
 	 * Ensure that we increment the head node->count before initialising
diff --git a/kernel/locking/qspinlock_stat.h b/kernel/locking/qspinlock_stat.h
index 42d3d8d..4f8ca8c 100644
--- a/kernel/locking/qspinlock_stat.h
+++ b/kernel/locking/qspinlock_stat.h
@@ -30,6 +30,14 @@
  *   pv_wait_node	- # of vCPU wait's at a non-head queue node
  *   lock_pending	- # of locking operations via pending code
  *   lock_slowpath	- # of locking operations via MCS lock queue
+ *   lock_use_node2	- # of locking operations that use 2nd percpu node
+ *   lock_use_node3	- # of locking operations that use 3rd percpu node
+ *   lock_use_node4	- # of locking operations that use 4th percpu node
+ *   lock_no_node	- # of locking operations without using percpu node
+ *   lock_waiting	- # of locking operations with waiting bit set
+ *
+ * Subtraccting lock_use_node[234] from lock_slowpath will give you
+ * lock_use_node1.
  *
  * Writing to the "reset_counters" file will reset all the above counter
  * values.
@@ -55,9 +63,11 @@ enum qlock_stats {
 	qstat_pv_wait_node,
 	qstat_lock_pending,
 	qstat_lock_slowpath,
-	qstat_lock_idx1,
-	qstat_lock_idx2,
-	qstat_lock_idx3,
+	qstat_lock_use_node2,
+	qstat_lock_use_node3,
+	qstat_lock_use_node4,
+	qstat_lock_no_node,
+	qstat_lock_waiting,
 	qstat_num,	/* Total number of statistical counters */
 	qstat_reset_cnts = qstat_num,
 };
@@ -85,9 +95,11 @@ enum qlock_stats {
 	[qstat_pv_wait_node]       = "pv_wait_node",
 	[qstat_lock_pending]       = "lock_pending",
 	[qstat_lock_slowpath]      = "lock_slowpath",
-	[qstat_lock_idx1]	   = "lock_index1",
-	[qstat_lock_idx2]	   = "lock_index2",
-	[qstat_lock_idx3]	   = "lock_index3",
+	[qstat_lock_use_node2]	   = "lock_use_node2",
+	[qstat_lock_use_node3]	   = "lock_use_node3",
+	[qstat_lock_use_node4]	   = "lock_use_node4",
+	[qstat_lock_no_node]	   = "lock_no_node",
+	[qstat_lock_waiting]	   = "lock_waiting",
 	[qstat_reset_cnts]         = "reset_counters",
 };
 
-- 
1.8.3.1
