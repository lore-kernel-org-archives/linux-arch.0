Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728415AbeGPScV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Jul 2018 14:32:21 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6GHxGrH117935
        for <linux-arch@vger.kernel.org>; Mon, 16 Jul 2018 14:03:49 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k9031gj1u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 16 Jul 2018 14:03:48 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 16 Jul 2018 14:03:48 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 11/14] locking: Clarify requirements for smp_mb__after_spinlock()
Date: Mon, 16 Jul 2018 11:06:02 -0700
In-Reply-To: <20180716180540.GA14222@linux.vnet.ibm.com>
References: <20180716180540.GA14222@linux.vnet.ibm.com>
Message-ID: <20180716180605.16115-11-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Andrea Parri <andrea.parri@amarulasolutions.com>, Ingo Molnar <mingo@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20180716180602.kYDg0xp5I6aRjyRvMskuimso1tvE4FALEC6fXqafVPY@z>

From: Andrea Parri <andrea.parri@amarulasolutions.com>

There are 11 interpretations of the requirements described in the header
comment for smp_mb__after_spinlock(): one for each LKMM maintainer, and
one currently encoded in the Cat file. Stick to the latter (until a more
satisfactory solution is available).

This also reworks some snippets related to the barrier to illustrate the
requirements and to link them to the idioms which are relied upon at its
call sites.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/spinlock.h | 53 +++++++++++++++++++++++++++-------------
 kernel/sched/core.c      | 41 ++++++++++++++++---------------
 2 files changed, 57 insertions(+), 37 deletions(-)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 1e8a46435838..d70a06ff2bdd 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -114,29 +114,48 @@ do {								\
 #endif /*arch_spin_is_contended*/
 
 /*
- * This barrier must provide two things:
+ * smp_mb__after_spinlock() provides the equivalent of a full memory barrier
+ * between program-order earlier lock acquisitions and program-order later
+ * memory accesses.
  *
- *   - it must guarantee a STORE before the spin_lock() is ordered against a
- *     LOAD after it, see the comments at its two usage sites.
+ * This guarantees that the following two properties hold:
  *
- *   - it must ensure the critical section is RCsc.
+ *   1) Given the snippet:
  *
- * The latter is important for cases where we observe values written by other
- * CPUs in spin-loops, without barriers, while being subject to scheduling.
+ *	  { X = 0;  Y = 0; }
  *
- * CPU0			CPU1			CPU2
+ *	  CPU0				CPU1
  *
- *			for (;;) {
- *			  if (READ_ONCE(X))
- *			    break;
- *			}
- * X=1
- *			<sched-out>
- *						<sched-in>
- *						r = X;
+ *	  WRITE_ONCE(X, 1);		WRITE_ONCE(Y, 1);
+ *	  spin_lock(S);			smp_mb();
+ *	  smp_mb__after_spinlock();	r1 = READ_ONCE(X);
+ *	  r0 = READ_ONCE(Y);
+ *	  spin_unlock(S);
  *
- * without transitivity it could be that CPU1 observes X!=0 breaks the loop,
- * we get migrated and CPU2 sees X==0.
+ *      it is forbidden that CPU0 does not observe CPU1's store to Y (r0 = 0)
+ *      and CPU1 does not observe CPU0's store to X (r1 = 0); see the comments
+ *      preceding the call to smp_mb__after_spinlock() in __schedule() and in
+ *      try_to_wake_up().
+ *
+ *   2) Given the snippet:
+ *
+ *  { X = 0;  Y = 0; }
+ *
+ *  CPU0		CPU1				CPU2
+ *
+ *  spin_lock(S);	spin_lock(S);			r1 = READ_ONCE(Y);
+ *  WRITE_ONCE(X, 1);	smp_mb__after_spinlock();	smp_rmb();
+ *  spin_unlock(S);	r0 = READ_ONCE(X);		r2 = READ_ONCE(X);
+ *			WRITE_ONCE(Y, 1);
+ *			spin_unlock(S);
+ *
+ *      it is forbidden that CPU0's critical section executes before CPU1's
+ *      critical section (r0 = 1), CPU2 observes CPU1's store to Y (r1 = 1)
+ *      and CPU2 does not observe CPU0's store to X (r2 = 0); see the comments
+ *      preceding the calls to smp_rmb() in try_to_wake_up() for similar
+ *      snippets but "projected" onto two CPUs.
+ *
+ * Property (2) upgrades the lock to an RCsc lock.
  *
  * Since most load-store architectures implement ACQUIRE with an smp_mb() after
  * the LL/SC loop, they need no further barriers. Similarly all our TSO
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 78d8facba456..7db0662360f1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1999,21 +1999,20 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * be possible to, falsely, observe p->on_rq == 0 and get stuck
 	 * in smp_cond_load_acquire() below.
 	 *
-	 * sched_ttwu_pending()                 try_to_wake_up()
-	 *   [S] p->on_rq = 1;                  [L] P->state
-	 *       UNLOCK rq->lock  -----.
-	 *                              \
-	 *				 +---   RMB
-	 * schedule()                   /
-	 *       LOCK rq->lock    -----'
-	 *       UNLOCK rq->lock
+	 * sched_ttwu_pending()			try_to_wake_up()
+	 *   STORE p->on_rq = 1			  LOAD p->state
+	 *   UNLOCK rq->lock
+	 *
+	 * __schedule() (switch to task 'p')
+	 *   LOCK rq->lock			  smp_rmb();
+	 *   smp_mb__after_spinlock();
+	 *   UNLOCK rq->lock
 	 *
 	 * [task p]
-	 *   [S] p->state = UNINTERRUPTIBLE     [L] p->on_rq
+	 *   STORE p->state = UNINTERRUPTIBLE	  LOAD p->on_rq
 	 *
-	 * Pairs with the UNLOCK+LOCK on rq->lock from the
-	 * last wakeup of our task and the schedule that got our task
-	 * current.
+	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
+	 * __schedule().  See the comment for smp_mb__after_spinlock().
 	 */
 	smp_rmb();
 	if (p->on_rq && ttwu_remote(p, wake_flags))
@@ -2027,15 +2026,17 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * One must be running (->on_cpu == 1) in order to remove oneself
 	 * from the runqueue.
 	 *
-	 *  [S] ->on_cpu = 1;	[L] ->on_rq
-	 *      UNLOCK rq->lock
-	 *			RMB
-	 *      LOCK   rq->lock
-	 *  [S] ->on_rq = 0;    [L] ->on_cpu
+	 * __schedule() (switch to task 'p')	try_to_wake_up()
+	 *   STORE p->on_cpu = 1		  LOAD p->on_rq
+	 *   UNLOCK rq->lock
+	 *
+	 * __schedule() (put 'p' to sleep)
+	 *   LOCK rq->lock			  smp_rmb();
+	 *   smp_mb__after_spinlock();
+	 *   STORE p->on_rq = 0			  LOAD p->on_cpu
 	 *
-	 * Pairs with the full barrier implied in the UNLOCK+LOCK on rq->lock
-	 * from the consecutive calls to schedule(); the first switching to our
-	 * task, the second putting it to sleep.
+	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
+	 * __schedule().  See the comment for smp_mb__after_spinlock().
 	 */
 	smp_rmb();
 
-- 
2.17.1
