From: Waiman Long <longman@redhat.com>
Subject: [PATCH v2 5/5] locking/qrwlock: Make qrwlock store writer cpu number
Date: Thu, 16 Jul 2020 15:29:27 -0400
Message-ID: <20200716192927.12944-6-longman@redhat.com>
References: <20200716192927.12944-1-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200716192927.12944-1-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, Waiman Long <longman@redhat.com>
List-Id: linux-arch.vger.kernel.org

Make the qrwlock code to store an encoded cpu number (+1 saturated)
for the writer that hold the write lock if desired.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/asm-generic/qrwlock.h | 12 +++++++++++-
 kernel/locking/qrwlock.c      | 11 ++++++-----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 3aefde23dcea..1b1d5253e314 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -15,11 +15,21 @@
 
 #include <asm-generic/qrwlock_types.h>
 
+/*
+ * If __cpu_number_sadd1 (+2 saturated cpu number) is defined, use it as the
+ * writer lock value.
+ */
+#ifdef __cpu_number_sadd1
+#define _QW_LOCKED	__cpu_number_sadd1
+#else
+#define _QW_LOCKED	0xff
+#endif
+
 /*
  * Writer states & reader shift and bias.
  */
 #define	_QW_WAITING	0x100		/* A writer is waiting	   */
-#define	_QW_LOCKED	0x0ff		/* A writer holds the lock */
+#define	_QW_LMASK	0x0ff		/* A writer lock byte mask */
 #define	_QW_WMASK	0x1ff		/* Writer mask		   */
 #define	_QR_SHIFT	9		/* Reader count shift	   */
 #define _QR_BIAS	(1U << _QR_SHIFT)
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index fe9ca92faa2a..394f34db4b8f 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -30,7 +30,7 @@ void queued_read_lock_slowpath(struct qrwlock *lock)
 		 * so spin with ACQUIRE semantics until the lock is available
 		 * without waiting in the queue.
 		 */
-		atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
+		atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LMASK));
 		return;
 	}
 	atomic_sub(_QR_BIAS, &lock->cnts);
@@ -46,7 +46,7 @@ void queued_read_lock_slowpath(struct qrwlock *lock)
 	 * that accesses can't leak upwards out of our subsequent critical
 	 * section in the case that the lock is currently held for write.
 	 */
-	atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
+	atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LMASK));
 
 	/*
 	 * Signal the next one in queue to become queue head
@@ -61,12 +61,14 @@ EXPORT_SYMBOL(queued_read_lock_slowpath);
  */
 void queued_write_lock_slowpath(struct qrwlock *lock)
 {
+	const u8 lockval = _QW_LOCKED;
+
 	/* Put the writer into the wait queue */
 	arch_spin_lock(&lock->wait_lock);
 
 	/* Try to acquire the lock directly if no reader is present */
 	if (!atomic_read(&lock->cnts) &&
-	    (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0))
+	    (atomic_cmpxchg_acquire(&lock->cnts, 0, lockval) == 0))
 		goto unlock;
 
 	/* Set the waiting flag to notify readers that a writer is pending */
@@ -75,8 +77,7 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 	/* When no more readers or writers, set the locked flag */
 	do {
 		atomic_cond_read_acquire(&lock->cnts, VAL == _QW_WAITING);
-	} while (atomic_cmpxchg_relaxed(&lock->cnts, _QW_WAITING,
-					_QW_LOCKED) != _QW_WAITING);
+	} while (atomic_cmpxchg_relaxed(&lock->cnts, _QW_WAITING, lockval) != _QW_WAITING);
 unlock:
 	arch_spin_unlock(&lock->wait_lock);
 }
-- 
2.18.1
