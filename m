Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50176 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732984AbfCZXln (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Mar 2019 19:41:43 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNXX5o123501
        for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2019 19:41:42 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rftk1qmqg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2019 19:41:41 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:41:41 -0000
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 14/21] tools/memory-model: Hardware checking for check{,all}litmus.sh
Date: Tue, 26 Mar 2019 16:41:26 -0700
In-Reply-To: <20190326234114.GA23843@linux.ibm.com>
References: <20190326234114.GA23843@linux.ibm.com>
Message-ID: <20190326234133.24962-14-paulmck@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20190326234126.I6KrR6Lsh27drzh5fwnEUSM791PEA3fE9oSRluYHCQA@z>

This commit makes checklitmus.sh and checkalllitmus.sh check to see
if a hardware verification was specified (via the --hw command-line
argument, which sets the LKMM_HW_MAP_FILE environment variable).
If so, the C-language litmus test is converted to the specified type
of assembly-language litmus test and herd is run on it.  Hardware is
permitted to be stronger than LKMM requires, so "Always" and "Never"
verifications of "Sometimes" C-language litmus tests are forgiven.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/checkalllitmus.sh | 23 +++++------
 tools/memory-model/scripts/checklitmus.sh    | 42 ++++++++++++++++++--
 2 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/tools/memory-model/scripts/checkalllitmus.sh b/tools/memory-model/scripts/checkalllitmus.sh
index d43c6b91db30..1e7afd3a51e4 100755
--- a/tools/memory-model/scripts/checkalllitmus.sh
+++ b/tools/memory-model/scripts/checkalllitmus.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
 # Run herd7 tests on all .litmus files in the litmus-tests directory
@@ -8,6 +8,11 @@
 # "^^^".  It also outputs verification results to a file whose name is
 # that of the specified litmus test, but with ".out" appended.
 #
+# If the --hw argument is specified, this script translates the .litmus
+# C-language file to the specified type of assembly and verifies that.
+# But in this case, litmus tests using complex synchronization (such as
+# locking, RCU, and SRCU) are cheerfully ignored.
+#
 # Usage:
 #	checkalllitmus.sh
 #
@@ -38,21 +43,15 @@ then
 	( cd "$LKMM_DESTDIR"; sed -e 's/^/mkdir -p /' | sh )
 fi
 
-# Find the checklitmus script.  If it is not where we expect it, then
-# assume that the caller has the PATH environment variable set
-# appropriately.
-if test -x scripts/checklitmus.sh
-then
-	clscript=scripts/checklitmus.sh
-else
-	clscript=checklitmus.sh
-fi
-
 # Run the script on all the litmus tests in the specified directory
 ret=0
 for i in $litmusdir/*.litmus
 do
-	if ! $clscript $i
+	if test -n "$LKMM_HW_MAP_FILE" && ! scripts/simpletest.sh $i
+	then
+		continue
+	fi
+	if ! scripts/checklitmus.sh $i
 	then
 		ret=1
 	fi
diff --git a/tools/memory-model/scripts/checklitmus.sh b/tools/memory-model/scripts/checklitmus.sh
index 11461ed40b5e..1922a5af2c17 100755
--- a/tools/memory-model/scripts/checklitmus.sh
+++ b/tools/memory-model/scripts/checklitmus.sh
@@ -6,6 +6,11 @@
 # results to a file whose name is that of the specified litmus test, but
 # with ".out" appended.
 #
+# If the --hw argument is specified, this script translates the .litmus
+# C-language file to the specified type of assembly and verifies that.
+# But in this case, litmus tests using complex synchronization (such as
+# locking, RCU, and SRCU) are cheerfully ignored.
+#
 # Usage:
 #	checklitmus.sh file.litmus
 #
@@ -18,8 +23,6 @@
 # Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
 
 litmus=$1
-herdoptions=${LKMM_HERD_OPTIONS--conf linux-kernel.cfg}
-
 if test -f "$litmus" -a -r "$litmus"
 then
 	:
@@ -28,7 +31,38 @@ else
 	exit 255
 fi
 
-echo Herd options: $herdoptions > $LKMM_DESTDIR/$litmus.out
-/usr/bin/time $LKMM_TIMEOUT_CMD herd7 $herdoptions $litmus >> $LKMM_DESTDIR/$litmus.out 2>&1
+if test -z "$LKMM_HW_MAP_FILE"
+then
+	# LKMM run
+	herdoptions=${LKMM_HERD_OPTIONS--conf linux-kernel.cfg}
+	echo Herd options: $herdoptions > $LKMM_DESTDIR/$litmus.out
+	/usr/bin/time $LKMM_TIMEOUT_CMD herd7 $herdoptions $litmus >> $LKMM_DESTDIR/$litmus.out 2>&1
+else
+	# Hardware run
+
+	T=/tmp/checklitmushw.sh.$$
+	trap 'rm -rf $T' 0 2
+	mkdir $T
+
+	# Generate filenames
+	catfile="`echo $LKMM_HW_MAP_FILE | tr '[A-Z]' '[a-z]'`.cat"
+	mapfile="Linux2${LKMM_HW_MAP_FILE}.map"
+	themefile="$T/${LKMM_HW_MAP_FILE}.theme"
+	herdoptions="-model $LKMM_HW_CAT_FILE"
+	hwlitmus=`echo $litmus | sed -e 's/\.litmus$/.'${LKMM_HW_MAP_FILE}'.litmus/'`
+	hwlitmusfile=`echo $hwlitmus | sed -e 's,^.*/,,'`
+
+	# Don't run on litmus tests with complex synchronization
+	if ! scripts/simpletest.sh $litmus
+	then
+		echo ' --- ' error: \"$litmus\" contains locking, RCU, or SRCU
+		exit 254
+	fi
+
+	# Generate the assembly code and run herd on it.
+	gen_theme7 -n 10 -map $mapfile -call Linux.call > $themefile
+	jingle7 -theme $themefile $litmus > $T/$hwlitmusfile 2> $T/$hwlitmusfile.jingle7.out
+	/usr/bin/time $LKMM_TIMEOUT_CMD herd7 -model $catfile $T/$hwlitmusfile > $LKMM_DESTDIR/$hwlitmus.out 2>&1
+fi
 
 scripts/judgelitmus.sh $litmus
-- 
2.17.1
