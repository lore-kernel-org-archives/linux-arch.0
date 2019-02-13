Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393132AbfBMRhv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Feb 2019 12:37:51 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DHSojv072763
        for <linux-arch@vger.kernel.org>; Wed, 13 Feb 2019 12:37:50 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qmny3p25d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 13 Feb 2019 12:37:50 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 13 Feb 2019 17:37:49 -0000
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH memory-model 6/7] tools/memory-model: Dynamically check SRCU lock-to-unlock matching
Date: Wed, 13 Feb 2019 09:37:42 -0800
In-Reply-To: <20190213173650.GA26078@linux.ibm.com>
References: <20190213173650.GA26078@linux.ibm.com>
Message-ID: <20190213173743.26682-6-paulmck@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Luc Maranget <Luc.Maranget@inria.fr>, "Paul E . McKenney" <paulmck@linux.ibm.com>
Message-ID: <20190213173742.qCjN4pSYYqTrg6qQU_WQkX79pODmZIt51xVqwkx2FWg@z>

From: Luc Maranget <Luc.Maranget@inria.fr>

This commit checks that the return value of srcu_read_lock() is passed
to the matching srcu_read_unlock(), where "matching" is determined by
nesting.  This check operates as follows:

   1. srcu_read_lock() creates an integer token, which is stored into
      the generated events.
   2. srcu_read_unlock() records its second (token) argument into the
      generated event.
   3. A new herd primitive 'different-values' filters out pairs of events
      with identical values from the relation passed as its argument.
   4. The bell file applies the above primitive to the (srcu)
      read-side-critical-section relation 'srcu-rscs' and flags non-empty
      results.

BEWARE: Works only with herd version 7.51+6 and onwards.

Signed-off-by: Luc Maranget <Luc.Maranget@inria.fr>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
[ paulmck: Apply Andrea Parri's off-list feedback. ]
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 tools/memory-model/linux-kernel.bell | 3 +++
 tools/memory-model/linux-kernel.cat  | 2 ++
 tools/memory-model/linux-kernel.def  | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 9c42cd9ddcb4..def9131d3d8e 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -73,3 +73,6 @@ flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
 
 (* Check for use of synchronize_srcu() inside an RCU critical section *)
 flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
+
+(* Validate SRCU dynamic match *)
+flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 8dcb37835b61..95bf45f1215f 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 (*
+ * Requires herd version 7.51+6 or higher.
+ *
  * Copyright (C) 2015 Jade Alglave <j.alglave@ucl.ac.uk>,
  * Copyright (C) 2016 Luc Maranget <luc.maranget@inria.fr> for Inria
  * Copyright (C) 2017 Alan Stern <stern@rowland.harvard.edu>,
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index 1d6a120cde14..0c3f0ef486f4 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -49,7 +49,7 @@ synchronize_rcu_expedited() { __fence{sync-rcu}; }
 
 // SRCU
 srcu_read_lock(X)  __srcu{srcu-lock}(X)
-srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X); }
+srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
 synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
 
 // Atomic
-- 
2.17.1
