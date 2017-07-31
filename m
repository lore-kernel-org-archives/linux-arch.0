From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH v2 tip/core/rcu 10/10] arch: Remove spin_unlock_wait() arch-specific definitions
Date: Mon, 31 Jul 2017 15:58:17 -0700
Message-ID: <1501541897-5225-10-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20170731225754.GB2674@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48357 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751976AbdGaW6Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Jul 2017 18:58:24 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6VMtsun105841
        for <linux-arch@vger.kernel.org>; Mon, 31 Jul 2017 18:58:23 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2c2c2surpy-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 31 Jul 2017 18:58:23 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 31 Jul 2017 18:58:22 -0400
In-Reply-To: <20170731225754.GB2674@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com, akpm@linux-foundation.org, mathieu.desnoyers@efficios.com, josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>

There is no agreed-upon definition of spin_unlock_wait()'s semantics,
and it appears that all callers could do just as well with a lock/unlock
pair.  This commit therefore removes the underlying arch-specific
arch_spin_unlock_wait() for all architectures providing them.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: <linux-arch@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/alpha/include/asm/spinlock.h    |  5 ----
 arch/arc/include/asm/spinlock.h      |  5 ----
 arch/arm/include/asm/spinlock.h      | 16 ----------
 arch/arm64/include/asm/spinlock.h    | 58 ++++--------------------------------
 arch/blackfin/include/asm/spinlock.h |  5 ----
 arch/hexagon/include/asm/spinlock.h  |  5 ----
 arch/ia64/include/asm/spinlock.h     | 21 -------------
 arch/m32r/include/asm/spinlock.h     |  5 ----
 arch/metag/include/asm/spinlock.h    |  5 ----
 arch/mn10300/include/asm/spinlock.h  |  5 ----
 arch/parisc/include/asm/spinlock.h   |  7 -----
 arch/powerpc/include/asm/spinlock.h  | 33 --------------------
 arch/s390/include/asm/spinlock.h     |  7 -----
 arch/sh/include/asm/spinlock-cas.h   |  5 ----
 arch/sh/include/asm/spinlock-llsc.h  |  5 ----
 arch/sparc/include/asm/spinlock_32.h |  5 ----
 arch/tile/include/asm/spinlock_32.h  |  2 --
 arch/tile/include/asm/spinlock_64.h  |  2 --
 arch/tile/lib/spinlock_32.c          | 23 --------------
 arch/tile/lib/spinlock_64.c          | 22 --------------
 arch/xtensa/include/asm/spinlock.h   |  5 ----
 21 files changed, 5 insertions(+), 241 deletions(-)

diff --git a/arch/alpha/include/asm/spinlock.h b/arch/alpha/include/asm/spinlock.h
index a40b9fc0c6c3..718ac0b64adf 100644
--- a/arch/alpha/include/asm/spinlock.h
+++ b/arch/alpha/include/asm/spinlock.h
@@ -16,11 +16,6 @@
 #define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
 #define arch_spin_is_locked(x)	((x)->lock != 0)
 
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	smp_cond_load_acquire(&lock->lock, !VAL);
-}
-
 static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 {
         return lock.lock == 0;
diff --git a/arch/arc/include/asm/spinlock.h b/arch/arc/include/asm/spinlock.h
index 233d5ffe6ec7..a325e6a36523 100644
--- a/arch/arc/include/asm/spinlock.h
+++ b/arch/arc/include/asm/spinlock.h
@@ -16,11 +16,6 @@
 #define arch_spin_is_locked(x)	((x)->slock != __ARCH_SPIN_LOCK_UNLOCKED__)
 #define arch_spin_lock_flags(lock, flags)	arch_spin_lock(lock)
 
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	smp_cond_load_acquire(&lock->slock, !VAL);
-}
-
 #ifdef CONFIG_ARC_HAS_LLSC
 
 static inline void arch_spin_lock(arch_spinlock_t *lock)
diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index 4bec45442072..c030143c18c6 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -52,22 +52,6 @@ static inline void dsb_sev(void)
  * memory.
  */
 
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	u16 owner = READ_ONCE(lock->tickets.owner);
-
-	for (;;) {
-		arch_spinlock_t tmp = READ_ONCE(*lock);
-
-		if (tmp.tickets.owner == tmp.tickets.next ||
-		    tmp.tickets.owner != owner)
-			break;
-
-		wfe();
-	}
-	smp_acquire__after_ctrl_dep();
-}
-
 #define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
 
 static inline void arch_spin_lock(arch_spinlock_t *lock)
diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index cae331d553f8..f445bd7f2b9f 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -26,58 +26,6 @@
  * The memory barriers are implicit with the load-acquire and store-release
  * instructions.
  */
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	unsigned int tmp;
-	arch_spinlock_t lockval;
-	u32 owner;
-
-	/*
-	 * Ensure prior spin_lock operations to other locks have completed
-	 * on this CPU before we test whether "lock" is locked.
-	 */
-	smp_mb();
-	owner = READ_ONCE(lock->owner) << 16;
-
-	asm volatile(
-"	sevl\n"
-"1:	wfe\n"
-"2:	ldaxr	%w0, %2\n"
-	/* Is the lock free? */
-"	eor	%w1, %w0, %w0, ror #16\n"
-"	cbz	%w1, 3f\n"
-	/* Lock taken -- has there been a subsequent unlock->lock transition? */
-"	eor	%w1, %w3, %w0, lsl #16\n"
-"	cbz	%w1, 1b\n"
-	/*
-	 * The owner has been updated, so there was an unlock->lock
-	 * transition that we missed. That means we can rely on the
-	 * store-release of the unlock operation paired with the
-	 * load-acquire of the lock operation to publish any of our
-	 * previous stores to the new lock owner and therefore don't
-	 * need to bother with the writeback below.
-	 */
-"	b	4f\n"
-"3:\n"
-	/*
-	 * Serialise against any concurrent lockers by writing back the
-	 * unlocked lock value
-	 */
-	ARM64_LSE_ATOMIC_INSN(
-	/* LL/SC */
-"	stxr	%w1, %w0, %2\n"
-	__nops(2),
-	/* LSE atomics */
-"	mov	%w1, %w0\n"
-"	cas	%w0, %w0, %2\n"
-"	eor	%w1, %w1, %w0\n")
-	/* Somebody else wrote to the lock, GOTO 10 and reload the value */
-"	cbnz	%w1, 2b\n"
-"4:"
-	: "=&r" (lockval), "=&r" (tmp), "+Q" (*lock)
-	: "r" (owner)
-	: "memory");
-}
 
 #define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
 
@@ -176,7 +124,11 @@ static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 
 static inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
-	smp_mb(); /* See arch_spin_unlock_wait */
+	/*
+	 * Ensure prior spin_lock operations to other locks have completed
+	 * on this CPU before we test whether "lock" is locked.
+	 */
+	smp_mb(); /* ^^^ */
 	return !arch_spin_value_unlocked(READ_ONCE(*lock));
 }
 
diff --git a/arch/blackfin/include/asm/spinlock.h b/arch/blackfin/include/asm/spinlock.h
index c58f4a83ed6f..f6431439d15d 100644
--- a/arch/blackfin/include/asm/spinlock.h
+++ b/arch/blackfin/include/asm/spinlock.h
@@ -48,11 +48,6 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 	__raw_spin_unlock_asm(&lock->lock);
 }
 
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	smp_cond_load_acquire(&lock->lock, !VAL);
-}
-
 static inline int arch_read_can_lock(arch_rwlock_t *rw)
 {
 	return __raw_uncached_fetch_asm(&rw->lock) > 0;
diff --git a/arch/hexagon/include/asm/spinlock.h b/arch/hexagon/include/asm/spinlock.h
index a1c55788c5d6..53a8d5885887 100644
--- a/arch/hexagon/include/asm/spinlock.h
+++ b/arch/hexagon/include/asm/spinlock.h
@@ -179,11 +179,6 @@ static inline unsigned int arch_spin_trylock(arch_spinlock_t *lock)
  */
 #define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
 
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	smp_cond_load_acquire(&lock->lock, !VAL);
-}
-
 #define arch_spin_is_locked(x) ((x)->lock != 0)
 
 #define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
