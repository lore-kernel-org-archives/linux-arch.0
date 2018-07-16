Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729811AbeGPScW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Jul 2018 14:32:22 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6GI09J5032187
        for <linux-arch@vger.kernel.org>; Mon, 16 Jul 2018 14:03:50 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k900b0py3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 16 Jul 2018 14:03:50 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 16 Jul 2018 14:03:48 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 10/14] sched: Use smp_mb() in wake_woken_function()
Date: Mon, 16 Jul 2018 11:06:01 -0700
In-Reply-To: <20180716180540.GA14222@linux.vnet.ibm.com>
References: <20180716180540.GA14222@linux.vnet.ibm.com>
Message-ID: <20180716180605.16115-10-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Andrea Parri <andrea.parri@amarulasolutions.com>, Ingo Molnar <mingo@redhat.com>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20180716180601.7RMH0oL1Wv6QgDgqny_dTikDmrrjH7_Qecc-Y1n_2DE@z>

From: Andrea Parri <andrea.parri@amarulasolutions.com>

wake_woken_function() synchronizes with wait_woken() as follows:

  [wait_woken]                       [wake_woken_function]

  entry->flags &= ~wq_flag_woken;    condition = true;
  smp_mb();                          smp_wmb();
  if (condition)                     wq_entry->flags |= wq_flag_woken;
     break;

This commit replaces the above smp_wmb() with an smp_mb() in order to
guarantee that either wait_woken() sees the wait condition being true
or the store to wq_entry->flags in woken_wake_function() follows the
store in wait_woken() in the coherence order (so that the former can
eventually be observed by wait_woken()).

The commit also fixes a comment associated to set_current_state() in
wait_woken(): the comment pairs the barrier in set_current_state() to
the above smp_wmb(), while the actual pairing involves the barrier in
set_current_state() and the barrier executed by the try_to_wake_up()
in wake_woken_function().

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Ingo Molnar <mingo@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/sched/wait.c | 47 ++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 928be527477e..a7a2aaa3026a 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -392,35 +392,36 @@ static inline bool is_kthread_should_stop(void)
  *     if (condition)
  *         break;
  *
- *     p->state = mode;				condition = true;
- *     smp_mb(); // A				smp_wmb(); // C
- *     if (!wq_entry->flags & WQ_FLAG_WOKEN)	wq_entry->flags |= WQ_FLAG_WOKEN;
- *         schedule()				try_to_wake_up();
- *     p->state = TASK_RUNNING;		    ~~~~~~~~~~~~~~~~~~
- *     wq_entry->flags &= ~WQ_FLAG_WOKEN;		condition = true;
- *     smp_mb() // B				smp_wmb(); // C
- *						wq_entry->flags |= WQ_FLAG_WOKEN;
- * }
- * remove_wait_queue(&wq_head, &wait);
+ *     // in wait_woken()			// in woken_wake_function()
  *
+ *     p->state = mode;				wq_entry->flags |= WQ_FLAG_WOKEN;
+ *     smp_mb(); // A				try_to_wake_up():
+ *     if (!(wq_entry->flags & WQ_FLAG_WOKEN))	   <full barrier>
+ *         schedule()				   if (p->state & mode)
+ *     p->state = TASK_RUNNING;			      p->state = TASK_RUNNING;
+ *     wq_entry->flags &= ~WQ_FLAG_WOKEN;	~~~~~~~~~~~~~~~~~~
+ *     smp_mb(); // B				condition = true;
+ * }						smp_mb(); // C
+ * remove_wait_queue(&wq_head, &wait);		wq_entry->flags |= WQ_FLAG_WOKEN;
  */
 long wait_woken(struct wait_queue_entry *wq_entry, unsigned mode, long timeout)
 {
-	set_current_state(mode); /* A */
 	/*
-	 * The above implies an smp_mb(), which matches with the smp_wmb() from
-	 * woken_wake_function() such that if we observe WQ_FLAG_WOKEN we must
-	 * also observe all state before the wakeup.
+	 * The below executes an smp_mb(), which matches with the full barrier
+	 * executed by the try_to_wake_up() in woken_wake_function() such that
+	 * either we see the store to wq_entry->flags in woken_wake_function()
+	 * or woken_wake_function() sees our store to current->state.
 	 */
+	set_current_state(mode); /* A */
 	if (!(wq_entry->flags & WQ_FLAG_WOKEN) && !is_kthread_should_stop())
 		timeout = schedule_timeout(timeout);
 	__set_current_state(TASK_RUNNING);
 
 	/*
-	 * The below implies an smp_mb(), it too pairs with the smp_wmb() from
-	 * woken_wake_function() such that we must either observe the wait
-	 * condition being true _OR_ WQ_FLAG_WOKEN such that we will not miss
-	 * an event.
+	 * The below executes an smp_mb(), which matches with the smp_mb() (C)
+	 * in woken_wake_function() such that either we see the wait condition
+	 * being true or the store to wq_entry->flags in woken_wake_function()
+	 * follows ours in the coherence order.
 	 */
 	smp_store_mb(wq_entry->flags, wq_entry->flags & ~WQ_FLAG_WOKEN); /* B */
 
@@ -430,14 +431,8 @@ EXPORT_SYMBOL(wait_woken);
 
 int woken_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *key)
 {
-	/*
-	 * Although this function is called under waitqueue lock, LOCK
-	 * doesn't imply write barrier and the users expects write
-	 * barrier semantics on wakeup functions.  The following
-	 * smp_wmb() is equivalent to smp_wmb() in try_to_wake_up()
-	 * and is paired with smp_store_mb() in wait_woken().
-	 */
-	smp_wmb(); /* C */
+	/* Pairs with the smp_store_mb() in wait_woken(). */
+	smp_mb(); /* C */
 	wq_entry->flags |= WQ_FLAG_WOKEN;
 
 	return default_wake_function(wq_entry, mode, sync, key);
-- 
2.17.1
