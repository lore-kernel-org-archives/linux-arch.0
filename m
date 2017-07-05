Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752622AbdGEXbu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2017 19:31:50 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v65NStbh110837
        for <linux-arch@vger.kernel.org>; Wed, 5 Jul 2017 19:31:49 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bgvybsjqk-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 05 Jul 2017 19:31:49 -0400
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 5 Jul 2017 19:31:48 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH v2 4/9] completion: Replace spin_unlock_wait() with lock/unlock pair
Date: Wed,  5 Jul 2017 16:31:38 -0700
In-Reply-To: <20170705232955.GA15992@linux.vnet.ibm.com>
References: <20170705232955.GA15992@linux.vnet.ibm.com>
Message-ID: <1499297503-23852-4-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, oleg@redhat.com, akpm@linux-foundation.org, mingo@redhat.com, dave@stgolabs.net, manfred@colorfullife.com, tj@kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, will.deacon@arm.com, peterz@infradead.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, torvalds@linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20170705233138.ZIIkb00nHgRTvWHUvNwRMR7UTsSrXjGwncwPeGLkhuI@z>

There is no agreed-upon definition of spin_unlock_wait()'s semantics,
and it appears that all callers could do just as well with a lock/unlock
pair.  This commit therefore replaces the spin_unlock_wait() call in
completion_done() with spin_lock() followed immediately by spin_unlock().
This should be safe from a performance perspective because the lock
will be held only the wakeup happens really quickly.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 kernel/sched/completion.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 53f9558fa925..3e66712e1964 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -307,14 +307,9 @@ bool completion_done(struct completion *x)
 	 * If ->done, we need to wait for complete() to release ->wait.lock
 	 * otherwise we can end up freeing the completion before complete()
 	 * is done referencing it.
-	 *
-	 * The RMB pairs with complete()'s RELEASE of ->wait.lock and orders
-	 * the loads of ->done and ->wait.lock such that we cannot observe
-	 * the lock before complete() acquires it while observing the ->done
-	 * after it's acquired the lock.
 	 */
-	smp_rmb();
-	spin_unlock_wait(&x->wait.lock);
+	spin_lock_irq(&x->wait.lock);
+	spin_unlock_irq(&x->wait.lock);
 	return true;
 }
 EXPORT_SYMBOL(completion_done);
-- 
2.5.2
