From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH v2 2/9] task_work: Replace spin_unlock_wait() with lock/unlock pair
Date: Wed,  5 Jul 2017 16:31:36 -0700
Message-ID: <1499297503-23852-2-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20170705232955.GA15992@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33955 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752138AbdGEXbs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2017 19:31:48 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v65NSr9F138265
        for <linux-arch@vger.kernel.org>; Wed, 5 Jul 2017 19:31:48 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2bgvxyhc7m-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 05 Jul 2017 19:31:48 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 5 Jul 2017 19:31:47 -0400
In-Reply-To: <20170705232955.GA15992@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, oleg@redhat.com, akpm@linux-foundation.org, mingo@redhat.com, dave@stgolabs.net, manfred@colorfullife.com, tj@kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, will.deacon@arm.com, peterz@infradead.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, torvalds@linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

From: Oleg Nesterov <oleg@redhat.com>

There is no agreed-upon definition of spin_unlock_wait()'s semantics,
and it appears that all callers could do just as well with a lock/unlock
pair.  This commit therefore replaces the spin_unlock_wait() call in
task_work_run() with a spin_lock_irq() and a spin_unlock_irq() aruond
the cmpxchg() dequeue loop.  This should be safe from a performance
perspective because ->pi_lock is local to the task and because calls to
the other side of the race, task_work_cancel(), should be rare.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/task_work.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/task_work.c b/kernel/task_work.c
index d513051fcca2..836a72a66fba 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -96,20 +96,16 @@ void task_work_run(void)
 		 * work->func() can do task_work_add(), do not set
 		 * work_exited unless the list is empty.
 		 */
+		raw_spin_lock_irq(&task->pi_lock);
 		do {
 			work = READ_ONCE(task->task_works);
 			head = !work && (task->flags & PF_EXITING) ?
 				&work_exited : NULL;
 		} while (cmpxchg(&task->task_works, work, head) != work);
+		raw_spin_unlock_irq(&task->pi_lock);
 
 		if (!work)
 			break;
-		/*
-		 * Synchronize with task_work_cancel(). It can't remove
-		 * the first entry == work, cmpxchg(task_works) should
-		 * fail, but it can play with *work and other entries.
-		 */
-		raw_spin_unlock_wait(&task->pi_lock);
 
 		do {
 			next = work->next;
-- 
2.5.2
