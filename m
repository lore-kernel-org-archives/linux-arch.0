From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 8/9] qspinlock: Generic paravirt support
Date: Thu, 2 Apr 2015 21:48:34 +0200
Message-ID: <20150402194834.GF32047@worktop.ger.corp.intel.com>
References: <551C1ACE.4090408@hp.com>
 <20150401171223.GO23123@twins.programming.kicks-ass.net>
 <20150401174239.GO24151@twins.programming.kicks-ass.net>
 <20150401181744.GE32047@worktop.ger.corp.intel.com>
 <551C3EF5.6090809@hp.com>
 <20150401184858.GA9791@dyad.arnhem.chello.nl>
 <551C4E02.8030806@hp.com>
 <20150401210317.GZ27490@worktop.programming.kicks-ass.net>
 <551D6E2E.1080801@hp.com>
 <20150402172057.GA27490@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:39060 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817AbbDBTsp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Apr 2015 15:48:45 -0400
Content-Disposition: inline
In-Reply-To: <20150402172057.GA27490@worktop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, paolo.bonzini@gmail.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net

On Thu, Apr 02, 2015 at 07:20:57PM +0200, Peter Zijlstra wrote:
> pv_wait_head():
> 
> 	pv_hash()
> 	/* MB as per cmpxchg */
> 	cmpxchg(&l->locked, _Q_LOCKED_VAL, _Q_SLOW_VAL);
> 
> VS
> 
> __pv_queue_spin_unlock():
> 
> 	if (xchg(&l->locked, 0) != _Q_SLOW_VAL)
> 		return;
> 
> 	/* MB as per xchg */
> 	pv_hash_find(lock);
> 
> 


Something like so.. compile tested only.

I took out the LFSR because that was likely over engineering from my
side :-)

--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -2,6 +2,8 @@
 #error "do not include this file"
 #endif
 
