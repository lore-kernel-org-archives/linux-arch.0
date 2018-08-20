From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] locking: Remove an insn from spin and write locks
Date: Mon, 20 Aug 2018 08:06:52 -0700
Message-ID: <20180820150652.29482-1-willy@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Matthew Wilcox <willy@infradead.org>
List-Id: linux-arch.vger.kernel.org

Both spin locks and write locks currently do:

 f0 0f b1 17             lock cmpxchg %edx,(%rdi)
 85 c0                   test   %eax,%eax
 75 05                   jne    [slowpath]

This 'test' insn is superfluous; the cmpxchg insn sets the Z flag
appropriately.  Peter pointed out that using atomic_try_cmpxchg()
will let the compiler know this is true.  Comparing before/after
disassemblies show the only effect is to remove this insn.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/asm-generic/qrwlock.h   | 6 +++---
 include/asm-generic/qspinlock.h | 9 +++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 0f7062bd55e5..9a1beb7ad0de 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -71,8 +71,7 @@ static inline int queued_write_trylock(struct qrwlock *lock)
 	if (unlikely(cnts))
 		return 0;
 
-	return likely(atomic_cmpxchg_acquire(&lock->cnts,
-					     cnts, cnts | _QW_LOCKED) == cnts);
+	return likely(atomic_try_cmpxchg(&lock->cnts, &cnts, _QW_LOCKED));
 }
 /**
  * queued_read_lock - acquire read lock of a queue rwlock
@@ -96,8 +95,9 @@ static inline void queued_read_lock(struct qrwlock *lock)
  */
 static inline void queued_write_lock(struct qrwlock *lock)
 {
+	u32 cnts = 0;
 	/* Optimize for the unfair lock case where the fair flag is 0. */
-	if (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0)
+	if (atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED))
 		return;
 
 	queued_write_lock_slowpath(lock);
diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index 95263e943fcc..d125f0c0b3d9 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -68,8 +68,10 @@ int queued_spin_is_contended(const struct qspinlock *lock)
  */
 static __always_inline int queued_spin_trylock(struct qspinlock *lock)
 {
+	u32 val = 0;
+
 	if (!atomic_read(&lock->val) &&
-	   (atomic_cmpxchg_acquire(&lock->val, 0, _Q_LOCKED_VAL) == 0))
+	    (atomic_try_cmpxchg(&lock->val, &val, _Q_LOCKED_VAL)))
 		return 1;
 	return 0;
 }
@@ -82,10 +84,9 @@ extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
  */
 static __always_inline void queued_spin_lock(struct qspinlock *lock)
 {
-	u32 val;
+	u32 val = 0;
 
-	val = atomic_cmpxchg_acquire(&lock->val, 0, _Q_LOCKED_VAL);
-	if (likely(val == 0))
+	if (likely(atomic_try_cmpxchg(&lock->val, &val, _Q_LOCKED_VAL)))
 		return;
 	queued_spin_lock_slowpath(lock, val);
 }
-- 
2.18.0
