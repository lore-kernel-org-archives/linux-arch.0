From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v15 13/15] pvqspinlock: Only kick CPU at unlock
	time
Date: Mon,  6 Apr 2015 22:55:48 -0400
Message-ID: <1428375350-9213-14-git-send-email-Waiman.Long@hp.com>
References: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, Waiman Long <Waiman.Long@hp.com>, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Daniel J Blueman <daniel@numascale.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Scott J Norton <scott.norton@hp.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

Before this patch, a CPU may have been kicked twice before getting
the lock - one before it becomes queue head and once before it gets
the lock. All these CPU kicking and halting (VMEXIT) can be expensive
and slow down system performance, especially in an overcommitted guest.

This patch add a new vCPU state (vcpu_hashed) which enables the code
to delay CPU kicking until at unlock time. Once this state is set,
the new lock holder will set _Q_SLOW_VAL and fill in the hash table
on behalf of the halted queue head vCPU.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 kernel/locking/qspinlock.c          |   10 ++--
 kernel/locking/qspinlock_paravirt.h |   76 +++++++++++++++++++++++++----------
 2 files changed, 59 insertions(+), 27 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 33b3f54..b9ba83b 100644
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
 
@@ -441,7 +441,7 @@ queue:
 		cpu_relax();
 
 	arch_mcs_spin_unlock_contended(&next->locked);
-	pv_kick_node(next);
+	pv_scan_next(lock, next);
 
 release:
 	/*
@@ -462,7 +462,7 @@ EXPORT_SYMBOL(queue_spin_lock_slowpath);
 
 #undef pv_init_node
 #undef pv_wait_node
-#undef pv_kick_node
+#undef pv_scan_next
 #undef pv_wait_head
 
 #undef  queue_spin_lock_slowpath
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 49dbd39..a210061 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -18,9 +18,16 @@
 
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
@@ -97,7 +104,13 @@ static inline u32 hash_align(u32 hash)
 	return hash & ~(PV_HB_PER_LINE - 1);
 }
 
-static struct qspinlock **pv_hash(struct qspinlock *lock, struct pv_node *node)
+/*
+ * Set up an entry in the lock hash table
+ * This is not inlined to reduce size of generated code as it is included
+ * twice and is used only in the slowest path of handling CPU halting.
+ */
+static noinline struct qspinlock **
+pv_hash(struct qspinlock *lock, struct pv_node *node)
 {
 	unsigned long init_hash, hash = hash_ptr(lock, pv_lock_hash_bits);
 	struct pv_hash_bucket *hb, *end;
@@ -178,7 +191,8 @@ static void pv_init_node(struct mcs_spinlock *node)
 
 /*
  * Wait for node->locked to become true, halt the vcpu after a short spin.
- * pv_kick_node() is used to wake the vcpu again.
+ * pv_scan_next() is used to set _Q_SLOW_VAL and fill in hash table on its
+ * behalf.
  */
 static void pv_wait_node(struct mcs_spinlock *node)
 {
@@ -189,7 +203,6 @@ static void pv_wait_node(struct mcs_spinlock *node)
 		for (loop = SPIN_THRESHOLD; loop; loop--) {
 			if (READ_ONCE(node->locked))
 				return;
-
 			cpu_relax();
 		}
 
@@ -198,17 +211,21 @@ static void pv_wait_node(struct mcs_spinlock *node)
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
 
 		if (!READ_ONCE(node->locked))
 			pv_wait(&pn->state, vcpu_halted);
 
-		/* Make sure that state is correct for spurious wakeup */
-		WRITE_ONCE(pn->state, vcpu_running);
+		/*
+		 * Reset the state except when vcpu_hashed is set. At this
+		 * state, node->locked should have been set already and it
+		 * needs to move on to pv_wait_head().
+		 */
+		(void)cmpxchg(&pn->state, vcpu_halted, vcpu_running);
 	}
 
 	/*
@@ -219,24 +236,30 @@ static void pv_wait_node(struct mcs_spinlock *node)
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
 	 */
-	if (xchg(&pn->state, vcpu_running) == vcpu_halted)
-		pv_kick(pn->cpu);
+	if (cmpxchg(&pn->state, vcpu_halted, vcpu_hashed) != vcpu_halted)
+		return;
+
+	/*
+	 * Put the lock into the hash table & set the _Q_SLOW_VAL in the lock.
+	 * As this is the same CPU that will check the _Q_SLOW_VAL value and
+	 * the hash table later on at unlock time, no atomic instruction is
+	 * needed.
+	 */
+	WRITE_ONCE(l->locked, _Q_SLOW_VAL);
+	(void)pv_hash(lock, pn);
 }
 
 /*
@@ -259,7 +282,16 @@ static void pv_wait_head(struct qspinlock *lock, struct mcs_spinlock *node)
 			cpu_relax();
 		}
 
-		WRITE_ONCE(pn->state, vcpu_halted);
+		/*
+		 * Go directly to pv_wait() if it has already been in the
+		 * hashed state - _Q_SLOW_VAL set & hash table filled.
+		 * This is to eliminate possible race condition of not
+		 * properly clearing the hash table entry.
+		 */
+		if (cmpxchg(&pn->state, vcpu_running, vcpu_halted)
+			    == vcpu_hashed)
+			goto wait_now;
+
 		if (!lp)
 			lp = pv_hash(lock, pn);
 		/*
@@ -283,7 +315,7 @@ static void pv_wait_head(struct qspinlock *lock, struct mcs_spinlock *node)
 		} else if (slow_set && !READ_ONCE(l->locked))
 			return;
 		slow_set = true;
-
+wait_now:
 		pv_wait(&l->locked, _Q_SLOW_VAL);
 	}
 	/*
@@ -315,7 +347,7 @@ __visible void __pv_queue_spin_unlock(struct qspinlock *lock)
 	 * At this point the memory pointed at by lock can be freed/reused,
 	 * however we can still use the PV node to kick the CPU.
 	 */
-	if (READ_ONCE(node->state) == vcpu_halted)
+	if (READ_ONCE(node->state) != vcpu_running)
 		pv_kick(node->cpu);
 }
 PV_CALLEE_SAVE_REGS_THUNK(__pv_queue_spin_unlock);
-- 
1.7.1