+#include <linux/hash.h>
+
 /*
  * Implement paravirt qspinlocks; the general idea is to halt the vcpus instead
  * of spinning them.
@@ -107,7 +109,84 @@ static void pv_kick_node(struct mcs_spin
 		pv_kick(pn->cpu);
 }
 
-static DEFINE_PER_CPU(struct qspinlock *, __pv_lock_wait);
+/*
+ * Hash table using open addressing with an linear probe sequence.
+ *
+ * Since we should not be holding locks from NMI context (very rare indeed) the
+ * max load factor is 0.75, which is around the point where open adressing
+ * breaks down.
+ *
+ * Instead of probing just the immediate bucket we probe all buckets in the
+ * same cacheline.
+ *
+ * http://en.wikipedia.org/wiki/Hash_table#Open_addressing
+ *
+ */
+
+struct pv_hash_bucket {
+	struct qspinlock *lock;
+	int cpu;
+};
+
+/*
+ * XXX dynamic allocate using nr_cpu_ids instead...
+ */
+#define PV_LOCK_HASH_BITS	(2 + NR_CPUS_BITS)
+
+#if PV_LOCK_HASH_BITS < 6
+#undef PV_LOCK_HASH_BITS
+#define PB_LOCK_HASH_BITS	6
+#endif
+
+#define PV_LOCK_HASH_SIZE	(1 << PV_LOCK_HASH_BITS)
+
+static struct pv_hash_bucket __pv_lock_hash[PV_LOCK_HASH_SIZE] ____cacheline_aligned;
+
+#define PV_HB_PER_LINE		(SMP_CACHE_BYTES / sizeof(struct pv_hash_bucket))
+
+static inline u32 hash_align(u32 hash)
+{
+	return hash & ~(PV_HB_PER_LINE - 1);
+}
+
+#define for_each_hash_bucket(hb, off, hash)					\
+	for (hash = hash_align(hash), off = 0, hb = &__pv_lock_hash[hash + off];\
+	    off < PV_LOCK_HASH_SIZE;						\
+	    off++, hb = &__pv_lock_hash[(hash + off) % PV_LOCK_HASH_SIZE])
+
+static struct pv_hash_bucket *pv_hash_insert(struct qspinlock *lock)
+{
+	u32 offset, hash = hash_ptr(lock, PV_LOCK_HASH_BITS);
+	struct pv_hash_bucket *hb;
+
+	for_each_hash_bucket(hb, offset, hash) {
+		if (!cmpxchg(&hb->lock, NULL, lock)) {
+			WRITE_ONCE(hb->cpu, smp_processor_id());
+			return hb;
+		}
+	}
+
+	/*
+	 * Hard assumes there is an empty bucket somewhere.
+	 */
+	BUG();
+}
+
+static struct pv_hash_bucket *pv_hash_find(struct qspinlock *lock)
+{
+	u32 offset, hash = hash_ptr(lock, PV_LOCK_HASH_BITS);
+	struct pv_hash_bucket *hb;
+
+	for_each_hash_bucket(hb, offset, hash) {
+		if (READ_ONCE(hb->lock) == lock)
+			return hb;
+	}
+
+	/*
+	 * Hard assumes we _WILL_ find a match.
+	 */
+	BUG();
+}
 
 /*
  * Wait for l->locked to become clear; halt the vcpu after a short spin.
@@ -116,7 +195,9 @@ static DEFINE_PER_CPU(struct qspinlock *
 static void pv_wait_head(struct qspinlock *lock)
 {
 	struct __qspinlock *l = (void *)lock;
+	struct pv_hash_bucket *hb = NULL;
 	int loop;
+	u8 o;
 
 	for (;;) {
 		for (loop = SPIN_THRESHOLD; loop; loop--) {
@@ -126,29 +207,47 @@ static void pv_wait_head(struct qspinloc
 			cpu_relax();
 		}
 
-		this_cpu_write(__pv_lock_wait, lock);
-		/*
-		 * __pv_lock_wait must be set before setting _Q_SLOW_VAL
-		 *
-		 * [S] __pv_lock_wait = lock    [RmW] l = l->locked = 0
-		 *     MB                             MB
-		 * [S] l->locked = _Q_SLOW_VAL  [L]   __pv_lock_wait
-		 *
-		 * Matches the xchg() in pv_queue_spin_unlock().
-		 */
-		if (!cmpxchg(&l->locked, _Q_LOCKED_VAL, _Q_SLOW_VAL))
-			goto done;
+		if (!hb) {
+			hb = pv_hash_insert(lock);
+			/*
+			 * hb  must be set before setting _Q_SLOW_VAL
+			 *
+			 * [S]   hb <- lock               [RmW] l = l->locked = 0
+			 *       MB                             MB
+			 * [RmW] l->locked ?= _Q_SLOW_VAL [L]   hb
+			 *
+			 * Matches the xchg() in pv_queue_spin_unlock().
+			 */
+			o = cmpxchg(&l->locked, _Q_LOCKED_VAL, _Q_SLOW_VAL);
+			if (!o) {
+				/*
+				 * The lock got unlocked before we could set
+				 * _Q_SLOW_VAL, we must unhash ourselves.
+				 */
+				WRITE_ONCE(hb->lock, NULL);
+				goto done;
+			}
+			BUG_ON(o != _Q_LOCKED_VAL);
+			/*
+			 * At this point _Q_SLOW_VAL is visible and the unlock
+			 * will do the lookup. The lookup hard relies on the
+			 * entry being visible -- which it should be. Unlock
+			 * will unhash for us.
+			 */
+		}
 
 		pv_wait(&l->locked, _Q_SLOW_VAL);
+		/*
+		 * We can get spurious wakeups from interrupts, cycle back.
+		 */
 	}
 done:
-	this_cpu_write(__pv_lock_wait, NULL);
-
 	/*
 	 * Lock is unlocked now; the caller will acquire it without waiting.
 	 * As with pv_wait_node() we rely on the caller to do a load-acquire
 	 * for us.
 	 */
+	return;
 }
 
 /*
@@ -158,20 +257,20 @@ static void pv_wait_head(struct qspinloc
 void __pv_queue_spin_unlock(struct qspinlock *lock)
 {
 	struct __qspinlock *l = (void *)lock;
-	int cpu;
+	struct pv_hash_bucket *hb;
 
 	if (xchg(&l->locked, 0) != _Q_SLOW_VAL)
 		return;
 
 	/*
 	 * At this point the memory pointed at by lock can be freed/reused,
-	 * however we can still use the pointer value to search in our cpu
-	 * array.
+	 * however we can still use the pointer value to search in our hash
+	 * table.
 	 *
-	 * XXX: get rid of this loop
+	 * Also, if we observe _Q_SLOW_VAL we _must_ now observe 'our' hash
+	 * bucket. See pv_wait_head().
 	 */
-	for_each_possible_cpu(cpu) {
-		if (per_cpu(__pv_lock_wait, cpu) == lock)
-			pv_kick(cpu);
-	}
+	hb = pv_hash_find(lock);
+	pv_kick(hb->cpu);
+	WRITE_ONCE(hb->lock, NULL); /* unhash */
 }
