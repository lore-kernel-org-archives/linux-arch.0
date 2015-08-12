From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Wed, 12 Aug 2015 10:59:38 -0700
Message-ID: <20150812175938.GA27985@linux.vnet.ibm.com>
References: <20150714140014.GD3717@linux.vnet.ibm.com>
 <20150714141202.GN16213@arm.com>
 <20150714193144.GP3717@linux.vnet.ibm.com>
 <20150715013820.GA21971@linux.vnet.ibm.com>
 <20150715105135.GE1005@arm.com>
 <20150715131221.GY3717@linux.vnet.ibm.com>
 <20150724113101.GE30410@arm.com>
 <20150724153046.GJ3717@linux.vnet.ibm.com>
 <20150812134415.GC23540@arm.com>
 <20150812154346.GR3895@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:39102 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbbHLR7o (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 12 Aug 2015 13:59:44 -0400
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 12 Aug 2015 11:59:43 -0600
Content-Disposition: inline
In-Reply-To: <20150812154346.GR3895@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Wed, Aug 12, 2015 at 08:43:46AM -0700, Paul E. McKenney wrote:
> On Wed, Aug 12, 2015 at 02:44:15PM +0100, Will Deacon wrote:
> > Hello Paul,
> > 
> > On Fri, Jul 24, 2015 at 04:30:46PM +0100, Paul E. McKenney wrote:
> > > On Fri, Jul 24, 2015 at 12:31:01PM +0100, Will Deacon wrote:
> > > > On Wed, Jul 15, 2015 at 02:12:21PM +0100, Paul E. McKenney wrote:
> > > > > > > commit 695c05d4b9666c50b40a1c022678b5f6e2e3e771
> > > > > > > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > > > > Date:   Tue Jul 14 18:35:23 2015 -0700
> > > > > > > 
> > > > > > >     rcu,locking: Privatize smp_mb__after_unlock_lock()
> > > > > > >     
> > > > > > >     RCU is the only thing that uses smp_mb__after_unlock_lock(), and is
> > > > > > >     likely the only thing that ever will use it, so this commit makes this
> > > > > > >     macro private to RCU.
> > > > > > >     
> > > > > > >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > > > >     Cc: Will Deacon <will.deacon@arm.com>
> > > > > > >     Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > >     Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > > > > >     Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
> > > > 
> > > > Are you planning to queue this somewhere? I think it makes sense regardless
> > > > of whether we change PowerPc or not and ideally it would be merged around
> > > > the same time as my relaxed atomics series.
> > > 
> > > I have is in -rcu.  By default, I will push it to the 4.4 merge window.
> > > Please let me know if you need it sooner.
> > 
> > The generic relaxed atomics are now queued in -tip, so it would be really
> > good to see this Documentation update land in 4.3 if at all possible. I
> > appreciate it's late in the cycle, but it's always worth asking.
> 
> Can't hurt to give it a try.  I have set -rcu's rcu/next branch to this
> commit, and if it passes a few day's worth of testing, I will see what
> Ingo has to say about a pull request.
> 
> This commit also privatizes smp_mb__after_unlock_lock() as well as
> updating documentation.  Looks like we need to strengthen powerpc's
> locking primitives, then get rid of smp_mb__after_unlock_lock() entirely.
> Or did that already happen and I just missed it?

And just for completeness, here is the current version of that commit.

							Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/memory-barriers.txt   |   71 +---------------------------------
 b/arch/powerpc/include/asm/spinlock.h |    2 
 b/include/linux/spinlock.h            |   10 ----
 b/kernel/rcu/tree.h                   |   12 +++++
 4 files changed, 16 insertions(+), 79 deletions(-)

commit 12d560f4ea87030667438a169912380be00cea4b
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Tue Jul 14 18:35:23 2015 -0700

    rcu,locking: Privatize smp_mb__after_unlock_lock()
    
    RCU is the only thing that uses smp_mb__after_unlock_lock(), and is
    likely the only thing that ever will use it, so this commit makes this
    macro private to RCU.
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: Will Deacon <will.deacon@arm.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 318523872db5..eafa6a53f72c 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1854,16 +1854,10 @@ RELEASE are to the same lock variable, but only from the perspective of
 another CPU not holding that lock.  In short, a ACQUIRE followed by an
 RELEASE may -not- be assumed to be a full memory barrier.
 
-Similarly, the reverse case of a RELEASE followed by an ACQUIRE does not
-imply a full memory barrier.  If it is necessary for a RELEASE-ACQUIRE
-pair to produce a full barrier, the ACQUIRE can be followed by an
-smp_mb__after_unlock_lock() invocation.  This will produce a full barrier
-(including transitivity) if either (a) the RELEASE and the ACQUIRE are
-executed by the same CPU or task, or (b) the RELEASE and ACQUIRE act on
-the same variable.  The smp_mb__after_unlock_lock() primitive is free
-on many architectures.  Without smp_mb__after_unlock_lock(), the CPU's
-execution of the critical sections corresponding to the RELEASE and the
-ACQUIRE can cross, so that:
+Similarly, the reverse case of a RELEASE followed by an ACQUIRE does
+not imply a full memory barrier.  Therefore, the CPU's execution of the
+critical sections corresponding to the RELEASE and the ACQUIRE can cross,
+so that:
 
 	*A = a;
 	RELEASE M
@@ -1901,29 +1895,6 @@ the RELEASE would simply complete, thereby avoiding the deadlock.
 	a sleep-unlock race, but the locking primitive needs to resolve
 	such races properly in any case.
 
-With smp_mb__after_unlock_lock(), the two critical sections cannot overlap.
-For example, with the following code, the store to *A will always be
-seen by other CPUs before the store to *B:
-
-	*A = a;
-	RELEASE M
-	ACQUIRE N
-	smp_mb__after_unlock_lock();
-	*B = b;
-
-The operations will always occur in one of the following orders:
-
-	STORE *A, RELEASE, ACQUIRE, smp_mb__after_unlock_lock(), STORE *B
-	STORE *A, ACQUIRE, RELEASE, smp_mb__after_unlock_lock(), STORE *B
-	ACQUIRE, STORE *A, RELEASE, smp_mb__after_unlock_lock(), STORE *B
-
-If the RELEASE and ACQUIRE were instead both operating on the same lock
-variable, only the first of these alternatives can occur.  In addition,
-the more strongly ordered systems may rule out some of the above orders.
-But in any case, as noted earlier, the smp_mb__after_unlock_lock()
-ensures that the store to *A will always be seen as happening before
-the store to *B.
-
 Locks and semaphores may not provide any guarantee of ordering on UP compiled
 systems, and so cannot be counted on in such a situation to actually achieve
 anything at all - especially with respect to I/O accesses - unless combined
@@ -2154,40 +2125,6 @@ But it won't see any of:
 	*E, *F or *G following RELEASE Q
 
 
-However, if the following occurs:
-
-	CPU 1				CPU 2
-	===============================	===============================
-	WRITE_ONCE(*A, a);
-	ACQUIRE M		     [1]
-	WRITE_ONCE(*B, b);
-	WRITE_ONCE(*C, c);
-	RELEASE M	     [1]
-	WRITE_ONCE(*D, d);		WRITE_ONCE(*E, e);
-					ACQUIRE M		     [2]
-					smp_mb__after_unlock_lock();
-					WRITE_ONCE(*F, f);
-					WRITE_ONCE(*G, g);
-					RELEASE M	     [2]
-					WRITE_ONCE(*H, h);
-
-CPU 3 might see:
-
-	*E, ACQUIRE M [1], *C, *B, *A, RELEASE M [1],
-		ACQUIRE M [2], *H, *F, *G, RELEASE M [2], *D
-
-But assuming CPU 1 gets the lock first, CPU 3 won't see any of:
-
-	*B, *C, *D, *F, *G or *H preceding ACQUIRE M [1]
-	*A, *B or *C following RELEASE M [1]
-	*F, *G or *H preceding ACQUIRE M [2]
-	*A, *B, *C, *E, *F or *G following RELEASE M [2]
-
-Note that the smp_mb__after_unlock_lock() is critically important
-here: Without it CPU 3 might see some of the above orderings.
-Without smp_mb__after_unlock_lock(), the accesses are not guaranteed
-to be seen in order unless CPU 3 holds lock M.
-
 
 ACQUIRES VS I/O ACCESSES
 ------------------------
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 4dbe072eecbe..523673d7583c 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -28,8 +28,6 @@
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
 
-#define smp_mb__after_unlock_lock()	smp_mb()  /* Full ordering for lock. */
-
 #ifdef CONFIG_PPC64
 /* use 0x800000yy when locked, where yy == CPU number */
 #ifdef __BIG_ENDIAN__
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 0063b24b4f36..16c5ed5a627c 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -130,16 +130,6 @@ do {								\
 #define smp_mb__before_spinlock()	smp_wmb()
 #endif
 
-/*
- * Place this after a lock-acquisition primitive to guarantee that
- * an UNLOCK+LOCK pair act as a full barrier.  This guarantee applies
- * if the UNLOCK and LOCK are executed by the same CPU or if the
- * UNLOCK and LOCK operate on the same lock variable.
- */
-#ifndef smp_mb__after_unlock_lock
-#define smp_mb__after_unlock_lock()	do { } while (0)
-#endif
-
 /**
  * raw_spin_unlock_wait - wait until the spinlock gets unlocked
  * @lock: the spinlock in question.
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 0412030ca882..2e991f8361e4 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -653,3 +653,15 @@ static inline void rcu_nocb_q_lengths(struct rcu_data *rdp, long *ql, long *qll)
 #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
 }
 #endif /* #ifdef CONFIG_RCU_TRACE */
+
+/*
+ * Place this after a lock-acquisition primitive to guarantee that
+ * an UNLOCK+LOCK pair act as a full barrier.  This guarantee applies
+ * if the UNLOCK and LOCK are executed by the same CPU or if the
+ * UNLOCK and LOCK operate on the same lock variable.
+ */
+#ifdef CONFIG_PPC
+#define smp_mb__after_unlock_lock()	smp_mb()  /* Full ordering for lock. */
+#else /* #ifdef CONFIG_PPC */
+#define smp_mb__after_unlock_lock()	do { } while (0)
+#endif /* #else #ifdef CONFIG_PPC */
