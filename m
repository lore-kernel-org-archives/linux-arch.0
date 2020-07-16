From: Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/5] locking/pvqspinlock: Make pvqsinlock code easier to read
Date: Thu, 16 Jul 2020 15:29:24 -0400
Message-ID: <20200716192927.12944-3-longman@redhat.com>
References: <20200716192927.12944-1-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200716192927.12944-1-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, Waiman Long <longman@redhat.com>
List-Id: linux-arch.vger.kernel.org

The way that pv_wait_head_or_lock() gets invoked and the dummy oring
of _Q_LOCKED_VAL to its returned value is a bit hard to read. Use
the available pv_enabled() helper function to make the PV and native
paths more explicit and easier to read. It can eliminate the dummy
oring of the return value. There is no functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock.c          | 12 ++++--------
 kernel/locking/qspinlock_paravirt.h |  6 ++----
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index b9515fcc9b29..b256e2d03817 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -501,16 +501,12 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * been designated yet, there is no way for the locked value to become
 	 * _Q_SLOW_VAL. So both the set_locked() and the
 	 * atomic_cmpxchg_relaxed() calls will be safe.
-	 *
-	 * If PV isn't active, 0 will be returned instead.
-	 *
 	 */
-	if ((val = pv_wait_head_or_lock(lock, node)))
-		goto locked;
-
-	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
+	if (pv_enabled())
+		val = pv_wait_head_or_lock(lock, node);
+	else
+		val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
 
-locked:
 	/*
 	 * claim the lock:
 	 *
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index e84d21aa0722..17878e531f51 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -477,12 +477,10 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 
 	/*
 	 * The cmpxchg() or xchg() call before coming here provides the
-	 * acquire semantics for locking. The dummy ORing of _Q_LOCKED_VAL
-	 * here is to indicate to the compiler that the value will always
-	 * be nozero to enable better code optimization.
+	 * acquire semantics for locking.
 	 */
 gotlock:
-	return (u32)(atomic_read(&lock->val) | _Q_LOCKED_VAL);
+	return (u32)atomic_read(&lock->val);
 }
 
 /*
-- 
2.18.1
