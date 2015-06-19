From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v5 1/3] locking/qrwlock: Rename functions to queued_*()
Date: Fri, 19 Jun 2015 11:50:00 -0400
Message-ID: <1434729002-57724-2-git-send-email-Waiman.Long@hp.com>
References: <1434729002-57724-1-git-send-email-Waiman.Long@hp.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53]:60970 "EHLO
	g4t3425.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406AbbFSPvE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jun 2015 11:51:04 -0400
In-Reply-To: <1434729002-57724-1-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>, Waiman Long <Waiman.Long@hp.com>

To sync up with the naming convention used in qspinlock, all the
qrwlock functions were renamed to started with "queued" instead of
"queue".

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/x86/include/asm/qrwlock.h |    4 +-
 include/asm-generic/qrwlock.h  |   58 ++++++++++++++++++++--------------------
 kernel/locking/qrwlock.c       |   12 ++++----
 3 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/arch/x86/include/asm/qrwlock.h b/arch/x86/include/asm/qrwlock.h
index ae0e241..a8810bf 100644
--- a/arch/x86/include/asm/qrwlock.h
+++ b/arch/x86/include/asm/qrwlock.h
@@ -4,8 +4,8 @@
 #include <asm-generic/qrwlock_types.h>
 
 #ifndef CONFIG_X86_PPRO_FENCE
-#define queue_write_unlock queue_write_unlock
-static inline void queue_write_unlock(struct qrwlock *lock)
+#define queued_write_unlock queued_write_unlock
+static inline void queued_write_unlock(struct qrwlock *lock)
 {
         barrier();
         ACCESS_ONCE(*(u8 *)&lock->cnts) = 0;
diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 6383d54..55e3ee1 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -36,33 +36,33 @@
 /*
  * External function declarations
  */
-extern void queue_read_lock_slowpath(struct qrwlock *lock);
-extern void queue_write_lock_slowpath(struct qrwlock *lock);
+extern void queued_read_lock_slowpath(struct qrwlock *lock);
+extern void queued_write_lock_slowpath(struct qrwlock *lock);
 
 /**
- * queue_read_can_lock- would read_trylock() succeed?
+ * queued_read_can_lock- would read_trylock() succeed?
  * @lock: Pointer to queue rwlock structure
  */
-static inline int queue_read_can_lock(struct qrwlock *lock)
+static inline int queued_read_can_lock(struct qrwlock *lock)
 {
 	return !(atomic_read(&lock->cnts) & _QW_WMASK);
 }
 
 /**
- * queue_write_can_lock- would write_trylock() succeed?
+ * queued_write_can_lock- would write_trylock() succeed?
  * @lock: Pointer to queue rwlock structure
  */
-static inline int queue_write_can_lock(struct qrwlock *lock)
+static inline int queued_write_can_lock(struct qrwlock *lock)
 {
 	return !atomic_read(&lock->cnts);
 }
 
 /**
- * queue_read_trylock - try to acquire read lock of a queue rwlock
+ * queued_read_trylock - try to acquire read lock of a queue rwlock
  * @lock : Pointer to queue rwlock structure
  * Return: 1 if lock acquired, 0 if failed
  */
-static inline int queue_read_trylock(struct qrwlock *lock)
+static inline int queued_read_trylock(struct qrwlock *lock)
 {
 	u32 cnts;
 
@@ -77,11 +77,11 @@ static inline int queue_read_trylock(struct qrwlock *lock)
 }
 
 /**
- * queue_write_trylock - try to acquire write lock of a queue rwlock
+ * queued_write_trylock - try to acquire write lock of a queue rwlock
  * @lock : Pointer to queue rwlock structure
  * Return: 1 if lock acquired, 0 if failed
  */
-static inline int queue_write_trylock(struct qrwlock *lock)
+static inline int queued_write_trylock(struct qrwlock *lock)
 {
 	u32 cnts;
 
@@ -93,10 +93,10 @@ static inline int queue_write_trylock(struct qrwlock *lock)
 				     cnts, cnts | _QW_LOCKED) == cnts);
 }
 /**
- * queue_read_lock - acquire read lock of a queue rwlock
+ * queued_read_lock - acquire read lock of a queue rwlock
  * @lock: Pointer to queue rwlock structure
  */
-static inline void queue_read_lock(struct qrwlock *lock)
+static inline void queued_read_lock(struct qrwlock *lock)
 {
 	u32 cnts;
 
@@ -105,27 +105,27 @@ static inline void queue_read_lock(struct qrwlock *lock)
 		return;
 
 	/* The slowpath will decrement the reader count, if necessary. */
-	queue_read_lock_slowpath(lock);
+	queued_read_lock_slowpath(lock);
 }
 
 /**
- * queue_write_lock - acquire write lock of a queue rwlock
+ * queued_write_lock - acquire write lock of a queue rwlock
  * @lock : Pointer to queue rwlock structure
  */
