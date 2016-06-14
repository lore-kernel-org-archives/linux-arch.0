Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:58345 "EHLO
	g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbcFNWsc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jun 2016 18:48:32 -0400
From: Waiman Long <Waiman.Long@hpe.com>
Subject: [RFC PATCH-tip v2 1/6] locking/osq: Make lock/unlock proper acquire/release barrier
Date: Tue, 14 Jun 2016 18:48:04 -0400
Message-ID: <1465944489-43440-2-git-send-email-Waiman.Long@hpe.com>
In-Reply-To: <1465944489-43440-1-git-send-email-Waiman.Long@hpe.com>
References: <1465944489-43440-1-git-send-email-Waiman.Long@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, Jason Low <jason.low2@hp.com>, Dave Chinner <david@fromorbit.com>, Scott J Norton <scott.norton@hpe.com>, Douglas Hatch <doug.hatch@hpe.com>, Waiman Long <Waiman.Long@hpe.com>
Message-ID: <20160614224804.TXWZgdEuHQ_MF2rxBFVq4tu5bHaQtAbpASUctAabKpc@z>

The osq_lock() and osq_unlock() function may not provide the necessary
acquire and release barrier in some cases. This patch makes sure
that the proper barriers are provided when osq_lock() is successful
or when osq_unlock() is called.

Signed-off-by: Waiman Long <Waiman.Long@hpe.com>
---
 kernel/locking/osq_lock.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 05a3785..7dd4ee5 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -115,7 +115,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 	 * cmpxchg in an attempt to undo our queueing.
 	 */
 
-	while (!READ_ONCE(node->locked)) {
+	while (!smp_load_acquire(&node->locked)) {
 		/*
 		 * If we need to reschedule bail... so we can block.
 		 */
@@ -198,7 +198,7 @@ void osq_unlock(struct optimistic_spin_queue *lock)
 	 * Second most likely case.
 	 */
 	node = this_cpu_ptr(&osq_node);
-	next = xchg(&node->next, NULL);
+	next = xchg_release(&node->next, NULL);
 	if (next) {
 		WRITE_ONCE(next->locked, 1);
 		return;
-- 
1.7.1

