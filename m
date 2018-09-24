From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH] tools/memory-model: Model smp_mb__after_unlock_lock()
Date: Mon, 24 Sep 2018 12:44:49 +0200
Message-ID: <20180924104449.8211-1-andrea.parri@amarulasolutions.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
List-Id: linux-arch.vger.kernel.org

From the header comment for smp_mb__after_unlock_lock():

  "Place this after a lock-acquisition primitive to guarantee that
   an UNLOCK+LOCK pair acts as a full barrier.  This guarantee applies
   if the UNLOCK and LOCK are executed by the same CPU or if the
   UNLOCK and LOCK operate on the same lock variable."

This formalizes the above guarantee by defining (new) mb-links according
to the law:

  ([M] ; po ; [UL] ; (co | po) ; [LKW] ;
	fencerel(After-unlock-lock) ; [M])

where the component ([UL] ; co ; [LKW]) identifies "UNLOCK+LOCK pairs on
the same lock variable" and the component ([UL] ; po ; [LKW]) identifies
"UNLOCK+LOCK pairs executed by the same CPU".

In particular, the LKMM forbids the following two behaviors (the second
litmus test below is based on

  Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html

c.f., Section "Tree RCU Grace Period Memory Ordering Building Blocks"):

C after-unlock-lock-same-cpu

(*
 * Result: Never
 *)

{}

P0(spinlock_t *s, spinlock_t *t, int *x, int *y)
{
	int r0;

	spin_lock(s);
	WRITE_ONCE(*x, 1);
	spin_unlock(s);
	spin_lock(t);
	smp_mb__after_unlock_lock();
	r0 = READ_ONCE(*y);
	spin_unlock(t);
}

P1(int *x, int *y)
{
	int r0;

	WRITE_ONCE(*y, 1);
	smp_mb();
	r0 = READ_ONCE(*x);
}

exists (0:r0=0 /\ 1:r0=0)

C after-unlock-lock-same-lock-variable

(*
 * Result: Never
 *)

{}

P0(spinlock_t *s, int *x, int *y)
{
	int r0;

	spin_lock(s);
	WRITE_ONCE(*x, 1);
	r0 = READ_ONCE(*y);
	spin_unlock(s);
}

P1(spinlock_t *s, int *y, int *z)
{
	int r0;

	spin_lock(s);
	smp_mb__after_unlock_lock();
	WRITE_ONCE(*y, 1);
	r0 = READ_ONCE(*z);
	spin_unlock(s);
}

P2(int *z, int *x)
{
	int r0;

	WRITE_ONCE(*z, 1);
	smp_mb();
	r0 = READ_ONCE(*x);
}

exists (0:r0=0 /\ 1:r0=0 /\ 2:r0=0)

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
---
NOTES.

- A number of equivalent formalizations seems available; for example,
  we could replace "co" in the law above with "coe" (by "coherence")
  and we could limit "coe" to "singlestep(coe)" (by the "prop" term).
  These changes did not show significant performance improvement and
  they looked slightly less readable to me, hence...

- The mb-links order memory accesses po-_before_ the lock-release to
  memory accesses po-_after_ the lock-acquire; in part., this forma-
  lization does _not_ forbid the following behavior (after A. Stern):

C po-in-after-unlock-lock

{}

P0(spinlock_t *s, spinlock_t *t, int *y)
{
	int r0;

	spin_lock(s);
	spin_unlock(s);

	spin_lock(t);
	smp_mb__after_unlock_lock();
	r0 = READ_ONCE(*y);
	spin_unlock(t);
}

P1(spinlock_t *s, int *y)
{
	int r0;

	WRITE_ONCE(*y, 1);
	smp_mb();
	r0 = spin_is_locked(s);
}

exists (0:r0=0 /\ 1:r0=0)

- I'm not aware of currently supported architectures (implementations)
  of smp_mb__after_unlock_lock() and spin_{lock,unlock}() which would
  violate the guarantee formalized in this patch.  It is worth noting
  that the same conclusion does _not_ extend to other locking primiti-
  ves (e.g., write_{lock,unlock}()), AFAICT: c.f., e.g., riscv.  This
  "works" considered the callsites for the barrier, but yeah...
---
 tools/memory-model/linux-kernel.bell | 3 ++-
 tools/memory-model/linux-kernel.cat  | 4 +++-
 tools/memory-model/linux-kernel.def  | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index b84fb2f67109e..796513362c052 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -29,7 +29,8 @@ enum Barriers = 'wmb (*smp_wmb*) ||
 		'sync-rcu (*synchronize_rcu*) ||
 		'before-atomic (*smp_mb__before_atomic*) ||
 		'after-atomic (*smp_mb__after_atomic*) ||
-		'after-spinlock (*smp_mb__after_spinlock*)
+		'after-spinlock (*smp_mb__after_spinlock*) ||
+		'after-unlock-lock (*smp_mb__after_unlock_lock*)
 instructions F[Barriers]
 
 (* Compute matching pairs of nested Rcu-lock and Rcu-unlock *)
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 882fc33274ac3..8f23c74a96fdc 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -30,7 +30,9 @@ let wmb = [W] ; fencerel(Wmb) ; [W]
 let mb = ([M] ; fencerel(Mb) ; [M]) |
 	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
 	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
-	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M])
+	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
+	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
+		fencerel(After-unlock-lock) ; [M])
 let gp = po ; [Sync-rcu] ; po?
 
 let strong-fence = mb | gp
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index 6fa3eb28d40b5..b27911cc087d4 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -23,6 +23,7 @@ smp_wmb() { __fence{wmb}; }
 smp_mb__before_atomic() { __fence{before-atomic}; }
 smp_mb__after_atomic() { __fence{after-atomic}; }
 smp_mb__after_spinlock() { __fence{after-spinlock}; }
+smp_mb__after_unlock_lock() { __fence{after-unlock-lock}; }
 
 // Exchange
 xchg(X,V)  __xchg{mb}(X,V)
-- 
2.17.1
