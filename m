From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v3] barriers: introduce smp_mb__release_acquire and update documentation
Date: Wed, 27 Jan 2016 18:22:04 +0000
Message-ID: <1453918924-27606-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:55530 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934567AbcA0SWj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 27 Jan 2016 13:22:39 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>

As much as we'd like to live in a world where RELEASE -> ACQUIRE is
always cheaply ordered and can be used to construct UNLOCK -> LOCK
definitions with similar guarantees, the grim reality is that this isn't
even possible on x86 (thanks to Paul for bringing us crashing down to
Earth).

This patch handles the issue by introducing a new barrier macro,
smp_mb__after_release_acquire, that can be placed after an ACQUIRE that
either reads from a RELEASE or is in program-order after a RELEASE. The
barrier upgrades the RELEASE-ACQUIRE pair to a full memory barrier,
implying global transitivity. At the moment, it doesn't have any users,
so its existence serves mainly as a documentation aid and a potential
stepping stone to the reintroduction of smp_mb__after_unlock_lock() used
by RCU.

Documentation/memory-barriers.txt is updated to describe more clearly
the ACQUIRE and RELEASE ordering in this area and to show some examples
of the new barrier in action.

Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Based on Paul's patch to describe local vs global transitivity:

  http://lkml.kernel.org/r/20160115173912.GU3818@linux.vnet.ibm.com

 Documentation/memory-barriers.txt   | 63 +++++++++++++++++++++++++++++++++----
 arch/ia64/include/asm/barrier.h     |  2 ++
 arch/powerpc/include/asm/barrier.h  |  3 +-
 arch/s390/include/asm/barrier.h     |  1 +
 arch/sparc/include/asm/barrier_64.h |  5 +--
 arch/x86/include/asm/barrier.h      |  2 ++
 include/asm-generic/barrier.h       | 13 ++++++++
 7 files changed, 80 insertions(+), 9 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 2dc4ba7c8d4d..62ce096b88fa 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -454,16 +454,22 @@ And a couple of implicit varieties:
      The use of ACQUIRE and RELEASE operations generally precludes the need
      for other sorts of memory barrier (but note the exceptions mentioned in
      the subsection "MMIO write barrier").  In addition, a RELEASE+ACQUIRE
-     pair is -not- guaranteed to act as a full memory barrier.  However, after
+     pair is -not- guaranteed to act as a full memory barrier without an
+     explicit smp_mb__after_release_acquire() barrier.  However, after
      an ACQUIRE on a given variable, all memory accesses preceding any prior
      RELEASE on that same variable are guaranteed to be visible.  In other
-     words, within a given variable's critical section, all accesses of all
-     previous critical sections for that variable are guaranteed to have
-     completed.
+     words, for a CPU executing within a given variable's critical section,
+     all accesses of all previous critical sections for that variable are
+     guaranteed to be visible to that CPU.
 
      This means that ACQUIRE acts as a minimal "acquire" operation and
      RELEASE acts as a minimal "release" operation.
 
+A subset of the atomic operations described in atomic_ops.txt have ACQUIRE
+and RELEASE variants in addition to fully-ordered and relaxed (no barrier
+semantics) definitions.  For compound atomics performing both a load and
+a store, ACQUIRE semantics apply only to the load and RELEASE semantics
+apply only to the store portion of the operation.
 
 Memory barriers are only required where there's a possibility of interaction
 between two CPUs or between a CPU and a device.  If it can be guaranteed that
@@ -1357,7 +1363,7 @@ However, the transitivity of release-acquire is local to the participating
 CPUs and does not apply to cpu3().  Therefore, the following outcome
 is possible:
 
-	r0 == 0 && r1 == 1 && r2 == 1 && r3 == 0 && r4 == 0
+	r0 == 0 && r1 == 1 && r2 == 1 && r3 == 0 && r4 == 0 && r5 == 1
 
 Although cpu0(), cpu1(), and cpu2() will see their respective reads and
 writes in order, CPUs not involved in the release-acquire chain might
@@ -1369,10 +1375,27 @@ store to u as happening -after- cpu1()'s load from v, even though
 both cpu0() and cpu1() agree that these two operations occurred in the
 intended order.
 
+This can be forbidden by upgrading the release-acquire relationship
+between cpu0() and cpu1() to a full barrier using
+smp_mb__after_release_acquire() to enforce global transitivity:
+
+	void cpu1(void)
+	{
+		r1 = smp_load_acquire(&y);
+		smp_mb__after_release_acquire();
+		r4 = READ_ONCE(v);
+		r5 = READ_ONCE(u);
+		smp_store_release(&z, 1);
+	}
+
+With this addition, the previous result is forbidden and, as long as
+r1 == 1, all CPUs must agree that cpu0()'s store to u happened before
+cpu1()'s read from v.
+
 However, please keep in mind that smp_load_acquire() is not magic.
 In particular, it simply reads from its argument with ordering.  It does
 -not- ensure that any particular value will be read.  Therefore, the
-following outcome is possible:
+following outcome is possible irrespective of any additional barriers:
 
 	r0 == 0 && r1 == 0 && r2 == 0 && r5 == 0
 
@@ -1971,6 +1994,34 @@ the RELEASE would simply complete, thereby avoiding the deadlock.
 	a sleep-unlock race, but the locking primitive needs to resolve
 	such races properly in any case.
 
