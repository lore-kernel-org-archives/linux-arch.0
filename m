From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v16 12/14] pvqspinlock: Only kick CPU at unlock time
Date: Fri, 24 Apr 2015 14:56:41 -0400
Message-ID: <1429901803-29771-13-git-send-email-Waiman.Long@hp.com>
References: <1429901803-29771-1-git-send-email-Waiman.Long@hp.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1429901803-29771-1-git-send-email-Waiman.Long@hp.com>
Sender: kvm-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Daniel J Blueman <daniel@numascale.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>, Waiman Long <Waiman.Long@hp.com>
List-Id: linux-arch.vger.kernel.org

Before this patch, a CPU may have been kicked twice before getting
the lock - one before it becomes queue head and once before it gets
the lock. All these CPU kicking and halting (VMEXIT) can be expensive
and slow down system performance, especially in an overcommitted guest.

This patch adds a new vCPU state (vcpu_hashed) which enables the code
to delay CPU kicking until at unlock time. Once this state is set,
the new lock holder will set _Q_SLOW_VAL and fill in the hash table
on behalf of the halted queue head vCPU.

It also adds a second synchronization point in __pv_queue_spin_unlock()
so as to do the pv_kick() only if it is really necessary.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 kernel/locking/qspinlock.c          |   10 ++--
 kernel/locking/qspinlock_paravirt.h |   76 +++++++++++++++++++++++++---------
 2 files changed, 61 insertions(+), 25 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index c009120..0a3a109 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -239,8 +239,8 @@ static __always_inline void set_locked(struct qspinlock *lock)
 
 static __always_inline void __pv_init_node(struct mcs_spinlock *node) { }
 static __always_inline void __pv_wait_node(struct mcs_spinlock *node) { }
-static __always_inline void __pv_kick_node(struct mcs_spinlock *node) { }
-
+static __always_inline void __pv_scan_next(struct qspinlock *lock,
+					   struct mcs_spinlock *node) { }
 static __always_inline void __pv_wait_head(struct qspinlock *lock,
 					   struct mcs_spinlock *node) { }
 
