From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 10/19] tools/memory-model: Add model support for spin_is_locked
Date: Mon, 14 May 2018 16:33:48 -0700
Message-ID: <1526340837-12222-10-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180514233328.GA7601@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514233328.GA7601@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Luc Maranget <Luc.Maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-arch.vger.kernel.org

From: Luc Maranget <Luc.Maranget@inria.fr>

This commit first adds a trivial macro for spin_is_locked() to
linux-kernel.def.

It also adds cat code for enumerating all possible matches of lock
write events (set LKW) with islocked events returning true (set RL,
for Read from Lock), and unlock write events (set UL) with islocked
events returning false (set RU, for Read from Unlock).  Note that this
intentionally does not model uniprocessor kernels (CONFIG_SMP=n) built
with CONFIG_DEBUG_SPINLOCK=n, in which spin_is_locked() unconditionally
returns zero.

It also adds a pair of litmus tests demonstrating the minimal ordering
provided by spin_is_locked() in conjunction with spin_lock().  Will Deacon
noted that this minimal ordering happens on ARMv8:
https://lkml.kernel.org/r/20180226162426.GB17158@arm.com

Notice that herd7 installations strictly older than version 7.49
do not handle the new constructs.

Signed-off-by: Luc Maranget <luc.maranget@inria.fr>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
---
 tools/memory-model/linux-kernel.def                |  1 +
 .../MP+polockmbonce+poacquiresilsil.litmus         | 35 ++++++++++++++
 .../MP+polockonce+poacquiresilsil.litmus           | 34 ++++++++++++++
 tools/memory-model/litmus-tests/README             | 10 ++++
 tools/memory-model/lock.cat                        | 53 ++++++++++++++++++++--
 5 files changed, 129 insertions(+), 4 deletions(-)
 create mode 100644 tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
 create mode 100644 tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus

diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index 6bd3bc431b3d..f0553bd37c08 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -38,6 +38,7 @@ cmpxchg_release(X,V,W) __cmpxchg{release}(X,V,W)
 spin_lock(X) { __lock(X); }
 spin_unlock(X) { __unlock(X); }
 spin_trylock(X) __trylock(X)
+spin_is_locked(X) __islocked(X)
 
 // RCU
 rcu_read_lock() { __fence{rcu-lock}; }
diff --git a/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus b/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
new file mode 100644
index 000000000000..50f4d62bbf0e
--- /dev/null
+++ b/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
@@ -0,0 +1,35 @@
+C MP+polockmbonce+poacquiresilsil
+
+(*
+ * Result: Never
+ *
+ * Do spinlocks combined with smp_mb__after_spinlock() provide order
+ * to outside observers using spin_is_locked() to sense the lock-held
+ * state, ordered by acquire?  Note that when the first spin_is_locked()
+ * returns false and the second true, we know that the smp_load_acquire()
+ * executed before the lock was acquired (loosely speaking).
+ *)
+
+{
+}
+
+P0(spinlock_t *lo, int *x)
+{
+	spin_lock(lo);
+	smp_mb__after_spinlock();
+	WRITE_ONCE(*x, 1);
+	spin_unlock(lo);
+}
+
+P1(spinlock_t *lo, int *x)
+{
+	int r1;
+	int r2;
+	int r3;
+
+	r1 = smp_load_acquire(x);
+	r2 = spin_is_locked(lo);
+	r3 = spin_is_locked(lo);
+}
+
+exists (1:r1=1 /\ 1:r2=0 /\ 1:r3=1)
diff --git a/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus b/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
new file mode 100644
index 000000000000..abf81e7a0895
--- /dev/null
+++ b/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
@@ -0,0 +1,34 @@
+C MP+polockonce+poacquiresilsil
+
+(*
+ * Result: Sometimes
+ *
+ * Do spinlocks provide order to outside observers using spin_is_locked()
+ * to sense the lock-held state, ordered by acquire?  Note that when the
+ * first spin_is_locked() returns false and the second true, we know that
+ * the smp_load_acquire() executed before the lock was acquired (loosely
+ * speaking).
+ *)
+
+{
+}
+
+P0(spinlock_t *lo, int *x)
+{
+	spin_lock(lo);
+	WRITE_ONCE(*x, 1);
+	spin_unlock(lo);
+}
+
+P1(spinlock_t *lo, int *x)
+{
+	int r1;
+	int r2;
+	int r3;
+
+	r1 = smp_load_acquire(x);
+	r2 = spin_is_locked(lo);
+	r3 = spin_is_locked(lo);
+}
+
+exists (1:r1=1 /\ 1:r2=0 /\ 1:r3=1)
diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 04096fb8b8d9..6919909bbd0f 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -63,6 +63,16 @@ LB+poonceonces.litmus
 MP+onceassign+derefonce.litmus
 	As below, but with rcu_assign_pointer() and an rcu_dereference().
 
