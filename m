From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC LKMM 3/7] tools/memory-model: Add SRCU support
Date: Wed,  9 Jan 2019 13:07:44 -0800
Message-ID: <20190109210748.29074-3-paulmck@linux.ibm.com>
References: <20190109210706.GA27268@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109210706.GA27268@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, willy@infradead.org, "Paul E . McKenney" <paulmck@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

Add support for SRCU.  Herd creates srcu events and linux-kernel.def
associates them with three possible annotations (srcu-lock,
srcu-unlock, and sync-srcu) corresponding to the API routines
srcu_read_lock(), srcu_read_unlock(), and synchronize_srcu().

The linux-kernel.bell file now declares the annotations
and determines matching lock/unlock pairs delimiting SRCU read-side
critical sections, and it also checks for synchronize_srcu() calls
inside an RCU critical section (which would generate a "sleeping in
atomic context" error in real kernel code).  The linux-kernel.cat file
now adds SRCU-induced ordering, analogous to the existing RCU-induced
ordering, to the gp and rcu-fence relations.

Curiously enough, these small changes to the model's .cat code are all
that is needed to describe SRCU.

Portions of this patch (linux-kernel.def and the first hunk in
linux-kernel.bell) were written by Luc Maranget.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: Luc Maranget <luc.maranget@inria.fr>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Tested-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 tools/memory-model/linux-kernel.bell | 25 +++++++++++++++++++++++++
 tools/memory-model/linux-kernel.cat  | 18 ++++++++++++++----
 tools/memory-model/linux-kernel.def  |  5 +++++
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 353c8d68e030..9c42cd9ddcb4 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -33,6 +33,12 @@ enum Barriers = 'wmb (*smp_wmb*) ||
 		'after-unlock-lock (*smp_mb__after_unlock_lock*)
 instructions F[Barriers]
 
+(* SRCU *)
+enum SRCU = 'srcu-lock || 'srcu-unlock || 'sync-srcu
+instructions SRCU[SRCU]
+(* All srcu events *)
+let Srcu = Srcu-lock | Srcu-unlock | Sync-srcu
+
 (* Compute matching pairs of nested Rcu-lock and Rcu-unlock *)
 let rcu-rscs = let rec
 	    unmatched-locks = Rcu-lock \ domain(matched)
@@ -48,3 +54,22 @@ let rcu-rscs = let rec
 (* Validate nesting *)
 flag ~empty Rcu-lock \ domain(rcu-rscs) as unbalanced-rcu-locking
 flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-locking
+
+(* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
+let srcu-rscs = let rec
+	    unmatched-locks = Srcu-lock \ domain(matched)
+	and unmatched-unlocks = Srcu-unlock \ range(matched)
+	and unmatched = unmatched-locks | unmatched-unlocks
+	and unmatched-po = ([unmatched] ; po ; [unmatched]) & loc
+	and unmatched-locks-to-unlocks =
+		([unmatched-locks] ; po ; [unmatched-unlocks]) & loc
+	and matched = matched | (unmatched-locks-to-unlocks \
+		(unmatched-po ; unmatched-po))
+	in matched
+
+(* Validate nesting *)
+flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
+flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
+
+(* Check for use of synchronize_srcu() inside an RCU critical section *)
+flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index b8e6197f05af..8dcb37835b61 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -33,7 +33,7 @@ let mb = ([M] ; fencerel(Mb) ; [M]) |
 	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
 	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
 		fencerel(After-unlock-lock) ; [M])
-let gp = po ; [Sync-rcu] ; po?
+let gp = po ; [Sync-rcu | Sync-srcu] ; po?
 
 let strong-fence = mb | gp
 
@@ -92,15 +92,18 @@ acyclic pb as propagation
 
 (*
  * Effects of read-side critical sections proceed from the rcu_read_unlock()
- * backwards on the one hand, and from the rcu_read_lock() forwards on the
- * other hand.
+ * or srcu_read_unlock() backwards on the one hand, and from the
+ * rcu_read_lock() or srcu_read_lock() forwards on the other hand.
  *
  * In the definition of rcu-fence below, the po term at the left-hand side
  * of each disjunct and the po? term at the right-hand end have been factored
  * out.  They have been moved into the definitions of rcu-link and rb.
+ * This was necessary in order to apply the "& loc" tests correctly.
  *)
 let rcu-gp = [Sync-rcu]		(* Compare with gp *)
+let srcu-gp = [Sync-srcu]
 let rcu-rscsi = rcu-rscs^-1
+let srcu-rscsi = srcu-rscs^-1
 
 (*
  * The synchronize_rcu() strong fence is special in that it can order not
@@ -112,12 +115,19 @@ let rcu-link = po? ; hb* ; pb* ; prop ; po
 (*
  * Any sequence containing at least as many grace periods as RCU read-side
  * critical sections (joined by rcu-link) acts as a generalized strong fence.
+ * Likewise for SRCU grace periods and read-side critical sections, provided
+ * the synchronize_srcu() and srcu_read_[un]lock() calls refer to the same
+ * struct srcu_struct location.
  *)
-let rec rcu-fence = rcu-gp |
+let rec rcu-fence = rcu-gp | srcu-gp |
 	(rcu-gp ; rcu-link ; rcu-rscsi) |
+	((srcu-gp ; rcu-link ; srcu-rscsi) & loc) |
 	(rcu-rscsi ; rcu-link ; rcu-gp) |
+	((srcu-rscsi ; rcu-link ; srcu-gp) & loc) |
 	(rcu-gp ; rcu-link ; rcu-fence ; rcu-link ; rcu-rscsi) |
+	((srcu-gp ; rcu-link ; rcu-fence ; rcu-link ; srcu-rscsi) & loc) |
 	(rcu-rscsi ; rcu-link ; rcu-fence ; rcu-link ; rcu-gp) |
+	((srcu-rscsi ; rcu-link ; rcu-fence ; rcu-link ; srcu-gp) & loc) |
 	(rcu-fence ; rcu-link ; rcu-fence)
 
 (* rb orders instructions just as pb does *)
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index b27911cc087d..1d6a120cde14 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -47,6 +47,11 @@ rcu_read_unlock() { __fence{rcu-unlock}; }
 synchronize_rcu() { __fence{sync-rcu}; }
 synchronize_rcu_expedited() { __fence{sync-rcu}; }
 
+// SRCU
+srcu_read_lock(X)  __srcu{srcu-lock}(X)
+srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X); }
+synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
+
 // Atomic
 atomic_read(X) READ_ONCE(*X)
 atomic_set(X,V) { WRITE_ONCE(*X,V); }
-- 
2.17.1
