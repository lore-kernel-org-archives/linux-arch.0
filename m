From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC LKMM 7/7] tools/memory-model: Dynamically check SRCU lock-to-unlock matching
Date: Wed,  9 Jan 2019 13:07:48 -0800
Message-ID: <20190109210748.29074-7-paulmck@linux.ibm.com>
References: <20190109210706.GA27268@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109210706.GA27268@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, willy@infradead.org, Luc Maranget <Luc.Maranget@inria.fr>, "Paul E . McKenney" <paulmck@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

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