@@ -248,7 +248,7 @@ static __always_inline void __pv_wait_head(struct qspinlock *lock,
 
 #define pv_init_node		__pv_init_node
 #define pv_wait_node		__pv_wait_node
-#define pv_kick_node		__pv_kick_node
+#define pv_scan_next		__pv_scan_next
 #define pv_wait_head		__pv_wait_head
 
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
@@ -440,7 +440,7 @@ queue:
 		cpu_relax();
 
 	arch_mcs_spin_unlock_contended(&next->locked);
-	pv_kick_node(next);
+	pv_scan_next(lock, next);
 
 release:
 	/*
@@ -461,7 +461,7 @@ EXPORT_SYMBOL(queue_spin_lock_slowpath);
 
 #undef pv_init_node
 #undef pv_wait_node
-#undef pv_kick_node
+#undef pv_scan_next
 #undef pv_wait_head
 
 #undef  queue_spin_lock_slowpath
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 084e5c1..9b4ac3d 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -21,9 +21,16 @@
 
 #define _Q_SLOW_VAL	(3U << _Q_LOCKED_OFFSET)
 
+/*
+ * The vcpu_hashed is a special state that is set by the new lock holder on
+ * the new queue head to indicate that _Q_SLOW_VAL is set and hash entry
+ * filled. With this state, the queue head CPU will always be kicked even
+ * if it is not halted to avoid potential racing condition.
+ */
 enum vcpu_state {
 	vcpu_running = 0,
 	vcpu_halted,
+	vcpu_hashed
 };
 
 struct pv_node {
@@ -162,13 +169,13 @@ __visible void __pv_queue_spin_unlock(struct qspinlock *lock)
 	 * The queue head has been halted. Need to locate it and wake it up.
 	 */
 	node = pv_hash_find(lock);
-	smp_store_release(&l->locked, 0);
+	(void)xchg(&l->locked, 0);
 
 	/*
 	 * At this point the memory pointed at by lock can be freed/reused,
 	 * however we can still use the PV node to kick the CPU.
 	 */
-	if (READ_ONCE(node->state) == vcpu_halted)
+	if (READ_ONCE(node->state) != vcpu_running)
 		pv_kick(node->cpu);
 }
 /*
@@ -195,7 +202,8 @@ static void pv_init_node(struct mcs_spinlock *node)
 
 /*
  * Wait for node->locked to become true, halt the vcpu after a short spin.
- * pv_kick_node() is used to wake the vcpu again.
+ * pv_scan_next() is used to set _Q_SLOW_VAL and fill in hash table on its
+ * behalf.
  */
 static void pv_wait_node(struct mcs_spinlock *node)
 {
@@ -214,9 +222,9 @@ static void pv_wait_node(struct mcs_spinlock *node)
 		 *
 		 * [S] pn->state = vcpu_halted	  [S] next->locked = 1
 		 *     MB			      MB
-		 * [L] pn->locked		[RmW] pn->state = vcpu_running
+		 * [L] pn->locked		[RmW] pn->state = vcpu_hashed
 		 *
-		 * Matches the xchg() from pv_kick_node().
+		 * Matches the cmpxchg() from pv_scan_next().
 		 */
 		(void)xchg(&pn->state, vcpu_halted);
 
@@ -224,9 +232,9 @@ static void pv_wait_node(struct mcs_spinlock *node)
 			pv_wait(&pn->state, vcpu_halted);
 
 		/*
-		 * Reset the vCPU state to avoid unncessary CPU kicking
+		 * Reset the state except when vcpu_hashed is set.
 		 */
-		WRITE_ONCE(pn->state, vcpu_running);
+		(void)cmpxchg(&pn->state, vcpu_halted, vcpu_running);
 
 		/*
 		 * If the locked flag is still not set after wakeup, it is a
@@ -236,6 +244,7 @@ static void pv_wait_node(struct mcs_spinlock *node)
 		 * MCS lock will be released soon.
 		 */
 	}
+
 	/*
 	 * By now our node->locked should be 1 and our caller will not actually
 	 * spin-wait for it. We do however rely on our caller to do a
@@ -244,24 +253,30 @@ static void pv_wait_node(struct mcs_spinlock *node)
 }
 
 /*
- * Called after setting next->locked = 1, used to wake those stuck in
- * pv_wait_node().
+ * Called after setting next->locked = 1 & lock acquired.
+ * Check if the the CPU has been halted. If so, set the _Q_SLOW_VAL flag
+ * and put an entry into the lock hash table to be waken up at unlock time.
  */
-static void pv_kick_node(struct mcs_spinlock *node)
+static void pv_scan_next(struct qspinlock *lock, struct mcs_spinlock *node)
 {
 	struct pv_node *pn = (struct pv_node *)node;
+	struct __qspinlock *l = (void *)lock;
 
 	/*
-	 * Note that because node->locked is already set, this actual
-	 * mcs_spinlock entry could be re-used already.
-	 *
-	 * This should be fine however, kicking people for no reason is
-	 * harmless.
-	 *
-	 * See the comment in pv_wait_node().
+	 * Transition CPU state: halted => hashed
+	 * Quit if the transition failed.
+	 */
+	if (cmpxchg(&pn->state, vcpu_halted, vcpu_hashed) != vcpu_halted)
+		return;
+
+	/*
+	 * Put the lock into the hash table & set the _Q_SLOW_VAL in the lock.
+	 * As this is the same CPU that will check the _Q_SLOW_VAL value and
+	 * the hash table later on at unlock time, no atomic instruction is
+	 * needed.
 	 */
-	if (xchg(&pn->state, vcpu_running) == vcpu_halted)
-		pv_kick(pn->cpu);
+	WRITE_ONCE(l->locked, _Q_SLOW_VAL);
+	(void)pv_hash(lock, pn);
 }
 
 /*
@@ -281,7 +296,14 @@ static void pv_wait_head(struct qspinlock *lock, struct mcs_spinlock *node)
 		cpu_relax();
 	}
 
-	WRITE_ONCE(pn->state, vcpu_halted);
+	/*
+	 * Go directly to pv_wait() if it has already been in the hashed
+	 * state - _Q_SLOW_VAL set & hash table filled. This is to eliminate
+	 * possible race condition in hash table handling.
+	 */
+	if (cmpxchg(&pn->state, vcpu_running, vcpu_halted) == vcpu_hashed)
+		goto wait_now;
+
 	lp = pv_hash(lock, pn);
 	/*
 	 * lp must be set before setting _Q_SLOW_VAL
@@ -307,13 +329,27 @@ static void pv_wait_head(struct qspinlock *lock, struct mcs_spinlock *node)
 	 * So if the lock is still not free, it is a spurious wakeup and
 	 * so the vCPU should wait again after spinning for a while.
 	 */
+wait_now:
 	for (;;) {
 		pv_wait(&l->locked, _Q_SLOW_VAL);
+		WRITE_ONCE(pn->state, vcpu_running);
 		for (loop = SPIN_THRESHOLD; loop; loop--) {
 			if (!READ_ONCE(l->locked))
 				return;
 			cpu_relax();
 		}
+		(void)xchg(&pn->state, vcpu_halted);
+		/*
+		 * Use xchg as a memory barrier to make sure that the
+		 * vcpu_halted state is visible to others before calling
+		 * pv_wait().
+		 *
+		 * [S] state = vcpu_halted	[S] l->locked = 0
+		 *     MB			    MB
+		 * [L] l->locked		[L] state
+		 *
+		 * Match the xchg() in pv_queue_spin_unlock().
+		 */
 	}
 
 	/*
-- 
1.7.1

