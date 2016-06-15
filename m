From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH Documentation/memory-barriers.txt] Clarify limited
 control-dependency scope
Date: Wed, 15 Jun 2016 16:08:17 -0700
Message-ID: <20160615230817.GA18039@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27519 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753129AbcFOXIU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Jun 2016 19:08:20 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5FN3kMV030864
	for <linux-arch@vger.kernel.org>; Wed, 15 Jun 2016 19:08:19 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23jch672hj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 15 Jun 2016 19:08:19 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 15 Jun 2016 19:08:18 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: corbet@lwn.net, mingo@kernel.org, will.deacon@arm.com, peterz@infradead.org

Nothing in the control-dependencies section of memory-barriers.txt
says that control dependencies don't extend beyond the end of the
if-statement containing the control dependency.  Worse yet, in many
situations, they do extend beyond that if-statement.  In particular,
the compiler cannot destroy the control dependency given proper use of
READ_ONCE() and WRITE_ONCE().  However, a weakly ordered system having
a conditional-move instruction provides the control-dependency guarantee
only to code within the scope of the if-statement itself.

This commit therefore adds words and an example demonstrating this
limitation of control dependencies.

Reported-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 147ae8ec836f..a4d0a99de04d 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -806,6 +806,41 @@ out-guess your code.  More generally, although READ_ONCE() does force
 the compiler to actually emit code for a given load, it does not force
 the compiler to use the results.
 
+In addition, control dependencies apply only to the then-clause and
+else-clause of the if-statement in question.  In particular, it does
+not necessarily apply to code following the if-statement:
+
+	q = READ_ONCE(a);
+	if (q) {
+		WRITE_ONCE(b, p);
+	} else {
+		WRITE_ONCE(b, r);
+	}
+	WRITE_ONCE(c, 1);  /* BUG: No ordering against the read from "a". */
+
+It is tempting to argue that there in fact is ordering because the
+compiler cannot reorder volatile accesses and also cannot reorder
+the writes to "b" with the condition.  Unfortunately for this line
+of reasoning, the compiler might compile the two writes to "b" as
+conditional-move instructions, as in this fanciful pseudo-assembly
+language:
+
+	ld r1,a
+	ld r2,p
+	ld r3,r
+	cmp r1,$0
+	cmov,ne r4,r2
+	cmov,eq r4,r3
+	st r4,b
+	st $1,c
+
+A weakly ordered CPU would have no dependency of any sort between the load
+from "a" and the store to "c".  The control dependencies would extend
+only to the pair of cmov instructions and the store depending on them.
+In short, control dependencies apply only to the stores in the then-clause
+and else-clause of the if-statement in question (including functions
+invoked by those two clauses), not to code following that if-statement.
+
 Finally, control dependencies do -not- provide transitivity.  This is
 demonstrated by two related examples, with the initial values of
 x and y both being zero:
@@ -869,6 +904,12 @@ In summary:
       atomic{,64}_read() can help to preserve your control dependency.
       Please see the COMPILER BARRIER section for more information.
 
+  (*) Control dependencies apply only to the then-clause and else-clause
+      of the if-statement containing the control dependency, including
+      any functions that these two clauses call.  Control dependencies
+      do -not- apply to code following the if-statement containing the
+      control dependency.
+
   (*) Control dependencies pair normally with other types of barriers.
 
   (*) Control dependencies do -not- provide transitivity.  If you
