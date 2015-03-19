From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 8/9] qspinlock: Generic paravirt support
Date: Thu, 19 Mar 2015 11:12:42 +0100
Message-ID: <20150319101242.GM21418@twins.programming.kicks-ass.net>
References: <20150316131613.720617163@infradead.org>
 <20150316133112.278511476@infradead.org>
 <5509E51D.7040909@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:60018 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbbCSKM4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Mar 2015 06:12:56 -0400
Content-Disposition: inline
In-Reply-To: <5509E51D.7040909@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, paolo.bonzini@gmail.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net

On Wed, Mar 18, 2015 at 04:50:37PM -0400, Waiman Long wrote:
> >+		this_cpu_write(__pv_lock_wait, lock);
> 
> We may run into the same problem of needing to have 4 queue nodes per CPU.
> If an interrupt happens just after the write and before the actual wait and
> it goes through the same sequence, it will overwrite the __pv_lock_wait[]
> entry. So we may have lost wakeup. That is why the pvticket lock code did
> that just before the actual wait with interrupt disabled. We probably
> couldn't disable interrupt here. So we may need to move the actual write to
> the KVM and Xen code if we keep the current logic.

Hmm indeed. So I didn't actually mean to keep this code, but yes I
missed that.

> >+	/*
> >+	 * At this point the memory pointed at by lock can be freed/reused,
> >+	 * however we can still use the pointer value to search in our cpu
> >+	 * array.
> >+	 *
> >+	 * XXX: get rid of this loop
> >+	 */
> >+	for_each_possible_cpu(cpu) {
> >+		if (per_cpu(__pv_lock_wait, cpu) == lock)
> >+			pv_kick(cpu);
> >+	}
> >+}
> 
> I do want to get rid of this loop too. On average, we have to scan about
> half the number of CPUs available. So it isn't that different
> performance-wise compared with my original idea of following the list from
> tail to head. And how about your idea of propagating the current head down
> the linked list?

Yeah, so I was half done with that patch when I fell asleep on the
flight home. Didn't get around to 'fixing' it. It applies and builds but
doesn't actually work.

_However_ I'm not sure I actually like it much.

The problem I have with it are these wait loops, they can generate the
same problem we're trying to avoid.

So I was now thinking of hashing the lock pointer; let me go and quickly
put something together.

---
 kernel/locking/qspinlock.c          |    8 +-
 kernel/locking/qspinlock_paravirt.h |  124 ++++++++++++++++++++++++++++--------
 2 files changed, 101 insertions(+), 31 deletions(-)

