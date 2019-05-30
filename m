From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 03/33] tools/memory-model: Add data-race detection
Date: Thu, 30 May 2019 07:41:55 -0700
Message-ID: <20190530144225.27624-3-paulmck@linux.ibm.com>
References: <20190530144202.GA26201@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190530144202.GA26201@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E . McKenney" <paulmck@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

This patch adds data-race detection to the Linux-Kernel Memory Model.
As part of this effort, support is added for:

	compiler barriers (the barrier() function), and

	a new Preserved Program Order term: (addr ; [Plain] ; wmb)

Data races are marked with a special Flag warning in herd.  It is
not guaranteed that the model will provide accurate predictions when a
data race is present.

The patch does not include documentation for the data-race detection
facility.  The basic design has been explained in various emails, and
a separate documentation patch will be submitted later.

This work is based on an earlier formulation of data races for the
LKMM by Andrea Parri.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/linux-kernel.bell |  1 +
 tools/memory-model/linux-kernel.cat  | 50 +++++++++++++++++++++++++++-
 tools/memory-model/linux-kernel.def  |  1 +
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index b60eb5a01053..5be86b1025e8 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -24,6 +24,7 @@ instructions RMW[{'once,'acquire,'release}]
 enum Barriers = 'wmb (*smp_wmb*) ||
 		'rmb (*smp_rmb*) ||
 		'mb (*smp_mb*) ||
+		'barrier (*barrier*) ||
 		'rcu-lock (*rcu_read_lock*)  ||
 		'rcu-unlock (*rcu_read_unlock*) ||
 		'sync-rcu (*synchronize_rcu*) ||
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index ff354e5ffd4b..36d367054811 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -44,6 +44,9 @@ let strong-fence = mb | gp
 
 let nonrw-fence = strong-fence | po-rel | acq-po
 let fence = nonrw-fence | wmb | rmb
+let barrier = fencerel(Barrier | Rmb | Wmb | Mb | Sync-rcu | Sync-srcu |
+		Before-atomic | After-atomic | Acquire | Release) |
+	(po ; [Release]) | ([Acquire] ; po)
 
 (**********************************)
 (* Fundamental coherence ordering *)
@@ -64,7 +67,7 @@ empty rmw & (fre ; coe) as atomic
 let dep = addr | data
 let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
-let to-w = rwdep | (overwrite & int)
+let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
 let to-r = addr | (dep ; [Marked] ; rfi)
 let ppo = to-r | to-w | fence | (po-unlock-rf-lock-po & int)
 
@@ -147,3 +150,48 @@ irreflexive rb as rcu
  * let xb = hb | pb | rb
  * acyclic xb as executes-before
  *)
+
+(*********************************)
+(* Plain accesses and data races *)
+(*********************************)
+
+(* Warn about plain writes and marked accesses in the same region *)
+let mixed-accesses = ([Plain & W] ; (po-loc \ barrier) ; [Marked]) |
+	([Marked] ; (po-loc \ barrier) ; [Plain & W])
+flag ~empty mixed-accesses as mixed-accesses
+
+(* Executes-before and visibility *)
+let xbstar = (hb | pb | rb)*
+let full-fence = strong-fence | (po ; rcu-fence ; po?)
+let vis = cumul-fence* ; rfe? ; [Marked] ;
+	((full-fence ; [Marked] ; xbstar) | (xbstar & int))
+
+(* Boundaries for lifetimes of plain accesses *)
+let w-pre-bounded = [Marked] ; (addr | fence)?
+let r-pre-bounded = [Marked] ; (addr | nonrw-fence |
+	([R4rmb] ; fencerel(Rmb) ; [~Noreturn]))?
+let w-post-bounded = fence? ; [Marked]
+let r-post-bounded = (nonrw-fence | ([~Noreturn] ; fencerel(Rmb) ; [R4rmb]))? ;
+	[Marked]
+
+(* Visibility and executes-before for plain accesses *)
+let ww-vis = w-post-bounded ; vis ; w-pre-bounded
+let wr-vis = w-post-bounded ; vis ; r-pre-bounded
+let rw-xbstar = r-post-bounded ; xbstar ; w-pre-bounded
+
+(* Potential races *)
+let pre-race = ext & ((Plain * M) | ((M \ IW) * Plain))
+
+(* Coherence requirements for plain accesses *)
+let wr-incoh = pre-race & rf & rw-xbstar^-1
+let rw-incoh = pre-race & fr & wr-vis^-1
+let ww-incoh = pre-race & co & ww-vis^-1
+empty (wr-incoh | rw-incoh | ww-incoh) as plain-coherence
+
+(* Actual races *)
+let ww-nonrace = ww-vis & ((Marked * W) | rw-xbstar) & ((W * Marked) | wr-vis)
+let ww-race = (pre-race & co) \ ww-nonrace
+let wr-race = (pre-race & (co? ; rf)) \ wr-vis
+let rw-race = (pre-race & fr) \ rw-xbstar
+
+flag ~empty (ww-race | wr-race | rw-race) as data-race
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index 551eeaa389d4..ef0f3c1850de 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -24,6 +24,7 @@ smp_mb__before_atomic() { __fence{before-atomic}; }
 smp_mb__after_atomic() { __fence{after-atomic}; }
 smp_mb__after_spinlock() { __fence{after-spinlock}; }
 smp_mb__after_unlock_lock() { __fence{after-unlock-lock}; }
+barrier() { __fence{barrier}; }
 
 // Exchange
 xchg(X,V)  __xchg{mb}(X,V)
-- 
2.17.1
