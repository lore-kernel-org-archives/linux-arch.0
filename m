From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC LKMM 6/7] tools/memory-model: Update Documentation/explanation.txt to include SRCU support
Date: Wed,  9 Jan 2019 13:07:47 -0800
Message-ID: <20190109210748.29074-6-paulmck@linux.ibm.com>
References: <20190109210706.GA27268@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109210706.GA27268@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, willy@infradead.org, Akira Yokosawa <akiyks@gmail.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

The recent commit adding support for SRCU to the Linux Kernel Memory
Model ended up changing the names and meanings of several relations.
This patch updates the explanation.txt documentation file to reflect
those changes.

It also revises the statement of the RCU Guarantee to a more accurate
form, and it adds a short paragraph mentioning the new support for SRCU.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 .../Documentation/explanation.txt             | 289 +++++++++---------
 1 file changed, 152 insertions(+), 137 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 35bff92cc773..68caa9a976d0 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -27,7 +27,7 @@ Explanation of the Linux-Kernel Memory Consistency Model
   19. AND THEN THERE WAS ALPHA
   20. THE HAPPENS-BEFORE RELATION: hb
   21. THE PROPAGATES-BEFORE RELATION: pb
-  22. RCU RELATIONS: rcu-link, gp, rscs, rcu-fence, and rb
+  22. RCU RELATIONS: rcu-link, rcu-gp, rcu-rscsi, rcu-fence, and rb
   23. LOCKING
   24. ODDS AND ENDS
 
@@ -1430,8 +1430,8 @@ they execute means that it cannot have cycles.  This requirement is
 the content of the LKMM's "propagation" axiom.
 
 
-RCU RELATIONS: rcu-link, gp, rscs, rcu-fence, and rb
-----------------------------------------------------
+RCU RELATIONS: rcu-link, rcu-gp, rcu-rscsi, rcu-fence, and rb
+-------------------------------------------------------------
 
 RCU (Read-Copy-Update) is a powerful synchronization mechanism.  It
 rests on two concepts: grace periods and read-side critical sections.
@@ -1446,17 +1446,19 @@ As far as memory models are concerned, RCU's main feature is its
 Grace-Period Guarantee, which states that a critical section can never
 span a full grace period.  In more detail, the Guarantee says:
 
-	If a critical section starts before a grace period then it
-	must end before the grace period does.  In addition, every
-	store that propagates to the critical section's CPU before the
-	end of the critical section must propagate to every CPU before
-	the end of the grace period.
+	For any critical section C and any grace period G, at least
+	one of the following statements must hold:
 
-	If a critical section ends after a grace period ends then it
-	must start after the grace period does.  In addition, every
-	store that propagates to the grace period's CPU before the
-	start of the grace period must propagate to every CPU before
-	the start of the critical section.
+(1)	C ends before G does, and in addition, every store that
+	propagates to C's CPU before the end of C must propagate to
+	every CPU before G ends.
+
+(2)	G starts before C does, and in addition, every store that
+	propagates to G's CPU before the start of G must propagate
+	to every CPU before C starts.
+
+In particular, it is not possible for a critical section to both start
+before and end after a grace period.
 
 Here is a simple example of RCU in action:
 
@@ -1483,10 +1485,11 @@ The Grace Period Guarantee tells us that when this code runs, it will
 never end with r1 = 1 and r2 = 0.  The reasoning is as follows.  r1 = 1
 means that P0's store to x propagated to P1 before P1 called
 synchronize_rcu(), so P0's critical section must have started before
-P1's grace period.  On the other hand, r2 = 0 means that P0's store to
-y, which occurs before the end of the critical section, did not
-propagate to P1 before the end of the grace period, violating the
-Guarantee.
+P1's grace period, contrary to part (2) of the Guarantee.  On the
+other hand, r2 = 0 means that P0's store to y, which occurs before the
+end of the critical section, did not propagate to P1 before the end of
+the grace period, contrary to part (1).  Together the results violate
+the Guarantee.
 
 In the kernel's implementations of RCU, the requirements for stores
 to propagate to every CPU are fulfilled by placing strong fences at
@@ -1504,11 +1507,11 @@ before" or "ends after" a grace period?  Some aspects of the meaning
 are pretty obvious, as in the example above, but the details aren't
 entirely clear.  The LKMM formalizes this notion by means of the
 rcu-link relation.  rcu-link encompasses a very general notion of