+MP+polockmbonce+poacquiresilsil.litmus
+	Protect the access with a lock and an smp_mb__after_spinlock()
+	in one process, and use an acquire load followed by a pair of
+	spin_is_locked() calls in the other process.
+
+MP+polockonce+poacquiresilsil.litmus
+	Protect the access with a lock in one process, and use an
+	acquire load followed by a pair of spin_is_locked() calls
+	in the other process.
+
 MP+polocks.litmus
 	As below, but with the second access of the writer process
 	and the first access of reader process protected by a lock.
diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index ba4a4ec6d313..3b1439edc818 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -5,7 +5,11 @@
  *)
 
 (* Generate coherence orders and handle lock operations *)
-
+(*
+ * Warning, crashes with herd7 versions strictly before 7.48.
+ * spin_islocked is functional from version 7.49.
+ *
+ *)
 include "cross.cat"
 
 (* From lock reads to their partner lock writes *)
@@ -32,12 +36,16 @@ flag ~empty [M \ IW] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
 (* The final value of a spinlock should not be tested *)
 flag ~empty [FW] ; loc ; [ALL-LOCKS] as lock-final
 
-
+(*
+ * Backward compatibility
+ *)
+let RL = try RL with emptyset (* defined herd7 >= 7.49 *)
+let RU = try RU with emptyset (* defined herd7 >= 7.49 *)
 (*
  * Put lock operations in their appropriate classes, but leave UL out of W
  * until after the co relation has been generated.
  *)
-let R = R | LKR | LF
+let R = R | LKR | LF | RL | RU
 let W = W | LKW
 
 let Release = Release | UL
@@ -72,8 +80,45 @@ let all-possible-rfe-lf =
 
 (* Generate all rf relations for LF events *)
 with rfe-lf from cross(all-possible-rfe-lf)
-let rf = rf | rfi-lf | rfe-lf
 
+let rf-lf = rfe-lf | rfi-lf
+
+(* rf for RL events, ie islocked returning true, similar to LF above *)
+
+(* islocked returning true inside a critical section
+ * must read from the opening lock
+ *)
+let rfi-rl = ([LKW] ; po-loc ; [RL]) \ ([LKW] ; po-loc ; [UL] ; po-loc)
+
+(* islocked returning true outside critical sections can match any
+ * external lock.
+ *)
+let all-possible-rfe-rl =
+  let possible-rfe-lf r =
+    let pair-to-relation p = p ++ 0
+    in map pair-to-relation ((LKW * {r}) & loc & ext)
+  in map possible-rfe-lf (RL \ range(rfi-rl))
+
+with rfe-rl from cross(all-possible-rfe-rl)
+let rf-rl = rfe-rl | rfi-rl
+
+(* Read from unlock, ie islocked returning false, slightly different *)
+
+(* islocked returning false can read from the last po-previous unlock *)
+let rfi-ru = ([UL] ; po-loc ; [RU]) \ ([UL] ; po-loc ; [LKW] ; po-loc)
+
+(* any islocked returning false can read from any external unlock *)
+let all-possible-rfe-ru =
+   let possible-rfe-ru r =
+     let pair-to-relation p = p ++ 0
+     in map pair-to-relation (((UL|IW) * {r}) & loc & ext)
+  in map possible-rfe-ru RU
+
+with rfe-ru from cross(all-possible-rfe-ru)
+let rf-ru = rfe-ru | rfi-ru
+
+(* Final rf relation *)
+let rf = rf | rf-lf | rf-rl | rf-ru
 
 (* Generate all co relations, including LKW events but not UL *)
 let co0 = co0 | ([IW] ; loc ; [LKW]) |
-- 
2.5.2
