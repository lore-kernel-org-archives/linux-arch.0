From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/core/rcu 10/15] locking: Remove smp_read_barrier_depends() from queued_spin_lock_slowpath()
Date: Mon,  9 Oct 2017 17:22:44 -0700
Message-ID: <1507594969-8347-10-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755827AbdJJAW4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2017 20:22:56 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9A0KIqq062174
        for <linux-arch@vger.kernel.org>; Mon, 9 Oct 2017 20:22:55 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dgkjxr3cu-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 09 Oct 2017 20:22:55 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Oct 2017 20:22:54 -0400
In-Reply-To: <20171010001951.GA6476@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>

Queued spinlocks are not used by DEC Alpha, and furthermore operations
such as READ_ONCE() and release/relaxed RMW atomics are being changed
to imply smp_read_barrier_depends().  This commit therefore removes the
now-redundant smp_read_barrier_depends() from queued_spin_lock_slowpath(),
and adjusts the comments accordingly.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
 kernel/locking/qspinlock.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 294294c71ba4..38ece035039e 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -170,7 +170,7 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
  * @tail : The new queue tail code word
  * Return: The previous queue tail code word
  *
- * xchg(lock, tail)
+ * xchg(lock, tail), which heads an address dependency
  *
  * p,*,* -> n,*,* ; prev = xchg(lock, node)
  */
@@ -409,13 +409,11 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if (old & _Q_TAIL_MASK) {
 		prev = decode_tail(old);
 		/*
-		 * The above xchg_tail() is also a load of @lock which generates,
-		 * through decode_tail(), a pointer.
-		 *
-		 * The address dependency matches the RELEASE of xchg_tail()
-		 * such that the access to @prev must happen after.
+		 * The above xchg_tail() is also a load of @lock which
+		 * generates, through decode_tail(), a pointer.  The address
+		 * dependency matches the RELEASE of xchg_tail() such that
+		 * the subsequent access to @prev happens after.
 		 */
-		smp_read_barrier_depends();
 
 		WRITE_ONCE(prev->next, node);
 
-- 
2.5.2
