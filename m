From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/memory-model 02/17] tools/memory-model: Redefine rb in terms of rcu-fence
Date: Mon, 16 Apr 2018 09:12:30 -0700
Message-ID: <1523895165-17576-2-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180416161209.GA6895@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180416161209.GA6895@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

This patch reorganizes the definition of rb in the Linux Kernel Memory
Consistency Model.  The relation is now expressed in terms of
rcu-fence, which consists of a sequence of gp and rscs links separated
by rcu-link links, in which the number of occurrences of gp is >= the
number of occurrences of rscs.

Arguments similar to those published in
http://diy.inria.fr/linux/long.pdf show that rcu-fence behaves like an
inter-CPU strong fence.  Furthermore, the definition of rb in terms of
rcu-fence is highly analogous to the definition of pb in terms of
strong-fence, which can help explain why rcu-path expresses a form of
temporal ordering.

This change should not affect the semantics of the memory model, just
its internal organization.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/Documentation/explanation.txt | 168 +++++++++++++++--------
 tools/memory-model/linux-kernel.cat              |  33 +++--
 2 files changed, 129 insertions(+), 72 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 1a387d703212..1b09f3175a1f 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -27,7 +27,7 @@ Explanation of the Linux-Kernel Memory Consistency Model
   19. AND THEN THERE WAS ALPHA
   20. THE HAPPENS-BEFORE RELATION: hb
   21. THE PROPAGATES-BEFORE RELATION: pb
-  22. RCU RELATIONS: rcu-link, gp-link, rscs-link, and rb
+  22. RCU RELATIONS: rcu-link, gp, rscs, rcu-fence, and rb
   23. ODDS AND ENDS
 
 
@@ -1451,8 +1451,8 @@ they execute means that it cannot have cycles.  This requirement is
 the content of the LKMM's "propagation" axiom.
 
 
-RCU RELATIONS: rcu-link, gp-link, rscs-link, and rb
----------------------------------------------------
+RCU RELATIONS: rcu-link, gp, rscs, rcu-fence, and rb
+----------------------------------------------------
 
 RCU (Read-Copy-Update) is a powerful synchronization mechanism.  It
 rests on two concepts: grace periods and read-side critical sections.
@@ -1537,49 +1537,100 @@ relation, and the details don't matter unless you want to comb through
 a somewhat lengthy formal proof.  Pretty much all you need to know
 about rcu-link is the information in the preceding paragraph.
 
-The LKMM goes on to define the gp-link and rscs-link relations.  They
-bring grace periods and read-side critical sections into the picture,
-in the following way:
+The LKMM also defines the gp and rscs relations.  They bring grace
+periods and read-side critical sections into the picture, in the
+following way:
 
-	E ->gp-link F means there is a synchronize_rcu() fence event S
-	and an event X such that E ->po S, either S ->po X or S = X,
-	and X ->rcu-link F.  In other words, E and F are linked by a
-	grace period followed by an instance of rcu-link.
+	E ->gp F means there is a synchronize_rcu() fence event S such
+	that E ->po S and either S ->po F or S = F.  In simple terms,
+	there is a grace period po-between E and F.
 
-	E ->rscs-link F means there is a critical section delimited by
-	an rcu_read_lock() fence L and an rcu_read_unlock() fence U,
-	and an event X such that E ->po U, either L ->po X or L = X,
-	and X ->rcu-link F.  Roughly speaking, this says that some
-	event in the same critical section as E is linked by rcu-link
-	to F.
+	E ->rscs F means there is a critical section delimited by an
+	rcu_read_lock() fence L and an rcu_read_unlock() fence U, such
+	that E ->po U and either L ->po F or L = F.  You can think of
+	this as saying that E and F are in the same critical section
+	(in fact, it also allows E to be po-before the start of the
+	critical section and F to be po-after the end).
 
 If we think of the rcu-link relation as standing for an extended
