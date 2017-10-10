From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/core/rcu 06/15] rcu: Adjust read-side accessor comments for READ_ONCE()
Date: Mon,  9 Oct 2017 17:22:40 -0700
Message-ID: <1507594969-8347-6-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754707AbdJJAWx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2017 20:22:53 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9A0JOB4058306
        for <linux-arch@vger.kernel.org>; Mon, 9 Oct 2017 20:22:53 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dgjf92ssf-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 09 Oct 2017 20:22:52 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Oct 2017 20:22:52 -0400
In-Reply-To: <20171010001951.GA6476@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

Now that READ_ONCE() implies smp_read_barrier_depends(), the commit
updates now-misleading comments to account for this change.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/rcupdate.h | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index de50d8a4cf41..de386d82e2f1 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -433,12 +433,12 @@ static inline void rcu_preempt_sleep_check(void) { }
  * @p: The pointer to read
  *
  * Return the value of the specified RCU-protected pointer, but omit the
- * smp_read_barrier_depends() and keep the READ_ONCE().  This is useful
- * when the value of this pointer is accessed, but the pointer is not
- * dereferenced, for example, when testing an RCU-protected pointer against
- * NULL.  Although rcu_access_pointer() may also be used in cases where
- * update-side locks prevent the value of the pointer from changing, you
- * should instead use rcu_dereference_protected() for this use case.
+ * lockdep checks for being in an RCU read-side critical section.  This is
+ * useful when the value of this pointer is accessed, but the pointer is
+ * not dereferenced, for example, when testing an RCU-protected pointer
+ * against NULL.  Although rcu_access_pointer() may also be used in cases
+ * where update-side locks prevent the value of the pointer from changing,
+ * you should instead use rcu_dereference_protected() for this use case.
  *
  * It is also permissible to use rcu_access_pointer() when read-side
  * access to the pointer was removed at least one grace period ago, as
@@ -521,12 +521,11 @@ static inline void rcu_preempt_sleep_check(void) { }
  * @c: The conditions under which the dereference will take place
  *
  * Return the value of the specified RCU-protected pointer, but omit
- * both the smp_read_barrier_depends() and the READ_ONCE().  This
- * is useful in cases where update-side locks prevent the value of the
- * pointer from changing.  Please note that this primitive does -not-
- * prevent the compiler from repeating this reference or combining it
- * with other references, so it should not be used without protection
- * of appropriate locks.
+ * the READ_ONCE().  This is useful in cases where update-side locks
+ * prevent the value of the pointer from changing.  Please note that this
+ * primitive does -not- prevent the compiler from repeating this reference
+ * or combining it with other references, so it should not be used without
+ * protection of appropriate locks.
  *
  * This function is only for update-side use.  Using this function
  * when protected only by rcu_read_lock() will result in infrequent
-- 
2.5.2
