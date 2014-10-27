From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v12 09/11] pvqspinlock,
	x86: Add para-virtualization support
Date: Mon, 27 Oct 2014 13:15:53 -0400
Message-ID: <544E7DC9.5020903@hp.com>
References: <1413483040-58399-1-git-send-email-Waiman.Long@hp.com>
	<1413483040-58399-10-git-send-email-Waiman.Long@hp.com>
	<20141024084738.GU21513@worktop.programming.kicks-ass.net>
	<544ABC47.2000700@hp.com>
	<20141024220423.GB10501@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141024220423.GB10501@worktop.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

On 10/24/2014 06:04 PM, Peter Zijlstra wrote:
> On Fri, Oct 24, 2014 at 04:53:27PM -0400, Waiman Long wrote:
>> The additional register pressure may just cause a few more register moves
>> which should be negligible in the overall performance . The additional
>> icache pressure, however, may have some impact on performance. I was trying
>> to balance the performance of the pv and non-pv versions so that we won't
>> penalize the pv code too much for a bit more performance in the non-pv code.
>> Doing it your way will add a lot of function call and register
>> saving/restoring to the pv code.
> If people care about performance they should not be using virt crap :-)
>
> I only really care about bare metal.

Yes, I am aware of that. However, the whole point of doing PV spinlock 
is to improve performance in a virtual guest.

Anyway, I had done some measurements. In my test system, the 
queue_spin_lock_slowpath() function has a text size of about 400 bytes 
without PV, but 1120 bytes with PV. I made some changes to create 
separate versions of PV and non-PV slowpath functions as shown by the 
diff below. The text size is now about 430 bytes for the non-PV version 
and 925 bytes for the PV version. The overall object size increases by a 
bit more than 200 bytes, but the icache footprint should be reduced no 
matter which version is used.

-Longman

----------------------------------------

diff --git a/arch/x86/include/asm/pvqspinlock.h 
b/arch/x86/include/asm/pvqspinlo
index d424252..241bf30 100644
--- a/arch/x86/include/asm/pvqspinlock.h
+++ b/arch/x86/include/asm/pvqspinlock.h
@@ -79,9 +79,6 @@ static inline void pv_init_node(struct mcs_spinlock *node)

         BUILD_BUG_ON(sizeof(struct pv_qnode) > 5*sizeof(struct 
mcs_spinlock));

-       if (!pv_enabled())
-               return;
-
         pn->cpustate = PV_CPU_ACTIVE;
         pn->mayhalt  = false;
         pn->mycpu    = smp_processor_id();
