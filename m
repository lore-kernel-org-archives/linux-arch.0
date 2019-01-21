From: Waiman Long <longman@redhat.com>
Subject: [PATCH 5/5] locking/qspinlock: Add some locking debug code
Date: Sun, 20 Jan 2019 21:49:54 -0500
Message-ID: <1548038994-30073-6-git-send-email-longman@redhat.com>
References: <1548038994-30073-1-git-send-email-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548038994-30073-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>, James Morse <james.morse@arm.com>, SRINIVAS <srinivas.eeda@oracle.com>, Waiman Long <longman@redhat.com>
List-Id: linux-arch.vger.kernel.org

Add some optionally enabled debug code to check if more than one CPU
that enter the lock critical section simultaneously.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 8163633..7671dfc 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -97,6 +97,18 @@ struct qnode {
 };
 
 /*
+ * Define _Q_DEBUG_LOCK to verify if no more than one cpu can enter
+ * the lock critical section at the same time.
+ */
+// #define _Q_DEBUG_LOCK
+
+#ifdef _Q_DEBUG_LOCK
+#define _Q_DEBUG_WARN_ON(c)	WARN_ON_ONCE(c)
+#else
+#define _Q_DEBUG_WARN_ON(c)
+#endif
+
+/*
  * The pending bit spinning loop count.
  * This heuristic is used to limit the number of lockword accesses
  * made by atomic_cond_read_relaxed when waiting for the lock to
@@ -184,7 +196,13 @@ static __always_inline void clear_pending(struct qspinlock *lock)
  */
 static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
 {
+#ifdef _Q_DEBUG_LOCK
+	u16 old = xchg_relaxed(&lock->locked_pending, _Q_LOCKED_VAL);
+
+	WARN_ON_ONCE((old & _Q_LOCKED_VAL) || !(old & _Q_PENDING_VAL));
+#else
 	WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
+#endif
 }
 
 /*
@@ -284,7 +302,13 @@ static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lo
  */
 static __always_inline void set_locked(struct qspinlock *lock)
 {
+#ifdef _O_DEBUG_LOCK
+	u8 old = xchg_relaxed(&lock->locked, _Q_LOCKED_VAL);
+
+	WARN_ON_ONCE(old);
+#else
 	WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
+#endif
 }
 
 /**
@@ -683,6 +707,9 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if ((val & _Q_TAIL_MASK) == tail) {
 		u32 new = _Q_LOCKED_VAL | (val & _Q_WAIT_PEND_MASK);
 
+		_Q_DEBUG_WARN_ON((val & _Q_WAIT_PEND_MASK) &&
+				 (val & _Q_WAIT_PEND_MASK) != _Q_WAIT_PEND_VAL);
+
 		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, new))
 			goto release; /* No contention */
 	}
-- 
1.8.3.1