-"before", then E ->gp-link F says that E executes before a grace
-period which ends before F executes.  (In fact it covers more than
-this, because it also includes cases where E executes before a grace
-period and some store propagates to F's CPU before F executes and
-doesn't propagate to some other CPU until after the grace period
-ends.)  Similarly, E ->rscs-link F says that E is part of (or before
-the start of) a critical section which starts before F executes.
+"before", then X ->gp Y ->rcu-link Z says that X executes before a
+grace period which ends before Z executes.  (In fact it covers more
+than this, because it also includes cases where X executes before a
+grace period and some store propagates to Z's CPU before Z executes
+but doesn't propagate to some other CPU until after the grace period
+ends.)  Similarly, X ->rscs Y ->rcu-link Z says that X is part of (or
+before the start of) a critical section which starts before Z
+executes.
+
+The LKMM goes on to define the rcu-fence relation as a sequence of gp
+and rscs links separated by rcu-link links, in which the number of gp
+links is >= the number of rscs links.  For example:
+
+	X ->gp Y ->rcu-link Z ->rscs T ->rcu-link U ->gp V
+
+would imply that X ->rcu-fence V, because this sequence contains two
+gp links and only one rscs link.  (It also implies that X ->rcu-fence T
+and Z ->rcu-fence V.)  On the other hand:
+
+	X ->rscs Y ->rcu-link Z ->rscs T ->rcu-link U ->gp V
+
+does not imply X ->rcu-fence V, because the sequence contains only
+one gp link but two rscs links.
+
+The rcu-fence relation is important because the Grace Period Guarantee
+means that rcu-fence acts kind of like a strong fence.  In particular,
+if W is a write and we have W ->rcu-fence Z, the Guarantee says that W
+will propagate to every CPU before Z executes.
+
+To prove this in full generality requires some intellectual effort.
+We'll consider just a very simple case:
+
+	W ->gp X ->rcu-link Y ->rscs Z.
+
+This formula means that there is a grace period G and a critical
+section C such that:
+
+	1. W is po-before G;
+
+	2. X is equal to or po-after G;
+
+	3. X comes "before" Y in some sense;
+
+	4. Y is po-before the end of C;
+
+	5. Z is equal to or po-after the start of C.
+
+From 2 - 4 we deduce that the grace period G ends before the critical
+section C.  Then the second part of the Grace Period Guarantee says
+not only that G starts before C does, but also that W (which executes
+on G's CPU before G starts) must propagate to every CPU before C
+starts.  In particular, W propagates to every CPU before Z executes
+(or finishes executing, in the case where Z is equal to the
+rcu_read_lock() fence event which starts C.)  This sort of reasoning
+can be expanded to handle all the situations covered by rcu-fence.
+
+Finally, the LKMM defines the RCU-before (rb) relation in terms of
+rcu-fence.  This is done in essentially the same way as the pb
+relation was defined in terms of strong-fence.  We will omit the
+details; the end result is that E ->rb F implies E must execute before
+F, just as E ->pb F does (and for much the same reasons).
 
 Putting this all together, the LKMM expresses the Grace Period
-Guarantee by requiring that there are no cycles consisting of gp-link
-and rscs-link links in which the number of gp-link instances is >= the
-number of rscs-link instances.  It does this by defining the rb
-relation to link events E and F whenever it is possible to pass from E
-to F by a sequence of gp-link and rscs-link links with at least as
-many of the former as the latter.  The LKMM's "rcu" axiom then says
-that there are no events E with E ->rb E.
-
-Justifying this axiom takes some intellectual effort, but it is in
-fact a valid formalization of the Grace Period Guarantee.  We won't
-attempt to go through the detailed argument, but the following
-analysis gives a taste of what is involved.  Suppose we have a
-violation of the first part of the Guarantee: A critical section
-starts before a grace period, and some store propagates to the
-critical section's CPU before the end of the critical section but
-doesn't propagate to some other CPU until after the end of the grace
-period.
+Guarantee by requiring that the rb relation does not contain a cycle.
+Equivalently, this "rcu" axiom requires that there are no events E and
+F with E ->rcu-link F ->rcu-fence E.  Or to put it a third way, the
+axiom requires that there are no cycles consisting of gp and rscs
+alternating with rcu-link, where the number of gp links is >= the
+number of rscs links.
+
+Justifying the axiom isn't easy, but it is in fact a valid
+formalization of the Grace Period Guarantee.  We won't attempt to go
+through the detailed argument, but the following analysis gives a
+taste of what is involved.  Suppose we have a violation of the first
+part of the Guarantee: A critical section starts before a grace
+period, and some store propagates to the critical section's CPU before
+the end of the critical section but doesn't propagate to some other
+CPU until after the end of the grace period.
 
 Putting symbols to these ideas, let L and U be the rcu_read_lock() and
 rcu_read_unlock() fence events delimiting the critical section in
@@ -1606,11 +1657,14 @@ by rcu-link, yielding:
 
 	S ->po X ->rcu-link Z ->po U.
 
-The formulas say that S is po-between F and X, hence F ->gp-link Z
-via X.  They also say that Z comes before the end of the critical
-section and E comes after its start, hence Z ->rscs-link F via E.  But
-now we have a forbidden cycle: F ->gp-link Z ->rscs-link F.  Thus the
-"rcu" axiom rules out this violation of the Grace Period Guarantee.
+The formulas say that S is po-between F and X, hence F ->gp X.  They
+also say that Z comes before the end of the critical section and E
+comes after its start, hence Z ->rscs E.  From all this we obtain:
+
+	F ->gp X ->rcu-link Z ->rscs E ->rcu-link F,
+
+a forbidden cycle.  Thus the "rcu" axiom rules out this violation of
+the Grace Period Guarantee.
 
 For something a little more down-to-earth, let's see how the axiom
 works out in practice.  Consider the RCU code example from above, this
@@ -1639,15 +1693,15 @@ time with statement labels added to the memory access instructions:
 If r2 = 0 at the end then P0's store at X overwrites the value that
 P1's load at Z reads from, so we have Z ->fre X and thus Z ->rcu-link X.
 In addition, there is a synchronize_rcu() between Y and Z, so therefore
-we have Y ->gp-link X.
+we have Y ->gp Z.
 
 If r1 = 1 at the end then P1's load at Y reads from P0's store at W,
 so we have W ->rcu-link Y.  In addition, W and X are in the same critical
-section, so therefore we have X ->rscs-link Y.
+section, so therefore we have X ->rscs W.
 
-This gives us a cycle, Y ->gp-link X ->rscs-link Y, with one gp-link
-and one rscs-link, violating the "rcu" axiom.  Hence the outcome is
-not allowed by the LKMM, as we would expect.
+Then X ->rscs W ->rcu-link Y ->gp Z ->rcu-link X is a forbidden cycle,
+violating the "rcu" axiom.  Hence the outcome is not allowed by the
+LKMM, as we would expect.
 
 For contrast, let's see what can happen in a more complicated example:
 
@@ -1683,15 +1737,11 @@ For contrast, let's see what can happen in a more complicated example:
 	}
 
 If r0 = r1 = r2 = 1 at the end, then similar reasoning to before shows