-"before": Among other things, X ->rcu-link Z includes cases where X
-happens-before or is equal to some event Y which is equal to or comes
-before Z in the coherence order.  When Y = Z this says that X ->rfe Z
-implies X ->rcu-link Z.  In addition, when Y = X it says that X ->fr Z
-and X ->co Z each imply X ->rcu-link Z.
+"before": If E and F are RCU fence events (i.e., rcu_read_lock(),
+rcu_read_unlock(), or synchronize_rcu()) then among other things,
+E ->rcu-link F includes cases where E is po-before some memory-access
+event X, F is po-after some memory-access event Y, and we have any of
+X ->rfe Y, X ->co Y, or X ->fr Y.
 
 The formal definition of the rcu-link relation is more than a little
 obscure, and we won't give it here.  It is closely related to the pb
@@ -1516,171 +1519,173 @@ relation, and the details don't matter unless you want to comb through
 a somewhat lengthy formal proof.  Pretty much all you need to know
 about rcu-link is the information in the preceding paragraph.
 
-The LKMM also defines the gp and rscs relations.  They bring grace
-periods and read-side critical sections into the picture, in the
+The LKMM also defines the rcu-gp and rcu-rscsi relations.  They bring
+grace periods and read-side critical sections into the picture, in the
 following way:
 
-	E ->gp F means there is a synchronize_rcu() fence event S such
-	that E ->po S and either S ->po F or S = F.  In simple terms,
-	there is a grace period po-between E and F.
+	E ->rcu-gp F means that E and F are in fact the same event,
+	and that event is a synchronize_rcu() fence (i.e., a grace
+	period).
 
-	E ->rscs F means there is a critical section delimited by an
-	rcu_read_lock() fence L and an rcu_read_unlock() fence U, such
-	that E ->po U and either L ->po F or L = F.  You can think of
-	this as saying that E and F are in the same critical section
-	(in fact, it also allows E to be po-before the start of the
-	critical section and F to be po-after the end).
+	E ->rcu-rscsi F means that E and F are the rcu_read_unlock()
+	and rcu_read_lock() fence events delimiting some read-side
+	critical section.  (The 'i' at the end of the name emphasizes
+	that this relation is "inverted": It links the end of the
+	critical section to the start.)
 
 If we think of the rcu-link relation as standing for an extended
-"before", then X ->gp Y ->rcu-link Z says that X executes before a
-grace period which ends before Z executes.  (In fact it covers more
-than this, because it also includes cases where X executes before a
-grace period and some store propagates to Z's CPU before Z executes
-but doesn't propagate to some other CPU until after the grace period
-ends.)  Similarly, X ->rscs Y ->rcu-link Z says that X is part of (or
-before the start of) a critical section which starts before Z
-executes.
-
-The LKMM goes on to define the rcu-fence relation as a sequence of gp
-and rscs links separated by rcu-link links, in which the number of gp
-links is >= the number of rscs links.  For example:
+"before", then X ->rcu-gp Y ->rcu-link Z roughly says that X is a
+grace period which ends before Z begins.  (In fact it covers more than
+this, because it also includes cases where some store propagates to
+Z's CPU before Z begins but doesn't propagate to some other CPU until
+after X ends.)  Similarly, X ->rcu-rscsi Y ->rcu-link Z says that X is
+the end of a critical section which starts before Z begins.
+
+The LKMM goes on to define the rcu-fence relation as a sequence of
+rcu-gp and rcu-rscsi links separated by rcu-link links, in which the
+number of rcu-gp links is >= the number of rcu-rscsi links.  For
+example:
 
-	X ->gp Y ->rcu-link Z ->rscs T ->rcu-link U ->gp V
+	X ->rcu-gp Y ->rcu-link Z ->rcu-rscsi T ->rcu-link U ->rcu-gp V
 
 would imply that X ->rcu-fence V, because this sequence contains two
-gp links and only one rscs link.  (It also implies that X ->rcu-fence T
-and Z ->rcu-fence V.)  On the other hand:
+rcu-gp links and one rcu-rscsi link.  (It also implies that
+X ->rcu-fence T and Z ->rcu-fence V.)  On the other hand:
 
-	X ->rscs Y ->rcu-link Z ->rscs T ->rcu-link U ->gp V
+	X ->rcu-rscsi Y ->rcu-link Z ->rcu-rscsi T ->rcu-link U ->rcu-gp V
 
 does not imply X ->rcu-fence V, because the sequence contains only
