Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389500AbfHAWVM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Aug 2019 18:21:12 -0400
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 13/31] tools/memory-model: Split runlitmus.sh out of checklitmus.sh
Date: Thu,  1 Aug 2019 15:20:38 -0700
Message-ID: <20190801222056.12144-13-paulmck@linux.ibm.com>
In-Reply-To: <20190801222026.GA11315@linux.ibm.com>
References: <20190801222026.GA11315@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20190801222038.cQbJbKoCFJcuuZGBd9OGiWwBROMu652TUgQlv7_d0Z8@z>

This commit prepares for adding --hw capability to github litmus-test
scripts by splitting runlitmus.sh (which simply runs the verification)
out of checklitmus.sh (which also judges the results).

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/checklitmus.sh | 57 ++-----------------
 tools/memory-model/scripts/runlitmus.sh   | 69 +++++++++++++++++++++++
 2 files changed, 73 insertions(+), 53 deletions(-)
 create mode 100755 tools/memory-model/scripts/runlitmus.sh

diff --git a/tools/memory-model/scripts/checklitmus.sh b/tools/memory-model/scripts/checklitmus.sh
index 42ff11869cd6..4c1d0cf0ddad 100755
--- a/tools/memory-model/scripts/checklitmus.sh
+++ b/tools/memory-model/scripts/checklitmus.sh
@@ -1,15 +1,8 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Run a herd7 test and invokes judgelitmus.sh to check the result against
-# a "Result:" comment within the litmus test.  It also outputs verification
-# results to a file whose name is that of the specified litmus test, but
-# with ".out" appended.
-#
-# If the --hw argument is specified, this script translates the .litmus
-# C-language file to the specified type of assembly and verifies that.
-# But in this case, litmus tests using complex synchronization (such as
-# locking, RCU, and SRCU) are cheerfully ignored.
+# Invokes runlitmus.sh and judgelitmus.sh on its arguments to run the
+# specified litmus test and pass judgment on the results.
 #
 # Usage:
 #	checklitmus.sh file.litmus
@@ -22,47 +15,5 @@
 #
 # Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
-litmus=$1
-if test -f "$litmus" -a -r "$litmus"
-then
-	:
-else
-	echo ' --- ' error: \"$litmus\" is not a readable file
-	exit 255
-fi
-
-if test -z "$LKMM_HW_MAP_FILE"
-then
-	# LKMM run
-	herdoptions=${LKMM_HERD_OPTIONS--conf linux-kernel.cfg}
-	echo Herd options: $herdoptions > $LKMM_DESTDIR/$litmus.out
-	/usr/bin/time $LKMM_TIMEOUT_CMD herd7 $herdoptions $litmus >> $LKMM_DESTDIR/$litmus.out 2>&1
-else
-	# Hardware run
-
-	T=/tmp/checklitmushw.sh.$$
-	trap 'rm -rf $T' 0 2
-	mkdir $T
-
-	# Generate filenames
-	catfile="`echo $LKMM_HW_MAP_FILE | tr '[A-Z]' '[a-z]'`.cat"
-	mapfile="Linux2${LKMM_HW_MAP_FILE}.map"
-	themefile="$T/${LKMM_HW_MAP_FILE}.theme"
-	herdoptions="-model $LKMM_HW_CAT_FILE"
-	hwlitmus=`echo $litmus | sed -e 's/\.litmus$/.'${LKMM_HW_MAP_FILE}'.litmus/'`
-	hwlitmusfile=`echo $hwlitmus | sed -e 's,^.*/,,'`
-
-	# Don't run on litmus tests with complex synchronization
-	if ! scripts/simpletest.sh $litmus
-	then
-		echo ' --- ' error: \"$litmus\" contains locking, RCU, or SRCU
-		exit 254
-	fi
-
-	# Generate the assembly code and run herd7 on it.
-	gen_theme7 -n 10 -map $mapfile -call Linux.call > $themefile
-	jingle7 -theme $themefile $litmus > $T/$hwlitmusfile 2> $T/$hwlitmusfile.jingle7.out
-	/usr/bin/time $LKMM_TIMEOUT_CMD herd7 -model $catfile $T/$hwlitmusfile > $LKMM_DESTDIR/$hwlitmus.out 2>&1
-fi
-
-scripts/judgelitmus.sh $litmus
+scripts/runlitmus.sh $1
+scripts/judgelitmus.sh $1
diff --git a/tools/memory-model/scripts/runlitmus.sh b/tools/memory-model/scripts/runlitmus.sh
new file mode 100755
index 000000000000..91af859c0e90
--- /dev/null
+++ b/tools/memory-model/scripts/runlitmus.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Without the -hw argument, runs a herd7 test and outputs verification
+# results to a file whose name is that of the specified litmus test,
+# but with ".out" appended.
+#
+# If the --hw argument is specified, this script translates the .litmus
+# C-language file to the specified type of assembly and verifies that.
+# But in this case, litmus tests using complex synchronization (such as
+# locking, RCU, and SRCU) are cheerfully ignored.
+#
+# Either way, return the status of the herd7 command.
+#
+# Usage:
+#	runlitmus.sh file.litmus
+#
+# Run this in the directory containing the memory model, specifying the
+# pathname of the litmus test to check.  The caller is expected to have
+# properly set up the LKMM environment variables.
+#
+# Copyright IBM Corporation, 2019
+#
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
+
+litmus=$1
+if test -f "$litmus" -a -r "$litmus"
+then
+	:
+else
+	echo ' --- ' error: \"$litmus\" is not a readable file
+	exit 255
+fi
+
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
+
+exit $?
-- 
2.17.1