@@ -132,9 +129,6 @@ static inline bool pv_link_and_wait_node(u32 old, 
struct mcs
         struct pv_qnode *ppn, *pn = (struct pv_qnode *)node;
         unsigned int count;

-       if (!pv_enabled())
-               return false;
-
         if (!(old & _Q_TAIL_MASK)) {
                 node->locked = true;    /* At queue head now */
                 goto ret;
@@ -236,9 +230,6 @@ pv_wait_head(struct qspinlock *lock, struct 
mcs_spinlock *no
  {
         struct pv_qnode *pn = (struct pv_qnode *)node;

-       if (!pv_enabled())
-               return smp_load_acquire(&lock->val.counter);
-
         for (;;) {
                 unsigned int count;
                 s8 oldstate;
@@ -328,8 +319,6 @@ static inline void pv_wait_check(struct qspinlock *lock,
         struct pv_qnode *pnxt = (struct pv_qnode *)next;
         struct pv_qnode *pcur = (struct pv_qnode *)node;

-       if (!pv_enabled())
-               return;
         /*
          * Clear the locked and head values of lock holder
          */
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 1662dbd..05aea57 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -16,6 +16,7 @@
   * Authors: Waiman Long <waiman.long@hp.com>
   *          Peter Zijlstra <pzijlstr@redhat.com>
   */
+#ifndef _GEN_PV_LOCK_SLOWPATH
  #include <linux/smp.h>
  #include <linux/bug.h>
  #include <linux/cpumask.h>
@@ -271,19 +272,37 @@ void queue_spin_unlock_slowpath(struct qspinlock 
*lock)
  }
  EXPORT_SYMBOL(queue_spin_unlock_slowpath);

-#else
+static void pv_queue_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+
+#else  /* CONFIG_PARAVIRT_SPINLOCKS */
+
+static inline void pv_queue_spin_lock_slowpath(struct qspinlock *lock, 
u32 val)
+       { }

-static inline void pv_init_node(struct mcs_spinlock *node)     { }
-static inline void pv_wait_check(struct qspinlock *lock,
-                                struct mcs_spinlock *node,
-                                struct mcs_spinlock *next)     { }
-static inline bool pv_link_and_wait_node(u32 old, struct mcs_spinlock 
*node)
+#endif /* CONFIG_PARAVIRT_SPINLOCKS */
+
+/*
+ * Dummy PV functions for bare-metal slowpath code
+ */
+static inline void nopv_init_node(struct mcs_spinlock *node)   { }
+static inline void nopv_wait_check(struct qspinlock *lock,
+                                  struct mcs_spinlock *node,
+                                  struct mcs_spinlock *next)   { }
+static inline bool nopv_link_and_wait_node(u32 old, struct mcs_spinlock 
*node)
                    { return false; }
-static inline int  pv_wait_head(struct qspinlock *lock,
+static inline int  nopv_wait_head(struct qspinlock *lock,
                                 struct mcs_spinlock *node)
                    { return smp_load_acquire(&lock->val.counter); }
+static inline bool return_true(void)   { return true;  }
+static inline bool return_false(void)  { return false; }

-#endif /* CONFIG_PARAVIRT_SPINLOCKS */
+#define pv_init_node           nopv_init_node
+#define pv_wait_check          nopv_wait_check
+#define pv_link_and_wait_node  nopv_link_and_wait_node
+#define pv_wait_head           nopv_wait_head
+#define in_pv_code             return_false
+
+#endif /* _GEN_PV_LOCK_SLOWPATH */

  /**
   * queue_spin_lock_slowpath - acquire the queue spinlock
@@ -306,7 +325,11 @@ static inline int  pv_wait_head(struct qspinlock *lock,
   * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
   *   queue               :         ^--'                             :
   */
+#ifdef _GEN_PV_LOCK_SLOWPATH
+static void pv_queue_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+#else
  void queue_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+#endif
  {
         struct mcs_spinlock *prev, *next, *node;
         u32 new, old, tail;
@@ -314,7 +337,12 @@ void queue_spin_lock_slowpath(struct qspinlock 
*lock, u32 v

         BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));

-       if (pv_enabled())
+       if (pv_enabled()) {
+               pv_queue_spin_lock_slowpath(lock, val);
+               return;
+       }
+
+       if (in_pv_code())
                 goto queue;

         if (virt_queue_spin_lock(lock))
@@ -474,3 +502,23 @@ release:
         this_cpu_dec(mcs_nodes[0].count);
  }
  EXPORT_SYMBOL(queue_spin_lock_slowpath);
+
+#if !defined(_GEN_PV_LOCK_SLOWPATH) && defined(CONFIG_PARAVIRT_SPINLOCKS)
+/*
+ * Generate the PV version of the queue_spin_lock_slowpath function
+ */
+#undef pv_init_node
+#undef pv_wait_check
+#undef pv_link_and_wait_node
+#undef pv_wait_head
+#undef EXPORT_SYMBOL
+#undef in_pv_code
+
+#define _GEN_PV_LOCK_SLOWPATH
+#define EXPORT_SYMBOL(x)
+#define in_pv_code     return_true
+#define pv_enabled     return_false
+
+#include "qspinlock.c"
+
+#endif