-one gp link but two rscs links.
+one rcu-gp link but two rcu-rscsi links.
 
 The rcu-fence relation is important because the Grace Period Guarantee
 means that rcu-fence acts kind of like a strong fence.  In particular,
-if W is a write and we have W ->rcu-fence Z, the Guarantee says that W
-will propagate to every CPU before Z executes.
+E ->rcu-fence F implies not only that E begins before F ends, but also
+that any write po-before E will propagate to every CPU before any
+instruction po-after F can execute.  (However, it does not imply that
+E must execute before F; in fact, each synchronize_rcu() fence event
+is linked to itself by rcu-fence as a degenerate case.)
 
 To prove this in full generality requires some intellectual effort.
 We'll consider just a very simple case:
 
-	W ->gp X ->rcu-link Y ->rscs Z.
+	G ->rcu-gp W ->rcu-link Z ->rcu-rscsi F.
 
-This formula means that there is a grace period G and a critical
-section C such that:
+This formula means that G and W are the same event (a grace period),
+and there are events X, Y and a read-side critical section C such that:
 
-	1. W is po-before G;
+	1. G = W is po-before or equal to X;
 
-	2. X is equal to or po-after G;
+	2. X comes "before" Y in some sense (including rfe, co and fr);
 
-	3. X comes "before" Y in some sense;
+	2. Y is po-before Z;
 
-	4. Y is po-before the end of C;
+	4. Z is the rcu_read_unlock() event marking the end of C;
 
-	5. Z is equal to or po-after the start of C.
+	5. F is the rcu_read_lock() event marking the start of C.
 
