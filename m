Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727048AbfE3Omd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:42:33 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEdPWe023957
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:32 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stepvge9x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:32 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:42:30 +0100
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 12/33] tools/memory-model: Fix paulmck email address on pre-existing scripts
Date: Thu, 30 May 2019 07:42:04 -0700
In-Reply-To: <20190530144202.GA26201@linux.ibm.com>
References: <20190530144202.GA26201@linux.ibm.com>
Message-ID: <20190530144225.27624-12-paulmck@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20190530144204.vIbXH4E4lru1Ms_m73M4-T2FHCFZjFvow5eLEsIHhdw@z>

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
index 3c0c7fbbd223..10e14d94acee 100755
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
index 11461ed40b5e..638b8c610894 100755
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
index 1d210ffb7c8a..406ecfc0aee4 100755
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
index 84c62eee321b..d82133e75580 100755
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
index 991f8f814881..3f4b06e29988 100755
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
index 40f52080fdbd..afe7bd23de6b 100755
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
index 6ed376f495bb..852786fef179 100755
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
2.17.1