-static inline void queue_write_lock(struct qrwlock *lock)
+static inline void queued_write_lock(struct qrwlock *lock)
 {
 	/* Optimize for the unfair lock case where the fair flag is 0. */
 	if (atomic_cmpxchg(&lock->cnts, 0, _QW_LOCKED) == 0)
 		return;
 
-	queue_write_lock_slowpath(lock);
+	queued_write_lock_slowpath(lock);
 }
 
 /**
- * queue_read_unlock - release read lock of a queue rwlock
+ * queued_read_unlock - release read lock of a queue rwlock
  * @lock : Pointer to queue rwlock structure
  */
-static inline void queue_read_unlock(struct qrwlock *lock)
+static inline void queued_read_unlock(struct qrwlock *lock)
 {
 	/*
 	 * Atomically decrement the reader count
@@ -134,12 +134,12 @@ static inline void queue_read_unlock(struct qrwlock *lock)
 	atomic_sub(_QR_BIAS, &lock->cnts);
 }
 
-#ifndef queue_write_unlock
+#ifndef queued_write_unlock
 /**
- * queue_write_unlock - release write lock of a queue rwlock
+ * queued_write_unlock - release write lock of a queue rwlock
  * @lock : Pointer to queue rwlock structure
  */
-static inline void queue_write_unlock(struct qrwlock *lock)
+static inline void queued_write_unlock(struct qrwlock *lock)
 {
 	/*
 	 * If the writer field is atomic, it can be cleared directly.
@@ -154,13 +154,13 @@ static inline void queue_write_unlock(struct qrwlock *lock)
  * Remapping rwlock architecture specific functions to the corresponding
  * queue rwlock functions.
  */
-#define arch_read_can_lock(l)	queue_read_can_lock(l)
-#define arch_write_can_lock(l)	queue_write_can_lock(l)
-#define arch_read_lock(l)	queue_read_lock(l)
-#define arch_write_lock(l)	queue_write_lock(l)
-#define arch_read_trylock(l)	queue_read_trylock(l)
-#define arch_write_trylock(l)	queue_write_trylock(l)
-#define arch_read_unlock(l)	queue_read_unlock(l)
-#define arch_write_unlock(l)	queue_write_unlock(l)
+#define arch_read_can_lock(l)	queued_read_can_lock(l)
+#define arch_write_can_lock(l)	queued_write_can_lock(l)
+#define arch_read_lock(l)	queued_read_lock(l)
+#define arch_write_lock(l)	queued_write_lock(l)
+#define arch_read_trylock(l)	queued_read_trylock(l)
+#define arch_write_trylock(l)	queued_write_trylock(l)
+#define arch_read_unlock(l)	queued_read_unlock(l)
+#define arch_write_unlock(l)	queued_write_unlock(l)
 
 #endif /* __ASM_GENERIC_QRWLOCK_H */
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index 00c12bb..9c2deed 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -40,10 +40,10 @@ rspin_until_writer_unlock(struct qrwlock *lock, u32 cnts)
 }
 
 /**
- * queue_read_lock_slowpath - acquire read lock of a queue rwlock
+ * queued_read_lock_slowpath - acquire read lock of a queue rwlock
  * @lock: Pointer to queue rwlock structure
  */
-void queue_read_lock_slowpath(struct qrwlock *lock)
+void queued_read_lock_slowpath(struct qrwlock *lock)
 {
 	u32 cnts;
 
@@ -84,13 +84,13 @@ void queue_read_lock_slowpath(struct qrwlock *lock)
 	 */
 	arch_spin_unlock(&lock->lock);
 }
-EXPORT_SYMBOL(queue_read_lock_slowpath);
+EXPORT_SYMBOL(queued_read_lock_slowpath);
 
 /**
- * queue_write_lock_slowpath - acquire write lock of a queue rwlock
+ * queued_write_lock_slowpath - acquire write lock of a queue rwlock
  * @lock : Pointer to queue rwlock structure
  */
-void queue_write_lock_slowpath(struct qrwlock *lock)
+void queued_write_lock_slowpath(struct qrwlock *lock)
 {
 	u32 cnts;
 
@@ -129,4 +129,4 @@ void queue_write_lock_slowpath(struct qrwlock *lock)
 unlock:
 	arch_spin_unlock(&lock->lock);
 }
-EXPORT_SYMBOL(queue_write_lock_slowpath);
+EXPORT_SYMBOL(queued_write_lock_slowpath);
-- 
1.7.1