-From 2 - 4 we deduce that the grace period G ends before the critical
-section C.  Then the second part of the Grace Period Guarantee says
-not only that G starts before C does, but also that W (which executes
-on G's CPU before G starts) must propagate to every CPU before C
-starts.  In particular, W propagates to every CPU before Z executes
-(or finishes executing, in the case where Z is equal to the
-rcu_read_lock() fence event which starts C.)  This sort of reasoning
-can be expanded to handle all the situations covered by rcu-fence.
+From 1 - 4 we deduce that the grace period G ends before the critical
+section C.  Then part (2) of the Grace Period Guarantee says not only
+that G starts before C does, but also that any write which executes on
+G's CPU before G starts must propagate to every CPU before C starts.
+In particular, the write propagates to every CPU before F finishes
+executing and hence before any instruction po-after F can execute.
+This sort of reasoning can be extended to handle all the situations
+covered by rcu-fence.
 
 Finally, the LKMM defines the RCU-before (rb) relation in terms of
 rcu-fence.  This is done in essentially the same way as the pb
 relation was defined in terms of strong-fence.  We will omit the
-details; the end result is that E ->rb F implies E must execute before
-F, just as E ->pb F does (and for much the same reasons).
+details; the end result is that E ->rb F implies E must execute
+before F, just as E ->pb F does (and for much the same reasons).
 
 Putting this all together, the LKMM expresses the Grace Period
 Guarantee by requiring that the rb relation does not contain a cycle.
-Equivalently, this "rcu" axiom requires that there are no events E and
-F with E ->rcu-link F ->rcu-fence E.  Or to put it a third way, the
-axiom requires that there are no cycles consisting of gp and rscs
-alternating with rcu-link, where the number of gp links is >= the
-number of rscs links.
+Equivalently, this "rcu" axiom requires that there are no events E
+and F with E ->rcu-link F ->rcu-fence E.  Or to put it a third way,
+the axiom requires that there are no cycles consisting of rcu-gp and
+rcu-rscsi alternating with rcu-link, where the number of rcu-gp links
+is >= the number of rcu-rscsi links.
 
 Justifying the axiom isn't easy, but it is in fact a valid
 formalization of the Grace Period Guarantee.  We won't attempt to go
 through the detailed argument, but the following analysis gives a
-taste of what is involved.  Suppose we have a violation of the first
-part of the Guarantee: A critical section starts before a grace
-period, and some store propagates to the critical section's CPU before
-the end of the critical section but doesn't propagate to some other
-CPU until after the end of the grace period.
+taste of what is involved.  Suppose both parts of the Guarantee are
+violated: A critical section starts before a grace period, and some
+store propagates to the critical section's CPU before the end of the
+critical section but doesn't propagate to some other CPU until after
+the end of the grace period.
 
 Putting symbols to these ideas, let L and U be the rcu_read_lock() and
 rcu_read_unlock() fence events delimiting the critical section in
 question, and let S be the synchronize_rcu() fence event for the grace
 period.  Saying that the critical section starts before S means there
-are events E and F where E is po-after L (which marks the start of the
-critical section), E is "before" F in the sense of the rcu-link
-relation, and F is po-before the grace period S:
+are events Q and R where Q is po-after L (which marks the start of the
+critical section), Q is "before" R in the sense used by the rcu-link
+relation, and R is po-before the grace period S.  Thus we have:
 
-	L ->po E ->rcu-link F ->po S.
+	L ->rcu-link S.
 
-Let W be the store mentioned above, let Z come before the end of the
+Let W be the store mentioned above, let Y come before the end of the
 critical section and witness that W propagates to the critical
-section's CPU by reading from W, and let Y on some arbitrary CPU be a
-witness that W has not propagated to that CPU, where Y happens after
+section's CPU by reading from W, and let Z on some arbitrary CPU be a
+witness that W has not propagated to that CPU, where Z happens after
 some event X which is po-after S.  Symbolically, this amounts to:
 
-	S ->po X ->hb* Y ->fr W ->rf Z ->po U.
+	S ->po X ->hb* Z ->fr W ->rf Y ->po U.
 
-The fr link from Y to W indicates that W has not propagated to Y's CPU
-at the time that Y executes.  From this, it can be shown (see the
-discussion of the rcu-link relation earlier) that X and Z are related
-by rcu-link, yielding:
+The fr link from Z to W indicates that W has not propagated to Z's CPU
+at the time that Z executes.  From this, it can be shown (see the
+discussion of the rcu-link relation earlier) that S and U are related
+by rcu-link:
 
-	S ->po X ->rcu-link Z ->po U.
+	S ->rcu-link U.
 
-The formulas say that S is po-between F and X, hence F ->gp X.  They
-also say that Z comes before the end of the critical section and E
-comes after its start, hence Z ->rscs E.  From all this we obtain:
+Since S is a grace period we have S ->rcu-gp S, and since L and U are
+the start and end of the critical section C we have U ->rcu-rscsi L.
+From this we obtain:
 
-	F ->gp X ->rcu-link Z ->rscs E ->rcu-link F,
+	S ->rcu-gp S ->rcu-link U ->rcu-rscsi L ->rcu-link S,
 
 a forbidden cycle.  Thus the "rcu" axiom rules out this violation of
 the Grace Period Guarantee.
 
 For something a little more down-to-earth, let's see how the axiom
 works out in practice.  Consider the RCU code example from above, this
-time with statement labels added to the memory access instructions:
+time with statement labels added:
 
 	int x, y;
 
 	P0()
 	{
-		rcu_read_lock();
-		W: WRITE_ONCE(x, 1);
-		X: WRITE_ONCE(y, 1);
-		rcu_read_unlock();
+		L: rcu_read_lock();
+		X: WRITE_ONCE(x, 1);
+		Y: WRITE_ONCE(y, 1);
+		U: rcu_read_unlock();
 	}
 
 	P1()
 	{
 		int r1, r2;
 
-		Y: r1 = READ_ONCE(x);
-		synchronize_rcu();
-		Z: r2 = READ_ONCE(y);
+		Z: r1 = READ_ONCE(x);
+		S: synchronize_rcu();
+		W: r2 = READ_ONCE(y);
 	}
 
 
-If r2 = 0 at the end then P0's store at X overwrites the value that
-P1's load at Z reads from, so we have Z ->fre X and thus Z ->rcu-link X.
-In addition, there is a synchronize_rcu() between Y and Z, so therefore
-we have Y ->gp Z.
+If r2 = 0 at the end then P0's store at Y overwrites the value that
+P1's load at W reads from, so we have W ->fre Y.  Since S ->po W and
+also Y ->po U, we get S ->rcu-link U.  In addition, S ->rcu-gp S
+because S is a grace period.
 
-If r1 = 1 at the end then P1's load at Y reads from P0's store at W,
-so we have W ->rcu-link Y.  In addition, W and X are in the same critical
-section, so therefore we have X ->rscs W.
+If r1 = 1 at the end then P1's load at Z reads from P0's store at X,
+so we have X ->rfe Z.  Together with L ->po X and Z ->po S, this
+yields L ->rcu-link S.  And since L and U are the start and end of a
+critical section, we have U ->rcu-rscsi L.
 
-Then X ->rscs W ->rcu-link Y ->gp Z ->rcu-link X is a forbidden cycle,
-violating the "rcu" axiom.  Hence the outcome is not allowed by the
-LKMM, as we would expect.
+Then U ->rcu-rscsi L ->rcu-link S ->rcu-gp S ->rcu-link U is a
+forbidden cycle, violating the "rcu" axiom.  Hence the outcome is not
+allowed by the LKMM, as we would expect.
 
 For contrast, let's see what can happen in a more complicated example:
 
@@ -1690,51 +1695,52 @@ For contrast, let's see what can happen in a more complicated example:
 	{
 		int r0;
 
-		rcu_read_lock();
-		W: r0 = READ_ONCE(x);
-		X: WRITE_ONCE(y, 1);
-		rcu_read_unlock();
+		L0: rcu_read_lock();
+		    r0 = READ_ONCE(x);
+		    WRITE_ONCE(y, 1);
+		U0: rcu_read_unlock();
 	}
 
 	P1()
 	{
 		int r1;
 
-		Y: r1 = READ_ONCE(y);
-		synchronize_rcu();
-		Z: WRITE_ONCE(z, 1);
+		    r1 = READ_ONCE(y);
+		S1: synchronize_rcu();
+		    WRITE_ONCE(z, 1);
 	}
 
 	P2()
 	{
 		int r2;
 
-		rcu_read_lock();
-		U: r2 = READ_ONCE(z);
-		V: WRITE_ONCE(x, 1);
-		rcu_read_unlock();
+		L2: rcu_read_lock();
+		    r2 = READ_ONCE(z);
+		    WRITE_ONCE(x, 1);
+		U2: rcu_read_unlock();
 	}
 
 If r0 = r1 = r2 = 1 at the end, then similar reasoning to before shows
-that W ->rscs X ->rcu-link Y ->gp Z ->rcu-link U ->rscs V ->rcu-link W.
-However this cycle is not forbidden, because the sequence of relations
-contains fewer instances of gp (one) than of rscs (two).  Consequently
-the outcome is allowed by the LKMM.  The following instruction timing
-diagram shows how it might actually occur:
+that U0 ->rcu-rscsi L0 ->rcu-link S1 ->rcu-gp S1 ->rcu-link U2 ->rcu-rscsi
+L2 ->rcu-link U0.  However this cycle is not forbidden, because the
+sequence of relations contains fewer instances of rcu-gp (one) than of
+rcu-rscsi (two).  Consequently the outcome is allowed by the LKMM.
+The following instruction timing diagram shows how it might actually
+occur:
 
 P0			P1			P2
 --------------------	--------------------	--------------------
 rcu_read_lock()
-X: WRITE_ONCE(y, 1)
-			Y: r1 = READ_ONCE(y)
+WRITE_ONCE(y, 1)
+			r1 = READ_ONCE(y)
 			synchronize_rcu() starts
 			.			rcu_read_lock()
-			.			V: WRITE_ONCE(x, 1)
-W: r0 = READ_ONCE(x)	.
+			.			WRITE_ONCE(x, 1)
+r0 = READ_ONCE(x)	.
 rcu_read_unlock()	.
 			synchronize_rcu() ends
-			Z: WRITE_ONCE(z, 1)
-						U: r2 = READ_ONCE(z)
+			WRITE_ONCE(z, 1)
+						r2 = READ_ONCE(z)
 						rcu_read_unlock()
 
 This requires P0 and P2 to execute their loads and stores out of
@@ -1744,6 +1750,15 @@ section in P0 both starts before P1's grace period does and ends
 before it does, and the critical section in P2 both starts after P1's
 grace period does and ends after it does.
 
+Addendum: The LKMM now supports SRCU (Sleepable Read-Copy-Update) in
+addition to normal RCU.  The ideas involved are much the same as
+above, with new relations srcu-gp and srcu-rscsi added to represent
+SRCU grace periods and read-side critical sections.  There is a
+restriction on the srcu-gp and srcu-rscsi links that can appear in an
+rcu-fence sequence (the srcu-rscsi links must be paired with srcu-gp
+links having the same SRCU domain with proper nesting); the details
+are relatively unimportant.
+
 
 LOCKING
 -------
-- 
2.17.1
