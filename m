From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 7/9] locking/qrwlock: expose internal lock structure in qrwlock definition
Date: Tue,  7 Jul 2015 18:24:23 +0100
Message-ID: <1436289865-2331-8-git-send-email-will.deacon@arm.com>
References: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:50332 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932511AbbGGRZM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jul 2015 13:25:12 -0400
In-Reply-To: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Waiman.Long@hp.com, peterz@infradead.org, mingo@redhat.com, Will Deacon <will.deacon@arm.com>

In order for a writer to unlock correctly on big-endian machines, we
need to expose the internal layout of the qrwlock structure so that
we also zero the correct sub-field.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/qrwlock.h       |  2 +-
 include/asm-generic/qrwlock_types.h | 17 ++++++++++++++++-
 kernel/locking/qrwlock.c            | 26 ++------------------------
 3 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index dbaac5f2af8f..25e97942726a 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -143,7 +143,7 @@ static inline void queued_read_unlock(struct qrwlock *lock)
 #ifndef queued_write_unlock
 static inline void queued_write_unlock(struct qrwlock *lock)
 {
-	smp_store_release((u8 *)&lock->cnts, 0);
+	smp_store_release(&lock->wmode, 0);
 }
 #endif
 
diff --git a/include/asm-generic/qrwlock_types.h b/include/asm-generic/qrwlock_types.h
index 4d76f24df518..4c4f87fcf720 100644
--- a/include/asm-generic/qrwlock_types.h
+++ b/include/asm-generic/qrwlock_types.h
@@ -2,14 +2,29 @@
 #define __ASM_GENERIC_QRWLOCK_TYPES_H
 
 #include <linux/types.h>
+#include <asm/byteorder.h>
 #include <asm/spinlock_types.h>
 
 /*
  * The queue read/write lock data structure
+ *
+ * The 32-bit count is divided into an 8-bit writer mode byte (least
+ * significant) and a 24-bit reader count.
  */
 
 typedef struct qrwlock {
-	atomic_t		cnts;
+	union {
+		atomic_t	cnts;
+		struct {
+#ifdef __LITTLE_ENDIAN
+			u8	wmode;		/* Writer mode   */
+			u8	rcnts[3];	/* Reader counts */
+#else
+			u8	rcnts[3];	/* Reader counts */
+			u8	wmode;		/* Writer mode   */
+#endif
+		};
+	};
 	arch_spinlock_t		lock;
 } arch_rwlock_t;
 
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index 45fbb48f83f6..6ae1ae321897 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -27,26 +27,6 @@
 # define arch_qrwlock_relax(lock)	cpu_relax_lowlatency()
 #endif
 
-/*
- * This internal data structure is used for optimizing access to some of
- * the subfields within the atomic_t cnts.
- */
-struct __qrwlock {
-	union {
-		atomic_t cnts;
-		struct {
-#ifdef __LITTLE_ENDIAN
-			u8 wmode;	/* Writer mode   */
-			u8 rcnts[3];	/* Reader counts */
-#else
-			u8 rcnts[3];	/* Reader counts */
-			u8 wmode;	/* Writer mode   */
-#endif
-		};
-	};
-	arch_spinlock_t	lock;
-};
-
 /**
  * rspin_until_writer_unlock - spin until writer is gone
  * @lock  : Pointer to queue rwlock structure
@@ -138,10 +118,8 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 	 * or wait for a previous writer to go away.
 	 */
 	for (;;) {
-		struct __qrwlock *l = (struct __qrwlock *)lock;
-
-		if (!READ_ONCE(l->wmode) &&
-		   (cmpxchg_relaxed(&l->wmode, 0, _QW_WAITING) == 0))
+		if (!READ_ONCE(lock->wmode) &&
+		   (cmpxchg_relaxed(&lock->wmode, 0, _QW_WAITING) == 0))
 			break;
 
 		arch_qrwlock_relax(lock);
-- 
2.1.4
