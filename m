From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC LKMM 2/7] tools/memory-model: Refactor some RCU relations
Date: Wed,  9 Jan 2019 13:07:43 -0800
Message-ID: <20190109210748.29074-2-paulmck@linux.ibm.com>
References: <20190109210706.GA27268@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109210706.GA27268@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, willy@infradead.org, "Paul E . McKenney" <paulmck@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

In preparation for adding support for SRCU, refactor the definitions
of rcu-fence, rcu-rscsi, rcu-link, and rb by moving the po and po?
terms from the first two to the second two.  An rcu-gp relation is
added; it is equivalent to gp with the po and po? terms removed.

This is necessary because for SRCU, we will have to use the loc
relation to check that the terms at the start and end of each disjunct
in the definition of rcu-fence refer to the same srcu_struct
location.  If these terms are hidden behind po and po?, there's no way
to carry out this check.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Tested-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 tools/memory-model/linux-kernel.cat | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index ab9de9c1234b..b8e6197f05af 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -91,32 +91,37 @@ acyclic pb as propagation
 (*******)
 
 (*
- * Effect of read-side critical section proceeds from the rcu_read_lock()
- * onward on the one hand and from the rcu_read_unlock() backwards on the
+ * Effects of read-side critical sections proceed from the rcu_read_unlock()
+ * backwards on the one hand, and from the rcu_read_lock() forwards on the
  * other hand.
+ *
+ * In the definition of rcu-fence below, the po term at the left-hand side
+ * of each disjunct and the po? term at the right-hand end have been factored
+ * out.  They have been moved into the definitions of rcu-link and rb.
  *)
-let rcu-rscsi = po ; rcu-rscs^-1 ; po?
+let rcu-gp = [Sync-rcu]		(* Compare with gp *)
+let rcu-rscsi = rcu-rscs^-1
 
 (*
  * The synchronize_rcu() strong fence is special in that it can order not
  * one but two non-rf relations, but only in conjunction with an RCU
  * read-side critical section.
  *)
-let rcu-link = hb* ; pb* ; prop
+let rcu-link = po? ; hb* ; pb* ; prop ; po
 
 (*
  * Any sequence containing at least as many grace periods as RCU read-side
  * critical sections (joined by rcu-link) acts as a generalized strong fence.
  *)
-let rec rcu-fence = gp |
-	(gp ; rcu-link ; rcu-rscsi) |
-	(rcu-rscsi ; rcu-link ; gp) |
-	(gp ; rcu-link ; rcu-fence ; rcu-link ; rcu-rscsi) |
-	(rcu-rscsi ; rcu-link ; rcu-fence ; rcu-link ; gp) |
+let rec rcu-fence = rcu-gp |
+	(rcu-gp ; rcu-link ; rcu-rscsi) |
+	(rcu-rscsi ; rcu-link ; rcu-gp) |
+	(rcu-gp ; rcu-link ; rcu-fence ; rcu-link ; rcu-rscsi) |
+	(rcu-rscsi ; rcu-link ; rcu-fence ; rcu-link ; rcu-gp) |
 	(rcu-fence ; rcu-link ; rcu-fence)
 
 (* rb orders instructions just as pb does *)
-let rb = prop ; rcu-fence ; hb* ; pb*
+let rb = prop ; po ; rcu-fence ; po? ; hb* ; pb*
 
 irreflexive rb as rcu
 
-- 
2.17.1
