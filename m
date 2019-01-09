Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726368AbfAIVH6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jan 2019 16:07:58 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09Kn3iJ083555
        for <linux-arch@vger.kernel.org>; Wed, 9 Jan 2019 16:07:57 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pwq2x44m6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 09 Jan 2019 16:07:56 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:07:55 -0000
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC LKMM 1/7] tools/memory-model: Rename some RCU relations
Date: Wed,  9 Jan 2019 13:07:42 -0800
In-Reply-To: <20190109210706.GA27268@linux.ibm.com>
References: <20190109210706.GA27268@linux.ibm.com>
Message-ID: <20190109210748.29074-1-paulmck@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, willy@infradead.org, "Paul E . McKenney" <paulmck@linux.ibm.com>
Message-ID: <20190109210742.2YQAUikNj5ejPR_c3teLbcwe0tEYvFFy99cA7Oaf-gs@z>

From: Alan Stern <stern@rowland.harvard.edu>

In preparation for adding support for SRCU, rename "crit" to
"rcu-rscs", rename "rscs" to "rcu-rscsi", and remove the restriction
to only the outermost level of nesting.

The name change is needed for disambiguating RCU read-side critical
sections from SRCU read-side critical sections.  Adding the "i" at the
end of "rcu-rscsi" emphasizes that the relation is inverted; it links
rcu_read_unlock() events to their corresponding preceding
rcu_read_lock() events.

The restriction to outermost nesting levels was never essential; it
was included mostly to show that it could be done.  Rather than add
equivalent unnecessary code for SRCU lock nesting, it seemed better to
remove the existing code.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Tested-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 tools/memory-model/linux-kernel.bell |  9 +++------
 tools/memory-model/linux-kernel.cat  | 10 +++++-----
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 796513362c05..353c8d68e030 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -34,7 +34,7 @@ enum Barriers = 'wmb (*smp_wmb*) ||
 instructions F[Barriers]
 
 (* Compute matching pairs of nested Rcu-lock and Rcu-unlock *)
-let matched = let rec
+let rcu-rscs = let rec
 	    unmatched-locks = Rcu-lock \ domain(matched)
 	and unmatched-unlocks = Rcu-unlock \ range(matched)
 	and unmatched = unmatched-locks | unmatched-unlocks
@@ -46,8 +46,5 @@ let matched = let rec
 	in matched
 
 (* Validate nesting *)
-flag ~empty Rcu-lock \ domain(matched) as unbalanced-rcu-locking
-flag ~empty Rcu-unlock \ range(matched) as unbalanced-rcu-locking
-
-(* Outermost level of nesting only *)
-let crit = matched \ (po^-1 ; matched ; po^-1)
+flag ~empty Rcu-lock \ domain(rcu-rscs) as unbalanced-rcu-locking
+flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-locking
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 8f23c74a96fd..ab9de9c1234b 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -95,7 +95,7 @@ acyclic pb as propagation
  * onward on the one hand and from the rcu_read_unlock() backwards on the
  * other hand.
  *)
-let rscs = po ; crit^-1 ; po?
+let rcu-rscsi = po ; rcu-rscs^-1 ; po?
 
 (*
  * The synchronize_rcu() strong fence is special in that it can order not
@@ -109,10 +109,10 @@ let rcu-link = hb* ; pb* ; prop
  * critical sections (joined by rcu-link) acts as a generalized strong fence.
  *)
 let rec rcu-fence = gp |
-	(gp ; rcu-link ; rscs) |
-	(rscs ; rcu-link ; gp) |
-	(gp ; rcu-link ; rcu-fence ; rcu-link ; rscs) |
-	(rscs ; rcu-link ; rcu-fence ; rcu-link ; gp) |
+	(gp ; rcu-link ; rcu-rscsi) |
+	(rcu-rscsi ; rcu-link ; gp) |
+	(gp ; rcu-link ; rcu-fence ; rcu-link ; rcu-rscsi) |
+	(rcu-rscsi ; rcu-link ; rcu-fence ; rcu-link ; gp) |
 	(rcu-fence ; rcu-link ; rcu-fence)
 
 (* rb orders instructions just as pb does *)
-- 
2.17.1
