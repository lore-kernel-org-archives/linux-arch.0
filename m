From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v2 1/2] locking/qrwlock: Fix bug in interrupt handling code
Date: Tue,  9 Jun 2015 11:19:12 -0400
Message-ID: <1433863153-30722-2-git-send-email-Waiman.Long@hp.com>
References: <1433863153-30722-1-git-send-email-Waiman.Long@hp.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53]:37275 "EHLO
	g4t3425.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504AbbFIPT0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 11:19:26 -0400
In-Reply-To: <1433863153-30722-1-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>, Waiman Long <Waiman.Long@hp.com>

The qrwlock is fair in the process context, but becoming unfair when
in the interrupt context to support use cases like the tasklist_lock.
However, the unfair code in the interrupt context has problem that
may cause deadlock.

The fast path increments the reader count. In the interrupt context,
the reader in the slowpath will wait until the writer release the
lock. However, if other readers have the lock and the writer is just
in the waiting mode. It will never get the write lock because the
that interrupt context reader has increment the count. This will
cause deadlock.

This patch fixes this problem by checking the state of the
reader/writer count retrieved at the fast path. If the writer
is in waiting mode, the reader will get the lock immediately and
return. Otherwise, it will wait until the writer release the lock
like before.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 include/asm-generic/qrwlock.h |    4 ++--
 kernel/locking/qrwlock.c      |   14 ++++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 6383d54..865d021 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -36,7 +36,7 @@
 /*
  * External function declarations
  */
-extern void queue_read_lock_slowpath(struct qrwlock *lock);
+extern void queue_read_lock_slowpath(struct qrwlock *lock, u32 cnts);
 extern void queue_write_lock_slowpath(struct qrwlock *lock);
 
 /**
@@ -105,7 +105,7 @@ static inline void queue_read_lock(struct qrwlock *lock)
 		return;
 
 	/* The slowpath will decrement the reader count, if necessary. */
-	queue_read_lock_slowpath(lock);
+	queue_read_lock_slowpath(lock, cnts);
 }
 
 /**
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index 00c12bb..d7d7557 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -43,22 +43,24 @@ rspin_until_writer_unlock(struct qrwlock *lock, u32 cnts)
  * queue_read_lock_slowpath - acquire read lock of a queue rwlock
  * @lock: Pointer to queue rwlock structure
  */
-void queue_read_lock_slowpath(struct qrwlock *lock)
+void queue_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
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
+		 * if the writer is just waiting (not holding the lock yet)
+		 * or they will spin until the lock is available without
+		 * waiting in the queue.
 		 */
-		cnts = smp_load_acquire((u32 *)&lock->cnts);
+		if ((cnts & _QW_WMASK) != _QW_LOCKED)
+			return;
 		rspin_until_writer_unlock(lock, cnts);
 		return;
 	}
+
 	atomic_sub(_QR_BIAS, &lock->cnts);
 
 	/*
-- 
1.7.1
