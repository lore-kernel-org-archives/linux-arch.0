Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752512AbdGGT3c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jul 2017 15:29:32 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v67JTKLH110664
        for <linux-arch@vger.kernel.org>; Fri, 7 Jul 2017 15:29:22 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bjf402ud2-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 07 Jul 2017 15:29:21 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 7 Jul 2017 15:28:32 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH v3 2/9] task_work: Replace spin_unlock_wait() with lock/unlock pair
Date: Fri,  7 Jul 2017 12:28:19 -0700
In-Reply-To: <20170707192704.GA6144@linux.vnet.ibm.com>
References: <20170707192704.GA6144@linux.vnet.ibm.com>
Message-ID: <1499455706-9398-2-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, oleg@redhat.com, akpm@linux-foundation.org, mingo@redhat.com, dave@stgolabs.net, manfred@colorfullife.com, tj@kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, will.deacon@arm.com, peterz@infradead.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, torvalds@linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20170707192819.sCBKEdMjVsxfiU1JZXp__3mIK9W-OXJECJu_tPAd1NM@z>

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