diff --git a/arch/ia64/include/asm/spinlock.h b/arch/ia64/include/asm/spinlock.h
index ca9e76149a4a..df2c121164b8 100644
--- a/arch/ia64/include/asm/spinlock.h
+++ b/arch/ia64/include/asm/spinlock.h
@@ -76,22 +76,6 @@ static __always_inline void __ticket_spin_unlock(arch_spinlock_t *lock)
 	ACCESS_ONCE(*p) = (tmp + 2) & ~1;
 }
 
-static __always_inline void __ticket_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	int	*p = (int *)&lock->lock, ticket;
-
-	ia64_invala();
-
-	for (;;) {
-		asm volatile ("ld4.c.nc %0=[%1]" : "=r"(ticket) : "r"(p) : "memory");
-		if (!(((ticket >> TICKET_SHIFT) ^ ticket) & TICKET_MASK))
-			return;
-		cpu_relax();
-	}
-
-	smp_acquire__after_ctrl_dep();
-}
-
 static inline int __ticket_spin_is_locked(arch_spinlock_t *lock)
 {
 	long tmp = ACCESS_ONCE(lock->lock);
@@ -143,11 +127,6 @@ static __always_inline void arch_spin_lock_flags(arch_spinlock_t *lock,
 	arch_spin_lock(lock);
 }
 
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	__ticket_spin_unlock_wait(lock);
-}
-
 #define arch_read_can_lock(rw)		(*(volatile int *)(rw) >= 0)
 #define arch_write_can_lock(rw)	(*(volatile int *)(rw) == 0)
 
diff --git a/arch/m32r/include/asm/spinlock.h b/arch/m32r/include/asm/spinlock.h
index 323c7fc953cd..a56825592b90 100644
--- a/arch/m32r/include/asm/spinlock.h
+++ b/arch/m32r/include/asm/spinlock.h
@@ -30,11 +30,6 @@
 #define arch_spin_is_locked(x)		(*(volatile int *)(&(x)->slock) <= 0)
 #define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
 
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	smp_cond_load_acquire(&lock->slock, VAL > 0);
-}
-
 /**
  * arch_spin_trylock - Try spin lock and return a result
  * @lock: Pointer to the lock variable
diff --git a/arch/metag/include/asm/spinlock.h b/arch/metag/include/asm/spinlock.h
index c0c7a22be1ae..ddf7fe5708a6 100644
--- a/arch/metag/include/asm/spinlock.h
+++ b/arch/metag/include/asm/spinlock.h
@@ -15,11 +15,6 @@
  * locked.
  */
 
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	smp_cond_load_acquire(&lock->lock, !VAL);
-}
-
 #define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
 
 #define	arch_read_lock_flags(lock, flags) arch_read_lock(lock)
