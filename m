Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49290 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726079AbfE3Omc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:42:32 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEdqeM082086
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:30 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2stfk75e0c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:30 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:42:29 +0100
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 01/33] tools/memory-model: Prepare for data-race detection
Date: Thu, 30 May 2019 07:41:53 -0700
In-Reply-To: <20190530144202.GA26201@linux.ibm.com>
References: <20190530144202.GA26201@linux.ibm.com>
Message-ID: <20190530144225.27624-1-paulmck@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E . McKenney" <paulmck@linux.ibm.com>
Message-ID: <20190530144153.3NXfa1Ylh2f8seaWP1WatG-0Pb31I1j-BxZk_3oB9tI@z>

From: Alan Stern <stern@rowland.harvard.edu>

This patch makes some slight alterations to linux-kernel.cat in
preparation for adding support for data-race detection to the
Linux-Kernel Memory Model.

	The definitions of relations involved in Acquire, Release, and
	unlock-lock ordering are moved up earlier in the source file.

	The rmb relation is factored through the new R4rmb class: the
	class of reads to which rmb will apply.

	The definition of the fence relation is moved earlier, and it
	is split up into read- and write-fences (rmb and wmb) and all
	the others.

This should not make any functional changes.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/linux-kernel.cat | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 8dcb37835b61..834107022c50 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -24,8 +24,14 @@ include "lock.cat"
 (* Basic relations *)
 (*******************)
 
+(* Release Acquire *)
+let acq-po = [Acquire] ; po ; [M]
+let po-rel = [M] ; po ; [Release]
+let po-unlock-rf-lock-po = po ; [UL] ; rf ; [LKR] ; po
+
 (* Fences *)
-let rmb = [R \ Noreturn] ; fencerel(Rmb) ; [R \ Noreturn]
+let R4rmb = R \ Noreturn	(* Reads for which rmb works *)
+let rmb = [R4rmb] ; fencerel(Rmb) ; [R4rmb]
 let wmb = [W] ; fencerel(Wmb) ; [W]
 let mb = ([M] ; fencerel(Mb) ; [M]) |
 	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
@@ -34,13 +40,10 @@ let mb = ([M] ; fencerel(Mb) ; [M]) |
 	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
 		fencerel(After-unlock-lock) ; [M])
 let gp = po ; [Sync-rcu | Sync-srcu] ; po?
-
 let strong-fence = mb | gp
 
-(* Release Acquire *)
-let acq-po = [Acquire] ; po ; [M]
-let po-rel = [M] ; po ; [Release]
-let po-unlock-rf-lock-po = po ; [UL] ; rf ; [LKR] ; po
+let nonrw-fence = strong-fence | po-rel | acq-po
+let fence = nonrw-fence | wmb | rmb
 
 (**********************************)
 (* Fundamental coherence ordering *)
@@ -63,7 +66,6 @@ let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int)
 let to-r = addr | (dep ; rfi)
-let fence = strong-fence | wmb | po-rel | rmb | acq-po
 let ppo = to-r | to-w | fence | (po-unlock-rf-lock-po & int)
 
 (* Propagation: Ordering from release operations and strong fences. *)
-- 
2.17.1
