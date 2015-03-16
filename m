Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45166 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754300AbbCPNgG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 Mar 2015 09:36:06 -0400
Message-ID: <20150316133112.153706749@infradead.org>
Date: Mon, 16 Mar 2015 14:16:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 6/9] qspinlock: Use a simple write to grab the lock
References: <20150316131613.720617163@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=waiman_long-qspinlock-use_a_simple_write_to_grab_the_lock.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman.Long@hp.com
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, paolo.bonzini@gmail.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net
Message-ID: <20150316131619.0C4egIOcD-O6dPbhpqU1dxZqWVztNM4lSivioZDiTyc@z>

From: Waiman Long <Waiman.Long@hp.com>

Currently, atomic_cmpxchg() is used to get the lock. However, this
is not really necessary if there is more than one task in the queue
and the queue head don't need to reset the tail code. For that case,
a simple write to set the lock bit is enough as the queue head will
be the only one eligible to get the lock as long as it checks that
both the lock and pending bits are not set. The current pending bit
waiting code will ensure that the bit will not be set as soon as the
tail code in the lock is set.

With that change, the are some slight improvement in the performance
of the queue spinlock in the 5M loop micro-benchmark run on a 4-socket
Westere-EX machine as shown in the tables below.

		[Standalone/Embedded - same node]
  # of tasks	Before patch	After patch	%Change
  ----------	-----------	----------	-------
       3	 2324/2321	2248/2265	 -3%/-2%
       4	 2890/2896	2819/2831	 -2%/-2%
       5	 3611/3595	3522/3512	 -2%/-2%
       6	 4281/4276	4173/4160	 -3%/-3%
       7	 5018/5001	4875/4861	 -3%/-3%
       8	 5759/5750	5563/5568	 -3%/-3%

		[Standalone/Embedded - different nodes]
  # of tasks	Before patch	After patch	%Change
  ----------	-----------	----------	-------
       3	12242/12237	12087/12093	 -1%/-1%
       4	10688/10696	10507/10521	 -2%/-2%

It was also found that this change produced a much bigger performance
improvement in the newer IvyBridge-EX chip and was essentially to close
the performance gap between the ticket spinlock and queue spinlock.

The disk workload of the AIM7 benchmark was run on a 4-socket
Westmere-EX machine with both ext4 and xfs RAM disks at 3000 users
on a 3.14 based kernel. The results of the test runs were:

                AIM7 XFS Disk Test
  kernel                 JPM    Real Time   Sys Time    Usr Time
  -----                  ---    ---------   --------    --------
  ticketlock            5678233    3.17       96.61       5.81
  qspinlock             5750799    3.13       94.83       5.97

                AIM7 EXT4 Disk Test
  kernel                 JPM    Real Time   Sys Time    Usr Time
  -----                  ---    ---------   --------    --------
  ticketlock            1114551   16.15      509.72       7.11
  qspinlock             2184466    8.24      232.99       6.01

The ext4 filesystem run had a much higher spinlock contention than
the xfs filesystem run.

The "ebizzy -m" test was also run with the following results:

  kernel               records/s  Real Time   Sys Time    Usr Time
  -----                ---------  ---------   --------    --------
  ticketlock             2075       10.00      216.35       3.49
  qspinlock              3023       10.00      198.20       4.80

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Scott J Norton <scott.norton@hp.com>
Cc: Paolo Bonzini <paolo.bonzini@gmail.com>
Cc: Douglas Hatch <doug.hatch@hp.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Waiman Long <Waiman.Long@hp.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1421784755-21945-7-git-send-email-Waiman.Long@hp.com
---
 kernel/locking/qspinlock.c |   61 +++++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 16 deletions(-)

--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -105,24 +105,33 @@ static inline struct mcs_spinlock *decod
  * By using the whole 2nd least significant byte for the pending bit, we
  * can allow better optimization of the lock acquisition for the pending
  * bit holder.
+ *
+ * This internal structure is also used by the set_locked function which
+ * is not restricted to _Q_PENDING_BITS == 8.
  */
-#if _Q_PENDING_BITS == 8
-
 struct __qspinlock {
 	union {
 		atomic_t val;
-		struct {
 #ifdef __LITTLE_ENDIAN
+		u8	 locked;
+		struct {
 			u16	locked_pending;
 			u16	tail;
+		};
 #else
+		struct {
 			u16	tail;
 			u16	locked_pending;
-#endif
 		};
+		struct {
+			u8	reserved[3];
+			u8	locked;
+		};
+#endif
 	};
 };
 
+#if _Q_PENDING_BITS == 8
 /**
  * clear_pending_set_locked - take ownership and clear the pending bit.
  * @lock: Pointer to queue spinlock structure
@@ -209,6 +218,19 @@ static __always_inline u32 xchg_tail(str
 #endif /* _Q_PENDING_BITS == 8 */
 
 /**
+ * set_locked - Set the lock bit and own the lock
+ * @lock: Pointer to queue spinlock structure
+ *
+ * *,*,0 -> *,0,1
+ */
+static __always_inline void set_locked(struct qspinlock *lock)
+{
+	struct __qspinlock *l = (void *)lock;
+
+	WRITE_ONCE(l->locked, _Q_LOCKED_VAL);
+}
+
+/**
  * queue_spin_lock_slowpath - acquire the queue spinlock
  * @lock: Pointer to queue spinlock structure
  * @val: Current value of the queue spinlock 32-bit word
@@ -343,8 +365,13 @@ void queue_spin_lock_slowpath(struct qsp
 	 * go away.
 	 *
 	 * *,x,y -> *,0,0
+	 *
+	 * this wait loop must use a load-acquire such that we match the
+	 * store-release that clears the locked bit and create lock
+	 * sequentiality; this is because the set_locked() function below
+	 * does not imply a full barrier.
 	 */
-	while ((val = atomic_read(&lock->val)) & _Q_LOCKED_PENDING_MASK)
+	while ((val = smp_load_acquire(&lock->val.counter)) & _Q_LOCKED_PENDING_MASK)
 		cpu_relax();
 
 	/*
@@ -352,15 +379,19 @@ void queue_spin_lock_slowpath(struct qsp
 	 *
 	 * n,0,0 -> 0,0,1 : lock, uncontended
 	 * *,0,0 -> *,0,1 : lock, contended
+	 *
+	 * If the queue head is the only one in the queue (lock value == tail),
+	 * clear the tail code and grab the lock. Otherwise, we only need
+	 * to grab the lock.
 	 */
 	for (;;) {
-		new = _Q_LOCKED_VAL;
-		if (val != tail)
-			new |= val;
-
-		old = atomic_cmpxchg(&lock->val, val, new);
-		if (old == val)
+		if (val != tail) {
+			set_locked(lock);
 			break;
+		}
+		old = atomic_cmpxchg(&lock->val, val, _Q_LOCKED_VAL);
+		if (old == val)
+			goto release;	/* No contention */
 
 		val = old;
 	}
@@ -368,12 +399,10 @@ void queue_spin_lock_slowpath(struct qsp
 	/*
 	 * contended path; wait for next, release.
 	 */
-	if (new != _Q_LOCKED_VAL) {
-		while (!(next = READ_ONCE(node->next)))
-			cpu_relax();
+	while (!(next = READ_ONCE(node->next)))
+		cpu_relax();
 
-		arch_mcs_spin_unlock_contended(&next->locked);
-	}
+	arch_mcs_spin_unlock_contended(&next->locked);
 
 release:
 	/*


