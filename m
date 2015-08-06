From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v5 6/8] locking/qrwlock: make use of acquire/release/relaxed atomics
Date: Thu,  6 Aug 2015 17:54:42 +0100
Message-ID: <1438880084-18856-7-git-send-email-will.deacon@arm.com>
References: <1438880084-18856-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438880084-18856-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Waiman.Long@hp.com, peterz@infradead.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, mingo@kernel.org, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

The qrwlock implementation is slightly heavy in its use of memory
barriers, mainly through the use of cmpxchg and _return atomics, which
imply full barrier semantics.

This patch modifies the qrwlock code to use the more relaxed atomic
routines so that we can reduce the unnecessary barrier overhead on
weakly-ordered architectures.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/qrwlock.h | 13 ++++++-------
 kernel/locking/qrwlock.c      | 22 ++++++++++++++--------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index eb673dde8879..54a8e65e18b6 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -68,7 +68,7 @@ static inline int queued_read_trylock(struct qrwlock *lock)
 
 	cnts = atomic_read(&lock->cnts);
 	if (likely(!(cnts & _QW_WMASK))) {
-		cnts = (u32)atomic_add_return(_QR_BIAS, &lock->cnts);
+		cnts = (u32)atomic_add_return_acquire(_QR_BIAS, &lock->cnts);
 		if (likely(!(cnts & _QW_WMASK)))
 			return 1;
 		atomic_sub(_QR_BIAS, &lock->cnts);
@@ -89,8 +89,8 @@ static inline int queued_write_trylock(struct qrwlock *lock)
 	if (unlikely(cnts))
 		return 0;
 
-	return likely(atomic_cmpxchg(&lock->cnts,
-				     cnts, cnts | _QW_LOCKED) == cnts);
+	return likely(atomic_cmpxchg_acquire(&lock->cnts,
+					     cnts, cnts | _QW_LOCKED) == cnts);
 }
 /**
  * queued_read_lock - acquire read lock of a queue rwlock
@@ -100,7 +100,7 @@ static inline void queued_read_lock(struct qrwlock *lock)
 {
 	u32 cnts;
 
-	cnts = atomic_add_return(_QR_BIAS, &lock->cnts);
+	cnts = atomic_add_return_acquire(_QR_BIAS, &lock->cnts);
 	if (likely(!(cnts & _QW_WMASK)))
 		return;
 
@@ -115,7 +115,7 @@ static inline void queued_read_lock(struct qrwlock *lock)
 static inline void queued_write_lock(struct qrwlock *lock)
 {
 	/* Optimize for the unfair lock case where the fair flag is 0. */
-	if (atomic_cmpxchg(&lock->cnts, 0, _QW_LOCKED) == 0)
+	if (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0)
 		return;
 
 	queued_write_lock_slowpath(lock);
@@ -130,8 +130,7 @@ static inline void queued_read_unlock(struct qrwlock *lock)
 	/*
 	 * Atomically decrement the reader count
 	 */
-	smp_mb__before_atomic();
-	atomic_sub(_QR_BIAS, &lock->cnts);
+	(void)atomic_sub_return_release(_QR_BIAS, &lock->cnts);
 }
 
 /**
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index d9c36c5f5711..1724eac4c84b 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -55,7 +55,7 @@ rspin_until_writer_unlock(struct qrwlock *lock, u32 cnts)
 {
 	while ((cnts & _QW_WMASK) == _QW_LOCKED) {
 		cpu_relax_lowlatency();
-		cnts = smp_load_acquire((u32 *)&lock->cnts);
+		cnts = atomic_read_acquire(&lock->cnts);
 	}
 }
 
@@ -74,8 +74,9 @@ void queued_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
 		 * Readers in interrupt context will get the lock immediately
 		 * if the writer is just waiting (not holding the lock yet).
 		 * The rspin_until_writer_unlock() function returns immediately
-		 * in this case. Otherwise, they will spin until the lock
-		 * is available without waiting in the queue.
+		 * in this case. Otherwise, they will spin (with ACQUIRE
+		 * semantics) until the lock is available without waiting in
+		 * the queue.
 		 */
 		rspin_until_writer_unlock(lock, cnts);
 		return;
@@ -97,7 +98,12 @@ void queued_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
 	while (atomic_read(&lock->cnts) & _QW_WMASK)
 		cpu_relax_lowlatency();
 
-	cnts = atomic_add_return(_QR_BIAS, &lock->cnts) - _QR_BIAS;
+	/*
+	 * The ACQUIRE semantics of the following spinning code ensure
+	 * that accesses can't leak upwards out of our subsequent critical
+	 * section in the case that the lock is currently held for write.
+	 */
+	cnts = atomic_add_return_acquire(_QR_BIAS, &lock->cnts) - _QR_BIAS;
 	rspin_until_writer_unlock(lock, cnts);
 
 	/*
@@ -120,7 +126,7 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 
 	/* Try to acquire the lock directly if no reader is present */
 	if (!atomic_read(&lock->cnts) &&
-	    (atomic_cmpxchg(&lock->cnts, 0, _QW_LOCKED) == 0))
+	    (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0))
 		goto unlock;
 
 	/*
@@ -131,7 +137,7 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 		struct __qrwlock *l = (struct __qrwlock *)lock;
 
 		if (!READ_ONCE(l->wmode) &&
-		   (cmpxchg(&l->wmode, 0, _QW_WAITING) == 0))
+		   (cmpxchg_relaxed(&l->wmode, 0, _QW_WAITING) == 0))
 			break;
 
 		cpu_relax_lowlatency();
@@ -141,8 +147,8 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 	for (;;) {
 		cnts = atomic_read(&lock->cnts);
 		if ((cnts == _QW_WAITING) &&
-		    (atomic_cmpxchg(&lock->cnts, _QW_WAITING,
-				    _QW_LOCKED) == _QW_WAITING))
+		    (atomic_cmpxchg_acquire(&lock->cnts, _QW_WAITING,
+					    _QW_LOCKED) == _QW_WAITING))
 			break;
 
 		cpu_relax_lowlatency();
-- 
2.1.4
