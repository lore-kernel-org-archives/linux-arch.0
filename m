From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 12/19] workqueue: Kill off ACCESS_ONCE()
Date: Mon, 23 Oct 2017 14:07:22 -0700
Message-ID: <1508792849-3115-12-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751427AbdJWVHl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Oct 2017 17:07:41 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9NL7DYG068024
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2017 17:07:40 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dspxqtnkj-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2017 17:07:40 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 23 Oct 2017 17:07:39 -0400
In-Reply-To: <20171023210408.GA2930@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, snitzer@redhat.com, thor.thayer@linux.intel.com, viro@zeniv.linux.org.uk, davem@davemloft.net, shuah@kernel.org, mpe@ellerman.id.au, tj@kernel.org, torvalds@linux-foundation.org, Lai Jiangshan <jiangshanlai@gmail.com>

From: Mark Rutland <mark.rutland@arm.com>

For several reasons, it is desirable to use {READ,WRITE}_ONCE() in
preference to ACCESS_ONCE(), and new code is expected to use one of the
former. So far, there's been no reason to change most existing uses of
ACCESS_ONCE(), as these aren't currently harmful.

However, for some features it is necessary to instrument reads and
writes separately, which is not possible with ACCESS_ONCE(). This
distinction is critical to correct operation.

It's possible to transform the bulk of kernel code using the Coccinelle
script below. However, this doesn't handle comments, leaving references
to ACCESS_ONCE() instances which have been removed. As a preparatory
step, this patch converts the workqueue code and comments to use
{READ,WRITE}_ONCE() consistently.

----
virtual patch

@ depends on patch @
expression E1, E2;
@@

- ACCESS_ONCE(E1) = E2
+ WRITE_ONCE(E1, E2)

@ depends on patch @
expression E;
@@

- ACCESS_ONCE(E)
+ READ_ONCE(E)
----

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 64d0edf428f8..39831b2f3c5f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4647,7 +4647,7 @@ static void rebind_workers(struct worker_pool *pool)
 		 * concurrency management.  Note that when or whether
 		 * @worker clears REBOUND doesn't affect correctness.
 		 *
-		 * ACCESS_ONCE() is necessary because @worker->flags may be
+		 * WRITE_ONCE() is necessary because @worker->flags may be
 		 * tested without holding any lock in
 		 * wq_worker_waking_up().  Without it, NOT_RUNNING test may
 		 * fail incorrectly leading to premature concurrency
@@ -4656,7 +4656,7 @@ static void rebind_workers(struct worker_pool *pool)
 		WARN_ON_ONCE(!(worker_flags & WORKER_UNBOUND));
 		worker_flags |= WORKER_REBOUND;
 		worker_flags &= ~WORKER_UNBOUND;
-		ACCESS_ONCE(worker->flags) = worker_flags;
+		WRITE_ONCE(worker->flags, worker_flags);
 	}
 
 	spin_unlock_irq(&pool->lock);
-- 
2.5.2
