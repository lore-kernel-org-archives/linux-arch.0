From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/sched/membarrier 3/5] membarrier: Document scheduler barrier requirements
Date: Fri, 13 Oct 2017 09:12:23 -0700
Message-ID: <1507911145-4134-3-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171012170051.GA27468@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171012170051.GA27468@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, ahh@google.com, maged.michael@gmail.com, gromer@google.com, avi@scylladb.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, davejwatson@fb.com, stern@rowland.harvard.edu, will.deacon@arm.com, luto@kernel.org, viro@zeniv.linux.org.uk, piggin@gmail.com, linux-arch@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrea Parri <parri.andrea@gmail.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Document the membarrier requirement on having a full memory barrier in
__schedule() after coming from user-space, before storing to rq->curr.
It is provided by smp_mb__after_spinlock() in __schedule().

Document that membarrier requires a full barrier on transition from
kernel thread to userspace thread. We currently have an implicit barrier
from atomic_dec_and_test() in mmdrop() that ensures this.

The x86 switch_mm_irqs_off() full barrier is currently provided by many
cpumask update operations as well as write_cr3(). Document that
write_cr3() provides this barrier.

Changes since v1:
- Update comments to match reality for code paths which are after
  storing to rq->curr, before returning to user-space, based on feedback
  from Andrea Parri.
Changes since v2:
- Update changelog (smp_mb__before_spinlock -> smp_mb__after_spinlock).
  Based on feedback from Andrea Parri.
Changes since v3:
- Clarify comments following feeback from Peter Zijlstra.
Changes since v4:
- Update comment regarding powerpc barrier.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Andrew Hunter <ahh@google.com>
CC: Maged Michael <maged.michael@gmail.com>
CC: gromer@google.com
CC: Avi Kivity <avi@scylladb.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Dave Watson <davejwatson@fb.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Andrea Parri <parri.andrea@gmail.com>
CC: x86@kernel.org
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 arch/x86/mm/tlb.c        |  5 +++++
 include/linux/sched/mm.h |  5 +++++
 kernel/sched/core.c      | 37 ++++++++++++++++++++++++++-----------
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 49d9778376d7..38f6cbd8cd80 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -143,6 +143,11 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	}
 #endif
 
+	/*
+	 * The membarrier system call requires a full memory barrier
+	 * before returning to user-space, after storing to rq->curr.
+	 * Writing to CR3 provides that full memory barrier.
+	 */
 	if (real_prev == next) {
 		VM_BUG_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
 			  next->context.ctx_id);
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 1b9c39f3d1e3..e4955d293687 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -38,6 +38,11 @@ static inline void mmgrab(struct mm_struct *mm)
 extern void __mmdrop(struct mm_struct *);
 static inline void mmdrop(struct mm_struct *mm)
 {
+	/*
+	 * The implicit full barrier implied by atomic_dec_and_test is
+	 * required by the membarrier system call before returning to
+	 * user-space, after storing to rq->curr.
+	 */
 	if (unlikely(atomic_dec_and_test(&mm->mm_count)))
 		__mmdrop(mm);
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f29525e453c4..8a176892b4f0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2648,6 +2648,12 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	finish_arch_post_lock_switch();
 
 	fire_sched_in_preempt_notifiers(current);
+	/*
+	 * When transitioning from a kernel thread to a userspace
+	 * thread, mmdrop()'s implicit full barrier is required by the
+	 * membarrier system call, because the current active_mm can
+	 * become the current mm without going through switch_mm().
+	 */
 	if (mm)
 		mmdrop(mm);
 	if (unlikely(prev_state == TASK_DEAD)) {
@@ -2753,6 +2759,13 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	 */
 	arch_start_context_switch(prev);
 
+	/*
+	 * If mm is non-NULL, we pass through switch_mm(). If mm is
+	 * NULL, we will pass through mmdrop() in finish_task_switch().
+	 * Both of these contain the full memory barrier required by
+	 * membarrier after storing to rq->curr, before returning to
+	 * user-space.
+	 */
 	if (!mm) {
 		next->active_mm = oldmm;
 		mmgrab(oldmm);
@@ -3289,6 +3302,9 @@ static void __sched notrace __schedule(bool preempt)
 	 * Make sure that signal_pending_state()->signal_pending() below
 	 * can't be reordered with __set_current_state(TASK_INTERRUPTIBLE)
 	 * done by the caller to avoid the race with signal_wake_up().
+	 *
+	 * The membarrier system call requires a full memory barrier
+	 * after coming from user-space, before storing to rq->curr.
 	 */
 	rq_lock(rq, &rf);
 	smp_mb__after_spinlock();
@@ -3336,17 +3352,16 @@ static void __sched notrace __schedule(bool preempt)
 		/*
 		 * The membarrier system call requires each architecture
 		 * to have a full memory barrier after updating
-		 * rq->curr, before returning to user-space. For TSO
-		 * (e.g. x86), the architecture must provide its own
-		 * barrier in switch_mm(). For weakly ordered machines
-		 * for which spin_unlock() acts as a full memory
-		 * barrier, finish_lock_switch() in common code takes
-		 * care of this barrier. For weakly ordered machines for
-		 * which spin_unlock() acts as a RELEASE barrier (only
-		 * arm64 and PowerPC), arm64 has a full barrier in
-		 * switch_to(), and PowerPC has
-		 * smp_mb__after_unlock_lock() before
-		 * finish_lock_switch().
+		 * rq->curr, before returning to user-space.
+		 *
+		 * Here are the schemes providing that barrier on the
+		 * various architectures:
+		 * - mm ? switch_mm() : mmdrop() for x86, s390, sparc, PowerPC.
+		 *   switch_mm() rely on membarrier_arch_switch_mm() on PowerPC.
+		 * - finish_lock_switch() for weakly-ordered
+		 *   architectures where spin_unlock is a full barrier,
+		 * - switch_to() for arm64 (weakly-ordered, spin_unlock
+		 *   is a RELEASE barrier),
 		 */
 		++*switch_count;
 
-- 
2.5.2
