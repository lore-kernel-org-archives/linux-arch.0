From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 3/9] locking/qrwlock: tidy up rspin_until_writer_unlock
Date: Tue,  7 Jul 2015 18:24:19 +0100
Message-ID: <1436289865-2331-4-git-send-email-will.deacon@arm.com>
References: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:50329 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932462AbbGGRZJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jul 2015 13:25:09 -0400
In-Reply-To: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Waiman.Long@hp.com, peterz@infradead.org, mingo@redhat.com, Will Deacon <will.deacon@arm.com>

rspin_until_writer_unlock is used by readers to spin on a qrwlock until
it is no longer held for write.

This patch tidies up the function so that (a) the comments match the
code and (b) we avoid passing the redundant initial lock value.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/locking/qrwlock.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index 4e29bef688ac..a1b63df19a04 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -44,16 +44,17 @@ struct __qrwlock {
 };
 
 /**
- * rspin_until_writer_unlock - inc reader count & spin until writer is gone
+ * rspin_until_writer_unlock - spin until writer is gone
  * @lock  : Pointer to queue rwlock structure
- * @writer: Current queue rwlock writer status byte
  *
  * In interrupt context or at the head of the queue, the reader will just
- * increment the reader count & wait until the writer releases the lock.
+ * wait until the writer releases the lock.
  */
 static __always_inline void
-rspin_until_writer_unlock(struct qrwlock *lock, u32 cnts)
+rspin_until_writer_unlock(struct qrwlock *lock)
 {
+	u32 cnts = smp_load_acquire((u32 *)&lock->cnts);
+
 	while ((cnts & _QW_WMASK) == _QW_LOCKED) {
 		cpu_relax_lowlatency();
 		cnts = smp_load_acquire((u32 *)&lock->cnts);
@@ -74,11 +75,11 @@ void queued_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
 		/*
 		 * Readers in interrupt context will get the lock immediately
 		 * if the writer is just waiting (not holding the lock yet).
-		 * The rspin_until_writer_unlock() function returns immediately
-		 * in this case. Otherwise, they will spin until the lock
-		 * is available without waiting in the queue.
+		 * Otherwise, they will spin until the lock is available
+		 * without waiting in the queue.
 		 */
-		rspin_until_writer_unlock(lock, cnts);
+		if ((cnts & _QW_WMASK) == _QW_LOCKED)
+			rspin_until_writer_unlock(lock);
 		return;
 	}
 	atomic_sub(_QR_BIAS, &lock->cnts);
@@ -99,8 +100,7 @@ void queued_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
 		cpu_relax_lowlatency();
 
 	atomic_add(_QR_BIAS, &lock->cnts);
-	cnts = smp_load_acquire((u32 *)&lock->cnts);
-	rspin_until_writer_unlock(lock, cnts);
+	rspin_until_writer_unlock(lock);
 
 	/*
 	 * Signal the next one in queue to become queue head
-- 
2.1.4
