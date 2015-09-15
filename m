From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH] barriers: introduce smp_mb__release_acquire and update documentation
Date: Tue, 15 Sep 2015 17:13:30 +0100
Message-ID: <1442333610-16228-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:44139 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752786AbbIOQNx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Sep 2015 12:13:53 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>

As much as we'd like to live in a world where RELEASE -> ACQUIRE is
always cheaply ordered and can be used to construct UNLOCK -> LOCK
definitions with similar guarantees, the grim reality is that this isn't
even possible on x86 (thanks to Paul for bringing us crashing down to
Earth).

This patch handles the issue by introducing a new barrier macro,
smp_mb__release_acquire, that can be placed between a RELEASE and a
subsequent ACQUIRE operation in order to upgrade them to a full memory
barrier. At the moment, it doesn't have any users, so its existence
serves mainly as a documentation aid.

Documentation/memory-barriers.txt is updated to describe more clearly
the ACQUIRE and RELEASE ordering in this area and to show an example of
the new barrier in action.

Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Following our discussion at [1], I thought I'd try to write something
down...

[1] http://lkml.kernel.org/r/20150828104854.GB16853@twins.programming.kicks-ass.net

 Documentation/memory-barriers.txt  | 23 ++++++++++++++++++++++-
 arch/powerpc/include/asm/barrier.h |  1 +
 arch/x86/include/asm/barrier.h     |  2 ++
 include/asm-generic/barrier.h      |  4 ++++
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 2ba8461b0631..46a85abb77c6 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -459,11 +459,18 @@ And a couple of implicit varieties:
      RELEASE on that same variable are guaranteed to be visible.  In other
      words, within a given variable's critical section, all accesses of all
      previous critical sections for that variable are guaranteed to have
-     completed.
+     completed.  If the RELEASE and ACQUIRE operations act on independent
+     variables, an smp_mb__release_acquire() barrier can be placed between
+     them to upgrade the sequence to a full barrier.
 
      This means that ACQUIRE acts as a minimal "acquire" operation and
      RELEASE acts as a minimal "release" operation.
 
+A subset of the atomic operations described in atomic_ops.txt have ACQUIRE
+and RELEASE variants in addition to fully-ordered and relaxed definitions.
+For compound atomics performing both a load and a store, ACQUIRE semantics
+apply only to the load and RELEASE semantics only to the store portion of
+the operation.
 
 Memory barriers are only required where there's a possibility of interaction
 between two CPUs or between a CPU and a device.  If it can be guaranteed that
@@ -1895,6 +1902,20 @@ the RELEASE would simply complete, thereby avoiding the deadlock.
 	a sleep-unlock race, but the locking primitive needs to resolve
 	such races properly in any case.
 
+If necessary, ordering can be enforced by use of an
+smp_mb__release_acquire() barrier:
+
+	*A = a;
+	RELEASE M
+	smp_mb__release_acquire();
+	ACQUIRE N
+	*B = b;
+
+in which case, the only permitted sequences are:
+
+	STORE *A, RELEASE M, ACQUIRE N, STORE *B
+	STORE *A, ACQUIRE N, RELEASE M, STORE *B
+
 Locks and semaphores may not provide any guarantee of ordering on UP compiled
 systems, and so cannot be counted on in such a situation to actually achieve
 anything at all - especially with respect to I/O accesses - unless combined
diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index 0eca6efc0631..919624634d0a 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -87,6 +87,7 @@ do {									\
 	___p1;								\
 })
 
+#define smp_mb__release_acquire()   smp_mb()
 #define smp_mb__before_atomic()     smp_mb()
 #define smp_mb__after_atomic()      smp_mb()
 #define smp_mb__before_spinlock()   smp_mb()
diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 0681d2532527..1c61ad251e0e 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -85,6 +85,8 @@ do {									\
 	___p1;								\
 })
 
+#define smp_mb__release_acquire()	smp_mb()
+
 #endif
 
 /* Atomic operations are already serializing on x86 */
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index b42afada1280..61ae95199397 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -119,5 +119,9 @@ do {									\
 	___p1;								\
 })
 
+#ifndef smp_mb__release_acquire
+#define smp_mb__release_acquire()	do { } while (0)
+#endif
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __ASM_GENERIC_BARRIER_H */
-- 
2.1.4
