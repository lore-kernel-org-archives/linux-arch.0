From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH memory-model 7/7] tools/memory-model: Avoid duplicating herdtools versions
Date: Wed, 13 Feb 2019 09:37:43 -0800
Message-ID: <20190213173743.26682-7-paulmck@linux.ibm.com>
References: <20190213173650.GA26078@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213173650.GA26078@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Andrea Parri <andrea.parri@amarulasolutions.com>, "Paul E . McKenney" <paulmck@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

Currently, herdtools version information appears no fewer than three
times in the LKMM source, which is difficult to maintain.  This commit
therefore places the required version in one place, namely the
tools/memory-model/README file.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 tools/memory-model/README           | 8 ++++++--
 tools/memory-model/linux-kernel.cat | 2 --
 tools/memory-model/lock.cat         | 3 ---
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index 9d7d4f23503f..2b87f3971548 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -20,13 +20,17 @@ that litmus test to be exercised within the Linux kernel.
 REQUIREMENTS
 ============
 
-Version 7.49 of the "herd7" and "klitmus7" tools must be downloaded
-separately:
+Version 7.52 or higher of the "herd7" and "klitmus7" tools must be
+downloaded separately:
 
   https://github.com/herd/herdtools7
 
 See "herdtools7/INSTALL.md" for installation instructions.
 
+Note that although these tools usually provide backwards compatibility,
+this is not absolutely guaranteed.  Therefore, if a later version does
+not work, please try using the exact version called out above.
+
 
 ==================
 BASIC USAGE: HERD7
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 95bf45f1215f..8dcb37835b61 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 (*
- * Requires herd version 7.51+6 or higher.
- *
  * Copyright (C) 2015 Jade Alglave <j.alglave@ucl.ac.uk>,
  * Copyright (C) 2016 Luc Maranget <luc.maranget@inria.fr> for Inria
  * Copyright (C) 2017 Alan Stern <stern@rowland.harvard.edu>,
diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index 305ded17e741..a059d1a6d8a2 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -6,9 +6,6 @@
 
 (*
  * Generate coherence orders and handle lock operations
- *
- * Warning: spin_is_locked() crashes herd7 versions strictly before 7.48.
- * spin_is_locked() is functional from herd7 version 7.49.
  *)
 
 include "cross.cat"
-- 
2.17.1
