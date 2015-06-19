From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v5 2/3] locking/qrwlock: Better optimization for interrupt context readers
Date: Fri, 19 Jun 2015 11:50:01 -0400
Message-ID: <1434729002-57724-3-git-send-email-Waiman.Long@hp.com>
References: <1434729002-57724-1-git-send-email-Waiman.Long@hp.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g9t5008.houston.hp.com ([15.240.92.66]:38030 "EHLO
	g9t5008.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754267AbbFSPvE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jun 2015 11:51:04 -0400
In-Reply-To: <1434729002-57724-1-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>, Waiman Long <Waiman.Long@hp.com>

The qrwlock is fair in the process context, but becoming unfair when
in the interrupt context to support use cases like the tasklist_lock.

The current code isn't that well-documented on what happens when
in the interrupt context. The rspin_until_writer_unlock() will only
spin if the writer has gotten the lock. If the writer is still in the
waiting state, the increment in the reader count will cause the writer
to remain in the waiting state and the new interrupt context reader
will get the lock and return immediately. The current code, however,
do an additional read of the lock value which is not necessary as
the information have already been there in the fast path. This may
sometime cause an additional cacheline transfer when the lock is
highly contended.

This patch passes the lock value information gotten in the fast path
to the slow path to eliminate the additional read. It also document
the action for the interrupt context readers more clearly.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/qrwlock.h |    4 ++--
 kernel/locking/qrwlock.c      |   13 +++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 55e3ee1..deb9e8b 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -36,7 +36,7 @@
 /*
  * External function declarations
  */
-extern void queued_read_lock_slowpath(struct qrwlock *lock);
+extern void queued_read_lock_slowpath(struct qrwlock *lock, u32 cnts);
 extern void queued_write_lock_slowpath(struct qrwlock *lock);
 
 /**
@@ -105,7 +105,7 @@ static inline void queued_read_lock(struct qrwlock *lock)
 		return;
 
 	/* The slowpath will decrement the reader count, if necessary. */
-	queued_read_lock_slowpath(lock);
+	queued_read_lock_slowpath(lock, cnts);
 }
 
 /**
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index 9c2deed..26ca0ca 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -42,20 +42,21 @@ rspin_until_writer_unlock(struct qrwlock *lock, u32 cnts)
 /**
  * queued_read_lock_slowpath - acquire read lock of a queue rwlock
  * @lock: Pointer to queue rwlock structure
+ * @cnts: Current qrwlock lock value
  */
-void queued_read_lock_slowpath(struct qrwlock *lock)
+void queued_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
 {
-	u32 cnts;
-
 	/*
 	 * Readers come here when they cannot get the lock without waiting
 	 */
 	if (unlikely(in_interrupt())) {
 		/*
-		 * Readers in interrupt context will spin until the lock is
-		 * available without waiting in the queue.
+		 * Readers in interrupt context will get the lock immediately
+		 * if the writer is just waiting (not holding the lock yet).
+		 * The rspin_until_writer_unlock() function returns immediately
+		 * in this case. Otherwise, they will spin until the lock
+		 * is available without waiting in the queue.
 		 */
-		cnts = smp_load_acquire((u32 *)&lock->cnts);
 		rspin_until_writer_unlock(lock, cnts);
 		return;
 	}
-- 
1.7.1