--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -246,10 +246,10 @@ static __always_inline void set_locked(s
  */
 
 static __always_inline void __pv_init_node(struct mcs_spinlock *node) { }
-static __always_inline void __pv_wait_node(struct mcs_spinlock *node) { }
+static __always_inline void __pv_wait_node(u32 old, struct mcs_spinlock *node) { }
 static __always_inline void __pv_kick_node(struct mcs_spinlock *node) { }
 
-static __always_inline void __pv_wait_head(struct qspinlock *lock) { }
+static __always_inline void __pv_wait_head(struct qspinlock *lock, struct mcs_spinlock *node) { }
 
 #define pv_enabled()           false
 
@@ -399,7 +399,7 @@ void queue_spin_lock_slowpath(struct qsp
                prev = decode_tail(old);
                WRITE_ONCE(prev->next, node);
 
-               pv_wait_node(node);
+               pv_wait_node(old, node);
                arch_mcs_spin_lock_contended(&node->locked);
        }
 
@@ -414,7 +414,7 @@ void queue_spin_lock_slowpath(struct qsp
         * sequentiality; this is because the set_locked() function below
         * does not imply a full barrier.
         */
-       pv_wait_head(lock);
+       pv_wait_head(lock, node);
        while ((val = smp_load_acquire(&lock->val.counter)) & _Q_LOCKED_PENDING_MASK)
                cpu_relax();
 
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -29,8 +29,14 @@ struct pv_node {
 
        int                     cpu;
        u8                      state;
+       struct pv_node          *head;
 };
 
+static inline struct pv_node *pv_decode_tail(u32 tail)
+{
+       return (struct pv_node *)decode_tail(tail);
+}
+
 /*
  * Initialize the PV part of the mcs_spinlock node.
  */
@@ -42,17 +48,49 @@ static void pv_init_node(struct mcs_spin
 
        pn->cpu = smp_processor_id();
        pn->state = vcpu_running;
+       pn->head = NULL;
+}
+
+static void pv_propagate_head(struct pv_node *pn, struct pv_node *ppn)
+{
+       /*
+        * When we race against the first waiter or ourselves we have to wait
+        * until the previous link updates its head pointer before we can
+        * propagate it.
+        */
+       while (!READ_ONCE(ppn->head)) {
+               /*
+                * queue_spin_lock_slowpath could have been waiting for the
+                * node->next store above before setting node->locked.
+                */
+               if (ppn->mcs.locked)
+                       return;
+
+               cpu_relax();
+       }
+       /*
+        * If we interleave such that the store from pv_set_head() happens
+        * between our load and store we could have over-written the new head
+        * value.
+        *
+        * Therefore use cmpxchg to only propagate the old head value if our
+        * head value is unmodified.
+        */
+       (void)cmpxchg(&pn->head, NULL, READ_ONCE(ppn->head));
 }
 
 /*
  * Wait for node->locked to become true, halt the vcpu after a short spin.
  * pv_kick_node() is used to wake the vcpu again.
  */
-static void pv_wait_node(struct mcs_spinlock *node)
+static void pv_wait_node(u32 old, struct mcs_spinlock *node)
 {
+       struct pv_node *ppn = pv_decode_tail(old);
        struct pv_node *pn = (struct pv_node *)node;
        int loop;
 
+       pv_propagate_head(pn, ppn);
+
        for (;;) {
                for (loop = SPIN_THRESHOLD; loop; loop--) {
                        if (READ_ONCE(node->locked))
@@ -107,13 +145,33 @@ static void pv_kick_node(struct mcs_spin
                pv_kick(pn->cpu);
 }
 
-static DEFINE_PER_CPU(struct qspinlock *, __pv_lock_wait);
+static void pv_set_head(struct qspinlock *lock, struct pv_node *head)
+{
+       struct pv_node *tail, *new_tail;
+
+       new_tail = pv_decode_tail(atomic_read(&lock->val));
+       do {
+               tail = new_tail;
+               while (!READ_ONCE(tail->head))
+                       cpu_relax();
+
+               (void)xchg(&tail->head, head);
+               /*
+                * pv_set_head()                pv_wait_node()
+                *
+                * [S] tail->head, head         [S] lock->tail
+                *     MB                           MB
+                * [L] lock->tail               [L] tail->head
+                */
+               new_tail = pv_decode_tail(atomic_read(&lock->val));
+       } while (tail != new_tail);
+}
 
 /*
  * Wait for l->locked to become clear; halt the vcpu after a short spin.
  * __pv_queue_spin_unlock() will wake us.
  */
-static void pv_wait_head(struct qspinlock *lock)
+static void pv_wait_head(struct qspinlock *lock, struct mcs_spinlock *node)
 {
        struct __qspinlock *l = (void *)lock;
        int loop;
@@ -121,28 +179,24 @@ static void pv_wait_head(struct qspinloc
        for (;;) {
                for (loop = SPIN_THRESHOLD; loop; loop--) {
                        if (!READ_ONCE(l->locked))
-                               goto done;
+                               return;
 
                        cpu_relax();
                }
 
-               this_cpu_write(__pv_lock_wait, lock);
+               pv_set_head(lock, (struct pv_node *)node);
                /*
-                * __pv_lock_wait must be set before setting _Q_SLOW_VAL
-                *
-                * [S] __pv_lock_wait = lock    [RmW] l = l->locked = 0
-                *     MB                             MB
-                * [S] l->locked = _Q_SLOW_VAL  [L]   __pv_lock_wait
+                * The head must be set before we set _Q_SLOW_VAL such that
+                * when pv_queue_spin_unlock() observes _Q_SLOW_VAL it must
+                * also observe the head pointer.
                 *
-                * Matches the xchg() in pv_queue_spin_unlock().
+                * We rely on the implied MB from the below cmpxchg()
                 */
                if (!cmpxchg(&l->locked, _Q_LOCKED_VAL, _Q_SLOW_VAL))
-                       goto done;
+                       return;
 
                pv_wait(&l->locked, _Q_SLOW_VAL);
        }
-done:
-       this_cpu_write(__pv_lock_wait, NULL);
 
        /*
         * Lock is unlocked now; the caller will acquire it without waiting.
@@ -157,21 +211,37 @@ static void pv_wait_head(struct qspinloc
  */
 void __pv_queue_spin_unlock(struct qspinlock *lock)
 {
-       struct __qspinlock *l = (void *)lock;
-       int cpu;
+       u32 old, val = atomic_read(&lock->val);
+       struct pv_node *pn = NULL;
 
-       if (xchg(&l->locked, 0) != _Q_SLOW_VAL)
-               return;
+       for (;;) {
+               if (val & _Q_SLOW_VAL) {
+                       /*
+                        * If we observe _Q_SLOW_VAL we must also observe
+                        * pn->head; see pv_wait_head();
+                        */
+                       smp_rmb();
+                       pn = pv_decode_tail(val);
+                       while (!READ_ONCE(pn->head))
+                               cpu_relax();
+                       pn = READ_ONCE(pn->head);
+               }
+               /*
+                * The cmpxchg() ensures the above loads are complete before
+                * we release the lock.
+                */
+               old = atomic_cmpxchg(&lock->val, val, val & _Q_TAIL_MASK);
+               if (old == val)
+                       break;
+
+               val = old;
+       }
 
        /*
-        * At this point the memory pointed at by lock can be freed/reused,
-        * however we can still use the pointer value to search in our cpu
-        * array.
-        *
-        * XXX: get rid of this loop
+        * We've freed the lock so the lock storage can be gone; however since
+        * the pv_node structure is static storage we can safely use that
+        * still.
         */
-       for_each_possible_cpu(cpu) {
-               if (per_cpu(__pv_lock_wait, cpu) == lock)
-                       pv_kick(cpu);
-       }
+       if (pn)
+               pv_kick(pn->cpu);
 }
