Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:17408 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752980AbcHSC31 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Aug 2016 22:29:27 -0400
From: Waiman Long <Waiman.Long@hpe.com>
Subject: [RFC PATCH-tip v4 01/10] locking/osq: Make lock/unlock proper acquire/release barrier
Date: Thu, 18 Aug 2016 17:11:03 -0400
Message-ID: <1471554672-38662-2-git-send-email-Waiman.Long@hpe.com>
In-Reply-To: <1471554672-38662-1-git-send-email-Waiman.Long@hpe.com>
References: <1471554672-38662-1-git-send-email-Waiman.Long@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, Jason Low <jason.low2@hp.com>, Dave Chinner <david@fromorbit.com>, Jonathan Corbet <corbet@lwn.net>, Scott J Norton <scott.norton@hpe.com>, Douglas Hatch <doug.hatch@hpe.com>, Waiman Long <Waiman.Long@hpe.com>
Message-ID: <20160818211103.C5A8paLhddOUtMTKIOVlmusZ38H2Sdqg6S0HA_yegcQ@z>

The osq_lock() and osq_unlock() function may not provide the necessary
acquire and release barrier in some cases. This patch makes sure
that the proper barriers are provided when osq_lock() is successful
or when osq_unlock() is called.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Waiman Long <Waiman.Long@hpe.com>
---
 kernel/locking/osq_lock.c |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 05a3785..3da0b97 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -124,6 +124,11 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 
 		cpu_relax_lowlatency();
 	}
+	/*
+	 * Add an acquire memory barrier for pairing with the release barrier
+	 * in unlock.
+	 */
+	smp_acquire__after_ctrl_dep();
 	return true;
 
 unqueue:
@@ -198,13 +203,20 @@ void osq_unlock(struct optimistic_spin_queue *lock)
 	 * Second most likely case.
 	 */
 	node = this_cpu_ptr(&osq_node);
-	next = xchg(&node->next, NULL);
-	if (next) {
-		WRITE_ONCE(next->locked, 1);
+	next = xchg_relaxed(&node->next, NULL);
+	if (next)
+		goto unlock;
+
+	next = osq_wait_next(lock, node, NULL);
+	if (unlikely(!next)) {
+		/*
+		 * In the unlikely event that the OSQ is empty, we need to
+		 * provide a proper release barrier.
+		 */
+		smp_mb();
 		return;
 	}
 
-	next = osq_wait_next(lock, node, NULL);
-	if (next)
-		WRITE_ONCE(next->locked, 1);
+unlock:
+	smp_store_release(&next->locked, 1);
 }
-- 
1.7.1

