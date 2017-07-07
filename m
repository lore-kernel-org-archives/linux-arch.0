Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45145 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752618AbdGGT3G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jul 2017 15:29:06 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v67JSlVp098635
        for <linux-arch@vger.kernel.org>; Fri, 7 Jul 2017 15:28:50 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bjdsunpb3-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 07 Jul 2017 15:28:50 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 7 Jul 2017 15:28:32 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH v3 3/9] sched: Replace spin_unlock_wait() with lock/unlock pair
Date: Fri,  7 Jul 2017 12:28:20 -0700
In-Reply-To: <20170707192704.GA6144@linux.vnet.ibm.com>
References: <20170707192704.GA6144@linux.vnet.ibm.com>
Message-ID: <1499455706-9398-3-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, oleg@redhat.com, akpm@linux-foundation.org, mingo@redhat.com, dave@stgolabs.net, manfred@colorfullife.com, tj@kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, will.deacon@arm.com, peterz@infradead.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, torvalds@linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20170707192820.T2YkG631vYjLShOMxf167e_DKFniggOFNky8q2RvBgM@z>

There is no agreed-upon definition of spin_unlock_wait()'s semantics,
and it appears that all callers could do just as well with a lock/unlock
pair.  This commit therefore replaces the spin_unlock_wait() call in
do_task_dead() with spin_lock() followed immediately by spin_unlock().
This should be safe from a performance perspective because the lock is
this tasks ->pi_lock, and this is called only after the task exits.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
[ paulmck: Replace leading smp_mb() with smp_mb__before_spinlock(),
  courtesy of Arnd Bergmann's noting its odd location. ]
---
 kernel/sched/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e91138fcde86..48a8760fedf4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3460,8 +3460,9 @@ void __noreturn do_task_dead(void)
 	 * To avoid it, we have to wait for releasing tsk->pi_lock which
 	 * is held by try_to_wake_up()
 	 */
-	smp_mb();
-	raw_spin_unlock_wait(&current->pi_lock);
+	smp_mb__before_spinlock();
+	raw_spin_lock_irq(&current->pi_lock);
+	raw_spin_unlock_irq(&current->pi_lock);
 
 	/* Causes final put_task_struct in finish_task_switch(): */
 	__set_current_state(TASK_DEAD);
-- 
2.5.2
