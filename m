From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 18/19] tools/memory-model: Update ASPLOS information
Date: Mon, 14 May 2018 16:33:56 -0700
Message-ID: <1526340837-12222-18-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180514233328.GA7601@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514233328.GA7601@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Andrea Parri <andrea.parri@amarulasolutions.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

ASPLOS 2018 was held in March: make sure this is reflected in
header comments and references.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/Documentation/references.txt | 11 ++++++-----
 tools/memory-model/linux-kernel.bell            |  4 ++--
 tools/memory-model/linux-kernel.cat             |  4 ++--
 tools/memory-model/linux-kernel.def             |  4 ++--
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/memory-model/Documentation/references.txt b/tools/memory-model/Documentation/references.txt
index ba2e34c2ec3f..74f448f2616a 100644
--- a/tools/memory-model/Documentation/references.txt
+++ b/tools/memory-model/Documentation/references.txt
@@ -67,11 +67,12 @@ o	Shaked Flur, Susmit Sarkar, Christopher Pulte, Kyndylan Nienhuis,
 Linux-kernel memory model
 =========================
 
-o	Andrea Parri, Alan Stern, Luc Maranget, Paul E. McKenney,
-	and Jade Alglave.  2017. "A formal model of
-	Linux-kernel memory ordering - companion webpage".
-	http://moscova.inria.fr/∼maranget/cats7/linux/. (2017). [Online;
-	accessed 30-January-2017].
+o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
+	Alan Stern.  2018. "Frightening small children and disconcerting
+	grown-ups: Concurrency in the Linux kernel". In Proceedings of
+	the 23rd International Conference on Architectural Support for
+	Programming Languages and Operating Systems (ASPLOS 2018). ACM,
+	New York, NY, USA, 405-418.  Webpage: http://diy.inria.fr/linux/.
 
 o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
 	Alan Stern.  2017.  "A formal kernel memory-ordering model (part 1)"
diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 432c7cf71b23..64f5740e0e75 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -5,10 +5,10 @@
  * Copyright (C) 2017 Alan Stern <stern@rowland.harvard.edu>,
  *                    Andrea Parri <parri.andrea@gmail.com>
  *
- * An earlier version of this file appears in the companion webpage for
+ * An earlier version of this file appeared in the companion webpage for
  * "Frightening small children and disconcerting grown-ups: Concurrency
  * in the Linux kernel" by Alglave, Maranget, McKenney, Parri, and Stern,
- * which is to appear in ASPLOS 2018.
+ * which appeared in ASPLOS 2018.
  *)
 
 "Linux-kernel memory consistency model"
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 1e5c4653dd12..59b5cbe6b624 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -5,10 +5,10 @@
  * Copyright (C) 2017 Alan Stern <stern@rowland.harvard.edu>,
  *                    Andrea Parri <parri.andrea@gmail.com>
  *
- * An earlier version of this file appears in the companion webpage for
+ * An earlier version of this file appeared in the companion webpage for
  * "Frightening small children and disconcerting grown-ups: Concurrency
  * in the Linux kernel" by Alglave, Maranget, McKenney, Parri, and Stern,
- * which is to appear in ASPLOS 2018.
+ * which appeared in ASPLOS 2018.
  *)
 
 "Linux-kernel memory consistency model"
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index f0553bd37c08..6fa3eb28d40b 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
 //
-// An earlier version of this file appears in the companion webpage for
+// An earlier version of this file appeared in the companion webpage for
 // "Frightening small children and disconcerting grown-ups: Concurrency
 // in the Linux kernel" by Alglave, Maranget, McKenney, Parri, and Stern,
-// which is to appear in ASPLOS 2018.
+// which appeared in ASPLOS 2018.
 
 // ONCE
 READ_ONCE(X) __load{once}(X)
-- 
2.5.2
