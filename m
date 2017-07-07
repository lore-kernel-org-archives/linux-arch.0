Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752688AbdGGT3L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jul 2017 15:29:11 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v67JSwED033082
        for <linux-arch@vger.kernel.org>; Fri, 7 Jul 2017 15:29:01 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bjf19ty4p-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 07 Jul 2017 15:28:59 -0400
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 7 Jul 2017 15:28:32 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH v3 6/9] ipc: Replace spin_unlock_wait() with lock/unlock pair
Date: Fri,  7 Jul 2017 12:28:23 -0700
In-Reply-To: <20170707192704.GA6144@linux.vnet.ibm.com>
References: <20170707192704.GA6144@linux.vnet.ibm.com>
Message-ID: <1499455706-9398-6-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, oleg@redhat.com, akpm@linux-foundation.org, mingo@redhat.com, dave@stgolabs.net, manfred@colorfullife.com, tj@kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, will.deacon@arm.com, peterz@infradead.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, torvalds@linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20170707192823.fHW2WfuTPiOWqH1EDAh2ZBbbIVAcnenlTZ4s86q_NZ0@z>

There is no agreed-upon definition of spin_unlock_wait()'s semantics,
and it appears that all callers could do just as well with a lock/unlock
pair.  This commit therefore replaces the spin_unlock_wait() call in
exit_sem() with spin_lock() followed immediately by spin_unlock().
This should be safe from a performance perspective because exit_sem()
is rarely invoked in production.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Manfred Spraul <manfred@colorfullife.com>
---
 ipc/sem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index 947dc2348271..e88d0749a929 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -2096,7 +2096,8 @@ void exit_sem(struct task_struct *tsk)
 			 * possibility where we exit while freeary() didn't
 			 * finish unlocking sem_undo_list.
 			 */
-			spin_unlock_wait(&ulp->lock);
+			spin_lock(&ulp->lock);
+			spin_unlock(&ulp->lock);
 			rcu_read_unlock();
 			break;
 		}
-- 
2.5.2
