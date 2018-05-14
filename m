Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58852 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752378AbeENXAH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 19:00:07 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4EMxbfr007838
        for <linux-arch@vger.kernel.org>; Mon, 14 May 2018 19:00:06 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hyh2adm9f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 14 May 2018 19:00:06 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 14 May 2018 19:00:05 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 3/3] locking: Clean up comment and #ifndef for {,queued_}spin_is_locked()
Date: Mon, 14 May 2018 16:01:29 -0700
In-Reply-To: <20180514230105.GA6421@linux.vnet.ibm.com>
References: <20180514230105.GA6421@linux.vnet.ibm.com>
Message-ID: <1526338889-7003-3-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Andrea Parri <andrea.parri@amarulasolutions.com>, Ingo Molnar <mingo@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20180514230129.7CN81SOp1GHStchfDx4XHL1WZukM6ZEjy9Yasei5jgE@z>

From: Andrea Parri <andrea.parri@amarulasolutions.com>

Removes "#ifndef queued_spin_is_locked" from the generic code: this is
unused and it's reasonable to conclude that it will continue to be unused.

Also removes the comment about spin_is_locked() from mutex_is_locked():
the comment remains valid but not particularly useful.

Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/asm-generic/qspinlock.h | 2 --
 include/linux/mutex.h           | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index b37b4ad7eb94..dc4e4ac4937e 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -26,7 +26,6 @@
  * @lock: Pointer to queued spinlock structure
  * Return: 1 if it is locked, 0 otherwise
  */
-#ifndef queued_spin_is_locked
 static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
 {
 	/*
@@ -35,7 +34,6 @@ static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
 	 */
 	return atomic_read(&lock->val);
 }
-#endif
 
 /**
  * queued_spin_value_unlocked - is the spinlock structure unlocked?
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 14bc0d5d0ee5..3093dd162424 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -146,9 +146,6 @@ extern void __mutex_init(struct mutex *lock, const char *name,
  */
 static inline bool mutex_is_locked(struct mutex *lock)
 {
-	/*
-	 * XXX think about spin_is_locked
-	 */
 	return __mutex_owner(lock) != NULL;
 }
 
-- 
2.5.2