+Where the RELEASE and ACQUIRE operations are performed by the same CPU
+to different addresses, ordering can be enforced by an
+smp_mb__after_release_acquire() barrier:
+
+	*A = a;
+	RELEASE M
+	ACQUIRE N
+	smp_mb__after_release_acquire();
+	*B = b;
+
+in which case, the only permitted orderings are:
+
+	STORE *A, RELEASE M, ACQUIRE N, STORE *B
+	STORE *A, ACQUIRE N, RELEASE M, STORE *B
+
+Similarly, smp_mb__after_release_acquire() enforces full,
+globally-transitive ordering in the case that an ACQUIRE operation on
+one CPU reads from a RELEASE operation on another:
+
+	CPU 1			CPU 2				CPU 3
+	=======================	=======================		===============
+		{ X = 0, Y = 0, M = 0 }
+	STORE X=1		ACQUIRE M==1			STORE Y=1
+	RELEASE M=1		smp_mb__after_release_acquire() smp_mb();
+				LOAD Y==0			LOAD X=0
+
+This outcome is forbidden (i.e. CPU 3 must read X == 1).
+
 Locks and semaphores may not provide any guarantee of ordering on UP compiled
 systems, and so cannot be counted on in such a situation to actually achieve
 anything at all - especially with respect to I/O accesses - unless combined
diff --git a/arch/ia64/include/asm/barrier.h b/arch/ia64/include/asm/barrier.h
index 588f1614cafc..ed803c84bd19 100644
--- a/arch/ia64/include/asm/barrier.h
+++ b/arch/ia64/include/asm/barrier.h
@@ -67,6 +67,8 @@ do {									\
 	___p1;								\
 })
 
+#define __smp_mb__after_release_acquire()	__smp_mb()
+
 /*
  * The group barrier in front of the rsm & ssm are necessary to ensure
  * that none of the previous instructions in the same group are
diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index c0deafc212b8..b12860b8c7e4 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -74,7 +74,8 @@ do {									\
 	___p1;								\
 })
 
-#define smp_mb__before_spinlock()   smp_mb()
+#define smp_mb__after_release_acquire()	__smp_mb()
+#define smp_mb__before_spinlock()	smp_mb()
 
 #include <asm-generic/barrier.h>
 
diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
index 5c8db3ce61c8..ee31da604b11 100644
--- a/arch/s390/include/asm/barrier.h
+++ b/arch/s390/include/asm/barrier.h
@@ -45,6 +45,7 @@ do {									\
 	___p1;								\
 })
 
+#define __smp_mb__release_acquire()	__smp_mb()
 #define __smp_mb__before_atomic()	barrier()
 #define __smp_mb__after_atomic()	barrier()
 
diff --git a/arch/sparc/include/asm/barrier_64.h b/arch/sparc/include/asm/barrier_64.h
index c9f6ee64f41d..68c9e931a933 100644
--- a/arch/sparc/include/asm/barrier_64.h
+++ b/arch/sparc/include/asm/barrier_64.h
@@ -52,8 +52,9 @@ do {									\
 	___p1;								\
 })
 
-#define __smp_mb__before_atomic()	barrier()
-#define __smp_mb__after_atomic()	barrier()
+#define __smp_mb__after_release_acquire()	__smp_mb()
+#define __smp_mb__before_atomic()		barrier()
+#define __smp_mb__after_atomic()		barrier()
 
 #include <asm-generic/barrier.h>
 
diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index a584e1c50918..b24dcb7e806a 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -77,6 +77,8 @@ do {									\
 
 #endif
 
+#define __smp_mb__after_release_acquire()	__smp_mb()
+
 /* Atomic operations are already serializing on x86 */
 #define __smp_mb__before_atomic()	barrier()
 #define __smp_mb__after_atomic()	barrier()
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 1cceca146905..895f5993d341 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -139,6 +139,10 @@ do {									\
 })
 #endif
 
+#ifndef __smp_mb__after_release_acquire
+#define __smp_mb__after_release_acquire()	do { } while (0)
+#endif
+
 #ifdef CONFIG_SMP
 
 #ifndef smp_store_mb
@@ -161,6 +165,10 @@ do {									\
 #define smp_load_acquire(p) __smp_load_acquire(p)
 #endif
 
+#ifndef smp_mb__after_release_acquire
+#define smp_mb__after_release_acquire()	__smp_mb__after_release_acquire()
+#endif
+
 #else	/* !CONFIG_SMP */
 
 #ifndef smp_store_mb
@@ -194,6 +202,10 @@ do {									\
 })
 #endif
 
+#ifndef smp_mb__after_release_acquire
+#define smp_mb__after_release_acquire()	do { } while (0)
+#endif
+
 #endif
 
 /* Barriers for virtual machine guests when talking to an SMP host */
@@ -206,6 +218,7 @@ do {									\
 #define virt_mb__after_atomic()	__smp_mb__after_atomic()
 #define virt_store_release(p, v) __smp_store_release(p, v)
 #define virt_load_acquire(p) __smp_load_acquire(p)
+#define virt_mb__after_release_acquire() __smp_mb__after_release_acquire()
 
 #endif /* !__ASSEMBLY__ */
 #endif /* __ASM_GENERIC_BARRIER_H */
-- 
2.1.4
