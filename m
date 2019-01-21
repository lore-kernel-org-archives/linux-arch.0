From: Waiman Long <longman@redhat.com>
Subject: [PATCH 3/5] locking/qspinlock_stat: Separate out the PV specific stat counts
Date: Sun, 20 Jan 2019 21:49:52 -0500
Message-ID: <1548038994-30073-4-git-send-email-longman@redhat.com>
References: <1548038994-30073-1-git-send-email-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548038994-30073-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>, James Morse <james.morse@arm.com>, SRINIVAS <srinivas.eeda@oracle.com>, Waiman Long <longman@redhat.com>
List-Id: linux-arch.vger.kernel.org

Some of the statistics counts are for PV qspinlocks only and are not
applicable if PARAVIRT_SPINLOCKS aren't configured. So make those counts
dependent on the PARAVIRT_SPINLOCKS config option now.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock_stat.h | 129 +++++++++++++++++++++++++---------------
 1 file changed, 81 insertions(+), 48 deletions(-)

diff --git a/kernel/locking/qspinlock_stat.h b/kernel/locking/qspinlock_stat.h
index 4f8ca8c..ad2e9f4 100644
--- a/kernel/locking/qspinlock_stat.h
+++ b/kernel/locking/qspinlock_stat.h
@@ -50,6 +50,7 @@
  * There may be slight difference between pv_kick_wake and pv_kick_unlock.
  */
 enum qlock_stats {
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
 	qstat_pv_hash_hops,
 	qstat_pv_kick_unlock,
 	qstat_pv_kick_wake,
@@ -61,6 +62,7 @@ enum qlock_stats {
 	qstat_pv_wait_early,
 	qstat_pv_wait_head,
 	qstat_pv_wait_node,
+#endif
 	qstat_lock_pending,
 	qstat_lock_slowpath,
 	qstat_lock_use_node2,
@@ -82,6 +84,7 @@ enum qlock_stats {
 #include <linux/fs.h>
 
 static const char * const qstat_names[qstat_num + 1] = {
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
 	[qstat_pv_hash_hops]	   = "pv_hash_hops",
 	[qstat_pv_kick_unlock]     = "pv_kick_unlock",
 	[qstat_pv_kick_wake]       = "pv_kick_wake",
@@ -93,6 +96,7 @@ enum qlock_stats {
 	[qstat_pv_wait_early]      = "pv_wait_early",
 	[qstat_pv_wait_head]       = "pv_wait_head",
 	[qstat_pv_wait_node]       = "pv_wait_node",
+#endif
 	[qstat_lock_pending]       = "lock_pending",
 	[qstat_lock_slowpath]      = "lock_slowpath",
 	[qstat_lock_use_node2]	   = "lock_use_node2",
@@ -107,6 +111,20 @@ enum qlock_stats {
  * Per-cpu counters
  */
 static DEFINE_PER_CPU(unsigned long, qstats[qstat_num]);
+
+/*
+ * Increment the PV qspinlock statistical counters
+ */
+static inline void qstat_inc(enum qlock_stats stat, bool cond)
+{
+	if (cond)
+		this_cpu_inc(qstats[stat]);
+}
+
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+/*
+ * PV specific per-cpu counters
+ */
 static DEFINE_PER_CPU(u64, pv_kick_time);
 
 /*
@@ -181,6 +199,69 @@ static ssize_t qstat_read(struct file *file, char __user *user_buf,
 }
 
 /*
+ * PV hash hop count
+ */
+static inline void qstat_hop(int hopcnt)
+{
+	this_cpu_add(qstats[qstat_pv_hash_hops], hopcnt);
+}
+
+/*
+ * Replacement function for pv_kick()
+ */
+static inline void __pv_kick(int cpu)
+{
+	u64 start = sched_clock();
+
+	per_cpu(pv_kick_time, cpu) = start;
+	pv_kick(cpu);
+	this_cpu_add(qstats[qstat_pv_latency_kick], sched_clock() - start);
+}
+
+/*
+ * Replacement function for pv_wait()
+ */
+static inline void __pv_wait(u8 *ptr, u8 val)
+{
+	u64 *pkick_time = this_cpu_ptr(&pv_kick_time);
+
+	*pkick_time = 0;
+	pv_wait(ptr, val);
+	if (*pkick_time) {
+		this_cpu_add(qstats[qstat_pv_latency_wake],
+			     sched_clock() - *pkick_time);
+		qstat_inc(qstat_pv_kick_wake, true);
+	}
+}
+
+#define pv_kick(c)	__pv_kick(c)
+#define pv_wait(p, v)	__pv_wait(p, v)
+
+#else /* CONFIG_PARAVIRT_SPINLOCKS */
+static ssize_t qstat_read(struct file *file, char __user *user_buf,
+			  size_t count, loff_t *ppos)
+{
+	char buf[64];
+	int cpu, counter, len;
+	u64 stat = 0;
+
+	/*
+	 * Get the counter ID stored in file->f_inode->i_private
+	 */
+	counter = (long)file_inode(file)->i_private;
+
+	if (counter >= qstat_num)
+		return -EBADF;
+
+	for_each_possible_cpu(cpu)
+		stat += per_cpu(qstats[counter], cpu);
+	len = snprintf(buf, sizeof(buf) - 1, "%llu\n", stat);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+#endif /* CONFIG_PARAVIRT_SPINLOCKS */
+
+/*
  * Function to handle write request
  *
  * When counter = reset_cnts, reset all the counter values.
@@ -253,54 +334,6 @@ static int __init init_qspinlock_stat(void)
 }
 fs_initcall(init_qspinlock_stat);
 
-/*
- * Increment the PV qspinlock statistical counters
- */
-static inline void qstat_inc(enum qlock_stats stat, bool cond)
-{
-	if (cond)
-		this_cpu_inc(qstats[stat]);
-}
-
-/*
- * PV hash hop count
- */
-static inline void qstat_hop(int hopcnt)
-{
-	this_cpu_add(qstats[qstat_pv_hash_hops], hopcnt);
-}
-
-/*
- * Replacement function for pv_kick()
- */
-static inline void __pv_kick(int cpu)
-{
-	u64 start = sched_clock();
-
-	per_cpu(pv_kick_time, cpu) = start;
-	pv_kick(cpu);
-	this_cpu_add(qstats[qstat_pv_latency_kick], sched_clock() - start);
-}
-
-/*
- * Replacement function for pv_wait()
- */
-static inline void __pv_wait(u8 *ptr, u8 val)
-{
-	u64 *pkick_time = this_cpu_ptr(&pv_kick_time);
-
-	*pkick_time = 0;
-	pv_wait(ptr, val);
-	if (*pkick_time) {
-		this_cpu_add(qstats[qstat_pv_latency_wake],
-			     sched_clock() - *pkick_time);
-		qstat_inc(qstat_pv_kick_wake, true);
-	}
-}
-
-#define pv_kick(c)	__pv_kick(c)
-#define pv_wait(p, v)	__pv_wait(p, v)
-
 #else /* CONFIG_QUEUED_LOCK_STAT */
 
 static inline void qstat_inc(enum qlock_stats stat, bool cond)	{ }
-- 
1.8.3.1