-that W ->rscs-link Y via X, Y ->gp-link U via Z, and U ->rscs-link W
-via V.  And just as before, this gives a cycle:
-
-	W ->rscs-link Y ->gp-link U ->rscs-link W.
-
-However, this cycle has fewer gp-link instances than rscs-link
-instances, and consequently the outcome is not forbidden by the LKMM.
-The following instruction timing diagram shows how it might actually
-occur:
+that W ->rscs X ->rcu-link Y ->gp Z ->rcu-link U ->rscs V ->rcu-link W.
+However this cycle is not forbidden, because the sequence of relations
+contains fewer instances of gp (one) than of rscs (two).  Consequently
+the outcome is allowed by the LKMM.  The following instruction timing
+diagram shows how it might actually occur:
 
 P0			P1			P2
 --------------------	--------------------	--------------------
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index cdf682859d4e..1e5c4653dd12 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -102,20 +102,27 @@ let rscs = po ; crit^-1 ; po?
  *)
 let rcu-link = hb* ; pb* ; prop
 
-(* Chains that affect the RCU grace-period guarantee *)
-let gp-link = gp ; rcu-link
-let rscs-link = rscs ; rcu-link
-
 (*
- * A cycle containing at least as many grace periods as RCU read-side
- * critical sections is forbidden.
+ * Any sequence containing at least as many grace periods as RCU read-side
+ * critical sections (joined by rcu-link) acts as a generalized strong fence.
  *)
-let rec rb =
-	gp-link |
-	(gp-link ; rscs-link) |
-	(rscs-link ; gp-link) |
-	(rb ; rb) |
-	(gp-link ; rb ; rscs-link) |
-	(rscs-link ; rb ; gp-link)
+let rec rcu-fence = gp |
+	(gp ; rcu-link ; rscs) |
+	(rscs ; rcu-link ; gp) |
+	(gp ; rcu-link ; rcu-fence ; rcu-link ; rscs) |
+	(rscs ; rcu-link ; rcu-fence ; rcu-link ; gp) |
+	(rcu-fence ; rcu-link ; rcu-fence)
+
+(* rb orders instructions just as pb does *)
+let rb = prop ; rcu-fence ; hb* ; pb*
 
 irreflexive rb as rcu
+
+(*
+ * The happens-before, propagation, and rcu constraints are all
+ * expressions of temporal ordering.  They could be replaced by
+ * a single constraint on an "executes-before" relation, xb:
+ *
+ * let xb = hb | pb | rb
+ * acyclic xb as executes-before
+ *)
-- 
2.5.2