diff --git a/arch/mn10300/include/asm/spinlock.h b/arch/mn10300/include/asm/spinlock.h
index 9c7b8f7942d8..fe413b41df6c 100644
--- a/arch/mn10300/include/asm/spinlock.h
+++ b/arch/mn10300/include/asm/spinlock.h
@@ -26,11 +26,6 @@
 
 #define arch_spin_is_locked(x)	(*(volatile signed char *)(&(x)->slock) != 0)
 
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	smp_cond_load_acquire(&lock->slock, !VAL);
-}
-
 static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
 	asm volatile(
diff --git a/arch/parisc/include/asm/spinlock.h b/arch/parisc/include/asm/spinlock.h
index e32936cd7f10..55bfe4affca3 100644
--- a/arch/parisc/include/asm/spinlock.h
+++ b/arch/parisc/include/asm/spinlock.h
@@ -14,13 +14,6 @@ static inline int arch_spin_is_locked(arch_spinlock_t *x)
 
 #define arch_spin_lock(lock) arch_spin_lock_flags(lock, 0)
 
-static inline void arch_spin_unlock_wait(arch_spinlock_t *x)
-{
-	volatile unsigned int *a = __ldcw_align(x);
-
-	smp_cond_load_acquire(a, VAL);
-}
-
 static inline void arch_spin_lock_flags(arch_spinlock_t *x,
 					 unsigned long flags)
 {
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 8c1b913de6d7..d256e448ea49 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -170,39 +170,6 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 	lock->slock = 0;
 }
 
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	arch_spinlock_t lock_val;
-
-	smp_mb();
-
-	/*
-	 * Atomically load and store back the lock value (unchanged). This
-	 * ensures that our observation of the lock value is ordered with
-	 * respect to other lock operations.
-	 */
-	__asm__ __volatile__(
-"1:	" PPC_LWARX(%0, 0, %2, 0) "\n"
-"	stwcx. %0, 0, %2\n"
-"	bne- 1b\n"
-	: "=&r" (lock_val), "+m" (*lock)
-	: "r" (lock)
-	: "cr0", "xer");
-
-	if (arch_spin_value_unlocked(lock_val))
-		goto out;
-
-	while (lock->slock) {
-		HMT_low();
-		if (SHARED_PROCESSOR)
-			__spin_yield(lock);
-	}
-	HMT_medium();
-
-out:
-	smp_mb();
-}
-
 /*
  * Read-write spinlocks, allowing multiple readers
  * but only one writer.
diff --git a/arch/s390/include/asm/spinlock.h b/arch/s390/include/asm/spinlock.h
index f7838ecd83c6..217ee5210c32 100644
--- a/arch/s390/include/asm/spinlock.h
+++ b/arch/s390/include/asm/spinlock.h
@@ -98,13 +98,6 @@ static inline void arch_spin_unlock(arch_spinlock_t *lp)
 		: "cc", "memory");
 }
 
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	while (arch_spin_is_locked(lock))
-		arch_spin_relax(lock);
-	smp_acquire__after_ctrl_dep();
-}
-
 /*
  * Read-write spinlocks, allowing multiple readers
  * but only one writer.
diff --git a/arch/sh/include/asm/spinlock-cas.h b/arch/sh/include/asm/spinlock-cas.h
index c46e8cc7b515..5ed7dbbd94ff 100644
--- a/arch/sh/include/asm/spinlock-cas.h
+++ b/arch/sh/include/asm/spinlock-cas.h
@@ -29,11 +29,6 @@ static inline unsigned __sl_cas(volatile unsigned *p, unsigned old, unsigned new
 #define arch_spin_is_locked(x)		((x)->lock <= 0)
 #define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
 
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	smp_cond_load_acquire(&lock->lock, VAL > 0);
-}
-
 static inline void arch_spin_lock(arch_spinlock_t *lock)
 {
 	while (!__sl_cas(&lock->lock, 1, 0));
diff --git a/arch/sh/include/asm/spinlock-llsc.h b/arch/sh/include/asm/spinlock-llsc.h
index cec78143fa83..f77263aae760 100644
--- a/arch/sh/include/asm/spinlock-llsc.h
+++ b/arch/sh/include/asm/spinlock-llsc.h
@@ -21,11 +21,6 @@
 #define arch_spin_is_locked(x)		((x)->lock <= 0)
 #define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
 
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	smp_cond_load_acquire(&lock->lock, VAL > 0);
-}
-
 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
  * on the local processor, one does not.
diff --git a/arch/sparc/include/asm/spinlock_32.h b/arch/sparc/include/asm/spinlock_32.h
index 8011e79f59c9..67345b2dc408 100644
--- a/arch/sparc/include/asm/spinlock_32.h
+++ b/arch/sparc/include/asm/spinlock_32.h
@@ -14,11 +14,6 @@
 
 #define arch_spin_is_locked(lock) (*((volatile unsigned char *)(lock)) != 0)
 
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	smp_cond_load_acquire(&lock->lock, !VAL);
-}
-
 static inline void arch_spin_lock(arch_spinlock_t *lock)
 {
 	__asm__ __volatile__(
diff --git a/arch/tile/include/asm/spinlock_32.h b/arch/tile/include/asm/spinlock_32.h
index b14b1ba5bf9c..cba8ba9b8da6 100644
--- a/arch/tile/include/asm/spinlock_32.h
+++ b/arch/tile/include/asm/spinlock_32.h
@@ -64,8 +64,6 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 	lock->current_ticket = old_ticket + TICKET_QUANTUM;
 }
 
-void arch_spin_unlock_wait(arch_spinlock_t *lock);
-
 /*
  * Read-write spinlocks, allowing multiple readers
  * but only one writer.
diff --git a/arch/tile/include/asm/spinlock_64.h b/arch/tile/include/asm/spinlock_64.h
index b9718fb4e74a..9a2c2d605752 100644
--- a/arch/tile/include/asm/spinlock_64.h
+++ b/arch/tile/include/asm/spinlock_64.h
@@ -58,8 +58,6 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 	__insn_fetchadd4(&lock->lock, 1U << __ARCH_SPIN_CURRENT_SHIFT);
 }
 
-void arch_spin_unlock_wait(arch_spinlock_t *lock);
-
 void arch_spin_lock_slow(arch_spinlock_t *lock, u32 val);
 
 /* Grab the "next" ticket number and bump it atomically.
diff --git a/arch/tile/lib/spinlock_32.c b/arch/tile/lib/spinlock_32.c
index 076c6cc43113..db9333f2447c 100644
--- a/arch/tile/lib/spinlock_32.c
+++ b/arch/tile/lib/spinlock_32.c
@@ -62,29 +62,6 @@ int arch_spin_trylock(arch_spinlock_t *lock)
 }
 EXPORT_SYMBOL(arch_spin_trylock);
 
-void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	u32 iterations = 0;
-	int curr = READ_ONCE(lock->current_ticket);
-	int next = READ_ONCE(lock->next_ticket);
-
-	/* Return immediately if unlocked. */
-	if (next == curr)
-		return;
-
-	/* Wait until the current locker has released the lock. */
-	do {
-		delay_backoff(iterations++);
-	} while (READ_ONCE(lock->current_ticket) == curr);
-
-	/*
-	 * The TILE architecture doesn't do read speculation; therefore
-	 * a control dependency guarantees a LOAD->{LOAD,STORE} order.
-	 */
-	barrier();
-}
-EXPORT_SYMBOL(arch_spin_unlock_wait);
-
 /*
  * The low byte is always reserved to be the marker for a "tns" operation
  * since the low bit is set to "1" by a tns.  The next seven bits are
diff --git a/arch/tile/lib/spinlock_64.c b/arch/tile/lib/spinlock_64.c
index a4b5b2cbce93..de414c22892f 100644
--- a/arch/tile/lib/spinlock_64.c
+++ b/arch/tile/lib/spinlock_64.c
@@ -62,28 +62,6 @@ int arch_spin_trylock(arch_spinlock_t *lock)
 }
 EXPORT_SYMBOL(arch_spin_trylock);
 
-void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	u32 iterations = 0;
-	u32 val = READ_ONCE(lock->lock);
-	u32 curr = arch_spin_current(val);
-
-	/* Return immediately if unlocked. */
-	if (arch_spin_next(val) == curr)
-		return;
-
-	/* Wait until the current locker has released the lock. */
-	do {
-		delay_backoff(iterations++);
-	} while (arch_spin_current(READ_ONCE(lock->lock)) == curr);
-
-	/*
-	 * The TILE architecture doesn't do read speculation; therefore
-	 * a control dependency guarantees a LOAD->{LOAD,STORE} order.
-	 */
-	barrier();
-}
-EXPORT_SYMBOL(arch_spin_unlock_wait);
 
 /*
  * If the read lock fails due to a writer, we retry periodically
diff --git a/arch/xtensa/include/asm/spinlock.h b/arch/xtensa/include/asm/spinlock.h
index a36221cf6363..3bb49681ee24 100644
--- a/arch/xtensa/include/asm/spinlock.h
+++ b/arch/xtensa/include/asm/spinlock.h
@@ -33,11 +33,6 @@
 
 #define arch_spin_is_locked(x) ((x)->slock != 0)
 
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	smp_cond_load_acquire(&lock->slock, !VAL);
-}
-
 #define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
 
 static inline void arch_spin_lock(arch_spinlock_t *lock)
-- 
2.5.2
