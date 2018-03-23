From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/lkmm 1/2] tools/memory-model: Rename link and rcu-path to rcu-link and rb
Date: Fri, 23 Mar 2018 08:50:08 -0700
Message-ID: <1521820209-29444-1-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180323154651.GA28363@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180323154651.GA28363@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

This patch makes a simple non-functional change to the RCU portion of
the Linux Kernel Memory Consistency Model by renaming the "link" and
"rcu-path" relations to "rcu-link" and "rb", respectively.

The name "link" was an unfortunate choice, because it was too generic
and subject to confusion with other meanings of the same word, which
occur quite often in LKMM documentation.  The name "rcu-path" is not
very appropriate, because the relation is analogous to the
happens-before (hb) and propagates-before (pb) relations -- although
that fact won't become apparent until the second patch in this series.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/Documentation/explanation.txt | 93 ++++++++++++------------
 tools/memory-model/linux-kernel.cat              | 16 ++--
 2 files changed, 55 insertions(+), 54 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index a727c82bd434..1a387d703212 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -27,7 +27,7 @@ Explanation of the Linux-Kernel Memory Consistency Model
   19. AND THEN THERE WAS ALPHA
   20. THE HAPPENS-BEFORE RELATION: hb
   21. THE PROPAGATES-BEFORE RELATION: pb
-  22. RCU RELATIONS: link, gp-link, rscs-link, and rcu-path
+  22. RCU RELATIONS: rcu-link, gp-link, rscs-link, and rb
   23. ODDS AND ENDS
 
 
@@ -1451,8 +1451,8 @@ they execute means that it cannot have cycles.  This requirement is
 the content of the LKMM's "propagation" axiom.
 
 
-RCU RELATIONS: link, gp-link, rscs-link, and rcu-path
------------------------------------------------------
+RCU RELATIONS: rcu-link, gp-link, rscs-link, and rb
+---------------------------------------------------
 
 RCU (Read-Copy-Update) is a powerful synchronization mechanism.  It
 rests on two concepts: grace periods and read-side critical sections.
@@ -1509,8 +1509,8 @@ y, which occurs before the end of the critical section, did not
 propagate to P1 before the end of the grace period, violating the
 Guarantee.
 
-In the kernel's implementations of RCU, the business about stores
-propagating to every CPU is realized by placing strong fences at
+In the kernel's implementations of RCU, the requirements for stores
+to propagate to every CPU are fulfilled by placing strong fences at
 suitable places in the RCU-related code.  Thus, if a critical section
 starts before a grace period does then the critical section's CPU will
 execute an smp_mb() fence after the end of the critical section and
@@ -1523,19 +1523,19 @@ executes.
 What exactly do we mean by saying that a critical section "starts
 before" or "ends after" a grace period?  Some aspects of the meaning
 are pretty obvious, as in the example above, but the details aren't
-entirely clear.  The LKMM formalizes this notion by means of a
-relation with the unfortunately generic name "link".  It is a very
-general relation; among other things, X ->link Z includes cases where
-X happens-before or is equal to some event Y which is equal to or
-comes before Z in the coherence order.  Taking Y = Z, this says that
-X ->rfe Z implies X ->link Z, and taking Y = X, it says that X ->fr Z
-and X ->co Z each imply X ->link Z.
-
-The formal definition of the link relation is more than a little
+entirely clear.  The LKMM formalizes this notion by means of the
+rcu-link relation.  rcu-link encompasses a very general notion of
+"before": Among other things, X ->rcu-link Z includes cases where X
+happens-before or is equal to some event Y which is equal to or comes
+before Z in the coherence order.  When Y = Z this says that X ->rfe Z
+implies X ->rcu-link Z.  In addition, when Y = X it says that X ->fr Z
+and X ->co Z each imply X ->rcu-link Z.
+
+The formal definition of the rcu-link relation is more than a little
 obscure, and we won't give it here.  It is closely related to the pb
 relation, and the details don't matter unless you want to comb through
 a somewhat lengthy formal proof.  Pretty much all you need to know
-about link is the information in the preceding paragraph.
+about rcu-link is the information in the preceding paragraph.
 
 The LKMM goes on to define the gp-link and rscs-link relations.  They
 bring grace periods and read-side critical sections into the picture,
@@ -1543,32 +1543,33 @@ in the following way:
 
 	E ->gp-link F means there is a synchronize_rcu() fence event S
 	and an event X such that E ->po S, either S ->po X or S = X,
-	and X ->link F.  In other words, E and F are connected by a
-	grace period followed by an instance of link.
+	and X ->rcu-link F.  In other words, E and F are linked by a
+	grace period followed by an instance of rcu-link.
 
 	E ->rscs-link F means there is a critical section delimited by
 	an rcu_read_lock() fence L and an rcu_read_unlock() fence U,
 	and an event X such that E ->po U, either L ->po X or L = X,
