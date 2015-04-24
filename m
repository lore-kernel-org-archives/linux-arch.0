From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v16 13/14] pvqspinlock: Improve slowpath performance by avoiding cmpxchg
Date: Fri, 24 Apr 2015 14:56:42 -0400
Message-ID: <1429901803-29771-14-git-send-email-Waiman.Long@hp.com>
References: <1429901803-29771-1-git-send-email-Waiman.Long@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429901803-29771-1-git-send-email-Waiman.Long@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Daniel J Blueman <daniel@numascale.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>, Waiman Long <Waiman.Long@hp.com>
List-Id: linux-arch.vger.kernel.org

In the pv_scan_next() function, the slow cmpxchg atomic operation is
performed even if the other CPU is not even close to being halted. This
extra cmpxchg can harm slowpath performance.

This patch introduces the new mayhalt flag to indicate if the other
spinning CPU is close to being halted or not. The current threshold
for x86 is 2k cpu_relax() calls. If this flag is not set, the other
spinning CPU will have at least 2k more cpu_relax() calls before
it can enter the halt state. This should give enough time for the
setting of the locked flag in struct mcs_spinlock to propagate to
that CPU without using atomic op.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 kernel/locking/qspinlock_paravirt.h |   28 +++++++++++++++++++++++++---
 1 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 9b4ac3d..41ee033 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -19,7 +19,8 @@
  * native_queue_spin_unlock().
  */
 
-#define _Q_SLOW_VAL	(3U << _Q_LOCKED_OFFSET)
+#define _Q_SLOW_VAL		(3U << _Q_LOCKED_OFFSET)
+#define MAYHALT_THRESHOLD	(SPIN_THRESHOLD >> 4)
 
 /*
  * The vcpu_hashed is a special state that is set by the new lock holder on
@@ -39,6 +40,7 @@ struct pv_node {
 
 	int			cpu;
 	u8			state;
+	u8			mayhalt;
 };
 
 /*
@@ -198,6 +200,7 @@ static void pv_init_node(struct mcs_spinlock *node)
 
 	pn->cpu = smp_processor_id();
 	pn->state = vcpu_running;
+	pn->mayhalt = false;
 }
 
 /*
@@ -214,23 +217,34 @@ static void pv_wait_node(struct mcs_spinlock *node)
 		for (loop = SPIN_THRESHOLD; loop; loop--) {
 			if (READ_ONCE(node->locked))
 				return;
+			if (loop == MAYHALT_THRESHOLD)
+				xchg(&pn->mayhalt, true);
 			cpu_relax();
 		}
 
 		/*
-		 * Order pn->state vs pn->locked thusly:
+		 * Order pn->state/pn->mayhalt vs pn->locked thusly:
 		 *
-		 * [S] pn->state = vcpu_halted	  [S] next->locked = 1
+		 * [S] pn->mayhalt = 1            [S] next->locked = 1
+		 *     MB, delay                      barrier()
+		 * [S] pn->state = vcpu_halted    [L] pn->mayhalt
 		 *     MB			      MB
 		 * [L] pn->locked		[RmW] pn->state = vcpu_hashed
 		 *
 		 * Matches the cmpxchg() from pv_scan_next().
+		 *
+		 * As the new lock holder may quit (when pn->mayhalt is not
+		 * set) without memory barrier, a sufficiently long delay is
+		 * inserted between the setting of pn->mayhalt and pn->state
+		 * to ensure that there is enough time for the new pn->locked
+		 * value to be propagated here to be checked below.
 		 */
 		(void)xchg(&pn->state, vcpu_halted);
 
 		if (!READ_ONCE(node->locked))
 			pv_wait(&pn->state, vcpu_halted);
 
+		pn->mayhalt = false;
 		/*
 		 * Reset the state except when vcpu_hashed is set.
 		 */
@@ -263,6 +277,14 @@ static void pv_scan_next(struct qspinlock *lock, struct mcs_spinlock *node)
 	struct __qspinlock *l = (void *)lock;
 
 	/*
+	 * If mayhalt is not set, there is enough time for the just set value
+	 * in pn->locked to be propagated to the other CPU before it is time
+	 * to halt.
+	 */
+	if (!READ_ONCE(pn->mayhalt))
+		return;
+
+	/*
 	 * Transition CPU state: halted => hashed
 	 * Quit if the transition failed.
 	 */
-- 
1.7.1
