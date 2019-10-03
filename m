Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729601AbfJCA04 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:26:56 -0400
From: paulmck@kernel.org
Subject: [PATCH tip/core/rcu 09/32] tools/memory-model: Fix paulmck email address on pre-existing scripts
Date: Wed,  2 Oct 2019 17:26:27 -0700
Message-ID: <20191003002650.11249-9-paulmck@kernel.org>
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20191003002627.el5P6oQdEPrUFmJo6e3o0Jj2VWPTHvy-kZfsbgeC6uU@z>

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/checkalllitmus.sh  | 2 +-
 tools/memory-model/scripts/checklitmus.sh     | 2 +-
 tools/memory-model/scripts/checklitmushist.sh | 2 +-
 tools/memory-model/scripts/judgelitmus.sh     | 2 +-
 tools/memory-model/scripts/newlitmushist.sh   | 2 +-
 tools/memory-model/scripts/parseargs.sh       | 2 +-
 tools/memory-model/scripts/runlitmushist.sh   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/memory-model/scripts/checkalllitmus.sh b/tools/memory-model/scripts/checkalllitmus.sh
index 3c0c7fb..10e14d9 100755
--- a/tools/memory-model/scripts/checkalllitmus.sh
+++ b/tools/memory-model/scripts/checkalllitmus.sh
@@ -17,7 +17,7 @@
 #
 # Copyright IBM Corporation, 2018
 #
-# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
 . scripts/parseargs.sh
 
diff --git a/tools/memory-model/scripts/checklitmus.sh b/tools/memory-model/scripts/checklitmus.sh
index 11461ed..638b8c6 100755
--- a/tools/memory-model/scripts/checklitmus.sh
+++ b/tools/memory-model/scripts/checklitmus.sh
@@ -15,7 +15,7 @@
 #
 # Copyright IBM Corporation, 2018
 #
-# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
 litmus=$1
 herdoptions=${LKMM_HERD_OPTIONS--conf linux-kernel.cfg}
diff --git a/tools/memory-model/scripts/checklitmushist.sh b/tools/memory-model/scripts/checklitmushist.sh
index 1d210ff..406ecfc 100755
--- a/tools/memory-model/scripts/checklitmushist.sh
+++ b/tools/memory-model/scripts/checklitmushist.sh
@@ -12,7 +12,7 @@
 #
 # Copyright IBM Corporation, 2018
 #
-# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
 . scripts/parseargs.sh
 
diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index 84c62ee..d82133e 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -13,7 +13,7 @@
 #
 # Copyright IBM Corporation, 2018
 #
-# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
 litmus=$1
 
diff --git a/tools/memory-model/scripts/newlitmushist.sh b/tools/memory-model/scripts/newlitmushist.sh
index 991f8f8..3f4b06e2 100755
--- a/tools/memory-model/scripts/newlitmushist.sh
+++ b/tools/memory-model/scripts/newlitmushist.sh
@@ -12,7 +12,7 @@
 #
 # Copyright IBM Corporation, 2018
 #
-# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
 . scripts/parseargs.sh
 
diff --git a/tools/memory-model/scripts/parseargs.sh b/tools/memory-model/scripts/parseargs.sh
index 40f5208..afe7bd2 100755
--- a/tools/memory-model/scripts/parseargs.sh
+++ b/tools/memory-model/scripts/parseargs.sh
@@ -9,7 +9,7 @@
 #
 # Copyright IBM Corporation, 2018
 #
-# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
 T=/tmp/parseargs.sh.$$
 mkdir $T
diff --git a/tools/memory-model/scripts/runlitmushist.sh b/tools/memory-model/scripts/runlitmushist.sh
index 6ed376f..852786f 100755
--- a/tools/memory-model/scripts/runlitmushist.sh
+++ b/tools/memory-model/scripts/runlitmushist.sh
@@ -13,7 +13,7 @@
 #
 # Copyright IBM Corporation, 2018
 #
-# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
 T=/tmp/runlitmushist.sh.$$
 trap 'rm -rf $T' 0
-- 
2.9.5