-	and X ->link F.  Roughly speaking, this says that some event
-	in the same critical section as E is connected by link to F.
-
-If we think of the link relation as standing for an extended "before",
-then E ->gp-link F says that E executes before a grace period which
-ends before F executes.  (In fact it says more than this, because it
-includes cases where E executes before a grace period and some store
-propagates to F's CPU before F executes and doesn't propagate to some
-other CPU until after the grace period ends.)  Similarly,
-E ->rscs-link F says that E is part of (or before the start of) a
-critical section which starts before F executes.
+	and X ->rcu-link F.  Roughly speaking, this says that some
+	event in the same critical section as E is linked by rcu-link
+	to F.
+
+If we think of the rcu-link relation as standing for an extended
+"before", then E ->gp-link F says that E executes before a grace
+period which ends before F executes.  (In fact it covers more than
+this, because it also includes cases where E executes before a grace
+period and some store propagates to F's CPU before F executes and
+doesn't propagate to some other CPU until after the grace period
+ends.)  Similarly, E ->rscs-link F says that E is part of (or before
+the start of) a critical section which starts before F executes.
 
 Putting this all together, the LKMM expresses the Grace Period
 Guarantee by requiring that there are no cycles consisting of gp-link
-and rscs-link connections in which the number of gp-link instances is
->= the number of rscs-link instances.  It does this by defining the
-rcu-path relation to link events E and F whenever it is possible to
-pass from E to F by a sequence of gp-link and rscs-link connections
-with at least as many of the former as the latter.  The LKMM's "rcu"
-axiom then says that there are no events E such that E ->rcu-path E.
+and rscs-link links in which the number of gp-link instances is >= the
+number of rscs-link instances.  It does this by defining the rb
+relation to link events E and F whenever it is possible to pass from E
+to F by a sequence of gp-link and rscs-link links with at least as
+many of the former as the latter.  The LKMM's "rcu" axiom then says
+that there are no events E with E ->rb E.
 
 Justifying this axiom takes some intellectual effort, but it is in
 fact a valid formalization of the Grace Period Guarantee.  We won't
@@ -1585,10 +1586,10 @@ rcu_read_unlock() fence events delimiting the critical section in
 question, and let S be the synchronize_rcu() fence event for the grace
 period.  Saying that the critical section starts before S means there
 are events E and F where E is po-after L (which marks the start of the
-critical section), E is "before" F in the sense of the link relation,
-and F is po-before the grace period S:
+critical section), E is "before" F in the sense of the rcu-link
+relation, and F is po-before the grace period S:
 
-	L ->po E ->link F ->po S.
+	L ->po E ->rcu-link F ->po S.
 
 Let W be the store mentioned above, let Z come before the end of the
 critical section and witness that W propagates to the critical
@@ -1600,12 +1601,12 @@ some event X which is po-after S.  Symbolically, this amounts to:
 
 The fr link from Y to W indicates that W has not propagated to Y's CPU
 at the time that Y executes.  From this, it can be shown (see the
-discussion of the link relation earlier) that X and Z are connected by
-link, yielding:
+discussion of the rcu-link relation earlier) that X and Z are related
+by rcu-link, yielding:
 
-	S ->po X ->link Z ->po U.
+	S ->po X ->rcu-link Z ->po U.
 
-These formulas say that S is po-between F and X, hence F ->gp-link Z
+The formulas say that S is po-between F and X, hence F ->gp-link Z
 via X.  They also say that Z comes before the end of the critical
 section and E comes after its start, hence Z ->rscs-link F via E.  But
 now we have a forbidden cycle: F ->gp-link Z ->rscs-link F.  Thus the
@@ -1635,13 +1636,13 @@ time with statement labels added to the memory access instructions:
 	}
 
 
-If r2 = 0 at the end then P0's store at X overwrites the value
-that P1's load at Z reads from, so we have Z ->fre X and thus
-Z ->link X.  In addition, there is a synchronize_rcu() between Y and
-Z, so therefore we have Y ->gp-link X.
+If r2 = 0 at the end then P0's store at X overwrites the value that
+P1's load at Z reads from, so we have Z ->fre X and thus Z ->rcu-link X.
+In addition, there is a synchronize_rcu() between Y and Z, so therefore
+we have Y ->gp-link X.
 
 If r1 = 1 at the end then P1's load at Y reads from P0's store at W,
-so we have W ->link Y.  In addition, W and X are in the same critical
+so we have W ->rcu-link Y.  In addition, W and X are in the same critical
 section, so therefore we have X ->rscs-link Y.
 
 This gives us a cycle, Y ->gp-link X ->rscs-link Y, with one gp-link
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index df97db03b6c2..cdf682859d4e 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -100,22 +100,22 @@ let rscs = po ; crit^-1 ; po?
  * one but two non-rf relations, but only in conjunction with an RCU
  * read-side critical section.
  *)
-let link = hb* ; pb* ; prop
+let rcu-link = hb* ; pb* ; prop
 
 (* Chains that affect the RCU grace-period guarantee *)
-let gp-link = gp ; link
-let rscs-link = rscs ; link
+let gp-link = gp ; rcu-link
+let rscs-link = rscs ; rcu-link
 
 (*
  * A cycle containing at least as many grace periods as RCU read-side
  * critical sections is forbidden.
  *)
-let rec rcu-path =
+let rec rb =
 	gp-link |
 	(gp-link ; rscs-link) |
 	(rscs-link ; gp-link) |
-	(rcu-path ; rcu-path) |
-	(gp-link ; rcu-path ; rscs-link) |
-	(rscs-link ; rcu-path ; gp-link)
+	(rb ; rb) |
+	(gp-link ; rb ; rscs-link) |
+	(rscs-link ; rb ; gp-link)
 
-irreflexive rcu-path as rcu
+irreflexive rb as rcu
-- 
2.5.2
