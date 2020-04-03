From: Alex Kogan <alex.kogan@oracle.com>
Subject: [PATCH v10 1/5] locking/qspinlock: Rename mcs lock/unlock macros and make them more generic
Date: Fri,  3 Apr 2020 16:59:26 -0400
Message-ID: <20200403205930.1707-2-alex.kogan@oracle.com>
References: <20200403205930.1707-1-alex.kogan@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200403205930.1707-1-alex.kogan@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com
List-Id: linux-arch.vger.kernel.org

The mcs unlock macro (arch_mcs_lock_handoff) should accept the value to be
stored into the lock argument as another argument. This allows using the
same macro in cases where the value to be stored when passing the lock is
different from 1.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 arch/arm/include/asm/mcs_spinlock.h |  6 +++---
 include/asm-generic/mcs_spinlock.h  |  4 ++--
 kernel/locking/mcs_spinlock.h       | 18 +++++++++---------
 kernel/locking/qspinlock.c          |  4 ++--
 kernel/locking/qspinlock_paravirt.h |  2 +-
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/mcs_spinlock.h b/arch/arm/include/asm/mcs_spinlock.h
index 529d2cf4d06f..1eb4d733459c 100644
--- a/arch/arm/include/asm/mcs_spinlock.h
+++ b/arch/arm/include/asm/mcs_spinlock.h
@@ -6,7 +6,7 @@
 #include <asm/spinlock.h>
 
 /* MCS spin-locking. */
-#define arch_mcs_spin_lock_contended(lock)				\
+#define arch_mcs_spin_wait(lock)					\
 do {									\
 	/* Ensure prior stores are observed before we enter wfe. */	\
 	smp_mb();							\
@@ -14,9 +14,9 @@ do {									\
 		wfe();							\
 } while (0)								\
 
-#define arch_mcs_spin_unlock_contended(lock)				\
+#define arch_mcs_lock_handoff(lock, val)				\
 do {									\
-	smp_store_release(lock, 1);					\
+	smp_store_release((lock), (val));				\
 	dsb_sev();							\
 } while (0)
 
diff --git a/include/asm-generic/mcs_spinlock.h b/include/asm-generic/mcs_spinlock.h
index 10cd4ffc6ba2..f933d99c63e0 100644
--- a/include/asm-generic/mcs_spinlock.h
+++ b/include/asm-generic/mcs_spinlock.h
@@ -4,8 +4,8 @@
 /*
  * Architectures can define their own:
  *
- *   arch_mcs_spin_lock_contended(l)
- *   arch_mcs_spin_unlock_contended(l)
+ *   arch_mcs_spin_wait(l)
+ *   arch_mcs_lock_handoff(l, val)
  *
  * See kernel/locking/mcs_spinlock.c.
  */
diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index 5e10153b4d3c..904ba5d0f3f4 100644
--- a/kernel/locking/mcs_spinlock.h
+++ b/kernel/locking/mcs_spinlock.h
@@ -21,7 +21,7 @@ struct mcs_spinlock {
 	int count;  /* nesting count, see qspinlock.c */
 };
 
-#ifndef arch_mcs_spin_lock_contended
+#ifndef arch_mcs_spin_wait
 /*
  * Using smp_cond_load_acquire() provides the acquire semantics
  * required so that subsequent operations happen after the
@@ -29,20 +29,20 @@ struct mcs_spinlock {
  * ARM64 would like to do spin-waiting instead of purely
  * spinning, and smp_cond_load_acquire() provides that behavior.
  */
-#define arch_mcs_spin_lock_contended(l)					\
-do {									\
-	smp_cond_load_acquire(l, VAL);					\
+#define arch_mcs_spin_wait(l)					\
+do {								\
+	smp_cond_load_acquire(l, VAL);				\
 } while (0)
 #endif
 
-#ifndef arch_mcs_spin_unlock_contended
+#ifndef arch_mcs_lock_handoff
 /*
  * smp_store_release() provides a memory barrier to ensure all
  * operations in the critical section has been completed before
  * unlocking.
  */
-#define arch_mcs_spin_unlock_contended(l)				\
-	smp_store_release((l), 1)
+#define arch_mcs_lock_handoff(l, val)				\
+	smp_store_release((l), (val))
 #endif
 
 /*
@@ -91,7 +91,7 @@ void mcs_spin_lock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
 	WRITE_ONCE(prev->next, node);
 
 	/* Wait until the lock holder passes the lock down. */
-	arch_mcs_spin_lock_contended(&node->locked);
+	arch_mcs_spin_wait(&node->locked);
 }
 
 /*
@@ -115,7 +115,7 @@ void mcs_spin_unlock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
 	}
 
 	/* Pass lock to next waiter. */
-	arch_mcs_spin_unlock_contended(&next->locked);
+	arch_mcs_lock_handoff(&next->locked, 1);
 }
 
 #endif /* __LINUX_MCS_SPINLOCK_H */
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index b9515fcc9b29..ac1dedbe0237 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -471,7 +471,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 		WRITE_ONCE(prev->next, node);
 
 		pv_wait_node(node, prev);
-		arch_mcs_spin_lock_contended(&node->locked);
+		arch_mcs_spin_wait(&node->locked);
 
 		/*
 		 * While waiting for the MCS lock, the next pointer may have
@@ -550,7 +550,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if (!next)
 		next = smp_cond_load_relaxed(&node->next, (VAL));
 
-	arch_mcs_spin_unlock_contended(&next->locked);
+	arch_mcs_lock_handoff(&next->locked, 1);
 	pv_kick_node(lock, next);
 
 release:
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index e84d21aa0722..619d80fd5ea8 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -368,7 +368,7 @@ static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 	 *
 	 * Matches with smp_store_mb() and cmpxchg() in pv_wait_node()
 	 *
-	 * The write to next->locked in arch_mcs_spin_unlock_contended()
+	 * The write to next->locked in arch_mcs_lock_handoff()
 	 * must be ordered before the read of pn->state in the cmpxchg()
 	 * below for the code to work correctly. To guarantee full ordering
 	 * irrespective of the success or failure of the cmpxchg(),
-- 
2.21.1 (Apple Git-122.3)
